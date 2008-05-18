Return-Path: <cyrus@holtmann.org>
Message-Id: <CD0EBC4C-69FC-4FAB-940C-28ED6308376A@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805171138r278aad56i9d1af3dfea5ca7c0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sun, 18 May 2008 02:04:38 +0200
References: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
	<75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
	<3e9cdced0805171138r278aad56i9d1af3dfea5ca7c0@mail.gmail.com>
Subject: Re: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
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

Hi Fritz,

> is there anywhere a HowTo / Tutorial how to use the low-level C API  
> of bluez through dbus?
>
> I've found a Tutorial for using the low-level C API of dbus here  
> (unfortunately just a ver basic Tut.)
> http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html
>
> But I didn't find anything about the characteristics of the Adapter  
> Interface of bluez (hcid) if its used from low-level API.
> E.g. the method names which I have to pass the method  
> dbus_message_new_method_call() ...

they are all documented. Check the doc/ directory within bluez-utils.

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
