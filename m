Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F495C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE03820A8B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762278AbgJXWal convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Oct 2020 18:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762265AbgJXWal (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Oct 2020 18:30:41 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209841] New: Segfault with A2DP because of a null codec
Date:   Sat, 24 Oct 2020 22:30:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: raphael.kernel@jakse.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-209841-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209841

            Bug ID: 209841
           Summary: Segfault with A2DP because of a null codec
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.8.10
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: raphael.kernel@jakse.fr
        Regression: No

Created attachment 293177
  --> https://bugzilla.kernel.org/attachment.cgi?id=293177&action=edit
Wireshark record of the Bluetooth connection between the two laptops

I have four devices:
 - a openSUSE Tumbleweed laptop running the 5.8.10-1-default x86_64 kernel
   (Bus 001 Device 002: ID 8087:0a2b Intel Corp. Bluetooth wireless interface)
 - a Debian Buster laptop also running the 5.7.0-0.bpo.2-amd64 kernel
   (Bus 002 Device 002: ID 04ca:300d Lite-On Technology Corp. Atheros AR3012
Bluetooth)
 - a Sony Bluetooth headset
 - an old Android 6 phone

Both laptop run Bluez 5.55 and Pulseaudio 13.0.

The Debian laptop acts as a bluetooth headset (it is supposed to receive sound
from devices). No GUI is running on it so configuration is manual.

The headset connects fine to the phone and the openSUSE laptop. The phone
connects to both laptops without issue, with sound working using A2DP.

Connecting from the Debian laptop to the openSUSE laptop only allows HSP (A2DP
is not available).

Connecting from the openSUSE laptop to the Debian laptop crashes Bluez on the
openSUSE laptop (segmentation fault). It does not matter if I connect using the
KDE Plasma applet or bluetoothctl. 

The crash happens because in function store_remote_sep, the service pointer is
NULL. Adding the following check:

    if (!service) return

right after:

    struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);

allows a successful connection without crash and A2DP is available, however,
there is no sound.

rewinding the execution, avdtp_register_sep gets a NULL codec_type parameter,
coming from endpoint->codec in endpoint_init_a2dp_sink, the remaining backtrace
being:

---
#0  0x000000000041e393 in endpoint_init_a2dp_sink (err=<optimized out>,
delay_reporting=<optimized out>, endpoint=<optimized out>) at
profiles/audio/media.c:807
#1  media_endpoint_create (adapter=adapter@entry=0x526cd0,
sender=sender@entry=0x522468 ":1.463", path=0x522284
"/MediaEndpoint/A2DPSink/sbc", 
    uuid=0x5222b8 "0000110b-0000-1000-8000-00805f9b34fb", delay_reporting=0,
codec=<optimized out>, capabilities=0x52230c "\377\377\002\065", size=4,
err=0x7fffffffe630)
    at profiles/audio/media.c:807
#2  0x000000000041e965 in register_endpoint (conn=<optimized out>,
msg=0x522030, data=0x526cd0) at profiles/audio/media.c:926
#3  0x000000000048b509 in process_message (connection=0x519290,
message=0x522030, method=0x4a69c0 <media_methods>, iface_user_data=<optimized
out>) at gdbus/object.c:259
#4  0x00007ffff7dfa501 in _dbus_object_tree_dispatch_and_unlock
(found_object=<synthetic pointer>, message=<optimized out>, tree=0x5196d0) at
dbus-object-tree.c:1020
---

Here is a Valgrind run:

# valgrind /usr/libexec/bluetooth/bluetoothd -d                                
                                                                        [0]
==21579== Memcheck, a memory error detector
==21579== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==21579== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==21579== Command: /usr/libexec/bluetooth/bluetoothd -d
==21579== 
==21579== Invalid read of size 1
==21579==    at 0x12AE86: store_remote_sep (a2dp.c:2652)
==21579==    by 0x12B75E: UnknownInlinedFun (queue.c:220)
==21579==    by 0x12B75E: UnknownInlinedFun (queue.c:203)
==21579==    by 0x12B75E: store_remote_seps (a2dp.c:2688)
==21579==    by 0x1335F0: discover_cb (a2dp.c:2722)
==21579==    by 0x12B8CD: finalize_discovery.lto_priv.0 (avdtp.c:1039)
==21579==    by 0x136D37: UnknownInlinedFun (avdtp.c:2896)
==21579==    by 0x136D37: UnknownInlinedFun (avdtp.c:2220)
==21579==    by 0x136D37: session_cb.lto_priv.0 (avdtp.c:2144)
==21579==    by 0x48D92D6: g_main_dispatch (gmain.c:3309)
==21579==    by 0x48D92D6: g_main_context_dispatch (gmain.c:3974)
==21579==    by 0x48D9657: g_main_context_iterate.constprop.0 (gmain.c:4047)
==21579==    by 0x48D994A: g_main_loop_run (gmain.c:4241)
==21579==    by 0x128C90: UnknownInlinedFun (mainloop-glib.c:79)
==21579==    by 0x128C90: UnknownInlinedFun (mainloop-notify.c:201)
==21579==    by 0x128C90: main (main.c:971)
==21579==  Address 0x3 is not stack'd, malloc'd or (recently) free'd
==21579== 
==21579== 
==21579== Process terminating with default action of signal 11 (SIGSEGV):
dumping core
==21579==  Access not within mapped region at address 0x3
==21579==    at 0x12AE86: store_remote_sep (a2dp.c:2652)
==21579==    by 0x12B75E: UnknownInlinedFun (queue.c:220)
==21579==    by 0x12B75E: UnknownInlinedFun (queue.c:203)
==21579==    by 0x12B75E: store_remote_seps (a2dp.c:2688)
==21579==    by 0x1335F0: discover_cb (a2dp.c:2722)
==21579==    by 0x12B8CD: finalize_discovery.lto_priv.0 (avdtp.c:1039)
==21579==    by 0x136D37: UnknownInlinedFun (avdtp.c:2896)
==21579==    by 0x136D37: UnknownInlinedFun (avdtp.c:2220)
==21579==    by 0x136D37: session_cb.lto_priv.0 (avdtp.c:2144)
==21579==    by 0x48D92D6: g_main_dispatch (gmain.c:3309)
==21579==    by 0x48D92D6: g_main_context_dispatch (gmain.c:3974)
==21579==    by 0x48D9657: g_main_context_iterate.constprop.0 (gmain.c:4047)
==21579==    by 0x48D994A: g_main_loop_run (gmain.c:4241)
==21579==    by 0x128C90: UnknownInlinedFun (mainloop-glib.c:79)
==21579==    by 0x128C90: UnknownInlinedFun (mainloop-notify.c:201)
==21579==    by 0x128C90: main (main.c:971)
==21579==  If you believe this happened as a result of a stack
==21579==  overflow in your program's main thread (unlikely but
==21579==  possible), you can try to increase the size of the
==21579==  main thread stack using the --main-stacksize= flag.
==21579==  The main thread stack size used in this run was 8388608.
==21579== 
==21579== HEAP SUMMARY:
==21579==     in use at exit: 183,968 bytes in 3,876 blocks
==21579==   total heap usage: 23,145 allocs, 19,269 frees, 7,976,961 bytes
allocated
==21579== 
==21579== LEAK SUMMARY:
==21579==    definitely lost: 0 bytes in 0 blocks
==21579==    indirectly lost: 0 bytes in 0 blocks
==21579==      possibly lost: 0 bytes in 0 blocks
==21579==    still reachable: 183,968 bytes in 3,876 blocks
==21579==         suppressed: 0 bytes in 0 blocks
==21579== Rerun with --leak-check=full to see details of leaked memory
==21579== 
==21579== For lists of detected and suppressed errors, rerun with: -s
==21579== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
[1]    21579 segmentation fault (core dumped)  valgrind
/usr/libexec/bluetooth/bluetoothd -d

There could be two problems here:
 - a missing null check
 - a codec incorrectly set to NULL. I've not yet traced back this NULL value.
This could be caused by a configuration error on my part, but something is
fishy since the phone successfully connects so it seemingly has the all the
information information it needs to stream sound (or makes assumption of what
is supported instead of checking, I don't know). 

I'm attaching:
 - a Wireshark capture of the connection
 - a record of the execution done using rr (`rr replay file` to replay)
containing the whole execution state.

Notes:
 - In GDB, setting a breakpoint in store_remote_sep makes Bluez not crash.
 - rr itself crashes on my openSUSE laptop when trying to record the execution,
unless running it in gdb like this: gdb -ex run -ex cont --args rr record
/usr/libexec/bluetooth/bluetoothd -d

Let me know if I can provide further information. I am very curious about this
crash.

-- 
You are receiving this mail because:
You are the assignee for the bug.
