Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D5C83F33
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 14:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjIDOM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbjIDOM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 10:12:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB81717
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 07:12:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0d5b16aacso8150235ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693836726; x=1694441526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77ZhpwyIbCl8NjNuWWA+XVZ5QXGSq69GvtqoZuQwP7E=;
        b=GDbsmb/Ge4Rp6rzQD+Jgo0Yd3WpfvJQde4brKtMiNp+vAIqSNtU1gKbXSqku0DoDbl
         xZwuoufX5fzDznY10m2TY6R2tou4ldVGHzxbrsS7ePlhFtbAXVQpgjmD5lyh5LythiPh
         SXLCKQwyh98ni0Ak5l2A5lmza9+3HFRTZ3no4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693836726; x=1694441526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77ZhpwyIbCl8NjNuWWA+XVZ5QXGSq69GvtqoZuQwP7E=;
        b=ACAA7iCHGNZa3BeRBclb8221l4pEspHHICN7WTO0YuA9tnkIkN3lGhu1FMThQRnG+L
         SCCW7RKVEIMBy1WKPrjBJY0BRSJ1+ZttipCGlTwbz4C2u1OFqDFsKaXSi2Q0ScBSV41c
         NUwa6S7m1hwWID2I+BpNq+8bzJwygoa8rC7bGFc7oUUXM8++md+yZH0DByL9M79VnoVF
         IsbEAXpSdJquaDO5fIzQc0YhAeMEkKdgMVweQ1BDMz8KjsPtTapX9jLaZfEWcJm7dGIY
         p+TLPJsj27QVnyKG6LnmA5WECiRD2YRsX3NY00gxYl7HSAzEgj/tRtJzt9BkiIzAbFA6
         CutA==
X-Gm-Message-State: AOJu0YwUuqOMtB0WWYzA/BHZLU+gacrZxvD4lOv5yR69IRpIyfsjaxUN
        EDu9ze9WaAh7CYZoG6b5KRl0/9YfDue81rG1P44=
X-Google-Smtp-Source: AGHT+IHNfsHxqWwK8aWr0T4UeeVFDMukWWnEolbAqXabOs3PsYsPCHigFjMRGaGr/8k5T/zgP2Z/eQ==
X-Received: by 2002:a17:903:244c:b0:1bd:ea88:7b93 with SMTP id l12-20020a170903244c00b001bdea887b93mr9597339pls.54.1693836726142;
        Mon, 04 Sep 2023 07:12:06 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a170902e80200b001b9da42cd7dsm7578243plg.279.2023.09.04.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:12:05 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix hci_link_tx_to RCU lock usage
Date:   Mon,  4 Sep 2023 14:11:51 +0000
Message-ID: <20230904141155.1688673-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Syzbot found a bug "BUG: sleeping function called from invalid context
at kernel/locking/mutex.c:580". It is because hci_link_tx_to holds an
RCU read lock and calls hci_disconnect which would hold a mutex lock
since the commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code
for aborting connections"). Here's an example call trace:

   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
   ___might_sleep+0x4a9/0x4d3 kernel/sched/core.c:9663
   __mutex_lock_common kernel/locking/mutex.c:576 [inline]
   __mutex_lock+0xc7/0x6e7 kernel/locking/mutex.c:732
   hci_cmd_sync_queue+0x3a/0x287 net/bluetooth/hci_sync.c:388
   hci_abort_conn+0x2cd/0x2e4 net/bluetooth/hci_conn.c:1812
   hci_disconnect+0x207/0x237 net/bluetooth/hci_conn.c:244
   hci_link_tx_to net/bluetooth/hci_core.c:3254 [inline]
   __check_timeout net/bluetooth/hci_core.c:3419 [inline]
   __check_timeout+0x310/0x361 net/bluetooth/hci_core.c:3399
   hci_sched_le net/bluetooth/hci_core.c:3602 [inline]
   hci_tx_work+0xe8f/0x12d0 net/bluetooth/hci_core.c:3652
   process_one_work+0x75c/0xba1 kernel/workqueue.c:2310
   worker_thread+0x5b2/0x73a kernel/workqueue.c:2457
   kthread+0x2f7/0x30b kernel/kthread.c:319
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

This patch releases RCU read lock before calling hci_disconnect and
reacquires it afterward to fix the bug.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested this commit using a C reproducer on qemu-x86_64 for 10 minutes.

 net/bluetooth/hci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a5992f1b3c9b..db4f28d68d71 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3418,7 +3418,12 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 		if (c->type == type && c->sent) {
 			bt_dev_err(hdev, "killing stalled connection %pMR",
 				   &c->dst);
+			/* hci_disconnect might sleep, so, we have to release
+			 * the RCU read lock before calling it.
+			 */
+			rcu_read_unlock();
 			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
+			rcu_read_lock();
 		}
 	}
 
-- 
2.42.0.283.g2d96d420d3-goog

