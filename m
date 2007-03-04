Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Mark Lord <lkml@rtr.ca>
In-Reply-To: <45EAE1D6.10900@rtr.ca>
References: <45EADD78.1030300@rtr.ca>  <45EAE1D6.10900@rtr.ca>
Date: Sun, 04 Mar 2007 18:33:36 +0100
Message-Id: <1173029616.5752.9.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
        "David S. Miller" <davem@sunset.davemloft.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [Regression] Bluetooth RFComm: using it locks up
	the machine
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mark,

> > Any attempt to open/use a bluetooth rfcomm device locks up
> > scheduling completely on my machine.
> > 
> > Interrupts (ping, alt-sysrq) seem to be alive, but nothing else.
> > 
> > This was working fine in 2.6.20, broken now in 2.6.21-rc2-git*
> 
> Further info:  Reverting this change (below) fixes it:
> 
> | author	Marcel Holtmann <marcel@holtmann.org>
> | 	 Sat, 17 Feb 2007 22:58:57 +0000 (23:58 +0100)
> | committer	David S. Miller <davem@sunset.davemloft.net>
> | 	 Mon, 26 Feb 2007 19:42:41 +0000 (11:42 -0800)
> | commit	c1a3313698895d8ad4760f98642007bf236af2e8
> | tree	337a876f727061362b6a169f8759849c105b8f7a	tree | snapshot
> | parent	f5ffd4620aba9e55656483ae1ef5c79ba81f5403	commit | diff
> | 
> | [Bluetooth] Make use of device_move() for RFCOMM TTY devices
> | 
> | In the case of bound RFCOMM TTY devices the parent is not available
> | before its usage. So when opening a RFCOMM TTY device, move it to
> | the corresponding ACL device as a child. When closing the device,
> | move it back to the virtual device tree.
> | Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> 
> Specifically, I reverted these changes, below, to fix it:

please post these information to the Linux kernel mailing list, because
I think that must be an issue with the device_move() API. I tested this
successfully with a Quad G5 and it was working as expected.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
