Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FC39A264-7D93-4BAA-9A85-7ACA6B762583@holtmann.org>
References: <CAE2MWkn0RBeZpiJy_6t0-3zs_DCikX4Qxqpa-FGr0MYWnOM_vw@mail.gmail.com>
	<FC39A264-7D93-4BAA-9A85-7ACA6B762583@holtmann.org>
Date: Thu, 12 Feb 2015 14:32:20 +0530
Message-ID: <CAE2MWkmrdftQjzqkVwHTjYZYH_XRyvPmG=q0ZJzCxJ5MAEt4Tw@mail.gmail.com>
Subject: Re: Query: HCI_RAW mode in Kernel 3.18
From: Ujjal Roy <royujjal@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

> what you want is to use the HCI User Channel if you need direct access to=
 the HCI layer of a controller. Look at tools/3dsp.c and tools/ibeacon.c fo=
r examples on how to use it. In src/shared/hci.c you find the internal deta=
ils of the HCI User Channel. It is a lot cleaner way of using a controller'=
s HCI interface exclusively.
>
> Regards
>
> Marcel
>

So, can you please help me to write an app? Is it possible to compile
an app without using the bluez? I mean without placing and compiling
the app inside bluez source code.
If I want to create an app then what library should I have to include
to compile successfully. Please suggest a way to build my own app to
use user channel.
