Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Reply-To: Edmund.Urbani@LilandIT.com
Date: Wed, 12 Aug 2015 08:12:35 +0200
Message-ID: <CADf1AV5fxh1cV8=_cBFkoX3-XTKHDG-xFaw01ynWZE5ykDZ3WA@mail.gmail.com>
Subject: Registering a GATT service via DBus
From: "Urbani, Edmund" <edmund.urbani@lilandit.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

my attempts to register a GATT service via DBus from Java have so far
been unsuccessful. The GattManager1.RegisterService method does not
return any reply, instead I simply get this timeout exception:
Exception in thread "main" org.freedesktop.DBus$Error$
NoReply: No reply within specified time

Also, all I see in the logs is the registration attempt, but no error:
Aug 11 14:42:02 raspberrypi bluetoothd[5466]:
src/gatt-database.c:manager_register_service() Registering service -
path: /com/lilandit/iventcloud/skg/service

Introspection of the service (with mdbus2 tool) shows this info (which
matches the specs as far as a DBus noob like I can tell):
[METHOD]   org.bluez.GattService1.GetPrimary() -> (b:arg_0)
[METHOD]   org.bluez.GattService1.GetDevice() -> (o:arg_0)
[METHOD]   org.bluez.GattService1.GetUUID() -> (s:arg_0)
[METHOD]   org.bluez.GattService1.GetCharacteristics() -> (ao:arg_0)
[METHOD]   org.bluez.GattService1.GetIncludes() -> (ao:arg_0)
[METHOD]   org.freedesktop.DBus.Introspectable.Introspect() -> (s:arg_0)
[METHOD]   org.freedesktop.DBus.Peer.Ping() -> ()

The implementation of the service is incomplete (same applies to the
ObjectManager registered at "/"), however I was expecting to at least
get some feedback on registration and possibly see some of the service
methods being called at this point. Instead I get nothing.

Any ideas what may be wrong or where I should be looking for the cause?

Kind regards,
 Edmund

PS: I'm using BlueZ 5.32
