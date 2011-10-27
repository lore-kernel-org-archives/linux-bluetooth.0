Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EA90C20.4080009@srdc.com.tr>
References: <4EA90C20.4080009@srdc.com.tr>
Date: Thu, 27 Oct 2011 11:30:24 +0200
Message-ID: <CACLukz+zzWckuWPAPo1kru5MLqUES_jMn48fkaHAQf2-KHAOmQ@mail.gmail.com>
Subject: Re: Compiling BlueZ Thermometer Example
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-9?Q?Ali=FEan_YILMAZ?= <alisan@srdc.com.tr>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-9
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Aliþan,

2011/10/27 Aliþan YILMAZ <alisan@srdc.com.tr>:
> Hello everybody,
> I am trying to compile thermometer example in BlueZ, but getting some
> errors. Firstly, I configured and installed the bluez as explained in readme
> file. I used some configuration parameters like --enable-health
> --enable-thermometer. It gave me .o files for thermometer example, but no
> executable file.
> When I tried to link these .o files myself, I got these errors:
>
> /usr/lib/i386-linux-gnu/gcc/i686-linux-gnu/4.5.2/../../../crt1.o: In
> function `_start':
> (.text+0x18): undefined reference to `main'
> manager.o: In function `thermometer_manager_init':
> manager.c:(.text+0x7c): undefined reference to `btd_register_device_driver'
> manager.c:(.text+0x8b): undefined reference to `dbus_connection_ref'
> manager.o: In function `thermometer_manager_exit':
> manager.c:(.text+0xbc): undefined reference to
> `btd_unregister_device_driver'
> manager.c:(.text+0xca): undefined reference to `dbus_connection_unref'
> collect2: ld returned 1 exit status
>

I'm not sure what are you trying to do. Health and thermometer are
built in plugin, that means that the bluetooth daemon will load it at
starting time and it will load/unload the proper drivers to manage
such devices.

By the way, health plugin it's only required if you want to enable
Health Device Profile (HTP) and Multichannel Adaptation Protocol
(MCAP). They are helpfull if you want to develop applications over
11073-20601 specification. You don't need enable this if you  are only
interested in thermometer capabilities.

Anyway, HTP plugin is still under development, I've a lot of patches
to upload yet so there is not much to do with it. If you are
interested I could set my current git repository wich implements most
of the thermeter functionality to any public site so that you can test
it and help me in development by reporting errors, etc. Any feedback
from your side will be very appreciated.

Regards.
Santi.
