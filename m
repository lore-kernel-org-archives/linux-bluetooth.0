Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Oct 2010 16:40:15 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ilya Basin <basinilya@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: 4.76 possible regression: bluetoothd segfaults when launching
 bluetooth programs
Message-ID: <20101025204015.GA19748@jh-x301>
References: <453819375.20101024163802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <453819375.20101024163802@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

On Sun, Oct 24, 2010, Ilya Basin wrote:
> Program received signal SIGSEGV, Segmentation fault.
> 0xb7d3e653 in strlen () from /lib/libc.so.6
> (gdb) bt
> #0  0xb7d3e653 in strlen () from /lib/libc.so.6
> #1  0xb7e5eb10 in ?? () from /usr/lib/libdbus-1.so.3
> #2  0xb7e4a34b in ?? () from /usr/lib/libdbus-1.so.3
> #3  0xb7e4e7a9 in dbus_message_iter_append_basic () from /usr/lib/libdbus-1.so.3
> #4  0xb7fef03d in append_array_variant ()
> #5  0xb7fef799 in emit_array_property_changed ()
> #6  0xb7fe4de4 in adapter_service_ins_rem ()
> #7  0xb7fd7fb1 in sdp_record_add ()
> #8  0xb7fd79de in service_register_req ()
> #9  0xb7fd5dfc in handle_request ()
> #10 0xb7fd496e in io_session_event ()
> #11 0xb7ef7a2b in ?? () from /usr/lib/libglib-2.0.so.0
> #12 0xb7eb0b72 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
> #13 0xb7eb1350 in ?? () from /usr/lib/libglib-2.0.so.0
> #14 0xb7eb1a1b in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
> #15 0xb7fd1bbd in main ()
> (gdb) 

Unfortunately this doesn't give too much info since you don't seem to
have all debug symbols enabled. Could you try to reproduce this with
latest bluez git. You don't need to install anything but just compile
(./boostrap-configure && make) and run (src/bluetoothd -nd) from the
source tree directly. Then, it'd also be nice if you could use git
bisect to determine the exact commit between 4.69 and 4.76 that
introduced this regression.
Thanks.

Johan
