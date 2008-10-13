Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Oct 2008 11:56:45 +0100
Message-Id: <1223895405.31961.3048.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Device not connected but working?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Heya,

Using bluez 4.13, I have a slight problem with a mouse not showing up as
connected.

GetProperties() on the device tells me:
dbus.Dictionary({dbus.String(u'Name'): dbus.String(u'Trust Bluetooth
Mouse', variant_level=1), dbus.String(u'Paired'): dbus.Boolean(False,
variant_level=1), dbus.String(u'Adapter'):
dbus.ObjectPath('/org/bluez/hci0', variant_level=1),
dbus.String(u'Alias'): dbus.String(u'Trust Bluetooth Mouse',
variant_level=1), dbus.String(u'Connected'): dbus.Boolean(False,
variant_level=1), dbus.String(u'UUIDs'):
dbus.Array([dbus.String(u'00001124-0000-1000-8000-00805f9b34fb')],
signature=dbus.Signature('s'), variant_level=1),
dbus.String(u'Address'): dbus.String(u'00:0A:94:C0:AB:9B',

org.bluez.Input.IsConnected() says:
1

$ hidd --show
00:0A:94:C0:AB:9B Trust Bluetooth Mouse [0000:0000] connected

Turning the mouse on and off will sometimes show the connection as being
up, and sometimes not.

Is this normal?

Cheers


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
