Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5d240eb0710050640p1d9454f3peb935cbcbb6052bf@mail.gmail.com>
References: <d5d240eb0710050552h25d923a0hd1de3c0cec71aeb7@mail.gmail.com>
	<1191589377.10698.168.camel@violet>
	<d5d240eb0710050640p1d9454f3peb935cbcbb6052bf@mail.gmail.com>
Date: Sat, 06 Oct 2007 11:24:06 +0200
Message-Id: <1191662646.6484.121.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DBus error <dbus/dbus-arch-deps.h> is missing
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

Hi Rohit,

> Thanks very much for your assistance but still some errors are there
> even I have changed the include path to -1
> 
> 'DBusConnection' undeclared (first use in this function) 
> dbus2.c:10: error: (Each undeclared identifier is reported only once
> dbus2.c:10: error: for each function it appears in.)
> dbus2.c:10: error: 'connection' undeclared (first use in this
> function)

don't ask me. You might wanna start using pkg-config to get the right
paths for the header files.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
