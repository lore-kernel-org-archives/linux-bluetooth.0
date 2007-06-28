Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W10EBD65660A4371E5650A1F00A0@phx.gbl>
References: <BAY102-W10EBD65660A4371E5650A1F00A0@phx.gbl>
Date: Thu, 28 Jun 2007 17:00:31 +0200
Message-Id: <1183042831.9499.27.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Service Discovery Issues
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

Hi Robert,

> >> try wrapping the handle with dbus.Uint32() to get the right type.
> 
> I've tried wrapping that now so the line of code now looks like:
>  
> print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09',
> dbus.Uint32(handle))
>  
> But I get a different error this time around:
>  
> AttributeError: 'module' object has no attribute 'Uint32'

I am not a Python guru, but you might simply start using the Python
D-Bus documentation to find it out by yourself. Maybe it is dbus.UInt32.

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
