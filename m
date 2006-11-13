Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <006001c70746$476c1800$0200a8c0@BLACKBIRD>
References: <006001c70746$476c1800$0200a8c0@BLACKBIRD>
Date: Mon, 13 Nov 2006 18:22:27 +0100
Message-Id: <1163438547.26272.55.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Problem with 2nd second dongle
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

Hi,

> Here is the information you requested:
> 
> Nov 13 16:56:00 ts7200 daemon.info hcid[214]: Bluetooth HCI daemon
> Nov 13 16:56:00 ts7200 daemon.info sdpd[217]: Bluetooth SDP daemon
> Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 registered
> Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 up
> Nov 13 16:57:50 ts7200 daemon.info hcid[214]: Starting security manager 0
> Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 down
> Nov 13 16:57:50 ts7200 daemon.info hcid[214]: Stoping security manager 0
> Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 unregistered
> Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 registered
> Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 up
> Nov 13 16:57:51 ts7200 daemon.info hcid[214]: Starting security manager 0
> Nov 13 16:58:05 ts7200 daemon.info hcid[214]: HCI dev 1 registered
> Nov 13 16:58:15 ts7200 daemon.err hcid[252]: Can't init device hci1:
> Connection timed out (110)

there you have your problem.

> $ ls /proc/bus/usb/devices
> ls: /proc/bus/usb/devices: No such file or directory

You have to mount that filesystem first.

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
