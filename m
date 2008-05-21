Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4328a52e0805210458w1438f361ub1eb28976e4a3efa@mail.gmail.com>
References: <4328a52e0805210458w1438f361ub1eb28976e4a3efa@mail.gmail.com>
Date: Wed, 21 May 2008 16:33:29 +0200
Message-Id: <1211380409.13248.65.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth-properties "Out of memory"
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

Hi Artem,

> I'm having issues with bluetooth-properties (the one which is in
> Ubuntu 8.04)
> When I ran bleutooth-config and try to add a device it crashes
> displaying this message:
> 
> "process 10105: arguments to dbus_message_new_method_call() were
> incorrect, assertion "_dbus_check_is_valid_path (path)" failed in file
> dbus-message.c line 1074.
> This is normally a bug in some application using the D-Bus library.
> 
> ** ERROR **: Out of memory
> aborting...
> Aborted"

this really doesn't help me. Can you try to use the latest bluez-gnome
and see if that issues still exists.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
