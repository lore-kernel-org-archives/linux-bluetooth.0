Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: rfcomm sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+V-a8v1DaXL=S850KWaBt-ykDGr_533y8bAkpKq+NMoiVRncA@mail.gmail.com>
Date: Fri, 25 Sep 2015 17:05:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0582BDEB-2274-4130-B13A-C122B86FFDAA@holtmann.org>
References: <CA+V-a8v1DaXL=S850KWaBt-ykDGr_533y8bAkpKq+NMoiVRncA@mail.gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhakar,

> I am using 5.34 bluez-5 stack on linux kernel version 3.14. when I
> create rfcomm connection and do cat /dev/rfcomm0 and from other
> terminal send AT commands to rfcomm0 I get proper response and other
> characters continuously(> ??? ...) echoed from rfcomm0.
> If I do the same from bluez4-101 I get proper response with no other characters.
> 
> What is the proper way to do rfcomm communication ? I am trying to
> connect to a OBD device via rfcom socket.

the /dev/rfcomm0 is a TTY. You have to set it to the right mode (most cases raw mode) to make sure that no extra characters are inserted. If you use rfcomm connect command, then the --raw switch might help.

Regards

Marcel

