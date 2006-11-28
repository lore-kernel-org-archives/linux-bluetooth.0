Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 28 Nov 2006 10:43:14 -0700
Message-ID: <77ADC7D0C96B1F44A924DC4E952A5E0E0123D103@AZ25EXM01.gddsi.com>
In-Reply-To: <1164687160.13955.9.camel@aeonflux.holtmann.net>
From: "Turley, Scott-P27856" <Scott.Turley@gdc4s.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trying to connect using a BCSP dongle
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

I'm using kernel version 2.6.9-5.EL (kernel for RedHat Enterprise v4.0).
Here's what shows up in /var/log/messages:

Bluetooth:  HCI device and connection manager initialized
Bluetooth:  HCI socket layer initialized 
Bluetooth:  HCI UART driver ver 2.1
Bluetooth:  HCI H4 protocol initialized
Bluetooth:  HCI BCSP protocol initialized

Then it hangs.

-Scott


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, November 27, 2006 9:13 PM
To: BlueZ users
Subject: Re: [Bluez-users] Trying to connect using a BCSP dongle

Hi Scott,

> I'm trying to connect a bluetooth module using the BCSP transport on a

> Linux machine.
> 
> I have all my services running, but when I try notifying the Linux 
> bluez stack that the transport will be bcsp using:
> "hciattach ttyS0 bcsp", the Linux PC locks up.  I have to reboot to 
> recover.

which kernel version do you use. Can you call "dmesg -n 8" and try it
again from the console to catch possible error messages from the kernel.

Regards

Marcel



------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT Join
SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
