Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Sun, 30 Oct 2011 16:48:07 +0100
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC47E3@dnce01.ent.ti.com>
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
 <CAJdJm_P2X+rMH1Apo7Z_TjwR4WCtdeQZL2Mq3f73xkgy1=UpJw@mail.gmail.com>
In-Reply-To: <CAJdJm_P2X+rMH1Apo7Z_TjwR4WCtdeQZL2Mq3f73xkgy1=UpJw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,
 
> Sorry, my mistake. This is actually how the Proximity Monitor API
> works, not the Generic API. Look for emit_property_changed() in
> proximity/monitor.c. We haven't touched the Generic API in a while
> (last big change was on July).
> 
> Assuming this could work just like Proximity Monitor, do you see any
> issues on this approach?
>
Ok, so there are things missing in the generic API behavior.

 
> > What happens if this value is written from another client ?
> 
> A property changed signal is emitted, and any client listening to it
> will know of the new value written to the server. This can be good for
> consistency between apps looking at the same service IMHO.
> 
Anderson - what if this value changes from another client from another device? What if this value changes on the server itself, and notification is not enabled? The client will need a way to poll the real time values, and not use a stale or cached value which is a big mistake here.

> 
> Polling is still possible, you simply keep reading the Value property
> periodically. If the connection is up, the value comes in "real time".
> If not, bluez will arrange re-connection in background.
> 
This is not reflected in the generic API at all. Maybe this functionality is also missing and only present in the proximity profile ?

> > I could not find in the upstream code any other gatt_read_char ,
> except for when connection is established.
> 
> It only makes sense (and only works) if there is a connection up
> right? If the connection is already up, the "connected" callback will
> be called immediately (sort of, it may be called on next main loop
> iteration).
> 
I don't really see how this makes sense. If the connection is already up, is it forbidden to re-read the value directly from the server ? I did not see in the generic code "get_properties" function any reference to att_io functionality at all -the function just reads the chr variable, and returnes dbus message with the current properties. No attempt to re-read the value is even made.


> 
> There is no restriction or requirement on notifications/indications
> here. Notifications/indications are solely handled by the
> RegisterCharacteristicsWatcher() callback.
> 
> PropertyChanged() has to be emitted when bluez is finally able to
> *read* the value (after restoring link). But as I said on first
> paragraph, this is currently only implemented in Proximity API, sorry.
> 
> > What if the profile requires you to poll ? For example, the health
> thermometer notification/indication is only optional. What will a
> client do if it needs to poll for a new value? Should it disconnect and
> reconnect ?
> 
> No. You seem to be confused about the semantics of attio connection
> callbacks. See btd_device_add_attio_callback() in src/device.c, it
> has:
> 
> if (device->attrib && cfunc) {
> ...
>     g_idle_add(notify_attios, device);
> ...
> 
> and notify_attios() has:
> 
> ...
> g_slist_foreach(device->attios_offline, attio_connected, device-
> >attrib);
> ...
> 
> This means: if you register a *intention* to use the connection, and
> the link is already up, the connected callback is called "immediately"
> (on next GLIB mainloop iteration).
> 
I only wrote this since the only possibility available currently for the generic GATT API to read a value from the server is to reconnect. Otherwise, the gatt_read_... function is never called.

> 
> Simply because SetProperty() modifies the property, and
> PropertyChanged() notifies property changes, this way you can notify
> other clients that a new value has been written on the peer device, as
> well as the "writer" client. Other clients can ignore the signal if
> they are not interested on it.
> 
Other clients running on the same host, connected to the same DBUS (assuming it actually implements this, which currently it does not). If the other client is running on a separate device, it will not get any signal from it's dbus, and will only wait for notification/indication or simply poll periodicall for the value.

> 
> Again, assuming this can be done just like Proximity Monitor, what are
> your concerns about it?
> 
Still, I do not think that returning a cached/stale value is the correct way. You intentionally return a bad value, which you know may no longer be the correct one, and risk a client taking decisions upon your assumption that it's ok to return a bad value. Take the health thermometer example again - if the connection is down - the client MUST know about it, and the value should not be returned until it is read from the server again. 

> 
> In this particular case, I don't see why allow the user to use any
> write method, if the properties or security mode does not allow it as
> per spec. If the user wants full control, why not simply open a socket
> and send commands, like gatttool does?
> 
> In my opinion, giving too much control to all clients may risk they
> not being able to co-operate, making the D-Bus API any better than
> letting all apps read/write on bluetooth sockets directly.
I'd like to allow clients to do it because the GATT profile spec allows you to use ANY GATT Client API's such as write with or without response, write a value when the link is not authenticated, or do whatever you like. It's not like opening a socket (GATT or L2cap - same result). GATT Profile is a high level profile, not like the ATT protocol. Taking control of everything, leaving the client no choice is the best practice to avoid problems, but its also the best way to frustrate them when the need to do something which you did not think of at first place. I think making the API a bit more flexible is not going to strain the DBUS or do any harm.

> 
> >> I can't find such "authenticated write".
> >>
> > Authenticated write is write on an encrypted link. In GATT /GAP LE
> specs, it is not required to establish a link and immediately raise the
> security level. It is assumed that the client can read the ATT error
> code, and figure out that the write needs encryption, so the client may
> initiate security mode change. Currently, we force the link security
> mode upgrade on connection according to bond state.
> 
> Yes, this is one point where we can surely improve. The current
> behavior was simply "cloned" from BR/EDR.
> 
> I think one of the patches Andre Guedes has been working on is a first
> step on this (actually it is a bug fix to an issue found on UPF where
> ATT requests made during SMP pairing may be lost), and we should
> probably send it this week. But we still need to implement support on
> ATT layer to increase security level when necessary.
> 
ATT layer does not need to do such a thing ! This is the responsibility of the profile client, and no one elses. The spec specifically defines the ATT error codes regarding the security , and how clients should handle those errors. 

> 
> I think that, if the spec only allows certain operations on certain
> conditions (see the "shall only"), the D-Bus should comply to this.
> This may help a lot when qualifying BlueZ based products against the
> Core spec. If apps want full control, again, they can use the socket
> based API (you can even still use the GATT and ATT functions, just
> like gatttool).
> 
Anderson - you keep mentioning the socket API - what is that exactly ? Where is it documented? How do we work with it ?
D-BUS is not the client here. It should not make decisions of a client. The client is the D-BUS user, which will try to build profiles on top of that API according to the specs.

> 
> I hope you agree the current "generic" Attribute API, as is, is not
> complete nor stable. Marking it "stable", as it is, will certainly not
> help app developers. I hope you guys keep contributing to it until we
> can jointly mark it as stable.
> 
> If you have any interest on Reliable Writes, feel free to propose some
> API, so we can discuss :).
> 
Making the write command a generic one as I suggested on my RFC is exactly that, unifying all the write API's into a single call, with parameters.

Thanks,
Chen.

