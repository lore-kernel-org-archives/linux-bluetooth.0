Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OfTBZed2aAYQssGS4HhBV5tDt95=NaMy6qevShKCwnBQ@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
	<CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
	<CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
	<CAJdJm_MYn=eG93WTPmHWu98t3Ufqrc9pXDpdBbCvbT-JdYeOaw@mail.gmail.com>
	<CACUGKYPSTh0CcN6fKc9NcbYmvZK3j8AwfNnMqkBkoTt-UFccSg@mail.gmail.com>
	<CAJdJm_PwrHdWnp6xXoYzd8GLigO3YSHdS-6feVj+c-9u3sjk5A@mail.gmail.com>
	<CACUGKYNPWDCbQgtA6u33NXn_U3CMm9q6vGqEAaA9FOPPjqeJiw@mail.gmail.com>
	<CACUGKYPf+2ZP6y5rfy8kbnanxCJt3pL800E6bHNO6WUSifQW+A@mail.gmail.com>
	<CAJdJm_MFT=KTREZavd_oaOVT24+jUsAXH=d-K8F0Rwyi6V1rQg@mail.gmail.com>
	<CACUGKYMKHvoAbH97-QLbxxYic_+5WjONc76mO642ywf6Jo-5+A@mail.gmail.com>
	<CACUGKYNEYREQTM4s7vGcjHLij9KB4Sav2Zi-S0SLZREe+K+XPg@mail.gmail.com>
	<CAJdJm_OfTBZed2aAYQssGS4HhBV5tDt95=NaMy6qevShKCwnBQ@mail.gmail.com>
Date: Mon, 17 Sep 2012 14:21:21 -0700
Message-ID: <CACUGKYN1_7X4P_-_NNVUOTERWzw=ib6fwWyUeqo7aF3gXUge_w@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: John Tobias <john.tobias.ph@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Thanks for the info., we will be going to snip what the iOS is sending
to understand the scenario. I think iOS stack has some handshaking
procedure or required in order to maintain the connection. I used
gatttool to connect to the CC2540 demo board and it did not disconnect
like the iOS does.

Regards,

John


On Mon, Sep 17, 2012 at 1:30 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi John,
>
> On Fri, Sep 14, 2012 at 3:04 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hi Anderson,
>>
>> Could you give me some bit of information on how to respond to the
>> handle 0x0039?. I'm digging the bluez sources but I'm kind a lost
>> right now and I don't know exactly what library/function should I use
>> in order to configure it.
>
> I suggest you take a look on GATT Procedures on the Core spec (see
> "Discover All Characteristics of a Service" on pages 1916 and the
> Figure 4.5 on page 1917). You will see that "Attribute not found" is
> used to inform the client that there are no more characteristics to
> discover.
>
> Also see channel_handler() in src/attrib-server.c (and the functions
> called by it) to understand how BlueZ's GATT server work.
>
> To avoid the GATT disconnection after 30 sec. you really need to
> figure out what the iPhone app is trying to do, it is clear from your
> hcidump logs that iPhone is disconnecting, not the Linux "client"
> side.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
