Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: jp-www@dcs.gla.ac.uk
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [ANNOUNCE] ALSA Bluetooth Headset Driver
In-Reply-To: <3F65CD1D.1020100@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.54.999.0309151532340.27929@brava.dcs.gla.ac.uk>
References: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
 <3F65CD1D.1020100@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Sep 2003 15:51:11 +0100 (BST)

On Mon, 15 Sep 2003 3:30pm +0100, James Courtier-Dutton wrote:

> I was also working on this. Do you have full duplex sound working ?
> I was under the impression that changes needed to be made to the
> bluetooth stack before full duplex worked.

Yes, full duplex seems to work. I've tested this out using the ALSA 0.9
driver for the Robust Audio Tool.

In fact, at the low level full duplex is a necessity since the outgoing
SCO frames are currently clocked by the arrival and sizing of incoming
frames. I haven't tried implementing any timers to replace this, but it's
something that would be worth investigating.

I'm glad to hear you're also working on a driver -- no doubt more ideas on
good ways of implementation would be useful. How far have you got?

Thanks.


PS:

I've just noticed a line missing from my patch, which will show up if you
don't already have the snd-hwdep.o module installed:

Add this line to alsa-driver-0.9.6/alsa-kernel/core/Makefile:

obj-$(CONFIG_SND_BLUEZ_SCO) += snd-pcm.o snd-page-alloc.o snd.o snd-hwdep.o



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
