Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD091C46467
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjAJVdD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjAJVb6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 16:31:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE371884
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 13:30:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so12929205pjf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 13:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGGTAoOqNiOLJ1JgkRcDri2EaN/39Nji+Z2gH92owBU=;
        b=CO0GkKaFMsLbntHv0V8BsQP+aWyeuvYnbdrSJGx7WxfDP5gDgNeubfuxBDrQVRgHLj
         aNEw3TKDjQ2gT2zSz3nOOHS3oj5WGebO9IIsSz5UvyQHEZKACQu/qNVcBSi//oLPYSB8
         IGdjrkYiS4ksHopcJeAWDUxFhwT5gq/NSYxhcanK7lT1m5V0y+V1ZmyRT3wAAn9s4CRl
         Xd34UbejbfHct2kJZ22A6mKffUqt9nCG8R8HE8dWYeHW5Jspuxal42B5bQEwC9Losxr0
         L44oXzxCPADnVpALMb9fiHMjnAXPQFlXWk2EpkXcJbgCGqvKAyqAdg6TMG9w6IxOGQdE
         913A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGGTAoOqNiOLJ1JgkRcDri2EaN/39Nji+Z2gH92owBU=;
        b=o9aUL1Lc/HqDgFO8iGpZb0wuDjEW617I73fRXh0qH9f9bEd7H8tPeBXWF1LpOtPrdU
         aCvFw/7M+xd6T7sPkPr8p6B+KlQHfrjljN0mjFnfLCCYHKs2T9k/zxad4E0hpDjhuWYK
         uinkibaB4It0tFBmGmBg3Egx/7WRrJ4fOnXi5wH8M0hROiC2cGZ0sy9e2/LjSjDRv0ca
         rJOFlsHee6CPUygov9rDVcmnb29Bl1jmLrCr/dmb3cT+6BIY/usTj6l/brvpT7ge0ZtP
         5EgZpETKdAvWhrrqraB/PfRh1JpECJ/Q69JlW6FFEdWyKZzh1dc5y/cCFyPa92/hX+Pf
         /63Q==
X-Gm-Message-State: AFqh2krXXrL0Q9aMDS+zb6tNAT8r05W608EzK+WOQsP5+3CsyL3x54WZ
        5rMJEjFpMdaVfqWCKN8QQIFgeNLpsPo=
X-Google-Smtp-Source: AMrXdXu5dVzeTwekdQNAqh+wUb/b0SBRTucSLwOzXXUy4/+TBu2SEfGNWq7eyr9HpgTrI1vcjrfzrg==
X-Received: by 2002:a17:902:cf4b:b0:192:d9b8:6316 with SMTP id e11-20020a170902cf4b00b00192d9b86316mr29530784plg.48.1673386236271;
        Tue, 10 Jan 2023 13:30:36 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b00186abb95bfdsm8656640plb.25.2023.01.10.13.30.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:30:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix possible circular locking dependency
Date:   Tue, 10 Jan 2023 13:30:34 -0800
Message-Id: <20230110213034.3629396-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix the following trace:

kworker/u3:1/184 is trying to acquire lock:
ffff888001888130 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
iso_connect_cfm+0x2de/0x690

but task is already holding lock:
ffff8880028d1c20 (&conn->lock){+.+.}-{2:2}, at:
iso_connect_cfm+0x265/0x690

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock){+.+.}-{2:2}:
       lock_acquire+0x176/0x3d0
       _raw_spin_lock+0x2a/0x40
       __iso_sock_close+0x1dd/0x4f0
       iso_sock_release+0xa0/0x1b0
       sock_close+0x5e/0x120
       __fput+0x102/0x410
       task_work_run+0xf1/0x160
       exit_to_user_mode_prepare+0x170/0x180
       syscall_exit_to_user_mode+0x19/0x50
       do_syscall_64+0x4e/0x90
       entry_SYSCALL_64_after_hwframe+0x62/0xcc

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
       check_prev_add+0xfc/0x1190
       __lock_acquire+0x1e27/0x2750
       lock_acquire+0x176/0x3d0
       lock_sock_nested+0x32/0x80
       iso_connect_cfm+0x2de/0x690
       hci_cc_le_setup_iso_path+0x195/0x340
       hci_cmd_complete_evt+0x1ae/0x500
       hci_event_packet+0x38e/0x7c0
       hci_rx_work+0x34c/0x980
       process_one_work+0x5a5/0x9a0
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x22/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->lock);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
                               lock(&conn->lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);

 *** DEADLOCK ***

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 61 +++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 035bb5d25f85..6157bc12b373 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -289,15 +289,15 @@ static int iso_connect_bis(struct sock *sk)
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
+	err = iso_chan_add(conn, sk, NULL);
+	if (err)
+		return err;
+
 	lock_sock(sk);
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
 
-	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		goto release;
-
 	if (hcon->state == BT_CONNECTED) {
 		iso_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
@@ -306,7 +306,6 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-release:
 	release_sock(sk);
 	return err;
 
@@ -372,15 +371,15 @@ static int iso_connect_cis(struct sock *sk)
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
+	err = iso_chan_add(conn, sk, NULL);
+	if (err)
+		return err;
+
 	lock_sock(sk);
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
 
-	err = iso_chan_add(conn, sk, NULL);
-	if (err)
-		goto release;
-
 	if (hcon->state == BT_CONNECTED) {
 		iso_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
@@ -392,7 +391,6 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-release:
 	release_sock(sk);
 	return err;
 
@@ -1432,33 +1430,29 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct sock *parent;
 	struct sock *sk = conn->sk;
 	struct hci_ev_le_big_sync_estabilished *ev;
+	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
 
 	if (sk) {
 		iso_sock_ready(conn->sk);
 	} else {
-		iso_conn_lock(conn);
-
-		if (!conn->hcon) {
-			iso_conn_unlock(conn);
+		hcon = conn->hcon;
+		if (!hcon)
 			return;
-		}
 
-		ev = hci_recv_event_data(conn->hcon->hdev,
+		ev = hci_recv_event_data(hcon->hdev,
 					 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
 		if (ev)
-			parent = iso_get_sock_listen(&conn->hcon->src,
-						     &conn->hcon->dst,
+			parent = iso_get_sock_listen(&hcon->src,
+						     &hcon->dst,
 						     iso_match_big, ev);
 		else
-			parent = iso_get_sock_listen(&conn->hcon->src,
+			parent = iso_get_sock_listen(&hcon->src,
 						     BDADDR_ANY, NULL, NULL);
 
-		if (!parent) {
-			iso_conn_unlock(conn);
+		if (!parent)
 			return;
-		}
 
 		lock_sock(parent);
 
@@ -1466,30 +1460,29 @@ static void iso_conn_ready(struct iso_conn *conn)
 				    BTPROTO_ISO, GFP_ATOMIC, 0);
 		if (!sk) {
 			release_sock(parent);
-			iso_conn_unlock(conn);
 			return;
 		}
 
 		iso_sock_init(sk, parent);
 
-		bacpy(&iso_pi(sk)->src, &conn->hcon->src);
-		iso_pi(sk)->src_type = conn->hcon->src_type;
+		bacpy(&iso_pi(sk)->src, &hcon->src);
+		iso_pi(sk)->src_type = hcon->src_type;
 
 		/* If hcon has no destination address (BDADDR_ANY) it means it
 		 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED so we need to
 		 * initialize using the parent socket destination address.
 		 */
-		if (!bacmp(&conn->hcon->dst, BDADDR_ANY)) {
-			bacpy(&conn->hcon->dst, &iso_pi(parent)->dst);
-			conn->hcon->dst_type = iso_pi(parent)->dst_type;
-			conn->hcon->sync_handle = iso_pi(parent)->sync_handle;
+		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
+			bacpy(&hcon->dst, &iso_pi(parent)->dst);
+			hcon->dst_type = iso_pi(parent)->dst_type;
+			hcon->sync_handle = iso_pi(parent)->sync_handle;
 		}
 
-		bacpy(&iso_pi(sk)->dst, &conn->hcon->dst);
-		iso_pi(sk)->dst_type = conn->hcon->dst_type;
+		bacpy(&iso_pi(sk)->dst, &hcon->dst);
+		iso_pi(sk)->dst_type = hcon->dst_type;
 
-		hci_conn_hold(conn->hcon);
-		__iso_chan_add(conn, sk, parent);
+		hci_conn_hold(hcon);
+		iso_chan_add(conn, sk, parent);
 
 		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
 			sk->sk_state = BT_CONNECT2;
@@ -1500,8 +1493,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		parent->sk_data_ready(parent);
 
 		release_sock(parent);
-
-		iso_conn_unlock(conn);
 	}
 }
 
-- 
2.37.3

