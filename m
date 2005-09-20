Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200509201146.j8KBkFrv047951@smtp-vbr6.xs4all.nl>
From: "Han Hoekstra" <Han.Hoekstra@WirelessValue.nl>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Re:BlueCore2 speed problem!
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127216481.5168.19.camel@localhost.localdomain>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Sep 2005 13:46:15 +0200

Hey Gadfly,

Not sure if you already have the answer, but the reason that you can attach
only at 57600 is that the speed is programmed into the BlueCore2, so you
have to change the setting in the BlueCore2 before you can attach at a
higher speed. We change the settings of the BlueCore2 here using PSTools, a
windows application from CSR.

Greetigns,
   Han


---
Han Hoekstra
Wireless Value B.V.
Waanderweg 30a
7812 HZ  Emmen
Tel: +31-591-633200

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: dinsdag 20 september 2005 13:41
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re:BlueCore2 speed problem!

Hi Gadfly,

> 
> I use this hciattach :hciattach /dev/ttyS1 any 57600 noflow But I 
> change it to 115200,it says :Can't init device hci0: Connection timed 
> out (110)!!
> It seems that only 57600 is ok!!  What can I do next?

why don't you use csr (or even bcsp) as type.

Regards

Marcel





-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
