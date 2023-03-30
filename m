Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417DC77B6D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC3WHe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjC3WGX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA61166B
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so19471675plg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680213816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uepZg69M+ah19FAXIauFv/g+sr4j5xKx856LnLPgKrA=;
        b=ea1jqo6xsATHtsewQK7n7LfEaCVorTpFPUhjBXiqFy8gmhqJ3hZQ5qwRPK30rL1i67
         yXPe49LYGqLyHPSQmX0dxO0hvVFZDd2Y/QJw2sksVs0YbVPA4aLzuc1Hnt/Fz7o07caz
         FdHmoDpmjKqbfzz1dkf4ViNmSrlHTdGC+y0lbNn8qdop8t6NFEQQD1f/HvF7HnM2c5p5
         /zKfrezped3chRMRsQ8Uyx7lXo+asNsnbljVs5ihP+5PEt+iRO9WyFHKpEOiAGOqBU5M
         rwrZKuHaWiO6KXLQv3H0qsp2jyiYNL/y8XM2BWTtAzDJdXzMi+Meef+KOoRddVTP4It8
         pBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uepZg69M+ah19FAXIauFv/g+sr4j5xKx856LnLPgKrA=;
        b=Cp6gVx4JMSoOLXto+eVTyp/5V0qn0Xws3EeSYpK+ovoXtTh6bVXmd79PEGmt1CuoDG
         fo0AFHxGQOXhQObhugk26f39jtMIJ2qyGbpKW3EksOIoxEjjDLQNWABrfy0wGV0iiIVa
         8WuvfgiXokVHmcnpK6ayHhYU51nfpVuSukDSoQmqltoxTZGHn8M8+nJ5Fuz4UYRO07Dl
         E7+AjFiDtSwRLmkmYfWBboBkWI8mCFJC0S2sKgWB4p4WD0AvME+CMViM0f/IgP0dK403
         PAyYBs59LNKIrZXk2he/NftCR5DBVyEEa0SxUKYqSSnElEqMNjiqaXovgiOwGYtS731l
         Bztw==
X-Gm-Message-State: AO0yUKX9lZZb/ygj6Yotu50WX6J+oyD9e+q/aM2Z21dJLcSRSmU9f3la
        xOyjrFyElh8IdXaiUSfPDzFFTBLMNzs=
X-Google-Smtp-Source: AK7set/O02D5EP3rbxJINyu3donzXzOQIv5D+qZRj3iFTfrAnw8/creL8dFTke0+UVUtmPrFNWZXvA==
X-Received: by 2002:a05:6a20:ba83:b0:db:b960:d319 with SMTP id fb3-20020a056a20ba8300b000dbb960d319mr23494432pzb.12.1680213816423;
        Thu, 30 Mar 2023 15:03:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z14-20020aa791ce000000b00571cdbd0771sm333790pfa.102.2023.03.30.15.03.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:03:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: SCO: Fix possible circular locking dependency sco_sock_getsockopt
Date:   Thu, 30 Mar 2023 15:03:32 -0700
Message-Id: <20230330220332.1035910-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330220332.1035910-1-luiz.dentz@gmail.com>
References: <20230330220332.1035910-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix the following trace:

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc2-g68fcb3a7bf97 #4706 Not tainted
------------------------------------------------------
sco-tester/31 is trying to acquire lock:
ffff8880025b8070 (&hdev->lock){+.+.}-{3:3}, at:
sco_sock_getsockopt+0x1fc/0xa90

but task is already holding lock:
ffff888001eeb130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at:
sco_sock_getsockopt+0x104/0xa90

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       lock_sock_nested+0x32/0x80
       sco_connect_cfm+0x118/0x4a0
       hci_sync_conn_complete_evt+0x1e6/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

-> #1 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock+0x13b/0xcc0
       hci_sync_conn_complete_evt+0x1ad/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

-> #0 (&hdev->lock){+.+.}-{3:3}:
       __lock_acquire+0x18cc/0x3740
       lock_acquire+0x151/0x3a0
       __mutex_lock+0x13b/0xcc0
       sco_sock_getsockopt+0x1fc/0xa90
       __sys_getsockopt+0xe9/0x190
       __x64_sys_getsockopt+0x5b/0x70
       do_syscall_64+0x42/0x90
       entry_SYSCALL_64_after_hwframe+0x70/0xda

other info that might help us debug this:

Chain exists of:
  &hdev->lock --> hci_cb_list_lock --> sk_lock-AF_BLUETOOTH-BTPROTO_SCO

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);
                               lock(hci_cb_list_lock);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);
  lock(&hdev->lock);

 *** DEADLOCK ***

1 lock held by sco-tester/31:
 #0: ffff888001eeb130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0},
 at: sco_sock_getsockopt+0x104/0xa90

Fixes: 248733e87d50 ("Bluetooth: Allow querying of supported offload codecs over SCO socket")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f3a5ab9e4fa4..cd1a27ac555d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1140,6 +1140,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		release_sock(sk);
+
 		/* find total buffer size required to copy codec + caps */
 		hci_dev_lock(hdev);
 		list_for_each_entry(c, &hdev->local_codecs, list) {
@@ -1157,15 +1159,13 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		buf_len += sizeof(struct bt_codecs);
 		if (buf_len > len) {
 			hci_dev_put(hdev);
-			err = -ENOBUFS;
-			break;
+			return -ENOBUFS;
 		}
 		ptr = optval;
 
 		if (put_user(num_codecs, ptr)) {
 			hci_dev_put(hdev);
-			err = -EFAULT;
-			break;
+			return -EFAULT;
 		}
 		ptr += sizeof(num_codecs);
 
@@ -1205,12 +1205,14 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			ptr += len;
 		}
 
-		if (!err && put_user(buf_len, optlen))
-			err = -EFAULT;
-
 		hci_dev_unlock(hdev);
 		hci_dev_put(hdev);
 
+		lock_sock(sk);
+
+		if (!err && put_user(buf_len, optlen))
+			err = -EFAULT;
+
 		break;
 
 	default:
-- 
2.39.2

