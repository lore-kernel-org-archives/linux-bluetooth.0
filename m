Return-Path: <cyrus@holtmann.org>
From: Alok <alokbarsode@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
	Jui-Hao Chiang <windtracekimo@gmail.com>
In-Reply-To: <loom.20080627T113221-342@post.gmane.org>
References: <loom.20080627T113221-342@post.gmane.org>
Date: Fri, 27 Jun 2008 17:37:19 +0530
Message-Id: <1214568439.9706.8.camel@greatbear>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Questions about SCO support hci_usb
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

I think Marcel has written a new usb driver(btusb) which does support 
multiple SCO connections(I am not sure).

On Fri, 2008-06-27 at 11:52 +0000, Jui-Hao Chiang wrote:
> Dear All:
>   Does the latest Bluez support 3 simultaneous SCO links from one USB dongle to
> 3 cell phones?
> (According to the discussion thread
> http://thread.gmane.org/gmane.linux.bluez.devel/12893/focus=12903, the
> hci_usb.c is not fully patched support well)

The patch was for hci_usb.c. Me and Whoopie had tested it for 2
simultaneous SCO connections. If your using hci_usb, you will need the
alternate setting patch.

-Alok.
>   
> Bests regards,
> Jui-Hao
> 
> 
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
