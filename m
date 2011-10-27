Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC4275@dnce01.ent.ti.com>
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
Date: Thu, 27 Oct 2011 13:32:02 -0400
Message-ID: <CAJdJm_Pjn=7DWPES9fdZJntSfi_h14WxWfORuoRa+tWwnk9Dfw@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Oct 27, 2011 at 12:47 PM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Anderson
>
>>
>> If the user tried to read the Value property, it will return
>> immediately with "cached" value if not connected (which is an actual,
>> not invented value read before by this or some other application),
> A value which is cached, can be there for several minutes, hours or days. It is not relevant, since it is not the value from the sever. This could be a value of a patient in a hospital bed, and as far as the client is concerned (doctor), the patient temperature is ok, although the patient may be actually dead (the termperature is updated only at connection or on notification). Notification in health thermometer is only optional, so if the server did not implement notification, and the client only reads the value once on connection, and the client did not disconnect for hours, the value read by the client is invalid.

The PropertyChanged signal will be emitted once the value is written.
Applications should listen to this signal if they want to know when/if
the value has been updated on peer device. So if the application has
some requirement to have the value written in, let's say, 20 seconds,
it starts a timer when doing a SetProperty(). If the timer expires and
PropertyChanged was not received, the value can be considered as "not
written yet". It is up to the application what to do later.

>> then attempt connection. After connection is done, the read request is
>> done, the value is updated, and a PropertyChanged signal is sent.
>>
> So again, basically, what you are saying here is that value is only updated when a connection is established. This is wrong. Value should be updated each time a client requests the value.

The value *can* only be updated once the connection is established. a
SetProperty() may trigger this connection. But it will *not* block
waiting for the connection establishment (which may be between "now"
and "never"). You monitor the PropertyChanged signal to know when/if
the value was written.

>> That is why we use Value as a property and not a method like you are
>> suggesting. Clients should be monitoring the PropertyChanged signals
>> all the time.
>>
> That's fine by me, as long as the value is also updated upon use request as well.

The value update is started by the time SetProperty() is called. But
it is not guaranteed to finish by the time it returns. You should
listen to the PropertyChanged signal for that.

>> And another way is like it is currently :) a Value property for
>> read/writing,  and PropertyChanged signal for when the new value is
>> read/written. I fail to see a difference between what you suggest
>> above. BlueZ has this "Property" concept for quite some time.
>>
> Properties are great, but need to be update correctly. I don't mind keeping it the way it is, but a fix is required for the following issues:
> 1. Values need to be updated when a user tries to read them (getProperties).

The "update process" is started by GetProperties(), but it will not
block. you have PropertiesChanged for knowing then the "fresh" value
has been read.

> 2. Why should I get all the properties every time I want the value ? Char properties may be constant throughout a session, but it's value may change frequently.

You need to ask this for the guys who implemented the concept :) But
AFAIK it is so to avoid too many D-Bus round trips.

> 3. Writing to the value property needs to be done in one of 4 methods. How do you support that in the existing bluez property format ?

Based on what the characteristic supports, and the state of the link. See below.

>> The only limitation is that we can't control which operation is used
>> for write (write without response vs. write request). But... what if
>> we detect that by the characteristic properties (like we discussed for
>> notification/indication in another message). Again, if both are
>> supported, Write Request takes priority because it is more "reliable".
>>
> What about authenticated write and signed write ? What about reliable write method?

I can't find such "authenticated write".

"Signed write without response" (also known as "authenticated signed
write"): from the spec:

"This sub-procedure is used to write a Characteristic Value to a server when the
client knows the Characteristic Value Handle and the ATT Bearer is not
encrypted. This sub-procedure shall only be used if the Characteristic Proper-
ties authenticated bit is enabled and the client and server device share a bond
as defined in [Vol. 3] Part C, Generic Access Profile."

Do you see that all necessary information to know when to use it or
not is already known by BlueZ?

Reliable Writes: This is a different beast. According to the spec, it
can be used in two situations:

* "assurance is required that the correct Characteristic Value is
going to be written..."
* "multiple values must be written, in order, in a single operation"

Both usecases cannot be satisfied on current API, and not even on your proposal.

To me, it seems support for Reliable Writes require a separate set of
functions, if we want to support both usecases listed on the spec.

>> If by "discover" you mean service discovery, it is already done "for
>> free" during pairing. The core spec says that this information is
>> valid for the time of bonding, and if some service needs to be added,
>> the server shall implement Service Changed. (BTW we don't support
>> Service Changed yet, neither as client nor server).
>>
> The service changed is mandatory for clients, optional for servers. If we intend to keep the cache of services/characteristics, we need to handle service changed notification. Otherwise, we must not cache and read the services on each connection.

Patches implementing the client side are welcome :)

Note that there is a condition, for "optional" on server. The server
cannot add/remove services during its lifetime, or at least cannot
change the attribute handles. We don't have this guarantee as well, as
handles are allocated dynamically during each plugin initialization.

> Regards,
> Chen Ganir.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
