Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: BLE Advertisement frustrations with pydbus
Date: Mon, 8 May 2017 10:43:09 -0700
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
 <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com>
Message-Id: <48520255-46C9-4696-8420-15DB4E8234B4@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On May 8, 2017, at 1:01 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:
>=20
> Hi Travis,
>=20
> On Sat, May 6, 2017 at 1:28 AM, Travis Griggs <travisgriggs@gmail.com> =
wrote:
>> I=E2=80=99m trying to switch to using pydbus (instead of deprecated =
dbus-python, which the bluez examples are based on). I=E2=80=99m running =
on stretch with bluez 5.43. My code is at the bottom (and here -> =
https://gist.github.com/travisgriggs/d8e14dcccf46751804456dc74da1e5e6). =
I=E2=80=99m running into a problem when I try to RegisterAdvertisement. =
What I can=E2=80=99t seem to discern is what is different between this =
and the old approach. The bluetooth driver fails around =
advertising:c:175
>>=20
>>    DBusMessageIter iter;
>>    const char *msg_type;
>>=20
>>    if (!g_dbus_proxy_get_property(proxy, "Type", &iter))
>>        return false;
>>=20
>> The g_dbus_proxy_get_property() call fails. What I don=E2=80=99t =
understand though is this. If I modify my program to NOT =
RegisterAdvertisement(), but just sit there with the advertisement =
object on the bus, I can do the following:
>>=20
>> $ sudo busctl get-property :1.5 /nic/twigpilot =
org.bluez.LEAdvertisement1 Type
>> s =E2=80=9Cperipheral"
>>=20
>> So I *am* able to get the Type using busctl. Why is that bluetoothd =
cannot? Using busctl introspect, I see that the pydbus variant =
automagically makes a lot more available than the dubs-python variant =
did.
>>=20
>> Any hints? Pointers? Help?
>=20
> Does pydbus have ObjectManager support? What about GetAll properties?
> You could perhaps try to sniff the message with eavesdrop option:
>=20
> https://wiki.ubuntu.com/DebuggingDBus
>=20
>>=20

That=E2=80=99s a great question. My neophyte skills with dbus are not =
that strong, but the following DOES seem odd to me:

$ sudo busctl introspect :1.5 /nic/twigpilot
NAME                                TYPE      SIGNATURE RESULT/VALUE =
FLAGS
org.bluez.LEAdvertisement1          interface -         -            -
.Release                            method    -         -            =
no-reply
.IncludeTxPower                     property  b         true         =
emits-change
.ManufacturerData                   property  a{sv}     0            =
emits-change
.ServiceData                        property  a{sv}     0            =
emits-change
.ServiceUUIDs                       property  as        0            =
emits-change
.SolicitUUIDs                       property  as        0            =
emits-change
.Type                               property  s         "peripheral" =
emits-change
org.freedesktop.DBus.Introspectable interface -         -            -
.Introspect                         method    -         s            -
org.freedesktop.DBus.Peer           interface -         -            -
.GetMachineId                       method    -         s            -
.Ping                               method    -         -            -
org.freedesktop.DBus.Properties     interface -         -            -
.Get                                method    ss        v            -
.GetAll                             method    s         a{sv}        -
.Set                                method    ssv       -            -
.PropertiesChanged                  signal    sa{sv}as  -            -

So it seems to think it does=E2=80=A6 And as aforementioned, I can get =
the Type:

$ sudo busctl get-property :1.5 /nic/twigpilot =
org.bluez.LEAdvertisement1 Type
s =E2=80=9Cperipheral"

BUT=E2=80=A6 if I try to access as GetAll as you suggest:

$ sudo busctl call :1.5 /nic/twigpilot org.freedesktop.DBus.Properties =
GetAll
No such interface 'org.freedesktop.DBus.Properties' on object at path =
/nic/twigpilot

Which is really weird, because the `introspect` command seems to show it =
is there.=20

(sorry if this is sent twice, I got a weird response back the first time =
I submitted this message)=
