Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: thomas.kear@gmail.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200610261319.41239.thomas.kear@gmail.com>
References: <200610261319.41239.thomas.kear@gmail.com>
Date: Sun, 29 Oct 2006 21:16:21 +0100
Message-Id: <1162152981.4720.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hidd connect permissions
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

Hi Thomas,

> # hidd -n --server
> hidd[32412]: Bluetooth HID daemon
> hidd[32412]: Rejected connection from unknown device 00:12:EE:07:95:48
> (same result running as non-root user)

connect from the Linux machine once again. It needs to store the HID
descriptor and authorize the phone first.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
