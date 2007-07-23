Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1185197769.46a4aec9d9dee@webmail.epfl.ch>
References: <1185197769.46a4aec9d9dee@webmail.epfl.ch>
Date: Mon, 23 Jul 2007 16:21:01 +0200
Message-Id: <1185200461.7111.44.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Use /dev/ttyS* instead of /dev/rfcomm*
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Steve,

> I would like to know if it is possible to use /dev/ttyS* instead of /dev/rfcomm*
> to connect to a bluetooth device.
> Indeed I tried :
> 
> rfcomm connect /dev/ttyS2 xx:xx:xx:xx:xx:xx

that is wrong syntax anyway. No idea who thinks you can give it an
actual device node. It is only a device number from 0 to 255. That will
in the end correlate with number the X on /dev/rfcommX. However the
actual naming of the device node is up to udev and we don't force it. If
you don't give it a number (for example /dev/ttyS2) it will convert it
into 0 since it uses atoi() as parsing function.

As a side node. Using -1 will create the next free RFCOMM TTY device
node.

And btw. what the f* are you trying to do? Your question makes no sense
whatsoever. ttyS and rfcomm TTY devices are totally different. The ttyS
actually present a physical serial port in your system how do you wanna
attach a Bluetooth virtual TTY into it. Think about it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
