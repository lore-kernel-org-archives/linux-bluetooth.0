Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 15:36:42 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [Crash report & Patch obexd 1/1] map: gboolean holds int value
 which 0/1 crashes in DBusMessage
Message-ID: <20120828183642.GA9691@samus>
References: <CAEd0BX-_PbMs1JV4g8_bYf43KScnHHKwsXaci=0cuqHcR-FGhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEd0BX-_PbMs1JV4g8_bYf43KScnHHKwsXaci=0cuqHcR-FGhg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Srini,

On 17:07 Tue 28 Aug, Venkateswaran, Srinivasa Ragavan wrote:
> Hi,
> 
> I was testing MAP and I came across a crash (trace attached). I
> figured out that the crash is because dbus expects gboolean to be 0/1
> where as it holds the 'int' results from strcasecmp. I've attached the
> patch that fixed the problem for me. This is my first message/patch to
> this list, sorry if it isn't in the right/expected format, just
> suggest me and I could put it right.

The patch in itself looks good.

Some changes: please use git send-email to send the patch (it is much
easier to look at inlined patches); please use a shorter subject line,
e.g. "map: Fix sending a D-Bus message with invalid parameters", and you
could attach the backtrace in the commit message.

> 
> Thanks,
> -Srini.

> Thread 1 (Thread 0x7ffff7fce700 (LWP 6124)):
> #0  0x00007ffff7328d95 in __GI_raise (sig=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
> #1  0x00007ffff732a2ab in __GI_abort () at abort.c:93
> #2  0x00007ffff78d0655 in _dbus_abort () at dbus-sysdeps.c:94
> #3  0x00007ffff78c75f1 in _dbus_warn_check_failed (format=0x7ffff78d6920 "arguments to %s() were incorrect, assertion \"%s\" failed in file %s line %d.\nThis is normally a bug in some application using the D-Bus library.\n") at dbus-internals.c:289
> #4  0x00007ffff78ba28b in dbus_message_iter_append_basic (iter=0x7fffffffd320, type=<optimized out>, value=0x7fffffffd43c) at dbus-message.c:2538
> #5  0x00000000004201c3 in append_variant (iter=0x7fffffffd3b0, type=98, value=0x7fffffffd43c) at client/dbus.c:44
> #6  0x000000000042024e in obex_dbus_dict_append (dict=0x7fffffffd480, key=0x4252bb "Read", type=98, value=0x7fffffffd43c) at client/dbus.c:65
> #7  0x000000000041dcc9 in parse_read (msg=0x63c650, value=0x63be00 "yes", iter=0x7fffffffd480) at client/map.c:423
> #8  0x000000000041dfa7 in msg_element (ctxt=0x63bc50, element=0x63bd70 "msg", names=0x7fffffffd5f0, values=0x7fffffffd560, user_data=0x6347b0, gerr=0x7fffffffd680) at client/map.c:518
> #9  0x00007ffff7b323b9 in emit_start_element (context=0x63bc50, error=0x0) at gmarkup.c:986
> #10 0x00007ffff7b33b44 in g_markup_parse_context_parse (context=0x63bc50, text=<optimized out>, text_len=<optimized out>, error=0x0) at gmarkup.c:1323
> #11 0x000000000041e1ad in message_listing_cb (session=0x631450, transfer=0x633fd0, err=0x0, user_data=0x638b60) at client/map.c:586
> #12 0x000000000041744c in session_terminate_transfer (session=0x631450, transfer=0x633fd0, gerr=0x0) at client/session.c:743
> #13 0x00000000004174d7 in session_notify_complete (session=0x631450, transfer=0x633fd0) at client/session.c:758
> #14 0x000000000041755a in transfer_complete (transfer=0x633fd0, err=0x0, user_data=0x631450) at client/session.c:778
> #15 0x000000000041f57b in xfer_complete (obex=0x634660, err=0x0, user_data=0x633fd0) at client/transfer.c:521
> #16 0x000000000040efdf in transfer_complete (transfer=0x63b260, err=0x0) at gobex/gobex-transfer.c:102
> #17 0x000000000040f418 in transfer_response (obex=0x634660, err=0x0, rsp=0x633d00, user_data=0x63b260) at gobex/gobex-transfer.c:221
> #18 0x000000000040b320 in handle_response (obex=0x634660, err=0x0, rsp=0x633d00) at gobex/gobex.c:948
> #19 0x000000000040bbc1 in incoming_data (io=0x638da0, cond=G_IO_IN, user_data=0x634660) at gobex/gobex.c:1191
> #20 0x00007ffff7b2f94a in g_main_dispatch (context=0x62f130) at gmain.c:2515
> #21 g_main_context_dispatch (context=0x62f130) at gmain.c:3052
> #22 0x00007ffff7b2fd10 in g_main_context_iterate (dispatch=1, block=<optimized out>, context=0x62f130, self=<optimized out>) at gmain.c:3123
> #23 g_main_context_iterate (context=0x62f130, block=<optimized out>, dispatch=1, self=<optimized out>) at gmain.c:3060
> #24 0x00007ffff7b3010a in g_main_loop_run (loop=0x62e1b0) at gmain.c:3317
> #25 0x000000000041527d in main (argc=1, argv=0x7fffffffdca8) at client/main.c:175
> (gdb) 


Cheers,
--  
Vinicius
