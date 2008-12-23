Return-Path: <cyrus@holtmann.org>
Subject: Re: understading bluetooth init
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Fiorini <claudio@cfiorini.it>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1230059514.11446.19.camel@netbimbo>
References: <1229977280.13720.5.camel@netbimbo>
	 <1229993505.8047.19.camel@californication>
	 <1230059514.11446.19.camel@netbimbo>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 00:10:40 +0100
Message-Id: <1230073840.4954.12.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

first things first, don't top-post on the mailing list. It is a proper
open source mailing list that uses bottom posting and inline quoting.

> I'm using an arduino board and a ps3 gamepad to move 3 servos for a
> small robotic arm. I would like to put a BT dongle to the arduino, the
> one that is used from a normal computer, without buy a bluetooth module
> that cost too much for now because my arm is just a prototype for
> something that i'll build in the few months.
> Anyway to make it short, i don't need to make huge data transfer, but
> just some bytes, so i can skip many USB and BT features to do that?
> 
> I know something about bluez because is searched inside source code to
> create Rbluez, ruby c extension, but i tried to find out what exactly
> happen, in kernel space and user space, when i plug a usb dongle but,
> for me, is too much now.
> 
> Maybe to start this search you can tell me which file is have to
> investigate!

as I said before, there is no easy answer to such a question. You can
grab one of my old presentation that I did around 2003, but even that
might not help that much. It is a really complex system. Sorry, there is
nothing I can really do in a quick answer. If you wanna look into the
kernel code, look at net/bluetooth/ and include/net/bluetooth/. The
actual drivers for the USB dongle is at drivers/bluetooth/btusb.c.

Regards

Marcel


