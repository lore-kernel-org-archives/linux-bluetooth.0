Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dick@mrns.nl>
Date: Mon, 20 Aug 2007 18:34:05 +0000 (UTC)
Message-ID: <loom.20070820T202825-944@post.gmane.org>
References: <loom.20070819T201223-639@post.gmane.org>
	<1187551141.11068.55.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users]
	=?utf-8?q?stale_connections_with_input=09service=09?=
	=?utf-8?q?=28bluez-libs-3=2E14=29?=
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

Marcel Holtmann <marcel <at> holtmann.org> writes:
> which kernel version is this. This is not suppose to happen. Have you
> tried a 2.6.23-rc3 kernel?
I'm using 2.6.22-gentoo-r4, today I've tried 23-rc3 twice but it seems to be
even more unstable! (Even the USB-HID had problems)

> Does the mouse always works? Maybe this is an issue with the
> authentication and encryption that are mandatory for keyboard. Which
> keyboard are you using? Which Bluetooth chip is inside it.
Most at the times, yes. The mouse sometimes gets "laggy" when the keyboard is
"stale". My keyboard is a standard logitech dinovo packaged as "Dinovo Media
Desktop Laser", is there a way to query the bluetooth chip in the keyboard?

Thanks so far,
Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
