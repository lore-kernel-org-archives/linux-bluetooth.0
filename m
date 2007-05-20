Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60705181036h32b7ed31ge7009a3ccc0a22a4@mail.gmail.com>
References: <be976db60705181036h32b7ed31ge7009a3ccc0a22a4@mail.gmail.com>
Date: Sun, 20 May 2007 15:09:18 +0200
Message-Id: <1179666558.10069.248.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid cannot connect to dbus
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

Hi Mark,

>  When I fire up my hcid, I got this error message:
> 
>      Can't connect to system message bus: Failed to connect to
> socket /var/run/dbus/system_bus_socket: Connection refused
> 
> My DBUS is running and there is /var/run/dbus/system_bus_socket.  I
> have a generic server/client and talks via the system bus and they
> work just fine. 
> My DBUS config also loads the system.d/bluetooth.conf as well.  
> 
> Is there a reason why hcid would print out the "Connection refused"
> message?

I have no idea. This simply works for me. Seems like your D-Bus
configuration is messed up.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
