Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 May 2013 10:57:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] gdbus: Fix segfault when D-Bus daemon exits
Message-ID: <20130508075749.GA12128@x220>
References: <1367696383-14831-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367696383-14831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, May 04, 2013, Anderson Lizardo wrote:
> Fix this crash if D-Bus exits while the client is still connected to it:
> 
> ==5570== Invalid read of size 1
> ==5570==    at 0x402D28E: strcmp (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==5570==    by 0x4070E22: g_str_equal (ghash.c:1704)
> ==5570==    by 0x8055F61: message_filter (client.c:1123)
> ==5570==    by 0x4141500: dbus_connection_dispatch (in
> /lib/i386-linux-gnu/libdbus-1.so.3.5.8)
> ==5570==    by 0x80506F7: message_dispatch (mainloop.c:76)
> ==5570==    by 0x4081A7E: g_timeout_dispatch (gmain.c:3882)
> ==5570==    by 0x4080D85: g_main_context_dispatch (gmain.c:2539)
> ==5570==    by 0x4081124: g_main_context_iterate.isra.21 (gmain.c:3146)
> ==5570==    by 0x408156A: g_main_loop_run (gmain.c:3340)
> ==5570==    by 0x41BF4D2: (below main) (libc-start.c:226)
> ==5570==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==5570==
> ==5570==
> ---
>  gdbus/client.c |    2 ++
>  1 file changed, 2 insertions(+)

Both patches have been applied. Thanks.

Johan
