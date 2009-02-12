Return-Path: <cyrus@holtmann.org>
Subject: Re: Can't find link keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6887eb5d0902112138p1202d15fh95919493d0d93ea9@mail.gmail.com>
References: <6887eb5d0902112138p1202d15fh95919493d0d93ea9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 08:54:07 +0100
Message-Id: <1234425247.7293.35.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

> I m using USB Bluetooth adapter to discover devices & connect to it.
> I can easily discover it using my test program
> But when I m going to connect it to rfcomm, it prompts me to enter PIN
> to accept connection.
> As I m entering PIN the connection fails as it don't find link key in
> /var/lib/bluetooth/
> 
> So I m not able to pair my bluetooth enable Mobile / Headset with
> application running in PC.
> What is its remedie?

if you are using bluez-4.29 then you are hitting a bug that is fixed in
the current tree. You just have to wait for bluez-4.30 then. Will be
released at the end of the day or tomorrow.

Regards

Marcel


