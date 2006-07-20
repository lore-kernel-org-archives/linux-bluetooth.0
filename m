Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Wolfgang =?iso-8859-1?q?M=FCes?= <wolfgang@iksw-muees.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 20 Jul 2006 17:52:47 +0200
References: <200607200028.47928.info@david-geiger.de>
	<44BEC4AC.4050203@xmission.com>
	<1153379075.25515.5.camel@pc044.coreteam.oslo.opera.com>
In-Reply-To: <1153379075.25515.5.camel@pc044.coreteam.oslo.opera.com>
MIME-Version: 1.0
Message-Id: <200607201752.47834.wolfgang@iksw-muees.de>
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

On Thursday 20 July 2006 09:04, Per Thomas Jahr wrote:
> On Wed, 2006-07-19 at 17:47 -0600, Brad Midgley wrote:
> > the bus has to fall back to usb1 speeds when a usb1 device
> > on the bus is active.
>
> That was really useful information!

And a really wrong information....

The truth is: every USB device needs time to make their transfers.
Slow devices need more time than fast. The host is switching between 
slow, fast and high speed devices dynamicly.

So a slow device can "steal" much of the available transfer time of the 
bus, and slow down fast devices on the same bus. But a slow device can 
not urge the host to serve a high speed device with a lower speed.

regards
Wolfgang
-- 
We're back to the times when men were men 
and wrote their own device drivers.

(Linus Torvalds)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
