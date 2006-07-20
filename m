Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BFACAA.40108@xmission.com>
Date: Thu, 20 Jul 2006 10:17:46 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200607200028.47928.info@david-geiger.de>	<44BEC4AC.4050203@xmission.com>	<1153379075.25515.5.camel@pc044.coreteam.oslo.opera.com>
	<200607201752.47834.wolfgang@iksw-muees.de>
In-Reply-To: <200607201752.47834.wolfgang@iksw-muees.de>
Subject: Re: [Bluez-users] CSR BlueCore4 dongles
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

Wolfgang

>>>the bus has to fall back to usb1 speeds when a usb1 device
>>>on the bus is active.

> The truth is: every USB device needs time to make their transfers.
> Slow devices need more time than fast. The host is switching between 
> slow, fast and high speed devices dynamicly.

Sure... I didn't mean to imply that usb2-to-usb2 transfers would start
using usb1 speeds, only that the usb1 device keeps the bus busier than
you might expect. By active I meant transferring data.

All bets are off when data starts getting constricted. My usb2 burner
would choke while burning sometimes if I used a usb mouse on the same bus.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
