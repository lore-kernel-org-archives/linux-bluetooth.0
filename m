Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: BLE Advertisement frustrations with pydbus
Message-Id: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
Date: Fri, 5 May 2017 15:28:01 -0700
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I=E2=80=99m trying to switch to using pydbus (instead of deprecated =
dbus-python, which the bluez examples are based on). I=E2=80=99m running =
on stretch with bluez 5.43. My code is at the bottom (and here -> =
https://gist.github.com/travisgriggs/d8e14dcccf46751804456dc74da1e5e6). =
I=E2=80=99m running into a problem when I try to RegisterAdvertisement. =
What I can=E2=80=99t seem to discern is what is different between this =
and the old approach. The bluetooth driver fails around =
advertising:c:175

    DBusMessageIter iter;
    const char *msg_type;

    if (!g_dbus_proxy_get_property(proxy, "Type", &iter))
        return false;

The g_dbus_proxy_get_property() call fails. What I don=E2=80=99t =
understand though is this. If I modify my program to NOT =
RegisterAdvertisement(), but just sit there with the advertisement =
object on the bus, I can do the following:

$ sudo busctl get-property :1.5 /nic/twigpilot =
org.bluez.LEAdvertisement1 Type
s =E2=80=9Cperipheral"

So I *am* able to get the Type using busctl. Why is that bluetoothd =
cannot? Using busctl introspect, I see that the pydbus variant =
automagically makes a lot more available than the dubs-python variant =
did.

Any hints? Pointers? Help?

TIA

=E2=80=94=E2=80=94

#!/usr/bin/env python3

import pydbus
from gi.repository import GLib

class Advertisement(object):
    """
      <node>
        <interface name=3D"org.bluez.LEAdvertisement1">
          <method name=3D"Release">
            <annotation name=3D"org.freedesktop.DBus.Method.NoReply" =
value=3D"true"/>
          </method>
          <annotation =
name=3D"org.freedesktop.DBus.Properties.PropertiesChanged" =
value=3D"const"/>
          <property name=3D"Type" type=3D"s" access=3D"read"/>
          <property name=3D"ServiceUUIDs" type=3D"as" access=3D"read"/>
          <property name=3D"ManufacturerData" type=3D"a{sv}" =
access=3D"read"/>
          <property name=3D"SolicitUUIDs" type=3D"as" access=3D"read"/>
          <property name=3D"ServiceData" type=3D"a{sv}" access=3D"read"/>
          <property name=3D"IncludeTxPower" type=3D"b" access=3D"read"/>
        </interface>
      </node>
    """

    def __init__(self, bus):
        self.Type =3D 'peripheral'
        self.ServiceUUIDs =3D []
        self.ManufacturerData =3D {}
        self.SolicitUUIDs =3D []
        self.ServiceData =3D {}
        self.IncludeTxPower =3D False
        bus.register_object('/nic/twigpilot', self, None)

    def Release(self):
        print('{}: Advertisement Released!'.format(self))


def main():
    bus =3D pydbus.SystemBus()
    adaptor =3D bus.get('org.bluez', '/org/bluez/hci0')
    adaptor.Powered =3D True
    adaptor.Alias =3D 'SeeMe'

    advertisement =3D Advertisement(bus)
    advertisement.IncludeTxPower =3D True

    #adaptor.RegisterAdvertisement('/nic/twigpilot', {})

    loop =3D GLib.MainLoop()
    try:
        loop.run()
    except KeyboardInterrupt:
        loop.quit()

if __name__ =3D=3D '__main__':
    main()=
