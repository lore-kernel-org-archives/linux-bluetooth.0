Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Tue, 1 Jul 2008 13:32:16 +0000 (UTC)
Message-ID: <loom.20080701T131823-958@post.gmane.org>
References: <loom.20080627T113221-342@post.gmane.org>
	<1214568439.9706.8.camel@greatbear>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] =?utf-8?q?Questions_about_SCO_support_hci=5Fusb?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,  
> I think Marcel has written a new usb driver(btusb) which does support 
> multiple SCO connections(I am not sure).
I find out one tihing: when I try to build up the linux 2.6.24.
The description of btusb itself says "no SCO support now".
Thus, I guess I should abandon this solution. 

> The patch was for hci_usb.c. Me and Whoopie had tested it for 2
> simultaneous SCO connections. If your using hci_usb, you will need the
> alternate setting patch.

Could someone give me some suggestions about the patch things?
(which linux kernel and which version of patch)
I know there are two steps
(1) sco_flowcontrol: 
It seems sco-flowcontrol-v4.3.diff is successful in 2.6.23 from this article
http://thread.gmane.org/gmane.linux.bluez.devel/13852
But why there are two revisions for that? and the latest one is "wrong patch
from whoopie"
http://bluetooth-alsa.cvs.sourceforge.net/
bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.3.diff?view=log
(2) alternate setting
there is a latest patch by Alok
http://thread.gmane.org/gmane.linux.bluez.devel/12893/focus=12903
But I don't know which kernel version it is against?

Appreciate any help
Bests regards,
Jui-Hao


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
