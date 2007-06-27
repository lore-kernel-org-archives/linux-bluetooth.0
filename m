Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W69DF635E82A29A17B512DF00A0@phx.gbl>
References: <BAY102-W69DF635E82A29A17B512DF00A0@phx.gbl>
Date: Wed, 27 Jun 2007 20:00:32 +0200
Message-Id: <1182967232.9499.10.camel@aeonflux.holtmann.net>
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

> I'm trying to use the DBUS API to query a device for a service using
> the example python code from the WIKI documents:
>  
> import dbus
> bus = dbus.SystemBus();
> obj = bus.get_object('org.bluez', '/org/bluez/hci0')
> adapter = dbus.Interface(obj, 'org.bluez.Adapter')
> handles = adapter.GetRemoteServiceHandles('00:17:B0:A0:E7:09', 'opp')
> for handle in handles:
> print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', handle)
>  
> However when running this code i get the following error message
> displayed:
>  
>   File "./test.py", line 13, in ?
>     print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09',
> handle)
>   File "/var/lib/python-support/python2.4/dbus/proxies.py", line 169,
> in __call__
>     reply_message =
> self._connection.send_message_with_reply_and_block(message, timeout)
> dbus.DBusException: org.bluez.Error.UnknownMethod: Method
> "GetRemoteServiceRecordAsXML" with signature "su" on interface
> "org.bluez.Adapter" doesn't exist
> 
> Do you have any ideas what might be causing this?

try wrapping the handle with dbus.Uint32() to get the right type.

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
