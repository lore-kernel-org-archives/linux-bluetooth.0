Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 15 Jan 2007 13:51:03 -0500
References: <200701150257.21542.bluez-devel@huitl.de>
	<200701151909.39305.bluez-devel@huitl.de>
	<45ABC826.10404@xmission.com>
In-Reply-To: <45ABC826.10404@xmission.com>
MIME-Version: 1.0
Message-Id: <200701151351.03730.akohlsmith-bluez@benshaw.com>
Subject: Re: [Bluez-devel] a2dpd: audio connection breaks every 300 seconds
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

On Monday 15 January 2007 1:29 pm, Brad Midgley wrote:
> a scan hijacks the radio briefly and I believe there is no way around it.

What about making the driver a little smarter?  perhaps having some kind 
of "realtime" (poor choice of word perhaps) that prevents things from taking 
over the radio like this if an application is using it?

> there's one unrelated thing you could try. Do you have any other
> bluetooth devices? I had to force my computer to be master in hcid.conf:
>
> lm accept,master;
> lp hold,sniff,park;
>
> otherwise moving the bluetooth mouse or using bluetooth dun would
> interrupt a2dp.

This is interesting... I'm still going over the email that Marcel and Steven 
sent about a month ago detailing the lowlevel BT radio details.  Very, very 
good reading.

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
