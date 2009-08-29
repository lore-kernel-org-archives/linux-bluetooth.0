Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251482074.966253.827.nullmailer@galant.ukfsn.org>
References: <113d36d80908260307g59eead24v9311d612c8541ad0@mail.gmail.com>
	 <1251309847.2950.96.camel@localhost.localdomain>
	 <113d36d80908270833q4eb7b4eg8d512fdd34e6ca83@mail.gmail.com>
	 <1251401414.2950.122.camel@localhost.localdomain>
	 <113d36d80908280234m34473a05n45654ab37a484ed0@mail.gmail.com>
	 <1251478713.2950.128.camel@localhost.localdomain>
	 <1251482074.966253.827.nullmailer@galant.ukfsn.org>
Date: Sat, 29 Aug 2009 19:19:18 +0800
Message-ID: <113d36d80908290419r7a6674f8p687158be2bcb1c82@mail.gmail.com>
Subject: Re: can we increase the send buffer size of rfcomm socket?
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Iain Hibbert <plunky@rya-online.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lain,

2009/8/29 Iain Hibbert <plunky@rya-online.net>:
> On Fri, 28 Aug 2009, Marcel Holtmann wrote:
>
>> > Yes, it's our kernel's problem. We used another version and it worked
>> > fine. Here the change in rfcomm_sock_alloc() is only for testing. What
>> > I'm doing now is adding a case for RFCOMM_SNDBUF in the function
>> > rfcomm_sock_setsockopt_old(), as below.
>> >
>> > =A0 =A0 case RFCOMM_SNDBUF:
>> > =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_sndbuf =3D opt;
>> > =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >
>> > I'm thinking to add a limitation for a maximum buffer size, but don't
>> > know what maximum size is appropriate here. Do you have any idea?
>>
>> no that is bluntly wrong. Why do you think the function has _old in its
>> name. It clearly shows that we are going to deprecate it soon. If you do
>> this for RFCOMM, then it should also be done for L2CAP. So make sure you
>> use SOL_BLUETOOTH. And make it similar to what TCP is doing.
>
> Eh? Why would you need to invent a SOL_BLUETOOTH setting for this when
> there is a standard "SOL_SOCKET, SO_SNDBUF" option that covers it already=
?
>
> =A0http://www.opengroup.org/onlinepubs/000095399/functions/setsockopt.htm=
l
>
> regards,
> iain
>
>
>
>

Lain, you are right. I tried setsockopt with level SOL_SOCKET and opt
SO_SNDBUF, it worked well. So, Bluetooth socket can set all the
standard sock options, no need to add extra code for that. Thanks a
lot for your suggestion.

Marcel, also thank you for considering this issue these days.

Thanks,
Zhu Lan
