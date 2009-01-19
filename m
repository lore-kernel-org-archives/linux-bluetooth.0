Return-Path: <cyrus@holtmann.org>
Subject: Re: disconnect incoming ACL connection
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=E5=8D=9E=E7=A3=8A?= <mykofzone@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a172fe730901190223g3b425950v63075fe91daa402f@mail.gmail.com>
References: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
	 <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
	 <1232292253.5095.21.camel@californication>
	 <a172fe730901190223g3b425950v63075fe91daa402f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Jan 2009 11:30:41 +0100
Message-Id: <1232361041.19390.9.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

please _don't_ use top posting. I am considering to just ignore any kind
of top-posting emails.

>      I try it in kernel 2.6.27.2 (including bluez patch), but this
> problem still exist. But when testing another headset, SonyEricsson,
> this problem does not appear on both 2.6.18 and 2.6.27. So, i guess
> it's not a issue of kernel. BTW, my BlueZ lib/utils is 3.26. Does it
> cause this issue? Thanks.

it could be that we have some file descriptor leaks that caused it. I
would rather try bluez-4.27 since that is recent and not an old version
that is in maintenance mode.

Regards

Marcel


