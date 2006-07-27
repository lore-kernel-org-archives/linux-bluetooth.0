Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 27 Jul 2006 22:08:05 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<1153997014.9543.4.camel@localhost>
	<200607271258.45178.fexpop@onlinehome.de>
In-Reply-To: <200607271258.45178.fexpop@onlinehome.de>
MIME-Version: 1.0
Message-Id: <200607272208.06047.fexpop@onlinehome.de>
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
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

On Thursday 27 July 2006 12:58, Felix Homann wrote:

> kbluetoothd finds other devices after that command! (It doesn't make my PC
> visible to other devices though). 

Part of the visibility issue seems to be that only PSCAN will be enabled 
regardless of what I specify in hcid.conf. If I manually do a 'hciconfig hci0 
piscan' everything is fine again. 

Is this a Debian bug?

Kind regards,

Felix

 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
