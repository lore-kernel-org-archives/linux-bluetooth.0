Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <D1EE7DB0.B607%adam.moore@savant.com>
References: <1438364565-24642-1-git-send-email-adam.moore@savantsystems.com>
	<CABBYNZLWpbr36dvPP-QsSTtMjW=zZqU7ZfK7KW8SohBeeTtvbg@mail.gmail.com>
	<D1EE7DB0.B607%adam.moore@savant.com>
Date: Sun, 10 Jan 2016 19:37:19 -0300
Message-ID: <CABBYNZLjRXHYqrRYn0Z7+i9Az0B6oFxxyD1Gt9yrHOMk7O3h_g@mail.gmail.com>
Subject: Re: [PATCH] gatt-database: allow GattService anywhere in
 ObjectManager tree
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Adam Moore <adam.moore@savantsystems.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> Hi Luiz,
>
> You are right - though I still like the initial design of having one
> service per ObjectManager, as it makes it easier to cleanup or restart (or
> D-Bus export/unexport) an individual service at the ObjectManager API
> level.
>
> I only added the pointer to manager_path because it was better to test
> that for that prefix than it was to not do any checking.  I couldn¹t do
> the stronger test for the GattService path because there is no guaranteed
> order to the proxy callbacks.

Please check the patch-set Ive sent last week, the idea is that you
would register the application only once, later on we might implement
support for InterfacesAdded/InterfacesRemoved allowing services to be
added/removed without having to unregistering and registering again.

> How strict do you think we need to be here in validating the parent/child
> relationships in the object tree?

Right now it expects the objects to appear in order, service ->
characteristic -> descriptor, so that we can established proper
relationship between the objects. I did not add any check for multiple
applications within the same connection id except if it is the very
same object path given for the object manager.
