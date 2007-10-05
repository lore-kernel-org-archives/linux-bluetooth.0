Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5d240eb0710050552h25d923a0hd1de3c0cec71aeb7@mail.gmail.com>
References: <d5d240eb0710050552h25d923a0hd1de3c0cec71aeb7@mail.gmail.com>
Date: Fri, 05 Oct 2007 15:02:57 +0200
Message-Id: <1191589377.10698.168.camel@violet>
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

> whenever I am compiling my program of 
> dbus for interprocess communication .i am getting following error .I
> have downloaded a latest version of dbus 1.1.2
> 
> 
> Here I am writing the program and all the errors I am facing 
> #include <stdio.h>
> #include <stdlib.h>
> #include <dbus-1.0/dbus/dbus.h>

you includes are not complete. You can't use the "dbus-1.0" prefix, you
have to change the include path (-I).

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
