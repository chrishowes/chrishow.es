---
layout: post
title:  "Ember controllers are singletons"
date:   2013-01-02 17:06:25
tags: ember
---

I was having an issue with creating a multi-page form in Ember - after I
published, I would go back and try to publish again, and I would end up on the
last page of the form! Why was that?

**Ember controllers are singletons**

When Ember transitions to a route, it calculates the model based on the `model`
method you have defined, and passes that into the controller in
`setupController`. The controller that is passed is NOT a new controller, but
THE instance of the controller defined for that route. AKA, a singleton.

So, because of the computed nature of Ember, anything that is calculated from
 your `model` will update, but anything non-model related will not.


**How to solve this**

Two ways I've found that solve this:

- Use components! Seriously - Ember is working on routable components, so
eventually controllers will be a thing of the past. You don't even need to
define controllers, and you can just have a one component template that
takes in your model data.

- Create a mixin that resets the properties you need.

This is a mixin for a route, that calls the controllers `reset` method if it's
defined.

{% highlight js %}
import Ember from 'ember';

export default Ember.Mixin.create({
  setupController(controller, model) {
    this._super(controller, model);
    controller.reset && controller.reset();
  }
});
{% endhighlight %}

After that, you just need to define a `reset` method in your controller that
'resets' the necessary props!
