Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA20C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Oct 2023 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjJ2Vty (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Oct 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJ2Vtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Oct 2023 17:49:53 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BD8C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Oct 2023 14:49:49 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SJVRt1gKlz9sdZ;
        Sun, 29 Oct 2023 22:49:46 +0100 (CET)
Message-ID: <59f3df96-3972-4266-a9ff-14c21af15c47@v0yd.nl>
Date:   Sun, 29 Oct 2023 22:49:44 +0100
MIME-Version: 1.0
To:     silviu.barbulescu@nxp.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com
References: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
Subject: Re: [PATCH v3 1/2] transport: Update transport release flow for bcast
 src
Content-Language: en-US
From:   =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SJVRt1gKlz9sdZ
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Silviu,

this patch introduced a use-after-free, reproducer:

- connect to a2dp sink
- start playing
- pause and wait until stream suspends
- bluetoothd crashes in a2dp_suspend_complete()

Here's the output running with address sanitizer:

bluetoothd[181120]: profiles/audio/a2dp.c:suspend_cfm() Source 
0x60600001e500: Suspend_Cfm
=================================================================
==181120==ERROR: AddressSanitizer: heap-use-after-free on address 
0x60300005a730 at pc 0xaaaaf9dbeea8 bp 0xfffff4d3b690 sp 0xfffff4d3b6a8
READ of size 8 at 0x60300005a730 thread T0
     #0 0xaaaaf9dbeea4 in a2dp_suspend_complete 
profiles/audio/transport.c:426
     #1 0xaaaaf9d7d37c in finalize_suspend profiles/audio/a2dp.c:376
     #2 0xaaaaf9d7e060 in suspend_cfm profiles/audio/a2dp.c:1276
     #3 0xaaaaf9da0ddc in avdtp_delay_report_resp 
profiles/audio/avdtp.c:2928
     #4 0xaaaaf9da0ddc in avdtp_parse_resp profiles/audio/avdtp.c:2997
     #5 0xaaaaf9da0ddc in session_cb profiles/audio/avdtp.c:2286
     #6 0xffff6e77030c in g_main_dispatch ../glib/gmain.c:3476
     #7 0xffff6e77030c in g_main_context_dispatch_unlocked 
../glib/gmain.c:4284
     #8 0xffff6e7ce598 in g_main_context_iterate_unlocked.isra.0 
../glib/gmain.c:4349
     #9 0xffff6e771a60 in g_main_loop_run 
(/lib64/libglib-2.0.so.0+0x61a60) (BuildId: 
7d17ee836a99abf35136ebb46126a95dee66511a)
     #10 0xaaaafa0ad0d8 in mainloop_run src/shared/mainloop-glib.c:66
     #11 0xaaaafa0ad920 in mainloop_run_with_signal 
src/shared/mainloop-notify.c:188
     #12 0xaaaaf9d5489c in main src/main.c:1452
     #13 0xffff6dd209d8 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58
     #14 0xffff6dd20aac in __libc_start_main_impl ../csu/libc-start.c:360
     #15 0xaaaaf9d5686c in _start 
(/home/jonas/git/bluez/src/bluetoothd+0x55686c) (BuildId: 
8922b026a55aac729ed13de54b3a622a31b5bb2b)

0x60300005a730 is located 0 bytes inside of 32-byte region 
[0x60300005a730,0x60300005a750)
freed by thread T0 here:
     #0 0xffff6ea24638 in __interceptor_free.part.0 
(/lib64/libasan.so.8+0xc4638) (BuildId: 
a77e9fa1e1448d41e9a8ddaf28aa5612f3ffc397)
     #1 0xffff6e773114 in g_free (/lib64/libglib-2.0.so.0+0x63114) 
(BuildId: 7d17ee836a99abf35136ebb46126a95dee66511a)
     #2 0xaaaaf9dbc42c in media_transport_remove_owner 
profiles/audio/transport.c:322
     #3 0xaaaaf9dc0b64 in bap_disable_complete 
profiles/audio/transport.c:632
     #4 0xaaaaf9dc0b64 in release profiles/audio/transport.c:674
     #5 0xaaaaf9ff2574 in process_message gdbus/object.c:246
     #6 0xffff6e69de78 in _dbus_object_tree_dispatch_and_unlock 
../../dbus/dbus-object-tree.c:1021
     #7 0xaaaaf9fe44a4 in message_dispatch gdbus/mainloop.c:59
     #8 0xffff6e76c444 in g_idle_dispatch ../glib/gmain.c:6282
     #9 0xffff6e77030c in g_main_dispatch ../glib/gmain.c:3476
     #10 0xffff6e77030c in g_main_context_dispatch_unlocked 
../glib/gmain.c:4284
     #11 0xffff6e7ce598 in g_main_context_iterate_unlocked.isra.0 
../glib/gmain.c:4349
     #12 0xffff6e771a60 in g_main_loop_run 
(/lib64/libglib-2.0.so.0+0x61a60) (BuildId: 
7d17ee836a99abf35136ebb46126a95dee66511a)
     #13 0xaaaafa0ad0d8 in mainloop_run src/shared/mainloop-glib.c:66
     #14 0xaaaafa0ad920 in mainloop_run_with_signal 
src/shared/mainloop-notify.c:188
     #15 0xaaaaf9d5489c in main src/main.c:1452
     #16 0xffff6dd209d8 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58
     #17 0xffff6dd20aac in __libc_start_main_impl ../csu/libc-start.c:360
     #18 0xaaaaf9d5686c in _start 
(/home/jonas/git/bluez/src/bluetoothd+0x55686c) (BuildId: 
8922b026a55aac729ed13de54b3a622a31b5bb2b)

previously allocated by thread T0 here:
     #0 0xffff6ea25218 in calloc (/lib64/libasan.so.8+0xc5218) (BuildId: 
a77e9fa1e1448d41e9a8ddaf28aa5612f3ffc397)
     #1 0xffff6e7769e4 in g_malloc0 (/lib64/libglib-2.0.so.0+0x669e4) 
(BuildId: 7d17ee836a99abf35136ebb46126a95dee66511a)
     #2 0xaaaaf9db89c4 in media_owner_create profiles/audio/transport.c:514
     #3 0xaaaaf9dbd760 in acquire profiles/audio/transport.c:552
     #4 0xaaaaf9dbd760 in acquire profiles/audio/transport.c:538
     #5 0xaaaaf9ff2574 in process_message gdbus/object.c:246
     #6 0xffff6e69de78 in _dbus_object_tree_dispatch_and_unlock 
../../dbus/dbus-object-tree.c:1021
     #7 0xaaaaf9fe44a4 in message_dispatch gdbus/mainloop.c:59
     #8 0xffff6e76c444 in g_idle_dispatch ../glib/gmain.c:6282
     #9 0xffff6e77030c in g_main_dispatch ../glib/gmain.c:3476
     #10 0xffff6e77030c in g_main_context_dispatch_unlocked 
../glib/gmain.c:4284
     #11 0xffff6e7ce598 in g_main_context_iterate_unlocked.isra.0 
../glib/gmain.c:4349
     #12 0xffff6e771a60 in g_main_loop_run 
(/lib64/libglib-2.0.so.0+0x61a60) (BuildId: 
7d17ee836a99abf35136ebb46126a95dee66511a)
     #13 0xaaaafa0ad0d8 in mainloop_run src/shared/mainloop-glib.c:66
     #14 0xaaaafa0ad920 in mainloop_run_with_signal 
src/shared/mainloop-notify.c:188
     #15 0xaaaaf9d5489c in main src/main.c:1452
     #16 0xffff6dd209d8 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58
     #17 0xffff6dd20aac in __libc_start_main_impl ../csu/libc-start.c:360
     #18 0xaaaaf9d5686c in _start 
(/home/jonas/git/bluez/src/bluetoothd+0x55686c) (BuildId: 
8922b026a55aac729ed13de54b3a622a31b5bb2b)

SUMMARY: AddressSanitizer: heap-use-after-free 
profiles/audio/transport.c:426 in a2dp_suspend_complete

