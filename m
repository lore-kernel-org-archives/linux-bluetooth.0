Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 12:56:59 +0200
From: Christian Birchinger <joker@netswarm.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Auto trust entry remove
Message-ID: <20100524105659.GA19294@netswarm.net>
References: <20100524083330.GA18128@netswarm.net>
 <20100524085344.GA18433@netswarm.net>
 <20100524113122.c084d160.ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100524113122.c084d160.ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 24, 2010 at 11:31:22AM +0200, Antonio Ospite wrote:

First of all i know what prevented the BT HID from being added.
The netlink plugin was disabled and that's required for this
to work. Really stupid mistake.

The device gets added now and for the first time i get input data
from it.

> On Mon, 24 May 2010 10:53:44 +0200
> Christian Birchinger <joker@netswarm.net> wrote:
> 
> Christian, I can only say that it works for me with the kernel patches
> from http://lists.ozlabs.org/pipermail/cbe-oss-dev/2010-May/007274.html
> and an updated sixaxis-cable patch which I haven't published yet
> because it was not final and I didn't want to leave temporary stuff,
> which could be soon deprecated, archived on the Internet; that may
> confuse people.

Thanks for the hint, i just patched my kernel an rebooted. This is the
output when i plug the controller over USB:

sony 0003:054C:0268.0007: input,hiddev96,hidraw3: USB HID v1.11 Joystick [Sony PLAYSTATION(R)3 Controller] on usb-0000:00:1a.0-1.3.4/input0
sony 0003:054C:0268.0007: Calling sixaxis_set_operational_usb
sony 0003:054C:0268.0007: Sony PS3 Controller bdaddr: <controller addr>

So it works fine.

> Let me know if you want me to send this updated sixaxis-cable to you
> privately.

Yes, that would be interesting. Is there some default location to find
the recent public release of it too? I'm alsways exctracting it from
the Fedora srpm.

Thanks a lot for your help
Bye, Christian
