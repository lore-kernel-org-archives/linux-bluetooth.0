Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Peter Johanson <peter@peterjohanson.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Philips PC Card + 2.6.10 kernel.
Message-ID: <20050114132329.GC23441@butchy.cubesearch.com>
References: <20050114051845.GA23441@butchy.cubesearch.com> <1105688837.7525.21.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105688837.7525.21.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 14 Jan 2005 05:23:29 -0800

On Fri, Jan 14, 2005 at 08:47:17AM +0100, Marcel Holtmann wrote:
<snip/>
> > dmesg, after implementing the small patch discussed here to recognize the card
> > http://www.cs.helsinki.fi/linux/linux-kernel/2002-08/1374.html:
> > 
> > PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
> > ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> > ttyS14: detected caps 00000700 should be 00000100
> > ttyS14 at I/O 0x4010 (irq = 11) is a 16C950/954
> > 
> > Having found the specs based on the FCC ID on the FCC site, i know this
> > is the OXford Semiconductor chipset with a BlueCore01 inside. As such, I
> > tried:
> > gonzo root # hciattach /dev/ttyS14 bcsp 921600
> > BCSP initialization timed out
> 
> It can also work in H4 mode and then you need to use "csr" or your baud
> rate is wrong. The hciattach tool gives you a lot of parameters and you
> should try some of them.

I've tried both csr and bcsp at all the available baud rates listed in
the man page, with the same results. The only other options available
seem to be either the initialization timeout, or flow/noflow. Should i
try the various permutations involving flow/noflow as well?

> 
> > Was there ever any success in finding out what had changed for the user
> > who reported success for 2.6.10-r1-mm2? Any suggestions on ways to debug
> > this? Thanks in advance.
> 
> Since Fabrizio works for Philips, you might wanna contact him and don't
> forget to put me on CC. It seems that the current kernel is still
> missing some patches. And btw feel free to donate one of these cards to
> me for testing.
> 

I'll try contacting him, thanks. I only have one of these cards, so a
permanent donation isn't really an option for me, but if a temporary
loan would help, I'd be more than willing to if none of my poking
results in a working card for me.

Thanks,

-pete

> Regards
> 
> Marcel
> 
> 

-- 
Peter Johanson
<latexer@gentoo.org>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
