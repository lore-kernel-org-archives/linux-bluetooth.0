Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com> <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 8 May 2017 09:51:12 +0100
Message-ID: <CAAu3APZy=NAKySrY5xUJt+arxvk3KPG4_rZULYuK84MjYWfk0g@mail.gmail.com>
Subject: Re: BLE Advertisement frustrations with pydbus
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Travis Griggs <travisgriggs@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz & Travis,

I've been taking a look at this also

On 8 May 2017 at 09:01, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote=
:
> On Sat, May 6, 2017 at 1:28 AM, Travis Griggs <travisgriggs@gmail.com> wr=
ote:
>> $ sudo busctl get-property :1.5 /nic/twigpilot org.bluez.LEAdvertisement=
1 Type
>> s =E2=80=9Cperipheral"
>>
>> So I *am* able to get the Type using busctl. Why is that bluetoothd cann=
ot? Using busctl introspect, I see that the pydbus variant automagically ma=
kes a lot more available than the dubs-python variant did.
>>
>> Any hints? Pointers? Help?
>
> Does pydbus have ObjectManager support?

Looking at the following entry in the libraries issue list it seems
like it does.
https://github.com/LEW21/pydbus/issues/28
Is there anything in particular we should be testing for?


> What about GetAll properties?
Yes it does. It creates these standard interfaces automatically based
on the XML in the Python class doc string. So for example Get and
GetAll give the following:


$ busctl call ukBaz.bluezero /ukBaz/bluezero
org.freedesktop.DBus.Properties Get ss org.bluez.LEAdvertisement1 Type

v s "peripheral"

$ busctl call ukBaz.bluezero /ukBaz/bluezero
org.freedesktop.DBus.Properties GetAll s org.bluez.LEAdvertisement1

a{sv} 3 "Type" s "peripheral" "SolicitUUIDs" as 1 "180F"
"IncludeTxPower" b false


> You could perhaps try to sniff the message with eavesdrop option:
>
> https://wiki.ubuntu.com/DebuggingDBus

Good suggestion. I'll try that later.

>
>> TIA
>>
>> =E2=80=94=E2=80=94
>>
>> #!/usr/bin/env python3
>>
>> import pydbus
>> from gi.repository import GLib
>>
>> class Advertisement(object):
>>     """
>>       <node>
>>         <interface name=3D"org.bluez.LEAdvertisement1">
>>           <method name=3D"Release">
>>             <annotation name=3D"org.freedesktop.DBus.Method.NoReply" val=
ue=3D"true"/>
>>           </method>
>>           <annotation name=3D"org.freedesktop.DBus.Properties.Properties=
Changed" value=3D"const"/>
>>           <property name=3D"Type" type=3D"s" access=3D"read"/>
>>           <property name=3D"ServiceUUIDs" type=3D"as" access=3D"read"/>
>>           <property name=3D"ManufacturerData" type=3D"a{sv}" access=3D"r=
ead"/>
>>           <property name=3D"SolicitUUIDs" type=3D"as" access=3D"read"/>
>>           <property name=3D"ServiceData" type=3D"a{sv}" access=3D"read"/=
>
>>           <property name=3D"IncludeTxPower" type=3D"b" access=3D"read"/>
>>         </interface>
>>       </node>
>>     """
>>
>>     def __init__(self, bus):
>>         self.Type =3D 'peripheral'
>>         self.ServiceUUIDs =3D []
>>         self.ManufacturerData =3D {}
>>         self.SolicitUUIDs =3D []
>>         self.ServiceData =3D {}
>>         self.IncludeTxPower =3D False
>>         bus.register_object('/nic/twigpilot', self, None)
>>
>>     def Release(self):
>>         print('{}: Advertisement Released!'.format(self))
>>
>>
>> def main():
>>     bus =3D pydbus.SystemBus()
>>     adaptor =3D bus.get('org.bluez', '/org/bluez/hci0')
>>     adaptor.Powered =3D True
>>     adaptor.Alias =3D 'SeeMe'
>>
>>     advertisement =3D Advertisement(bus)
>>     advertisement.IncludeTxPower =3D True
>>
>>     #adaptor.RegisterAdvertisement('/nic/twigpilot', {})
>>
>>     loop =3D GLib.MainLoop()
>>     try:
>>         loop.run()
>>     except KeyboardInterrupt:
>>         loop.quit()
>>
>> if __name__ =3D=3D '__main__':
>>     main()--
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
