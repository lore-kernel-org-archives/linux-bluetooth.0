Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: paivakil@gmail.com (Mahesh T. Pai)
Date: Tue, 06 Feb 2007 21:38:38 +0530
Message-ID: <8764afs1yx.fsf@nandini.home>
References: <20070124212526.2de68b62@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid behing a hub usb
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

Andres Vargas - zodman <zod@linuxmerida.org> writes:

> im using a usb-hub and get some errors with hcid...
> and im conect the bluetooh on mi usb-hub with my mouse-usb ... 

I read somewhere (while trying to solve my own problem) that bluez
does not work with usb-hubs. 

> lagrutadelzod:/home/andy# lsusb 
> Bus 001 Device 029: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter

> lagrutadelzod:/home/andy# hciconfig  -a
> hci0:   Type: USB
>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10

And that makes you the third person (including me) to report a device
with the same macid on this list.

-- 
 Mahesh T. Pai <<>> http://paivakil.blogspot.com/
Copying an idea is plagiarism. Copying many ideas
from many authors is RESEARCH.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
