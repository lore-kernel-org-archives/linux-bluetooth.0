Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1248784304.28545.226.camel@violet>
References: <5eee8c670907280453i76f4957fvcca9c3954576580d@mail.gmail.com>
	<5eee8c670907280455ube96c5aka5a9a97149034a71@mail.gmail.com>
	<1248784304.28545.226.camel@violet>
From: Alexander H Deriziotis <deriziotis@gmail.com>
Date: Wed, 12 Aug 2009 23:37:03 +0100
Message-ID: <5eee8c670908121537j500e2883t30e726c10bb7ffef@mail.gmail.com>
Subject: Re: non-blocking hci_inquiry()
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/7/28 Marcel Holtmann <marcel@holtmann.org>:
>
> use the D-Bus interface for non-blocking inquiry.

I'm following the GLib with C example in the following doc:
http://wiki.bluez.org/wiki/HOWTO/DiscoveringDevices and having
problems running the example code.

It compiles perfectly fine, however, when I run it, it gives me the
following error:

jackflap@genesis:~/Desktop/cwiid-0.6.00/new_test$ ./bluetooth
Failed to discover devices: Method "DiscoverDevices" with signature ""
on interface "org.bluez.Adapter" doesn't exist

I'm getting the impression that it's the following line in the code
that isn't working:

        obj = dbus_g_proxy_new_for_name(bus, "org.bluez",
"/org/bluez/hci0", "org.bluez.Adapter");

I'm certain my bluetooth adapter is recognized and is configured as hci0.

What am I missing?

Thanks,
Alex
