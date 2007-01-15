Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45ABC826.10404@xmission.com>
Date: Mon, 15 Jan 2007 11:29:58 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150257.21542.bluez-devel@huitl.de>	<45AB5679.8050606@palmsource.com>
	<200701151909.39305.bluez-devel@huitl.de>
In-Reply-To: <200701151909.39305.bluez-devel@huitl.de>
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

Robert

> On the other hand, why is a scan able to interfere with communication? Is this 
> behavior by design (because the hardware can only either scan or send/receive 
> data)?

a scan hijacks the radio briefly and I believe there is no way around it.

there's one unrelated thing you could try. Do you have any other
bluetooth devices? I had to force my computer to be master in hcid.conf:

lm accept,master;
lp hold,sniff,park;

otherwise moving the bluetooth mouse or using bluetooth dun would
interrupt a2dp.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
