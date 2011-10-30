Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC47E3@dnce01.ent.ti.com>
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
	<7769C83744F2C34A841232EF77AEA20C01DCBC47E3@dnce01.ent.ti.com>
Date: Sun, 30 Oct 2011 14:02:27 -0400
Message-ID: <CAJdJm_MWFbfwZ6LGdUnJV6LzT4XRLFC17rsKXV4jMwSAOd5PSQ@mail.gmail.com>
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

On Sun, Oct 30, 2011 at 11:48 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> > What happens if this value is written from another client ?
>>
>> A property changed signal is emitted, and any client listening to it
>> will know of the new value written to the server. This can be good for
>> consistency between apps looking at the same service IMHO.
>>
> Anderson - what if this value changes from another client from another device?

We have been talking about consistence inside a single host. What has
another "xyz" stack to do with making sure apps on the *same host* can
run together and even access the same services?

> What if this value changes on the server itself, and notification is not enabled? The client will need a way to poll the real time values, and not use a stale or cached value which is a big mistake here.

(This is not how it works on current implementation, but we already
know that right?) You just keep reading the Value property in some
loop in your code:

while <blah>:
    read-Value-property

If the connection is up, the ATT commands will be sent as soon as
possible. If not, connection is triggered, and then the ATT read
request/command is sent, and then PropertyChanged signal (should be)
sent.

>> Polling is still possible, you simply keep reading the Value property
>> periodically. If the connection is up, the value comes in "real time".
>> If not, bluez will arrange re-connection in background.
>>
> This is not reflected in the generic API at all. Maybe this functionality is also missing and only present in the proximity profile ?

Taking a look at the current generic API source code, you are right,
it is only happening at Value writes, not read.

Anyway, in Proximity, the characteristic values are not supposed to be
polled (TX Power, for instance, should only read it once on each
connection). So at least for Value reads, it is not useful as example.

>
>> > I could not find in the upstream code any other gatt_read_char ,
>> except for when connection is established.
>>
>> It only makes sense (and only works) if there is a connection up
>> right? If the connection is already up, the "connected" callback will
>> be called immediately (sort of, it may be called on next main loop
>> iteration).
>>
> I don't really see how this makes sense. If the connection is already up, is it forbidden to re-read the value directly from the server ? I did not see in the generic code "get_properties" function any reference to att_io functionality at all -the function just reads the chr variable, and returnes dbus message with the current properties. No attempt to re-read the value is even made.

Same reason as above. The rationale I gave you is based on how attio
connection callbacks work, if the Generic API does not use it yet for
reading values, surely this rationale does not apply to the current
implementation. We are still discussing the API, right?

>> This means: if you register a *intention* to use the connection, and
>> the link is already up, the connected callback is called "immediately"
>> (on next GLIB mainloop iteration).
>>
> I only wrote this since the only possibility available currently for the generic GATT API to read a value from the server is to reconnect. Otherwise, the gatt_read_... function is never called.

Ok, I see a trend here :) We are now discussing about the current
Generic API implementation and not about doc/attribute-api.txt nor
your patch right? Ideally the .txt doc should always reflect the .c
code, but currently it is not the case. I suggest we get back to the
API discussion, then we can fix the code to behave like documented. Is
that ok?

>> Simply because SetProperty() modifies the property, and
>> PropertyChanged() notifies property changes, this way you can notify
>> other clients that a new value has been written on the peer device, as
>> well as the "writer" client. Other clients can ignore the signal if
>> they are not interested on it.
>>
> Other clients running on the same host, connected to the same DBUS (assuming it actually implements this, which currently it does not). If the other client is running on a separate device, it will not get any signal from it's dbus, and will only wait for notification/indication or simply poll periodicall for the value.

I honestly don't see why this matters. We have been talking about
BlueZ consistency on the same host (two or more applications using the
same API), when did another device enter the game?

>> Again, assuming this can be done just like Proximity Monitor, what are
>> your concerns about it?
>>
> Still, I do not think that returning a cached/stale value is the correct way. You intentionally return a bad value, which you know may no longer be the correct one, and risk a client taking decisions upon your assumption that it's ok to return a bad value. Take the health thermometer example again - if the connection is down - the client MUST know about it, and the value should not be returned until it is read from the server again.

If PropertyChanged() were emitted, there would be no such "cache".
Even now, it is not a cache. It is a "read once" behavior, which of
course is inappropriate for any dynamic service (most are dynamic).

If it was meant to be some cache, I think it could be mentioned on the
API document. The reason it is only read once is implementation
limitation, not the API.

>> In my opinion, giving too much control to all clients may risk they
>> not being able to co-operate, making the D-Bus API any better than
>> letting all apps read/write on bluetooth sockets directly.
> I'd like to allow clients to do it because the GATT profile spec allows you to use ANY GATT Client API's such as write with or without response, write a value when the link is not authenticated, or do whatever you like. It's not like opening a socket (GATT or L2cap - same result). GATT Profile is a high level profile, not like the ATT protocol. Taking control of everything, leaving the client no choice is the best practice to avoid problems, but its also the best way to frustrate them when the need to do something which you did not think of at first place. I think making the API a bit more flexible is not going to strain the DBUS or do any harm.

It will simply allow apps to (intentionally or not) mess with each
other, on the *same host* (just to be clear). But I think I repeated
this too much already :)

Also if the spec says "... shall not ..." I think we should really
consider not allowing it on the (D-Bus) API as well.

>> Yes, this is one point where we can surely improve. The current
>> behavior was simply "cloned" from BR/EDR.
>>
>> I think one of the patches Andre Guedes has been working on is a first
>> step on this (actually it is a bug fix to an issue found on UPF where
>> ATT requests made during SMP pairing may be lost), and we should
>> probably send it this week. But we still need to implement support on
>> ATT layer to increase security level when necessary.
>>
> ATT layer does not need to do such a thing ! This is the responsibility of the profile client, and no one elses. The spec specifically defines the ATT error codes regarding the security , and how clients should handle those errors.

It seems you are mapping the Core Spec's "client" definition as a
D-Bus client. This will *not* work. A client (as per Core spec) is
BlueZ. If it it provides external D-Bus API, it is out of scope for
the specification.

BTW, it seems the client.c code already do something like that
(update_char_value()):

        else if (status == ATT_ECODE_INSUFF_ENC) {
                GIOChannel *io = g_attrib_get_channel(gatt->attrib);

                if (bt_io_set(io, BT_IO_L2CAP, NULL,
                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
                                BT_IO_OPT_INVALID)) {
                        gatt_read_char(gatt->attrib, chr->handle, 0,
                                        update_char_value, current);
                        return;
                }
        }

But for sure it will require review after we agree on how to handle this.

>> I think that, if the spec only allows certain operations on certain
>> conditions (see the "shall only"), the D-Bus should comply to this.
>> This may help a lot when qualifying BlueZ based products against the
>> Core spec. If apps want full control, again, they can use the socket
>> based API (you can even still use the GATT and ATT functions, just
>> like gatttool).
>>
> Anderson - you keep mentioning the socket API - what is that exactly ? Where is it documented? How do we work with it ?

It is the API used by attrib/client.c itself and attrib/gatttool.c. No
documentation AFAIK.

> D-BUS is not the client here. It should not make decisions of a client. The client is the D-BUS user, which will try to build profiles on top of that API according to the specs.

Again, you are assuming a Core spec's "client" as a D-Bus client. This
may mean we have not been on the same page since long :)

>> If you have any interest on Reliable Writes, feel free to propose some
>> API, so we can discuss :).
>>
> Making the write command a generic one as I suggested on my RFC is exactly that, unifying all the write API's into a single call, with parameters.

For Reliable Writes it should simply not work for all its use cases.
It is not atomic as your proposal suggests.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
