Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3d5226e5-c356-04aa-415e-fd896113cc10@gmail.com>
References: <6b556d8b-b0ee-543f-2ca1-0ef9a48172ee@gmail.com>
 <CAAu3APbbPGtitaEb5YSDxqyuQWdrERUiRGo5YLdYV-OVJLC9RQ@mail.gmail.com> <3d5226e5-c356-04aa-415e-fd896113cc10@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Jul 2016 11:38:31 +0300
Message-ID: <CABBYNZKAZvirWh7CGzAk9hby3bLecVphbXR-2rFhsGgppJZGQQ@mail.gmail.com>
Subject: Re: AVRCP: player object path
To: Marco Trapanese <marcotrapanese@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco, Barry,

On Wed, Jul 20, 2016 at 6:44 PM, Marco Trapanese
<marcotrapanese@gmail.com> wrote:
> Il 20/07/2016 16:39, Barry Byford ha scritto:
>>
>>
>> This is something I'm currently trying to get my head around.
>>
>> There appears to be a dbus.INTROSPECTABLE_IFACE interface that has an
>> Introspect() method.
>>
>> I've got an example of using it in Python at:
>> https://github.com/ukBaz/python-bluezero/blob/master/examples/iterate.py
>> In build_introspection()
>>
>> You can do something similar on the command line with:
>> gdbus introspect --system --dest org.bluez --object-path / --recurse
>>
>> Hope that helps move you forward.
>
>
> Hi Barry,
> I was able to get it in this way:
>
>> QDBusInterface *iface = new QDBusInterface("org.bluez", "/org/bluez/hci0",
>> "org.freedesktop.DBus.Introspectable", QDBusConnection::systemBus(), this);
>> QString xml = iface->call("Introspect").arguments().at(0).toString();
>
>
> and then I extract the attribute "name" from the second "node" tag...

If the issue under discussion here is how to enumerate these objects
you should use ObjectManager to do that, you can check how
tools/bluetooth-player.c uses our gdbus client helpers to discover the
objects, it should be very straight forward if the D-Bus library has
support for ObjectManager built-in otherwise you may need to do it
yourselves.

-- 
Luiz Augusto von Dentz
