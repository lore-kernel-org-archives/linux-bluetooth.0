Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232361041.19390.9.camel@californication>
References: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
	 <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
	 <1232292253.5095.21.camel@californication>
	 <a172fe730901190223g3b425950v63075fe91daa402f@mail.gmail.com>
	 <1232361041.19390.9.camel@californication>
Date: Wed, 21 Jan 2009 14:42:55 +0800
Message-ID: <a172fe730901202242j401a291al2273caff42d4d90@mail.gmail.com>
Subject: Re: disconnect incoming ACL connection
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
   I found the dbus interface of bluez-4.27 has been changed, so the
qtopia can't work against this bluez. Which is the lastest version
 that keep the old dbus interface? I think i can try it first. Thanks.

2009/1/19 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
> please _don't_ use top posting. I am considering to just ignore any kind
> of top-posting emails.
>
>>      I try it in kernel 2.6.27.2 (including bluez patch), but this
>> problem still exist. But when testing another headset, SonyEricsson,
>> this problem does not appear on both 2.6.18 and 2.6.27. So, i guess
>> it's not a issue of kernel. BTW, my BlueZ lib/utils is 3.26. Does it
>> cause this issue? Thanks.
>
> it could be that we have some file descriptor leaks that caused it. I
> would rather try bluez-4.27 since that is recent and not an old version
> that is in maintenance mode.
>
> Regards
>
> Marcel
>
>
>
