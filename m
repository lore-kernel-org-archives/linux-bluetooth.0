Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D7CA0FE9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjIDWMK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbjIDWMI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D89C
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so28503921fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865520; x=1694470320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ur35l0hzeFrQ0x+xJ3It213z7CznBjMNaAxesEVScZI=;
        b=cIWvxn8LAtW+nF/o001sZG035Nkd5qK5gGnynQPhAqNR4Ya5VFfxj2yfSo1IPIusXP
         LMByCo0dUhEg7T23W0M4nrf3kQKGnJUzLx+fMWZRvKWXwFKsr/4NVdXWCYF3GDFnq72b
         1sYNejGM4V4KB/T2VW5h2HKEnXZZCxaOn43NtvvkzP4PO9DJiPhZclYfriEjS3pxX8Ur
         nfTmbIVKFJaG/TBHjlmq3Z24vR101bOTbDEOMvHbv+JPfFaq1cYF3rxoPeGj7k2JokKo
         IWM127rfnxiV7cC9HOYGVLPYXfnn+RvBxOuhwuVwPUBr21HhX3edcW0A3R54RXgAODQJ
         97mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865520; x=1694470320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ur35l0hzeFrQ0x+xJ3It213z7CznBjMNaAxesEVScZI=;
        b=FKNMIYoyVHciKcRmHWjJkof9/FBzyZbLR83yMm/oPapZErNq3mManCct4sGWHM5Gbk
         1IqWqrR9nggx1AkII3iAlbm08dONZNUeS1KXQR9gGbiGdnbsGCUzs2lBVrIryHEoxLIo
         J526d9pZFo/MAsIFB9MstQ2FI74gZ34ptIwCIveAa0P6xkYqPFx+8rVnNAxg4iBCv1zv
         nTnvJGGVBs4MCWifIP9hHnv8p15xHG9OkTbhmSMFZSxo6fefj17S/jc0glmusMNKcmGk
         gpUlFQVglPws+uBlAfahKHCWMktGG2fSOBZkhUJw181toEYHFR88yOLJTyU9t7/izAl4
         p3yw==
X-Gm-Message-State: AOJu0YxVQg/Xz65rqqk2tjBNkVj0E3GWTb50tsyZ+f81x05RBrnbxT+R
        CubK3cyx4F/DwoVzhqw/88hdWuecD1wh00IWRzE=
X-Google-Smtp-Source: AGHT+IFUJHVBi6B9Gsra8heaEBTuzwK58nqaw5cIvmZNAoHw9i9ubVdi+2ah3YF+Hf/bgbTdOso48g==
X-Received: by 2002:a2e:9691:0:b0:2b5:80c9:1266 with SMTP id q17-20020a2e9691000000b002b580c91266mr8398561lji.43.1693865520307;
        Mon, 04 Sep 2023 15:12:00 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:11:59 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH RFC 0/7] Fix a memory leak in Bluetooth L2CAP
Date:   Tue,  5 Sep 2023 00:11:51 +0200
Message-Id: <20230904221158.35425-1-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Request for Comments

Summary
=======

We have found a memory leak in the Bluetooth L2CAP subsystem and fixed
it, but this opened the doors to use-after-free problems, which are
not completely fixed yet. This patch series present a way to reproduce
it, the proposed fix and the status. There is more detailed
documentation in [1].

Memory Leak Overview
====================

We have found a memory leak in the L2CAP layer of Linux's Bluetooth
Subsystem, the same as reported by syzbot in "[syzbot] [bluetooth?]
memory leak in hci_conn_add (2)" (2023-09-02 23:25:00 -0700) [19].

We can reproduce it. When, in a loop, a user-mode program:

 1. Opens a Bluetooth socket at the L2CAP layer:

          sockfd = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

 2. Set a timeout on the socket:

          timeout.tv_sec  = 2;
          timeout.tv_usec = 0;

          err = setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(timeout));

 3. Connect to a specific Bluetooth address:

          struct sockaddr_l2 ble_addr;

          memset(&ble_addr, 0, sizeof(ble_addr));
          ble_addr.l2_family = AF_BLUETOOTH;
          ble_addr.l2_psm = htobs(0x80 /* L2CAP_PSM_LE_DYN_START */);
          // l2_bdaddr=00:0a:07:a3:22:00
          ble_addr.l2_bdaddr = *(bdaddr_t*)("\x00\x0a\x07\xa3\x22\x00");
          ble_addr.l2_cid = htobs(0);
          ble_addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;

          err = connect(sockfd, (struct sockaddr*)&ble_addr, sizeof(ble_addr));

and when the user program does those three steps in a loop, then the
kernel leaks the "struct l2cap_conn" [5] and "struct hci_conn" [6]
objects allocated in "l2cap_conn_add()" [2] and "hci_conn_add()" [3].
Those objects are never freed.

The "ble-memleak-repro" program reproduces the memory leak, if the
kernel is not patched. Its source is in
"package/ble-memleak-repro/ble-memleak-repro.c" [18].

Memory Leak Fix
===============

We have fixed the memory leak, see the patch series in
"patches/linux/":

 1. The first patch
    "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch" [11]
    enables Bluetooth on the DK2.
 2. The second patch
    "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch" [12]
    adds many dynamic debug traces that help understand the kernel
    behaviour and freeing problems.
 3. Patches
    "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch" [13]
    and
    "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch" [14]
    fix the memory leak.
 4. Patches
    "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch" [15],
    "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch" [16]
    and
    "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch" [17]
    fixes the use-after-free that appears when the "struct l2cap_conn"
    [5] and "struct hci_conn" [6] objects are freed.

The commit messages explain why the commit is needed, which problem
the commit solves, and how.

The first and second patches are present for the memory leak
reproduction only, they should not be part of a final fix.

Patch Status
============

As of writing, the memory leak is fixed. The fix opened the door to
other problems, especially use-after-free, sometimes followed by
crashes due to NULL dereferences. We think there are weak references
(i.e. pointers that don't increment the refcounter) previously
pointing to memory that was never freed, but now is freed. On kernels
v5.13 and v5.15, patches 0005, 0006 and 0007 seem to fix the
use-after-free and NULL dereferences, but not on kernel v6.5 yet.

Reproducing with Buildroot
==========================

We have reproduced and fixed the memory leak with Buildroot [7] and a
"ble-memleak-repro" test application on an ST's Discovery Kit DK2 [4].

The "ble-memleak-repro" repository [1] contains the sources of a
complete external Buildroot customisation [8], with the patches, a
README, and more explanations to reproduce the problem with Buildroot
on a DK2.

References:
===========

- [1]: <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
       "ble-memleak-repro repository"

- [2]: <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/l2cap_core.c#L7833>
       "l2cap_conn_add()"

- [3]: <https://elixir.bootlin.com/linux/v6.5/source/net/bluetooth/hci_conn.c#L986>
       "hci_conn_add()"

- [4]: <https://www.st.com/content/st_com/en/products/evaluation-tools/product-evaluation-tools/mcu-mpu-eval-tools/stm32-mcu-mpu-eval-tools/stm32-discovery-kits/stm32mp157c-dk2.html>
       "STM32MP157C-DK2 (DK2)"

- [5]: <https://elixir.bootlin.com/linux/v6.5/source/include/net/bluetooth/l2cap.h#L674>
       "struct l2cap_conn"

- [6]: <https://elixir.bootlin.com/linux/v6.5/source/include/net/bluetooth/hci_core.h#L685>
       "struct hci_conn"

- [7]: <https://buildroot.org/>
       "Buildroot is a tool to generate embedded Linux systems"

- [8]: <https://buildroot.org/downloads/manual/manual.html#outside-br-custom>
       "9.2. Keeping customizations outside of Buildroot"

- [11]: <patches/linux/0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch>
        "0001-ARM-dts-stm32-Add-Bluetooth-usart2-feature-on-stm32m.patch"

- [12]: <patches/linux/0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch>
        "0002-Bluetooth-add-many-traces-for-allocation-free-refcou.patch"

- [13]: <patches/linux/0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch>
        "0003-Bluetooth-L2CAP-use-refcount-on-struct-l2cap_chan-co.patch"

- [14]: <patches/linux/0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch>
        "0004-Bluetooth-L2CAP-free-the-leaking-struct-l2cap_conn.patch"

- [15]: <patches/linux/0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch>
        "0005-Bluetooth-introduce-hci_conn_free-for-better-structu.patch"

- [16]: <patches/linux/0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch>
        "0006-Bluetooth-L2CAP-inc-refcount-if-reuse-struct-l2cap_c.patch"

- [17]: <patches/linux/0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch>
        "0007-Bluetooth-unlink-objects-to-avoid-use-after-free.patch"

- [18]: <https://gitlab.com/essensium-mind/ble-memleak-repro/-/blob/main/package/ble-memleak-repro/ble-memleak-repro.c?ref_type=heads>
        "ble-memleak-repro.c"

- [19]: <https://lore.kernel.org/linux-bluetooth/0000000000000fd01206046e7410@google.com/T/#u>
        "[syzbot] [bluetooth?] memory leak in hci_conn_add (2)"
        2023-09-02 23:25:00 -0700

---

Christophe Roullier (1):
  ARM: dts: stm32: Add Bluetooth (usart2) feature on stm32mp157x

Olivier L'Heureux (6):
  Bluetooth: add many traces for allocation/free/refcounting
  Bluetooth: L2CAP: use refcount on struct l2cap_chan->conn
  Bluetooth: L2CAP: free the leaking struct l2cap_conn
  Bluetooth: introduce hci_conn_free() for better structure
  Bluetooth: L2CAP: inc refcount if reuse struct l2cap_conn
  Bluetooth: unlink objects to avoid use-after-free

 arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 11 ++++++-
 include/net/bluetooth/hci_core.h         |  7 +++--
 net/bluetooth/hci_conn.c                 | 18 ++++++++++++
 net/bluetooth/hci_sysfs.c                |  8 ++++-
 net/bluetooth/l2cap_core.c               | 37 ++++++++++++++++++++----
 5 files changed, 72 insertions(+), 9 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.39.2

