Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 15 Jan 2007 20:23:47 +0100
References: <200701150257.21542.bluez-devel@huitl.de>
	<200701151909.39305.bluez-devel@huitl.de>
	<45ABC826.10404@xmission.com>
In-Reply-To: <45ABC826.10404@xmission.com>
MIME-Version: 1.0
Message-Id: <200701152023.47802.bluez-devel@huitl.de>
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

On Monday 15 January 2007 19:29, Brad Midgley wrote:
> Robert
>
> > On the other hand, why is a scan able to interfere with communication? Is
> > this behavior by design (because the hardware can only either scan or
> > send/receive data)?
>
> a scan hijacks the radio briefly and I believe there is no way around it.
>
> there's one unrelated thing you could try. Do you have any other
> bluetooth devices? I had to force my computer to be master in hcid.conf:
>
> lm accept,master;
> lp hold,sniff,park;

I already have these lines in hcid.conf. I had an rswitch in the link policy, 
but removing it does not change.

But I found the program scanning every 300 seconds. This is a feature of 
kbluetoothd, disabling it results in perfectly gapless playback.

Thanks to everyone on this list helping me to get those issues sorted out. Now 
I'm quite happy with my headset :)

Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
