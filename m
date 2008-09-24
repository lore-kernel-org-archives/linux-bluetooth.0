Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetoothd crasher
From: Bastien Nocera <hadess@hadess.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1222297746.10497.186.camel@snoogens.fab.redhat.com>
References: <1222297746.10497.186.camel@snoogens.fab.redhat.com>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 16:18:38 -0700
Message-Id: <1222298318.10497.187.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2008-09-24 at 16:09 -0700, Bastien Nocera wrote:
> Heya,
> 
> The current bluetoothd crashes on resume from suspend. Here's the valgrind output:

And the crash itself:
#0  malloc_consolidate (av=<value optimized out>) at malloc.c:4841
#1  0x002e1b2d in _int_malloc (av=<value optimized out>, bytes=<value optimized out>) at malloc.c:4184
#2  0x002e368f in __libc_calloc (n=<value optimized out>, elem_size=<value optimized out>) at malloc.c:3901
#3  0x002d7a7d in open_memstream (bufloc=Could not find the frame base for "open_memstream".
) at memstream.c:86
#4  0x00350088 in __vsyslog_chk (pri=<value optimized out>, flag=<value optimized out>, fmt=<value optimized out>, ap=<value optimized out>) at ../misc/syslog.c:169
#5  0x003505d7 in __vsyslog (pri=Could not find the frame base for "__vsyslog".
) at ../misc/syslog.c:326
#6  0xb7ff5e68 in vinfo (format=0xb7ffcf75 "HCI dev %d unregistered", ap=0xbffff0b4 "") at logging.c:36
#7  0xb7ff5e3a in info (format=0xb7ffcf75 "HCI dev %d unregistered") at logging.c:45
#8  0xb7fdc1a9 in device_event (chan=0xb800a3d0, si=0xbffff10b) at main.c:544
#9  0xb7fdc0ed in io_stack_event (chan=0xb800a3d0, cond=G_IO_IN, data=0x0) at main.c:595
#10 0x001a524d in ?? () from /lib/libglib-2.0.so.0
#11 0x0016e218 in g_main_context_dispatch () from /lib/libglib-2.0.so.0
#12 0x001718c3 in ?? () from /lib/libglib-2.0.so.0
#13 0x00171de2 in g_main_loop_run () from /lib/libglib-2.0.so.0
#14 0xb7fdc7a4 in main (argc=1, argv=0xbffff7e4) at main.c:750


