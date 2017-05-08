Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKM=EsXfRB1EOiB+7ojaSwXypQWPSGqromVJYtoQ+7Kug@mail.gmail.com>
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
 <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
 <CAAu3APZy=NAKySrY5xUJt+arxvk3KPG4_rZULYuK84MjYWfk0g@mail.gmail.com> <CABBYNZKM=EsXfRB1EOiB+7ojaSwXypQWPSGqromVJYtoQ+7Kug@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 8 May 2017 21:46:08 +0100
Message-ID: <CAAu3APaZwa7MERmXRDWO85Yf5yv9QoVKJV3K5-658rQD_51NAA@mail.gmail.com>
Subject: Re: BLE Advertisement frustrations with pydbus
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Travis Griggs <travisgriggs@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 8 May 2017 at 11:18, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote=
:
> Hi Barry,
>
> On Mon, May 8, 2017 at 11:51 AM, Barry Byford <31baz66@gmail.com> wrote:
>> Hello Luiz & Travis,
>>
>> I've been taking a look at this also
>>
>> On 8 May 2017 at 09:01, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wr=
ote:
>>> On Sat, May 6, 2017 at 1:28 AM, Travis Griggs <travisgriggs@gmail.com> =
wrote:
>>>> $ sudo busctl get-property :1.5 /nic/twigpilot org.bluez.LEAdvertiseme=
nt1 Type
>>>> s =E2=80=9Cperipheral"
>>>>
>>>> So I *am* able to get the Type using busctl. Why is that bluetoothd ca=
nnot? Using busctl introspect, I see that the pydbus variant automagically =
makes a lot more available than the dubs-python variant did.
>>>>
>>>> Any hints? Pointers? Help?
>>>
>>> Does pydbus have ObjectManager support?
>>
>> Looking at the following entry in the libraries issue list it seems
>> like it does.
>> https://github.com/LEW21/pydbus/issues/28
>> Is there anything in particular we should be testing for?
>
> This is support for ObjectManager as a client, I was asking for the
> server side so we can query the advertisement objects. Though this
> used to work even without ObjectManager support so perhaps there is
> some regression.

Given the information below, this seems like it is the issue.
Does this mean it is a bug in BlueZ?
Or is this how it is intend to work going forward?

>
>>
>>> What about GetAll properties?
>> Yes it does. It creates these standard interfaces automatically based
>> on the XML in the Python class doc string. So for example Get and
>> GetAll give the following:
>>
>>
>> $ busctl call ukBaz.bluezero /ukBaz/bluezero
>> org.freedesktop.DBus.Properties Get ss org.bluez.LEAdvertisement1 Type
>>
>> v s "peripheral"
>>
>> $ busctl call ukBaz.bluezero /ukBaz/bluezero
>> org.freedesktop.DBus.Properties GetAll s org.bluez.LEAdvertisement1
>>
>> a{sv} 3 "Type" s "peripheral" "SolicitUUIDs" as 1 "180F"
>> "IncludeTxPower" b false
>>
>>
>>> You could perhaps try to sniff the message with eavesdrop option:
>>>
>>> https://wiki.ubuntu.com/DebuggingDBus

This was a good suggestion. And you were correct about your suspicion
that it was missing ObjectManager.

method call time=3D1494270131.995970 sender=3D:1.13 ->
destination=3Dorg.freedesktop.DBus serial=3D78 path=3D/org/freedesktop/DBus=
;
interface=3Dorg.freedesktop.DBus; member=3DAddMatch
   string "type=3D'signal',sender=3D':1.51',path=3D'/ukBaz/bluezero',interf=
ace=3D'org.freedesktop.DBus.Properties',member=3D'PropertiesChanged',arg0=
=3D'org.bluez.LEAdvertisement1'"
method return time=3D1494270131.996002 sender=3Dorg.freedesktop.DBus ->
destination=3D:1.13 serial=3D33 reply_serial=3D78
method call time=3D1494270131.996317 sender=3D:1.13 -> destination=3D:1.51
serial=3D79 path=3D/ukBaz/bluezero;
interface=3Dorg.freedesktop.DBus.Properties; member=3DGetAll
   string "org.bluez.LEAdvertisement1"
method call time=3D1494270131.996358 sender=3D:1.13 -> destination=3D:1.51
serial=3D80 path=3D/ukBaz/bluezero;
interface=3Dorg.freedesktop.DBus.ObjectManager; member=3DGetManagedObjects
error time=3D1494270131.997525 sender=3D:1.51 -> destination=3D:1.13
error_name=3Dorg.freedesktop.DBus.Error.UnknownMethod reply_serial=3D80
   string "No such interface 'org.freedesktop.DBus.ObjectManager' on
object at path /ukBaz/bluezero"


I'll do some investigation as to how difficult it is to implement
ObjectManager for this.


>>
>> Good suggestion. I'll try that later.
>>
>>>
>>>> TIA
>>>>
>>>> =E2=80=94=E2=80=94
>>>>
>>>> #!/usr/bin/env python3
>>>>
>>>> import pydbus
>>>> from gi.repository import GLib
>>>>
>>>> class Advertisement(object):
>>>>     """
>>>>       <node>
>>>>         <interface name=3D"org.bluez.LEAdvertisement1">
>>>>           <method name=3D"Release">
>>>>             <annotation name=3D"org.freedesktop.DBus.Method.NoReply" v=
alue=3D"true"/>
>>>>           </method>
>>>>           <annotation name=3D"org.freedesktop.DBus.Properties.Properti=
esChanged" value=3D"const"/>
>>>>           <property name=3D"Type" type=3D"s" access=3D"read"/>
>>>>           <property name=3D"ServiceUUIDs" type=3D"as" access=3D"read"/=
>
>>>>           <property name=3D"ManufacturerData" type=3D"a{sv}" access=3D=
"read"/>
>>>>           <property name=3D"SolicitUUIDs" type=3D"as" access=3D"read"/=
>
>>>>           <property name=3D"ServiceData" type=3D"a{sv}" access=3D"read=
"/>
>>>>           <property name=3D"IncludeTxPower" type=3D"b" access=3D"read"=
/>
>>>>         </interface>
>>>>       </node>
>>>>     """
>>>>
>>>>     def __init__(self, bus):
>>>>         self.Type =3D 'peripheral'
>>>>         self.ServiceUUIDs =3D []
>>>>         self.ManufacturerData =3D {}
>>>>         self.SolicitUUIDs =3D []
>>>>         self.ServiceData =3D {}
>>>>         self.IncludeTxPower =3D False
>>>>         bus.register_object('/nic/twigpilot', self, None)
>>>>
>>>>     def Release(self):
>>>>         print('{}: Advertisement Released!'.format(self))
>>>>
>>>>
>>>> def main():
>>>>     bus =3D pydbus.SystemBus()
>>>>     adaptor =3D bus.get('org.bluez', '/org/bluez/hci0')
>>>>     adaptor.Powered =3D True
>>>>     adaptor.Alias =3D 'SeeMe'
>>>>
>>>>     advertisement =3D Advertisement(bus)
>>>>     advertisement.IncludeTxPower =3D True
>>>>
>>>>     #adaptor.RegisterAdvertisement('/nic/twigpilot', {})
>>>>
>>>>     loop =3D GLib.MainLoop()
>>>>     try:
>>>>         loop.run()
>>>>     except KeyboardInterrupt:
>>>>         loop.quit()
>>>>
>>>> if __name__ =3D=3D '__main__':
>>>>     main()--
>>>> To unsubscribe from this list: send the line "unsubscribe linux-blueto=
oth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
