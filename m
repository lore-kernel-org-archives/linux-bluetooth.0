Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C526C04FFE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 21:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjITVJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjITVJ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 17:09:26 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E3CA
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 14:09:20 -0700 (PDT)
Received: from github.com (hubbernetes-node-2b29bc0.va3-iad.github.net [10.48.139.15])
        by smtp.github.com (Postfix) with ESMTPA id B3DEB8C06F0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695244158;
        bh=o2BKZ7MpRDyMvsm8nx8IzuVJGhF5gDBp2qC+eHOlSfk=;
        h=Date:From:To:Subject:From;
        b=J5qM1/jWshXqnRWHcOO7oAhK+vEkIPpQYUHP0cf0rbL8EE6BZL5xbct/rWWo0DiNu
         Ys8EF1ggRxvOaP0KXTeMtr/Pn2dkED3R98YDiLyJmJSjZfMz7Y40d8x5eEcE88oxbd
         HvoXl4t4HneD4+sDjCaxCqLi0bPySNWkUeTD/ZqA=
Date:   Wed, 20 Sep 2023 14:09:18 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7f788a-5ab535@github.com>
Subject: [bluez/bluez] f479c2: media-api: Convert to ReStructuredText format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f479c2404ecfb8723a1c4d55c7cbe8726ffcd6b7
      https://github.com/bluez/bluez/commit/f479c2404ecfb8723a1c4d55c7cbe8726ffcd6b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-19 (Tue, 19 Sep 2023)

  Changed paths:
    M Makefile.am
    A doc/media-api.rst
    R doc/media-api.txt
    M test/example-player
    M test/simple-player

  Log Message:
  -----------
  media-api: Convert to ReStructuredText format

This converts media-api.txt to media-api.rst.


  Commit: a2d47ef0522663fbd3887d198196647e28d2cf3c
      https://github.com/bluez/bluez/commit/a2d47ef0522663fbd3887d198196647e28d2cf3c
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2023-09-20 (Wed, 20 Sep 2023)

  Changed paths:
    M emulator/vhci.c

  Log Message:
  -----------
  vhci: Check whether vhci open setup succeeded

Due to race condition in the vhci kernel driver, we might read not a
vendor response packet, but a HCI reset command. This extra check will
ensure that kernel driver behaves correctly. Otherwise, the HCI setup
process will fail, because our controller will not respond to "missing"
HCI reset command. In result the virtual HCI will be DOWN and without
initialized Bluetooth address, e.g:

> hciconfig
hci2:   Type: Primary  Bus: Virtual
        BD Address: 00:AA:01:01:00:02  ACL MTU: 192:1  SCO MTU: 0:0
        UP RUNNING
        RX bytes:0 acl:0 sco:0 events:66 errors:0
        TX bytes:3086 acl:0 sco:0 commands:66 errors:0

hci1:   Type: Primary  Bus: Virtual
        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:8 acl:0 sco:0 commands:1 errors:0

> dmesg
[1754256.640122] Bluetooth: MGMT ver 1.22
[1754263.023806] Bluetooth: MGMT ver 1.22
[1754265.043775] Bluetooth: hci1: Opcode 0x c03 failed: -110


  Commit: 5ab5352531a9cc7058cce569607f3a6831464443
      https://github.com/bluez/bluez/commit/5ab5352531a9cc7058cce569607f3a6831464443
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-20 (Wed, 20 Sep 2023)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: Fix not checking Primary/Secundary Counter length

Primary/Secundary Counters are supposed to be 16 bytes values, if the
server has implemented them incorrectly it may lead to the following
crash:

=================================================================
==31860==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x607000001878 at pc 0x7f95a1575638 bp 0x7fff58c6bb80 sp 0x7fff58c6b328

 READ of size 48 at 0x607000001878 thread T0
     #0 0x7f95a1575637 in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long) ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:860
     #1 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:892
     #2 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:887
     #3 0x564df69c77a0 in read_version obexd/client/pbap.c:288
     #4 0x564df69c77a0 in read_return_apparam obexd/client/pbap.c:352
     #5 0x564df69c77a0 in phonebook_size_callback obexd/client/pbap.c:374
     #6 0x564df69bea3c in session_terminate_transfer obexd/client/session.c:921
     #7 0x564df69d56b0 in get_xfer_progress_first obexd/client/transfer.c:729
     #8 0x564df698b9ee in handle_response gobex/gobex.c:1140
     #9 0x564df698cdea in incoming_data gobex/gobex.c:1385
     #10 0x7f95a12fdc43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
     #11 0x7f95a13526c7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xaa6c7)
     #12 0x7f95a12fd2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
     #13 0x564df6977d41 in main obexd/src/main.c:307
     #14 0x7f95a10a7d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
     #15 0x7f95a10a7e3f in __libc_start_main_impl ../csu/libc-start.c:392
     #16 0x564df6978704 in _start (/usr/local/libexec/bluetooth/obexd+0x8b704)
 0x607000001878 is located 0 bytes to the right of 72-byte region [0x607000001830,0x607000001878)

 allocated by thread T0 here:
     #0 0x7f95a1595a37 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
     #1 0x564df69c8b6a in pbap_probe obexd/client/pbap.c:1259


Compare: https://github.com/bluez/bluez/compare/7f788a2c5162...5ab5352531a9
