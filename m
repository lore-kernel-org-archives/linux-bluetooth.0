Return-Path: <cyrus@holtmann.org>
Subject: Re: disconnect incoming ACL connection
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=E5=8D=9E=E7=A3=8A?= <mykofzone@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
References: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
	 <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:24:13 +0100
Message-Id: <1232292253.5095.21.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>     I'm debugging Qtopia bluetooth in my EVB, and found this issue:
>     If it is a incoming HFP connection, after pressed "Disconnect
> HFP", the Qtopia only release rfcomm device and disconnect rfcomm
> connection, and the ACL incoming connection can't be
> disconnected(check this by 'hcitool con'). Is this a bug or something
> else? Thanks. And happy new year!
>     My develop environment:
>     kernel : 2.6.18.8 + some patches
>     BlueZ : 3.26
>     BT HW : STLC2500
>     Headset : iTech

that has been fixed, but I can't remember in which kernel version. I
think your kernel is just too old.

Regards

Marcel


