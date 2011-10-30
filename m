Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC472E@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
	<CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
	<CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
	<CAJdJm_NKmrx-qieUFMibPSL3L17=-nwKEjQrfvmf77HFsU8yaw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4234@dnce01.ent.ti.com>
	<CAJdJm_M5LS6o4yiiG-7-KedUF6_dafYbLX=Vqj0QJ4rV926gpg@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC4275@dnce01.ent.ti.com>
	<CAJdJm_Pjn=7DWPES9fdZJntSfi_h14WxWfORuoRa+tWwnk9Dfw@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCBC472E@dnce01.ent.ti.com>
Date: Sun, 30 Oct 2011 10:23:09 -0400
Message-ID: <CAJdJm_P2X+rMH1Apo7Z_TjwR4WCtdeQZL2Mq3f73xkgy1=UpJw@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Sun, Oct 30, 2011 at 2:56 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Anderson,
>
>> The PropertyChanged signal will be emitted once the value is written.
>> Applications should listen to this signal if they want to know when/if
>> the value has been updated on peer device. So if the application has
>> some requirement to have the value written in, let's say, 20 seconds,
>> it starts a timer when doing a SetProperty(). If the timer expires and
>> PropertyChanged was not received, the value can be considered as "not
>> written yet". It is up to the application what to do later.
>>
> I could not find this in the upstream code. Can you please point me to where this happens?

Sorry, my mistake. This is actually how the Proximity Monitor API
works, not the Generic API. Look for emit_property_changed() in
proximity/monitor.c. We haven't touched the Generic API in a while
(last big change was on July).

Assuming this could work just like Proximity Monitor, do you see any
issues on this approach?

> What happens if this value is written from another client ?

A property changed signal is emitted, and any client listening to it
will know of the new value written to the server. This can be good for
consistency between apps looking at the same service IMHO.

> What happens if this value is
> changed by the server at some unknown time, and the client is responsible for updating this value occasionally by polling the server ?

Polling is still possible, you simply keep reading the Value property
periodically. If the connection is up, the value comes in "real time".
If not, bluez will arrange re-connection in background.

> I could not find in the upstream code any other gatt_read_char , except for when connection is established.

It only makes sense (and only works) if there is a connection up
right? If the connection is already up, the "connected" callback will
be called immediately (sort of, it may be called on next main loop
iteration).

>> The value *can* only be updated once the connection is established. a
>> SetProperty() may trigger this connection. But it will *not* block
>> waiting for the connection establishment (which may be between "now"
>> and "never"). You monitor the PropertyChanged signal to know when/if
>> the value was written.
>>
> Again, you force a specific scenario, where you believe that the server should notify/indicate the client of any changes. What if not ?

There is no restriction or requirement on notifications/indications
here. Notifications/indications are solely handled by the
RegisterCharacteristicsWatcher() callback.

PropertyChanged() has to be emitted when bluez is finally able to
*read* the value (after restoring link). But as I said on first
paragraph, this is currently only implemented in Proximity API, sorry.

> What if the profile requires you to poll ? For example, the health thermometer notification/indication is only optional. What will a client do if it needs to poll for a new value? Should it disconnect and reconnect ?

No. You seem to be confused about the semantics of attio connection
callbacks. See btd_device_add_attio_callback() in src/device.c, it
has:

if (device->attrib && cfunc) {
...
    g_idle_add(notify_attios, device);
...

and notify_attios() has:

...
g_slist_foreach(device->attios_offline, attio_connected, device->attrib);
...

This means: if you register a *intention* to use the connection, and
the link is already up, the connected callback is called "immediately"
(on next GLIB mainloop iteration).

>> The value update is started by the time SetProperty() is called. But
>> it is not guaranteed to finish by the time it returns. You should
>> listen to the PropertyChanged signal for that.
>>
> I don't get why you bind setProperty with value change here.

Simply because SetProperty() modifies the property, and
PropertyChanged() notifies property changes, this way you can notify
other clients that a new value has been written on the peer device, as
well as the "writer" client. Other clients can ignore the signal if
they are not interested on it.

>> The "update process" is started by GetProperties(), but it will not
>> block. you have PropertiesChanged for knowing then the "fresh" value
>> has been read.
>>
> I could not find this either in the code.

Same reason as on my first paragraph. I confess I didn't look at the
client.c code lately, and had proximity/monitor.c in mind.

> Nothing here does any of the things you suggest. If I'm wrong, let me know where it does that.

Again, assuming this can be done just like Proximity Monitor, what are
your concerns about it?

>> You need to ask this for the guys who implemented the concept :) But
>> AFAIK it is so to avoid too many D-Bus round trips.
>>
> So to avoid too many round trips I need to get all the information at once ? Characteristic Properties are values that do not change frequently. Char properties, write permissions for example are set and fixed. Value however is changing all the time. I do not see a reason to put all those together - I do not need to get the write modes each time I get a value.

Sorry, I think this thread is splitting into too many discussions.
Feel free to create separate threads if you want to propose any
changes on this regard, maybe others with more experience on D-Bus can
give better answers (they might not be reading all this thread). But
this is what I remember when asking about similar thing in the past.

>> > 3. Writing to the value property needs to be done in one of 4
>> methods. How do you support that in the existing bluez property format
>> ?
>>
>> Based on what the characteristic supports, and the state of the link.
>> See below.
>>
> So again, we take the easy way to decide what's best for the user, instead of giving him control.

In this particular case, I don't see why allow the user to use any
write method, if the properties or security mode does not allow it as
per spec. If the user wants full control, why not simply open a socket
and send commands, like gatttool does?

In my opinion, giving too much control to all clients may risk they
not being able to co-operate, making the D-Bus API any better than
letting all apps read/write on bluetooth sockets directly.

>> I can't find such "authenticated write".
>>
> Authenticated write is write on an encrypted link. In GATT /GAP LE specs, it is not required to establish a link and immediately raise the security level. It is assumed that the client can read the ATT error code, and figure out that the write needs encryption, so the client may initiate security mode change. Currently, we force the link security mode upgrade on connection according to bond state.

Yes, this is one point where we can surely improve. The current
behavior was simply "cloned" from BR/EDR.

I think one of the patches Andre Guedes has been working on is a first
step on this (actually it is a bug fix to an issue found on UPF where
ATT requests made during SMP pairing may be lost), and we should
probably send it this week. But we still need to implement support on
ATT layer to increase security level when necessary.

BTW, we already support Security Request if they come from a slave.

>
>>
>> "This sub-procedure is used to write a Characteristic Value to a server
>> when the
>> client knows the Characteristic Value Handle and the ATT Bearer is not
>> encrypted. This sub-procedure shall only be used if the Characteristic
>> Proper-
>> ties authenticated bit is enabled and the client and server device
>> share a bond
>> as defined in [Vol. 3] Part C, Generic Access Profile."
>>
>> Do you see that all necessary information to know when to use it or
>> not is already known by BlueZ?
>>
> Yes. I see that. However, I'm not sure we need to take control over decisions like this.

I think that, if the spec only allows certain operations on certain
conditions (see the "shall only"), the D-Bus should comply to this.
This may help a lot when qualifying BlueZ based products against the
Core spec. If apps want full control, again, they can use the socket
based API (you can even still use the GATT and ATT functions, just
like gatttool).

>> To me, it seems support for Reliable Writes require a separate set of
>> functions, if we want to support both usecases listed on the spec.
>>
> So we need to be prepared, and make sure the API stays and does not change too much when we do add support for this type of write.

I hope you agree the current "generic" Attribute API, as is, is not
complete nor stable. Marking it "stable", as it is, will certainly not
help app developers. I hope you guys keep contributing to it until we
can jointly mark it as stable.

If you have any interest on Reliable Writes, feel free to propose some
API, so we can discuss :).

>> Note that there is a condition, for "optional" on server. The server
>> cannot add/remove services during its lifetime, or at least cannot
>> change the attribute handles. We don't have this guarantee as well, as
>> handles are allocated dynamically during each plugin initialization.
>>
> Yes. How do we currently handle a request for updating services and characteristics? Do we remove all old object paths and create new ones ?

You mean notifications of Service Changed service from a peer device?
There is no implementation, as I said. We do not even look for this
service during service discovery. Patches are welcome!

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
