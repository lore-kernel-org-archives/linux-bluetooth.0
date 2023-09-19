Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBCE79A8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 19:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjISTey (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjISTex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 15:34:53 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC19D
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:34:48 -0700 (PDT)
Received: from github.com (hubbernetes-node-8556733.va3-iad.github.net [10.48.204.64])
        by smtp.github.com (Postfix) with ESMTPA id 88B5394104C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1695152087;
        bh=INVDvDU+bpPHwskb+V3m6o/XPhA3z8r5zpNLMWuMoQo=;
        h=Date:From:To:Subject:From;
        b=l+K7Tp49h2+EVVE3LCMvQngj6NcR6RTpR2AZaJ3oUojhFa+VlSw1KsW8bqhG0ryNC
         0bvYzB6viSfCFjWIt/14jxeD84Dqqml9VK835tiEQWRP3ZcNipz+fAXUeSrxV4cYNn
         1ya/5LmiXDDQ8/bmGgDWgCr5NhdrRjxBHLqQDCgM=
Date:   Tue, 19 Sep 2023 12:34:47 -0700
From:   Arkadiusz Bokowy <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/04e18c-7f788a@github.com>
Subject: [bluez/bluez] 616900: shared/log: Fix not checking vasprintf return
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6169001a2b57eab09743467b4392d554f1a26e92
      https://github.com/bluez/bluez/commit/6169001a2b57eab09743467b4392d=
554f1a26e92
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-18 (Mon, 18 Sep 2023)

  Changed paths:
    M src/shared/log.c

  Log Message:
  -----------
  shared/log: Fix not checking vasprintf return

It seems like some implementation of vasprintf set the content of the
str to NULL rather then returning -1 causing the following errors:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D216204=3D=3DERROR: AddressSanitizer: attempting free on address whi=
ch
was not malloc()-ed: 0x55e787722cf0 in thread T0
      #0 0x55e784f75872 in __interceptor_free.part.0 asan_malloc_linux.cp=
p.o
      #1 0x55e7850e55f9 in bt_log_vprintf
/usr/src/debug/bluez-git/bluez-git/src/shared/log.c:154:2
      #2 0x55e78502db18 in monitor_log
/usr/src/debug/bluez-git/bluez-git/src/log.c:40:2
      #3 0x55e78502dab4 in info
/usr/src/debug/bluez-git/bluez-git/src/log.c:52:2
      #4 0x55e78502e314 in __btd_log_init
/usr/src/debug/bluez-git/bluez-git/src/log.c:179:2
      #5 0x55e78502aa63 in main
/usr/src/debug/bluez-git/bluez-git/src/main.c:1388:2
      #6 0x7f1d5fe27ccf  (/usr/lib/libc.so.6+0x27ccf) (BuildId:
316d0d3666387f0e8fb98773f51aa1801027c5ab)
      #7 0x7f1d5fe27d89 in __libc_start_main
(/usr/lib/libc.so.6+0x27d89) (BuildId:
316d0d3666387f0e8fb98773f51aa1801027c5ab)
      #8 0x55e784e88084 in _start
(/usr/lib/bluetooth/bluetoothd+0x36084) (BuildId:
19348ea642303b701c033d773055becb623fe79a)
  Address 0x55e787722cf0 is a wild pointer inside of access range of
size 0x000000000001.
  SUMMARY: AddressSanitizer: bad-free asan_malloc_linux.cpp.o in
__interceptor_free.part.0
  =3D=3D216204=3D=3DABORTING
=D1=81=D0=B5=D0=BD 18 13:10:02 archlinux systemd[1]: bluetooth.service: M=
ain process
exited, code=3Dexited, status=3D1/FAILURE


  Commit: eb9eaf01d1616246a261aba155d348401882184b
      https://github.com/bluez/bluez/commit/eb9eaf01d1616246a261aba155d34=
8401882184b
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2023-09-19 (Tue, 19 Sep 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Skip new line when using util_debug

The debug callback vhci_debug() already prints new line after each debug
string. Explicit new line in the util_debug call causes double new line
in the output.


  Commit: 7f788a2c5162985eaddc8bb9377b3f1c91f2e041
      https://github.com/bluez/bluez/commit/7f788a2c5162985eaddc8bb9377b3=
f1c91f2e041
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2023-09-19 (Tue, 19 Sep 2023)

  Changed paths:
    M emulator/hciemu.c
    M emulator/vhci.c

  Log Message:
  -----------
  hciemu: Call btdev_receive_h4 unconditionally

Calling btdev_receive_h4 without prior logic will allow this function
to print some debug logs. E.g.: in case when the received packet type
is not supported.

> Bluetooth emulator ver 5.66
> vhci0: > ff 00 01 00                                      ....
> vhci0: Unsupported packet 0xff


Compare: https://github.com/bluez/bluez/compare/04e18c0dcbc1...7f788a2c51=
62
