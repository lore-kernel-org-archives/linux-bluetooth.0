Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87331b13-0aa5-5183-960c-f8df437b4cc2@felipetonello.com>
References: <87331b13-0aa5-5183-960c-f8df437b4cc2@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Sep 2016 22:23:35 +0300
Message-ID: <CABBYNZ+cOvqvU-khroX3C35KNgdT8tMZUqy=SMwhpvQ_tg+hGQ@mail.gmail.com>
Subject: Re: Correct way to write a profile plugin
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Wed, Sep 7, 2016 at 7:49 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi guys,
>
> I've been working on a profile plugin for BlueZ[1] that implements the
> MIDI over BLE spec for some time now. I am close to release an initial
> implementation, but I still have some questions, since it seems that the
> profile plugin is not really working properly, or at least in a way that
> makes sense to me.
>
> This is what I expect from BlueZ:
>
> adapter_probe: called when a any new adapter is probed
> adapter_remove: called when the previous probed adapter is removed
>
> device_probe: called when a device that advertises supports to the
> `remote_uuid' property is probed
> device_remove: when that device is removed
>
> connect: called when a previously probed device is connected to.
> disconnect: called when a previously connected device is disconnected.

This is for BR/EDR profile where it actually initiate the connection,
for disconnect maybe you have a point since it can be called to
cleanup before we disconnect GATT/ATT.

> accept: This is still an incognito for me, but I suppose this is a step
> after the `connect()', once BlueZ has all the gatt_db ready.

This will be called once the LE services is resolved so you can then
take action, it will first match the profile UUID so the db shall be
populated already.

> What actually happens:
>
> Based on my expectations, adapter_probe/remove and device_probe/remove
> are the only callbacks that works.
>
> connect and disconnect are *never* called. accept is called when the
> device is connected, but before the gatt_db is actually populated so I
> can't `gatt_db_foreach_service()'.

That is pretty since bt_gatt_client actually shall be populated,
perhaps we have a bug then, or perhaps this actually intentional
because plugins such as HoG need to enabled right away, in the other
you have access to gatt_db so you can detect when service are being
added, but then again for the first probe we actually need to discover
the service first and after that the attributes are loaded from cache
so I don't know why it is not working for you.

> I noticed that btd_service.state is not properly updated, which means
> that accept is only called on the first connection.

Not properly updated as in the state is not correct? I guess this has
to do with disconnect not being called thus the service don't transit
to disconnected, etc, although you can register a callback to receive
this events it probably make sense to have the profile callback handle
this.

> So in order for me to work, I have patched my branch with some code to
> make it work in the sense I have previously stated, but it is hacky
> since I don't really understand the proper states of this state machine.
>
> Based on this, I could say that we have few bugs happening:
> * btd_service state machine is not working properly, causing several
> side-effects.
> * gatt_db is been populated too late (it should be the first thing after
> a connection)
> * connect, disconnect and accept should be called in proper order
>
> Does it makes sense? I appreciate any comments.
>
> PS: I am always rebasing my code on top of origin/master.
>
> [1] https://github.com/ftonello/bluez
>
> Thanks in advance,
> Felipe



-- 
Luiz Augusto von Dentz
