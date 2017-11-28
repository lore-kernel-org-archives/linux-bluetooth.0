Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511877514.11411.49.camel@hadess.net>
Subject: Re: [PATCH BlueZ] gdbus: Force service to start if proxy is created
 while not connected
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Nov 2017 14:58:34 +0100
In-Reply-To: <CABBYNZ+w3GPnU7DJtBRO2UoXZD=AnJNdgHqrJyJ_O3_1BcXMGQ@mail.gmail.com>
References: <20171128105746.13000-1-luiz.dentz@gmail.com>
         <1511876867.11411.41.camel@hadess.net>
         <CABBYNZ+w3GPnU7DJtBRO2UoXZD=AnJNdgHqrJyJ_O3_1BcXMGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-11-28 at 15:49 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Nov 28, 2017 at 3:47 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Tue, 2017-11-28 at 12:57 +0200, Luiz Augusto von Dentz wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > 
> > > Because GetAll is no longer send right away the service may never
> > > be
> > > started.
> > 
> > Causes an assertion on startup on my machine.
> > 
> > dbus[12994]: arguments to dbus_message_unref() were incorrect,
> > assertion "!message->in_cache" failed in file ../../dbus/dbus-
> > message.c line 1718.
> > 
> > #0  __GI_raise (sig=sig@entry=6) at
> > ../sysdeps/unix/sysv/linux/raise.c:51
> > #1  0x00007ffff6b752a7 in __GI_abort () at abort.c:90
> > #2  0x00007ffff76618c4 in _dbus_abort () from /lib64/libdbus-1.so.3
> > #3  0x00007ffff7658150 in _dbus_warn_check_failed () from
> > /lib64/libdbus-1.so.3
> > #4  0x000000000048b281 in start_service (proxy=0x70a4f0) at
> > gdbus/client.c:505
> > #5  g_dbus_proxy_new (client=<optimized out>, path=path@entry=0x49b
> > cad "/org/freedesktop/hostname1", interface=interface@entry=0x49bcc
> > 8 "org.freedesktop.hostname1") at gdbus/client.c:527
> > #6  0x000000000040cb9d in hostname_init () at
> > plugins/hostname.c:287
> > #7  0x000000000045617a in plugin_init (enable=<optimized out>,
> > disable=<optimized out>) at src/plugin.c:200
> > #8  0x000000000040bc9e in main (argc=<optimized out>,
> > argv=<optimized out>) at src/main.c:744
> > 
> > Looks like g_dbus_send_message() takes ownership of the reference
> > to
> > the message. Removing that call in your patch makes it work.
> > 
> > Might want to double-check though.
> 
> Does it fixes the problem after that?

Yes, the hostname plugin works correctly, and the adapter name matches
the hostname.
