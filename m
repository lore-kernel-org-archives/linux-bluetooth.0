Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A174A7.3040707@xmission.com>
Date: Sun, 07 Jan 2007 15:31:03 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070107120608.05a65c7f@ningauble.scrye.com>
In-Reply-To: <20070107120608.05a65c7f@ningauble.scrye.com>
Subject: Re: [Bluez-devel] 2 plugz issues
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

Kevin

> 2. Once I comment out that code from 1 above, my headset works fine and
> sounds ok. However, if I do anything that sends a DTMF from my sip
> phone (I am using twinkle) it causes twinkle to go into a 100% cpu
> spin, and once to totally lock up my machine. Any idea why DTMF would
> cause that? Is there any way I can test or get more info to track down
> the problem?

please try it with plugz/patches/sco-flowcontrol-v3.0.diff applied.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
