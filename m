Return-Path: <cyrus@holtmann.org>
Message-ID: <4AD2D155.8040008@pardus.org.tr>
Date: Mon, 12 Oct 2009 09:48:53 +0300
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: marcel@holtmann.org
Subject: Re: Undefined symbols in netlink plugin
References: <4AB94E32.8060703@pardus.org.tr>
In-Reply-To: <4AB94E32.8060703@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Ozan Çağlayan wrote On 23-09-2009 01:22:

> Hi,
>
> I'm getting the following when I launch bluetoothd with -n -d:
>
> ..
> Can't load plugin /usr/lib/bluetooth/plugins/netlink.so:
> /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
> ..
>
> AFAIK, those libtool plugins are allowed to have undefined symbols after
> linking as they will probably be resolved during runtime loading but the
> warning above wasn't present on previous versions like 4.41 for example.
>
> # ldd -u -r /usr/lib/bluetooth/plugins/netlink.so
>      26771:     /usr/lib/bluetooth/plugins/netlink.so: error: symbol
> lookup error: undefined symbol: g_io_channel_unix_new (continued)
> undefined symbol: g_io_channel_unix_new
> (/usr/lib/bluetooth/plugins/netlink.so)
>      26771:     /usr/lib/bluetooth/plugins/netlink.so: error: symbol
> lookup error: undefined symbol: debug (continued)
> undefined symbol: debug (/usr/lib/bluetooth/plugins/netlink.so)
>      26771:     /usr/lib/bluetooth/plugins/netlink.so: error: symbol
> lookup error: undefined symbol: g_io_add_watch (continued)
> undefined symbol: g_io_add_watch       
> (/usr/lib/bluetooth/plugins/netlink.so)
>      26771:     /usr/lib/bluetooth/plugins/netlink.so: error: symbol
> lookup error: undefined symbol: info (continued)
> undefined symbol: info  (/usr/lib/bluetooth/plugins/netlink.so)
>      26771:     /usr/lib/bluetooth/plugins/netlink.so: error: symbol
> lookup error: undefined symbol: g_io_channel_unref (continued)
> undefined symbol: g_io_channel_unref   
> (/usr/lib/bluetooth/plugins/netlink.so)
> Unused direct dependencies:
>
>
> So we have 3 undefined symbol from glib and 2 internal symbols from
> logging.c: debug() and info(). There's no difference if I install the
> libtool la file or not. Since glib is already needed by bluez daemon,
> those undefined symbols seems harmless but AFAIK the internal ones
> should have been linked against the static logging.o.
>
> Or do I miss something?
>
>
> Thanks,
> Ozan Caglayan
>
>   

Still an issue on bluez 4.56. CC'ing Marcel Holtmann.
