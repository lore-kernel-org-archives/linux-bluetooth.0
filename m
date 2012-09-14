Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMKHvoAbH97-QLbxxYic_+5WjONc76mO642ywf6Jo-5+A@mail.gmail.com>
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
Date: Fri, 14 Sep 2012 12:04:38 -0700
Message-ID: <CACUGKYNEYREQTM4s7vGcjHLij9KB4Sav2Zi-S0SLZREe+K+XPg@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: John Tobias <john.tobias.ph@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Could you give me some bit of information on how to respond to the
handle 0x0039?. I'm digging the bluez sources but I'm kind a lost
right now and I don't know exactly what library/function should I use
in order to configure it.

Regards,

John


On Thu, Sep 13, 2012 at 2:59 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Anderson,
>
> I added these line of codes in gatttool:
>
> listen_start:
> g_attrib_register(attrib, ATT_OP_READ_BY_TYPE_RESP, events_handler,
>                                                         attrib, NULL);
>
> Then, in events_handler I dumped the handles for
> ATT_OP_READ_BY_TYPE_REQ and ATT_OP_READ_BY_TYPE_RESP:
>
> ATT_OP_READ_BY_TYPE_REQ:   handle = 0x1 value: ff ff 00 2a
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x207 value: 00 02 03 00 00 2a 04
> 00 02 05 00 01 2a 07 00 20 08 00 05 2a
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0xb15 value: 00 02 0c 00 31 3d 35
> 06 1e 60 70 a3 8d 4e 58 9c 2d 6a 3c 16
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0xd15 value: 00 8a 0e 00 32 3d 35
> 06 1e 60 70 a3 8d 4e 58 9c 2d 6a 3c 16
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x1015 value: 00 88 11 00 33 3d
> 35 06 1e 60 70 a3 8d 4e 58 9c 2d 6a 3c 16
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x1315 value: 00 9a 14 00 52 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x1715 value: 00 9a 18 00 36 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x1b15 value: 00 9a 1c 00 37 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x1f15 value: 00 8a 20 00 38 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x2215 value: 00 98 23 00 40 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x2615 value: 00 9a 27 00 41 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x2a15 value: 00 98 2b 00 42 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x2e15 value: 00 88 2f 00 60 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x3115 value: 00 88 32 00 61 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x3415 value: 00 12 35 00 62 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
> ATT_OP_READ_BY_TYPE_RESP:   handle = 0x3715 value: 00 8a 38 00 39 72
> 3a 71 ae 82 0c ae e0 49 1d 18 c2 b4 d8 37
>
> In hcidump:
>
>  ACL data: handle 76 flags 0x02 dlen 9
> ATT: Error (0x01)
> Error: Attribute not found (10)
> Read By Type req (0x08) on handle 0x0039
>
>
> In hcidump, the error was the attribute for handle 0x0039. How I can
> respond to that request if the I did not receive the said handle?
>
>
> Regards,
>
> John
>
>
>
> On Thu, Sep 13, 2012 at 1:18 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi John,
>>
>> On Thu, Sep 13, 2012 at 4:11 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>>> Hi Anderson,
>>>
>>> If I add a simple GATT/GAP server on gatttool, should I still use the
>>> DBUS to listen or I can communicate directly to the kernel?.
>>
>> You either talk to bluetoothd (using D-Bus, like those test-* python
>> scripts do), which will handle connections for you, or you talk
>> directly to kernel using bluetooth socket (like gatttool does). You
>> have more flexibility talking to the kernel directly, but your app
>> will not be interoperable with other apps running at the same time,
>> specially if they try to call connect() at the same time (one of them
>> will get a EBUSY error).
>>
>> Using D-Bus, on the other hand, bluetoothd queues the connections properly.
>>
>> So you should use what is more appropriate for your use case.
>>
>> Best Regards,
>> --
>> Anderson Lizardo
>> Instituto Nokia de Tecnologia - INdT
>> Manaus - Brazil
