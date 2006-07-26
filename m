Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux@feline-soul.com
In-Reply-To: <200607260140.10216.Linux@feline-soul.com>
References: <200607260027.41270.Linux@feline-soul.com>
	<1153898346.746.4.camel@localhost>
	<200607260140.10216.Linux@feline-soul.com>
Date: Wed, 26 Jul 2006 09:46:10 +0200
Message-Id: <1153899970.746.28.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Page timeout on Logetech cordless elite
	keyboard	but mouse works
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Bearcat,

> hidd --server is indeed running. 
> 
> At my start up i do:
> modprobe hidp
> /usr/bin/hidd --server
> hid2hci -0
> /usr/bin/hidd --connect 00:07:61:1d:29:32
> 
> That connects the mouse just fine. However the keyboard never wakes up.  Even 
> removing and replacing a battery does nothing. A "/usr/bin/hidd --connect 
> 00:07:61:1B:50:9B" just gives me the time out error. (forget the MAC i 
> entered below, i cut/paste the wrong one). Nothing appears in my syslogs when 
> i do a hdd --connect.

the "hidd --connect ..." should only be used once. Every further connect
will be done by the keyboard or the mouse. I stated this various times.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
