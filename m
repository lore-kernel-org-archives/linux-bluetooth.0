Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4223C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjC3WHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC3WGW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E291166A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u38so13557805pfg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680213815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d77Nw+BkN6Mf/MhUByOfs+MKddlz3PjAAb/O2n/14tQ=;
        b=q5FUTPlCbzFRLk85LdnRAk3fT4dPxiU2I6Reu5hZMJd6+tUByepDxKxfFBcQE6jVDW
         KUN6k/hz0M6T9dH4cVfHjseDGRegjll55K3+KXb4RGy+Qf6D84qF+SbqkZRcBSAwL+dx
         ew5lgRFOkLjBfYbGZ9HlbLw5Kfjl/y9+yxVvDwNV++NrTOpzp7oUgg5ji1uajX/0joAx
         yo5cc3N3Izc5os1vy278k+sE5ObrbjiVAb5GB0ZLLEZfoGiwQmCJZIKKgDQpFmohPPxh
         DetwdIZ/KMfJN60dYcY4JM/a6LrcDC5QmugX/YzDAtYSvNAs1ZW2BcGsYy13q76UhCPV
         Wm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d77Nw+BkN6Mf/MhUByOfs+MKddlz3PjAAb/O2n/14tQ=;
        b=E5QTY0d/OCtryWlVqMRVvu/oXaG9uWGnK/VFRJrmNEdF54zhRc4kWLi03JhvrqgodP
         vGH1AihP3ORpTctWC2IiJkXwUNFec85Tf6jmHsOlED3cQGZeoyIzqo//5a0pfj6J10T7
         rmcXBBq0oC16EyNEu+qLgeO2QW/TKwDkr8wzMyuckZgBTgKLDVeIY+sFWQv0EHbPoB03
         BWw2JJOxfXCMR6i5tu8g2zSyVLRRlPzZoiJoNh4iNeezdlS+VsGn07e6xtMzJCue21Wd
         3zvbNC07adi+Obj3LrBhyXt+V+jJQdmMHA0e9WP+ZPT9tXwf+dnhCs2EoYX8W2JoiSpU
         ATfw==
X-Gm-Message-State: AAQBX9cE/pZuTyio/7ei1MAr873/cHDB/dDHyCT4RtIT+YcN3KTGBviq
        6DYmuqRI4i6mCjLHr/LmtMHu6H/Hl1s=
X-Google-Smtp-Source: AKy350ZvSi6r+r89KzD5+Hpf2KqFzQC/rOzrZ4PnZhsCzJqa3GbBmrPVivOfE8zkDfZvkV7+LUzRLg==
X-Received: by 2002:a62:1b85:0:b0:627:ecd4:84a5 with SMTP id b127-20020a621b85000000b00627ecd484a5mr22140813pfb.14.1680213815346;
        Thu, 30 Mar 2023 15:03:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z14-20020aa791ce000000b00571cdbd0771sm333790pfa.102.2023.03.30.15.03.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:03:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm
Date:   Thu, 30 Mar 2023 15:03:31 -0700
Message-Id: <20230330220332.1035910-2-luiz.dentz@gmail.com>
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
6.3.0-rc2-g0b93eeba4454 #4703 Not tainted
------------------------------------------------------
kworker/u3:0/46 is trying to acquire lock:
ffff888001fd9130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at:
sco_connect_cfm+0x118/0x4a0

but task is already holding lock:
ffffffff831e3340 (hci_cb_list_lock){+.+.}-{3:3}, at:
hci_sync_conn_complete_evt+0x1ad/0x3d0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock+0x13b/0xcc0
       hci_sync_conn_complete_evt+0x1ad/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock+0x13b/0xcc0
       sco_sock_connect+0xfc/0x630
       __sys_connect+0x197/0x1b0
       __x64_sys_connect+0x37/0x50
       do_syscall_64+0x42/0x90
       entry_SYSCALL_64_after_hwframe+0x70/0xda

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       __lock_acquire+0x18cc/0x3740
       lock_acquire+0x151/0x3a0
       lock_sock_nested+0x32/0x80
       sco_connect_cfm+0x118/0x4a0
       hci_sync_conn_complete_evt+0x1e6/0x3d0
       hci_event_packet+0x55c/0x7c0
       hci_rx_work+0x34c/0xa00
       process_one_work+0x575/0x910
       worker_thread+0x89/0x6f0
       kthread+0x14e/0x180
       ret_from_fork+0x2b/0x50

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_SCO --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);

 *** DEADLOCK ***

4 locks held by kworker/u3:0/46:
 #0: ffff8880028d1130 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
 process_one_work+0x4c0/0x910
 #1: ffff8880013dfde0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
 at: process_one_work+0x4c0/0x910
 #2: ffff8880025d8070 (&hdev->lock){+.+.}-{3:3}, at:
 hci_sync_conn_complete_evt+0xa6/0x3d0
 #3: ffffffffb79e3340 (hci_cb_list_lock){+.+.}-{3:3}, at:
 hci_sync_conn_complete_evt+0x1ad/0x3d0

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 69 ++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1111da4e2f2b..f3a5ab9e4fa4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -235,27 +235,41 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	return err;
 }
 
-static int sco_connect(struct hci_dev *hdev, struct sock *sk)
+static int sco_connect(struct sock *sk)
 {
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
+	struct hci_dev  *hdev;
 	int err, type;
 
 	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
 
+	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+	if (!hdev)
+		return -EHOSTUNREACH;
+
+	hci_dev_lock(hdev);
+
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
 	else
 		type = SCO_LINK;
 
 	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)))
-		return -EOPNOTSUPP;
+	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
 			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
-	if (IS_ERR(hcon))
-		return PTR_ERR(hcon);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto unlock;
+	}
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 
 	conn = sco_conn_add(hcon);
 	if (!conn) {
@@ -263,13 +277,15 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		return -ENOMEM;
 	}
 
-	/* Update source addr of the socket */
-	bacpy(&sco_pi(sk)->src, &hcon->src);
-
 	err = sco_chan_add(conn, sk, NULL);
 	if (err)
 		return err;
 
+	lock_sock(sk);
+
+	/* Update source addr of the socket */
+	bacpy(&sco_pi(sk)->src, &hcon->src);
+
 	if (hcon->state == BT_CONNECTED) {
 		sco_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
@@ -278,6 +294,13 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	release_sock(sk);
+
+	return err;
+
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 	return err;
 }
 
@@ -565,7 +588,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 {
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
-	struct hci_dev  *hdev;
 	int err;
 
 	BT_DBG("sk %p", sk);
@@ -574,37 +596,26 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	lock_sock(sk);
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
-		err = -EBADFD;
-		goto done;
-	}
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+		return -EBADFD;
 
-	if (sk->sk_type != SOCK_SEQPACKET) {
+	if (sk->sk_type != SOCK_SEQPACKET)
 		err = -EINVAL;
-		goto done;
-	}
-
-	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev) {
-		err = -EHOSTUNREACH;
-		goto done;
-	}
-	hci_dev_lock(hdev);
 
+	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
+	release_sock(sk);
 
-	err = sco_connect(hdev, sk);
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	err = sco_connect(sk);
 	if (err)
-		goto done;
+		return err;
+
+	lock_sock(sk);
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 				 sock_sndtimeo(sk, flags & O_NONBLOCK));
 
-done:
 	release_sock(sk);
 	return err;
 }
-- 
2.39.2

