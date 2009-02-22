Return-Path: <cyrus@holtmann.org>
Date: Sun, 22 Feb 2009 17:16:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: current git segfaults, gdb backtraces included, pl;ease help
Message-ID: <20090222151619.GA18302@jh-x301>
References: <499FDB3E.3040202@powercraft.nl> <20090221215945.GA10295@jh-x301> <49A15C9C.6040907@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49A15C9C.6040907@powercraft.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jelle,

On Sun, Feb 22, 2009, Jelle de Jong wrote:
> ==9308== Conditional jump or move depends on uninitialised value(s)
> ==9308==    at 0x49AEEE0: (within /lib/i686/cmov/libc-2.7.so)
> ==9308==    by 0x49A21F5: vsprintf (in /lib/i686/cmov/libc-2.7.so)
> ==9308==    by 0x498A48A: sprintf (in /lib/i686/cmov/libc-2.7.so)
> ==9308==    by 0x492B922: ba2str (bluetooth.c:88)
> ==9308==    by 0x13262C: l2cap_get (btio.c:731)
> ==9308==    by 0x13312F: get_valist (btio.c:983)
> ==9308==    by 0x133447: bt_io_get (btio.c:1061)
> ==9308==    by 0x48312A2: connect_event_cb (server.c:102)
> ==9308==    by 0x130F37: server_cb (btio.c:180)
> ==9308==    by 0x48A8F2C: (within /usr/lib/libglib-2.0.so.0.1800.4)
> ==9308==    by 0x4872367: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1800.4)
> ==9308==    by 0x4875A02: (within /usr/lib/libglib-2.0.so.0.1800.4)
> ==9308==  Uninitialised value was created by a stack allocation
> ==9308==    at 0x483121F: connect_event_cb (server.c:91)

This was actually a pretty stupid thing I should have noticed earlier.
The parameter list to bt_io_get should end in BT_IO_OPT_INVALID but it
was ending in NULL for this call. I also found two other places with
problematic parameters to bt_io_get. All occurences have been fixed in
git now.

Johan
