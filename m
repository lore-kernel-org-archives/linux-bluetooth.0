Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Wolfgang =?utf-8?q?M=C3=BCes?= <wolfgang@iksw-muees.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Need help with PAND between 2  linux boxes
References: <pan.2004.08.14.22.56.57.538948@yahoo.com> <1092645247.4375.86.camel@pegasus>
In-Reply-To: <1092645247.4375.86.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200408161208.43504.wolfgang@iksw-muees.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 Aug 2004 12:08:43 +0200

Hello,

On Monday 16 August 2004 10:34, Marcel Holtmann wrote:
> Hi Paul,
>
> > I have two linux boxes with FedoraCore 2 installed on both.
> > Both of them have USB bluetooth adapters.
> > I have tried to connect them in a NAP - PANU config, as indicated
> > in http://bluez.sourceforge.net/contrib/HOWTO-PAN, but something is
> > not working and I can't figure out what.

> > pand[1431]: Connect to 00:20:E0:73:EB:F7 failed. Function not
> > implemented(38)

I have seen this too... Master = Suse 9.1, Slave = Zaurus C 750.
I have managed to get it working by disabling authentication on the 
master box....

best regards
Wolfgang


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
