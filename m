Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 May 2017 11:01:53 +0300
Message-ID: <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
Subject: Re: BLE Advertisement frustrations with pydbus
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Sat, May 6, 2017 at 1:28 AM, Travis Griggs <travisgriggs@gmail.com> wrot=
e:
> I=E2=80=99m trying to switch to using pydbus (instead of deprecated dbus-=
python, which the bluez examples are based on). I=E2=80=99m running on stre=
tch with bluez 5.43. My code is at the bottom (and here -> https://gist.git=
hub.com/travisgriggs/d8e14dcccf46751804456dc74da1e5e6). I=E2=80=99m running=
 into a problem when I try to RegisterAdvertisement. What I can=E2=80=99t s=
eem to discern is what is different between this and the old approach. The =
bluetooth driver fails around advertising:c:175
>
>     DBusMessageIter iter;
>     const char *msg_type;
>
>     if (!g_dbus_proxy_get_property(proxy, "Type", &iter))
>         return false;
>
> The g_dbus_proxy_get_property() call fails. What I don=E2=80=99t understa=
nd though is this. If I modify my program to NOT RegisterAdvertisement(), b=
ut just sit there with the advertisement object on the bus, I can do the fo=
llowing:
>
> $ sudo busctl get-property :1.5 /nic/twigpilot org.bluez.LEAdvertisement1=
 Type
> s =E2=80=9Cperipheral"
>
> So I *am* able to get the Type using busctl. Why is that bluetoothd canno=
t? Using busctl introspect, I see that the pydbus variant automagically mak=
es a lot more available than the dubs-python variant did.
>
> Any hints? Pointers? Help?

Does pydbus have ObjectManager support? What about GetAll properties?
You could perhaps try to sniff the message with eavesdrop option:

https://wiki.ubuntu.com/DebuggingDBus

> TIA
>
> =E2=80=94=E2=80=94
>
> #!/usr/bin/env python3
>
> import pydbus
> from gi.repository import GLib
>
> class Advertisement(object):
>     """
>       <node>
>         <interface name=3D"org.bluez.LEAdvertisement1">
>           <method name=3D"Release">
>             <annotation name=3D"org.freedesktop.DBus.Method.NoReply" valu=
e=3D"true"/>
>           </method>
>           <annotation name=3D"org.freedesktop.DBus.Properties.PropertiesC=
hanged" value=3D"const"/>
>           <property name=3D"Type" type=3D"s" access=3D"read"/>
>           <property name=3D"ServiceUUIDs" type=3D"as" access=3D"read"/>
>           <property name=3D"ManufacturerData" type=3D"a{sv}" access=3D"re=
ad"/>
>           <property name=3D"SolicitUUIDs" type=3D"as" access=3D"read"/>
>           <property name=3D"ServiceData" type=3D"a{sv}" access=3D"read"/>
>           <property name=3D"IncludeTxPower" type=3D"b" access=3D"read"/>
>         </interface>
>       </node>
>     """
>
>     def __init__(self, bus):
>         self.Type =3D 'peripheral'
>         self.ServiceUUIDs =3D []
>         self.ManufacturerData =3D {}
>         self.SolicitUUIDs =3D []
>         self.ServiceData =3D {}
>         self.IncludeTxPower =3D False
>         bus.register_object('/nic/twigpilot', self, None)
>
>     def Release(self):
>         print('{}: Advertisement Released!'.format(self))
>
>
> def main():
>     bus =3D pydbus.SystemBus()
>     adaptor =3D bus.get('org.bluez', '/org/bluez/hci0')
>     adaptor.Powered =3D True
>     adaptor.Alias =3D 'SeeMe'
>
>     advertisement =3D Advertisement(bus)
>     advertisement.IncludeTxPower =3D True
>
>     #adaptor.RegisterAdvertisement('/nic/twigpilot', {})
>
>     loop =3D GLib.MainLoop()
>     try:
>         loop.run()
>     except KeyboardInterrupt:
>         loop.quit()
>
> if __name__ =3D=3D '__main__':
>     main()--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
