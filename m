Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Mon, 31 Oct 2011 08:19:14 +0100
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCBC483B@dnce01.ent.ti.com>
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
 <CAJdJm_MWFbfwZ6LGdUnJV6LzT4XRLFC17rsKXV4jMwSAOd5PSQ@mail.gmail.com>
In-Reply-To: <CAJdJm_MWFbfwZ6LGdUnJV6LzT4XRLFC17rsKXV4jMwSAOd5PSQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

 
> Hi Chen,
> 
> We have been talking about consistence inside a single host. What has
> another "xyz" stack to do with making sure apps on the *same host* can
> run together and even access the same services?
> 
I agree. Let's keep it simple for now.

> (This is not how it works on current implementation, but we already
> know that right?) You just keep reading the Value property in some
> loop in your code:
> 
> while <blah>:
>     read-Value-property
> 
> If the connection is up, the ATT commands will be sent as soon as
> possible. If not, connection is triggered, and then the ATT read
> request/command is sent, and then PropertyChanged signal (should be)
> sent.
> 
That's ok with me. We need to implement it in the DBUS API. We need to try and read the char value and return it as part of the response.

> 
> Anyway, in Proximity, the characteristic values are not supposed to be
> polled (TX Power, for instance, should only read it once on each
> connection). So at least for Value reads, it is not useful as example.
> 
I agree. Proximity is a bad example. Health thermometer on the other hand is a good example for the need to poll the value.

> Same reason as above. The rationale I gave you is based on how attio
> connection callbacks work, if the Generic API does not use it yet for
> reading values, surely this rationale does not apply to the current
> implementation. We are still discussing the API, right?

Yes, we are. I'm just trying to figure out how it's currently implemented


> Ok, I see a trend here :) We are now discussing about the current
> Generic API implementation and not about doc/attribute-api.txt nor
> your patch right? Ideally the .txt doc should always reflect the .c
> code, but currently it is not the case. I suggest we get back to the
> API discussion, then we can fix the code to behave like documented. Is
> that ok?
> 
Unless I misunderstood, the doc/attribute-api.txt describes the generic API? Or is it called somewhat else? I'm talking about the DBUS interface which enables external GATT Clients to be implemented on top of DBUS.

> 
> If it was meant to be some cache, I think it could be mentioned on the
> API document. The reason it is only read once is implementation
> limitation, not the API.
> 
Ok. I understand this now. You were responding as if you were totally aware of the problematic current implementation, and this is why it was so strange and difficult to understand your arguments. Now that we agree on the fact that the property "Value" Should always be read, Can we also make sure that the Value property should be omitted from the "get_properties" response, in case there is no connection? What about writing the value? Should we allow the user to set the value with either Write request/Write Command/Write signed or do we really want to keep that internal (like read/read blob) ?

> 
> It seems you are mapping the Core Spec's "client" definition as a
> D-Bus client. This will *not* work. A client (as per Core spec) is
> BlueZ. If it it provides external D-Bus API, it is out of scope for
> the specification.
> 
> BTW, it seems the client.c code already do something like that
> (update_char_value()):
> 
>         else if (status == ATT_ECODE_INSUFF_ENC) {
>                 GIOChannel *io = g_attrib_get_channel(gatt->attrib);
> 
>                 if (bt_io_set(io, BT_IO_L2CAP, NULL,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
>                                 BT_IO_OPT_INVALID)) {
>                         gatt_read_char(gatt->attrib, chr->handle, 0,
>                                         update_char_value, current);
>                         return;
>                 }
>         }
> 
> But for sure it will require review after we agree on how to handle
> this.
>
> 
> Again, you are assuming a Core spec's "client" as a D-Bus client. This
> may mean we have not been on the same page since long :)
>
Why do you think it will not work ? the DBUS for me is just a transparent transport for GATT operations. It should not have too much logic in it. The code mentioned above is also a bit problematic for me, since it hides some of the GATT functionality, and I'm not sure I'm still comfortable with this kind of encapsulation. Why do you think allowing the user to set the security level correctly before reading, or after getting the ATT_ECODE_INSUFF_ENC is wrong ? What do we benefit from hiding so much from the DBUS user who implements the profile? As I said before, I would rather let the DBUS client implementing the profile as much flexibility and control, to prevent future major changes to API when we realize we forgot something important.

Best regards,
Chen Ganir.

