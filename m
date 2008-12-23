Return-Path: <cyrus@holtmann.org>
Subject: Re: understading bluetooth init
From: Claudio Fiorini <claudio@cfiorini.it>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1229993505.8047.19.camel@californication>
References: <1229977280.13720.5.camel@netbimbo>
	 <1229993505.8047.19.camel@californication>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 20:11:54 +0100
Message-Id: <1230059514.11446.19.camel@netbimbo>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your answer.
I'm using an arduino board and a ps3 gamepad to move 3 servos for a
small robotic arm. I would like to put a BT dongle to the arduino, the
one that is used from a normal computer, without buy a bluetooth module
that cost too much for now because my arm is just a prototype for
something that i'll build in the few months.
Anyway to make it short, i don't need to make huge data transfer, but
just some bytes, so i can skip many USB and BT features to do that?

I know something about bluez because is searched inside source code to
create Rbluez, ruby c extension, but i tried to find out what exactly
happen, in kernel space and user space, when i plug a usb dongle but,
for me, is too much now.

Maybe to start this search you can tell me which file is have to
investigate!

Thanks

claudio


On Tue, 2008-12-23 at 01:51 +0100, Marcel Holtmann wrote:
> Hi Claudio,
> 
> > is there any point of start to know what exactly happens when i plug a
> > BT dongle in my usb port? I mean what code is sent to BT through USB?
> 
> this is kinda generic broad questions that can't be answered here
> quickly by anybody. It would take some time to write this up. Why are
> you asking?
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

