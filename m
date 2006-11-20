Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <456234FB.4020506@xmission.com>
Date: Mon, 20 Nov 2006 16:06:35 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455392B6.5060209@free.fr> <45622D23.7070105@vasmac.com>
In-Reply-To: <45622D23.7070105@vasmac.com>
Subject: Re: [Bluez-devel] New bluetooth-headset release 20061109 : nickname
 'dogfood' ; -)
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

Jose

> Regarding the kernel patches, you know I've taken a different
> approach. I believe that what I posted is simpler and more reliable
> as it doesn't depend timers. The flow control approach avoids the
> possibility of getting out of sync with the dongle.

fyi, I talked to Marcel about this and he likes solving it at a higher
level so the transports (usb/uart/sdio) don't have to each have their
own solution. Maybe he could articulate it better...

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
