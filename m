Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
Date: Wed, 23 Jul 2014 09:18:58 -0700
Message-ID: <CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

> Of course if DBus has these array object of characteristic property, there is more clear and easy for client to get. However, in my opinion, bluez just put out least but enough information in DBus Hierarchy for application to use. Just you said, to add array object property , this could even be a simple boolean property such as "DiscoveryComplete". That would be add more property in DBus, so on the contrary it would not let DBus Hierarchy look simple and clear.
> Through the objectAdded and InterfaceAdded Signal, application can acquire this subset of object in fact.

Explain to me how, using only the InterfacesAdded signal, an
application can know that all characteristic objects under a service
hierarchy have been added? The only way is if the external application
already knows about service it's interacting with, which is not the
case if you're building a generic application API on top of
bluetoothd. Without what I'm proposing, you can't build a generic GATT
application API without requiring cumbersome event handling for each
service, characteristic, and descriptor object as they get added and
have only partial access to these objects in the handlers as the
objects are getting processed. This might be fine for low-level
applications that interact with D-Bus directly, but for higher level
app developers this is a real issue that we want to handle properly
and make their lives easier.


>why adapter did not export array object of devices and device not export array object of services ?

Because it doesn't need to. You always deal with individual devices as
they get added. You do NOT have this hierarchy with adapter where
doing anything meaningful with the adapter requires you to have seen a
certain set of multiple device objects.


> I am totally ok with generic notify API to application, but I am afraid that there would be conflict between LE profile and generic notify API. Because application does not know RegisterWatcher method has enable the notification. I do not know org.bluez.Inprogress error code could warn this condition or not.
>

You're right, as we move to the new shared GATT/ATT stack, we will
have to change the way the LE plugins work. We need an internal API
for bluetoothd that will handle discovery and other resource
management (such as the CCC write) among daemon plugins and external
applications. Without that, there will be conflict since the plugins,
as they are today, perform these operations directly.

Eventually what we want is to allow plugins to expose methods such as
RegisterWatcher but have that call an internal API method so that
UnregisterWatcher won't cause a write to the CCC descriptor if an
external app called StartNotify on that characteristic and vice versa.

So yes, there will be conflict unless we fix the whole stack, but
that's what we'll do as we deprecate attrib/*.


> BTW, you saidi that calling WriteValue on the CCC descriptor will always fail with WriteNotPermitted. I think gatt_write_char function can write CCC descriptor , do you mean in WriteValue method to refuse write CCC descriptor on purpose and return WriteNotPermitted ?

Yes, I meant the latter (WriteValue method will refuse on purpose).

Cheers and thanks for the comments,
Arman
