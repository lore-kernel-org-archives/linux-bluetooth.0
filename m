Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC483B@dnce01.ent.ti.com>
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
	<7769C83744F2C34A841232EF77AEA20C01DCBC483B@dnce01.ent.ti.com>
Date: Mon, 31 Oct 2011 07:07:26 -0400
Message-ID: <CAJdJm_M0cK5YzpHeWhjLdm+Tekej3nGue_Dc44nT-Ba6Fo7S+A@mail.gmail.com>
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

On Mon, Oct 31, 2011 at 3:19 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> Ok, I see a trend here :) We are now discussing about the current
>> Generic API implementation and not about doc/attribute-api.txt nor
>> your patch right? Ideally the .txt doc should always reflect the .c
>> code, but currently it is not the case. I suggest we get back to the
>> API discussion, then we can fix the code to behave like documented. Is
>> that ok?
>>
> Unless I misunderstood, the doc/attribute-api.txt describes the generic API? Or is it called somewhat else? I'm talking about the DBUS interface which enables external GATT Clients to be implemented on top of DBUS.

Yes, it is the so called "generic API", although this unofficial alias
is too generic for my taste :).

>> If it was meant to be some cache, I think it could be mentioned on the
>> API document. The reason it is only read once is implementation
>> limitation, not the API.
>>
> Ok. I understand this now. You were responding as if you were totally aware of the problematic current implementation, and this is why it was so strange and difficult to understand your arguments. Now that we agree on the fact that the property "Value" Should always be read, Can we also make sure that the Value property should be omitted from the "get_properties" response, in case there is no connection?

Note I did not actually agree the Value (as a property) should always
be read over-the-air, I was explaining it is not a cache at all, but a
"read once" value. For me it is a sort of limitation, because you
can't use it in all use cases (the same way I explained that ReadValue
method is not ok in all other use cases as well).

I would rather go with Ajay's suggestion for now, and in short term
(as your ReadValue implementation evolves) we drop Value if we indeed
see it as redundant. As long as we don't declare this API stable
(which it is not currently), I see no problem postponing the decision
of whether keeping Value or not.

> What about writing the value? Should we allow the user to set the value with either Write request/Write Command/Write signed or do we really want to keep that internal (like read/read blob) ?

Again, If I were to implement it, I would stick with the core spec
requirements, and checking Characteristic Properties and the link
encryption status for deciding which operation to use. But if you
really think it is useful to allow D-Bus clients "break" spec
requirements some times, you can provide this control. This particular
detail is not my main concern :).

>> Again, you are assuming a Core spec's "client" as a D-Bus client. This
>> may mean we have not been on the same page since long :)
>>
> Why do you think it will not work ? the DBUS for me is just a transparent transport for GATT operations. It should not have too much logic in it. The code mentioned above is also a bit problematic for me, since it hides some of the GATT functionality, and I'm not sure I'm still comfortable with this kind of encapsulation. Why do you think allowing the user to set the security level correctly before reading, or after getting the ATT_ECODE_INSUFF_ENC is wrong ?

If you allow "application A" to set seclevel by itself, it will affect
any other applications (on the same host) which share the same
connection, but are working with other services. Now some may say this
is not common, but it is, if you are able to see IOP results on BT SIG
mailing lists , you can see some interesting combinations of profiles.

On the other hand, if BlueZ takes care of this, it will do what is
best to keep all apps happy.

> What do we benefit from hiding so much from the DBUS user who implements the profile? As I said before, I would rather let the DBUS client implementing the profile as much flexibility and control, to prevent future major changes to API when we realize we forgot something important.

And here I can argue that, on the other hand, giving "full control"
means you need to keep that "complete" API for a long time, and if you
think you made a mistake allowing applications to do that much, you
cannot go back. Extending the API , on the other hand, is easier.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
