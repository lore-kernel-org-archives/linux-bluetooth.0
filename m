Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 27 Jul 2006 12:10:38 -0300
From: Nelson Murilo <nelson@pangeia.com.br>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060727151038.GE28854@pangeia.com.br>
References: <1153915377.6149.1.camel@anselm.venusberg.augustinnetz.de>
	<20060727143305.GC28854@pangeia.com.br>
	<1154012213.6222.16.camel@anselm.venusberg.augustinnetz.de>
Mime-Version: 1.0
In-Reply-To: <1154012213.6222.16.camel@anselm.venusberg.augustinnetz.de>
Subject: Re: [Bluez-devel] HIDclient: Using a Bluez PC as virtual
	Bluetooth	keyboard and	mouse [repost]
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


Hmmm.

ps auwx | grep hi
root      6147  0.0  0.0   1816   444 ?        Ss   12:08   0:00 /usr/bin/hidd --server

After killed it all works fine now...

./hidclient 
HID keyboard/mouse service registered
Opened event device [/dev/input/event0]
Opened event device [/dev/input/event1]
Opened event device [/dev/input/event2]
Opened event device [/dev/input/event3]
The HID-Client is now ready to accept connections from another machine

Thanks for your help,

./nelson -murilo


> It seems you already have a bluetooth daemon using the PSM 19. I do not
> know which one that might be, but if I remember right, that should be
> reserved for HID!? Sorry I cannot tell you how to find out which program
> that might be. If possible, you could try to shutdown the bluetooth
> daemons currently running, and see wether that port becomes free.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
