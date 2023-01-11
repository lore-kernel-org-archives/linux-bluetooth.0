Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679CC677F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 01:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjAKBXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 20:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjAKBW7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 20:22:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94101D8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 17:22:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso18348147pjp.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 17:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maE/prng7KLiQSTifzcWotx3MOWGOQxNw77MFHWc1yo=;
        b=IhujJeSwFFUZichpfkSq5IZmD5vhYXJUOogRYTAwGqOtPR1MZKzyddvipU9XIkFtnF
         dJ/i40kgKRPyWmnBZN9bVHMZSB8jgf7euqBIejJnKq5xB4MHAh9eS9eKOeDFsbG6s79h
         74EQtq/SDLlc+51kDBH2MijMEtz2VZ2+YbVDt9rgcVMT7AKiESS7DWtQkExBJk0dcrVA
         4p01DxULPvqdFX9VzjqOj0HPxvHxfCYxv2swR3y6RING98DeHIZraGsl8W5bQ04epRoZ
         Z3nMQw4SKMuRzfX7YWrpaDl672Ukd4Q4O4OybR2ELOU3B71p5GihnoB/FoZSQcnRaVbc
         BsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maE/prng7KLiQSTifzcWotx3MOWGOQxNw77MFHWc1yo=;
        b=C1nz0IlBhL56fA6HOdDSGLpEkpnqSUzJl5dtNrTAKpsBsUwOn3I7zaZv6tpQStXJvr
         +jx2jpxr+OX6AjuRIO8ai1zsdyeEWFc+WcA5BnaiO6ufBKn0JAuxeBxqu0XxzcAuZV0D
         uZNaZ4BBs4YwukLeLF1b8+mC3Jk/vmU1TxuBpyKL2nRzHnGHji6Fc/a1BCHp64os9BYk
         ECFZfP3H8dJJ47oMktppi8aP/UScPkJbpXkrQCYSl8Xki7MuMQyKftHrgQxrhdBNG1tr
         DNG5+x3VhH9v+QoPnZ4TKzGoem/1Ez4v+QAjEJqWR2mAAJcX1Evyb0Qo4XauSq0YoGkM
         aSaQ==
X-Gm-Message-State: AFqh2kpGNj5R7KcTn1VLqepEOYUso47aWTm5IjKv/2GOTKmenYHR5pz7
        zYuIqh1e1lujidLtoYaieSAvD7GvSfs=
X-Google-Smtp-Source: AMrXdXvorzBk3o1WXEFBg53AZV+aR+qwb/a3aVh6ythPcqYADFSYpyCa4B0M9TFUlgsoHx/NKvacjw==
X-Received: by 2002:a17:902:c106:b0:193:24fb:ec65 with SMTP id 6-20020a170902c10600b0019324fbec65mr13117740pli.56.1673400177738;
        Tue, 10 Jan 2023 17:22:57 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b00192b0a07891sm8784670plx.101.2023.01.10.17.22.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:22:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix possible circular locking dependency
Date:   Tue, 10 Jan 2023 17:22:54 -0800
Message-Id: <20230111012254.3724082-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230111012254.3724082-1-luiz.dentz@gmail.com>
References: <20230111012254.3724082-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix the following trace:

iso-tester/52 is trying to acquire lock:
ffff8880024e0070 (&hdev->lock){+.+.}-{3:3}, at:
iso_sock_listen+0x29e/0x440

but task is already holding lock:
ffff888001978130 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
iso_sock_listen+0x8b/0x440

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
       lock_acquire+0x176/0x3d0
       lock_sock_nested+0x32/0x80
       iso_connect_cfm+0x1a3/0x630
       hci_cc_le_setup_iso_path+0x195/0x340
       hci_cmd_complete_evt+0x1ae/0x500
       hci_event_packet+0x38e/0x7c0
       hci_rx_work+0x34c/0x980
       process_one_work+0x5a5/0x9a0
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x22/0x30

-> #1 (hci_cb_list_lock){+.+.}-{3:3}:
       lock_acquire+0x176/0x3d0
       __mutex_lock+0x13b/0xf50
       hci_le_remote_feat_complete_evt+0x17e/0x320
       hci_event_packet+0x38e/0x7c0
       hci_rx_work+0x34c/0x980
       process_one_work+0x5a5/0x9a0
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x22/0x30

-> #0 (&hdev->lock){+.+.}-{3:3}:
       check_prev_add+0xfc/0x1190
       __lock_acquire+0x1e27/0x2750
       lock_acquire+0x176/0x3d0
       __mutex_lock+0x13b/0xf50
       iso_sock_listen+0x29e/0x440
       __sys_listen+0xe6/0x160
       __x64_sys_listen+0x25/0x30
       do_syscall_64+0x42/0x90
       entry_SYSCALL_64_after_hwframe+0x62/0xcc

other info that might help us debug this:

Chain exists of:
  &hdev->lock --> hci_cb_list_lock --> sk_lock-AF_BLUETOOTH-BTPROTO_ISO

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
                               lock(hci_cb_list_lock);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by iso-tester/52:
 #0: ffff888001978130 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
 iso_sock_listen+0x8b/0x440

Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6157bc12b373..24444b502e58 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -893,13 +893,10 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
-	hci_dev_lock(hdev);
-
 	err = hci_pa_create_sync(hdev, &iso_pi(sk)->dst,
 				 le_addr_type(iso_pi(sk)->dst_type),
 				 iso_pi(sk)->bc_sid);
 
-	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
-- 
2.37.3

