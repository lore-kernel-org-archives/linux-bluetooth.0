Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: AVRCP: player object path
To: Barry Byford <31baz66@gmail.com>
References: <6b556d8b-b0ee-543f-2ca1-0ef9a48172ee@gmail.com>
 <CAAu3APbbPGtitaEb5YSDxqyuQWdrERUiRGo5YLdYV-OVJLC9RQ@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Message-ID: <3d5226e5-c356-04aa-415e-fd896113cc10@gmail.com>
Date: Wed, 20 Jul 2016 17:44:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAAu3APbbPGtitaEb5YSDxqyuQWdrERUiRGo5YLdYV-OVJLC9RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Il 20/07/2016 16:39, Barry Byford ha scritto:
>
> This is something I'm currently trying to get my head around.
>
> There appears to be a dbus.INTROSPECTABLE_IFACE interface that has an
> Introspect() method.
>
> I've got an example of using it in Python at:
> https://github.com/ukBaz/python-bluezero/blob/master/examples/iterate.py
> In build_introspection()
>
> You can do something similar on the command line with:
> gdbus introspect --system --dest org.bluez --object-path / --recurse
>
> Hope that helps move you forward.

Hi Barry,
I was able to get it in this way:

> QDBusInterface *iface = new QDBusInterface("org.bluez", 
> "/org/bluez/hci0", "org.freedesktop.DBus.Introspectable", 
> QDBusConnection::systemBus(), this);
> QString xml = iface->call("Introspect").arguments().at(0).toString();

and then I extract the attribute "name" from the second "node" tag...

