Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE87C352A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 01:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLGBfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGBfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 20:35:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975074D5ED
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:35:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jl24so15673835plb.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 17:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZJiCE5Stc0/Cog/Juyi/+ihzpMf6Nn4NRYaK5f6pZ4=;
        b=FgMsRoCkdA58eit8SS2sr30zWQgU2t4l0F4xRY4s6mmwhodxQIZtMEbKDcfaMqbY2T
         PmputOGXpiCr1EXA45q3TJgxI2zjUImZ4hi5ixM/gYKicJ8c7VJw5NNosSs1lFdKOQC9
         7zeMc3kUTMDv0xDgRDjutddex0WcZC59Qo1dWqNRz2ZTDaRJ/GkOhiKmZQ1FVLW0XFdE
         /SPx20veLpKAjOyJV62hWuXb6msbvbUu599QR+qdwlFFo93qswBGikfvZWvfe0FiCzkk
         lT85jRdhl4NnfTZH2kCoDHlq3J8FR0S7z8xsqH2fJn1ak2GBGsBOcg6I4bXx8AsOjpkl
         KYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZJiCE5Stc0/Cog/Juyi/+ihzpMf6Nn4NRYaK5f6pZ4=;
        b=eG7mAfnIUkbrjEdd42YfQIe5FDefXn0bZPJAZIAsVtRUcMkP0DDgnPsNB1zeBnDl8E
         d1yprab1fTjFMz0ogNXrSgv4nC7kWYdOp1dgH9vG8n+6hI1ph+5bV7Qr9mdjxgRovdEh
         SFpcE3qNwUDwwuMWluBeHM1KJ5C+Ul3oC2HBagf6lQgvzZXseBCA1heTaNh16ByfPdpE
         L82z8i4IrN+s3dn+oHEQxs0cAtbNkU6vS9Jf3Tocu1STIvgyZP8SvHLfCSvC723pC4gJ
         RS31TMpExcqDDEfAHSLv3o0vgCRa0l9xbVurf8pb3K96FRopy5jWVDrEZiaIcf/HgjyX
         JcVw==
X-Gm-Message-State: ANoB5pl9PBXo+ir6kWuTOmMlC9YVX6QpSvAziOt5ysch9IyQUtVhjZrh
        WAU0gtwSwhx+MTwsesIAq2r4yoQdXqg7mUo3
X-Google-Smtp-Source: AA0mqf7yrcd9gcZObcJJZjwglOL7EGppFs0GkirJ8jdHQsw9sM2JVIfr9OBTZgLNVxjzqDQmBejo8A==
X-Received: by 2002:a17:903:3052:b0:189:651c:f023 with SMTP id u18-20020a170903305200b00189651cf023mr57103357pla.78.1670376903393;
        Tue, 06 Dec 2022 17:35:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b0056b6a22d6c9sm12317979pff.212.2022.12.06.17.35.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:35:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Avoid circular locking dependency
Date:   Tue,  6 Dec 2022 17:35:01 -0800
Message-Id: <20221207013501.4162096-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to avoid circular locking dependency between sock_lock
and hdev_lock:

WARNING: possible circular locking dependency detected
6.0.0-rc7-03728-g18dd8ab0a783 #3 Not tainted
------------------------------------------------------
kworker/u3:2/53 is trying to acquire lock:
ffff888000254130 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
iso_conn_del+0xbd/0x1d0
but task is already holding lock:
ffffffff9f39a080 (hci_cb_list_lock){+.+.}-{3:3}, at:
hci_le_cis_estabilished_evt+0x1b5/0x500
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #2 (hci_cb_list_lock){+.+.}-{3:3}:
       __mutex_lock+0x10e/0xfe0
       hci_le_remote_feat_complete_evt+0x17f/0x320
       hci_event_packet+0x39c/0x7d0
       hci_rx_work+0x2bf/0x950
       process_one_work+0x569/0x980
       worker_thread+0x2a3/0x6f0
       kthread+0x153/0x180
       ret_from_fork+0x22/0x30
-> #1 (&hdev->lock){+.+.}-{3:3}:
       __mutex_lock+0x10e/0xfe0
       iso_connect_cis+0x6f/0x5a0
       iso_sock_connect+0x1af/0x710
       __sys_connect+0x17e/0x1b0
       __x64_sys_connect+0x37/0x50
       do_syscall_64+0x43/0x90
       entry_SYSCALL_64_after_hwframe+0x62/0xcc
-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
       __lock_acquire+0x1b51/0x33d0
       lock_acquire+0x16f/0x3b0
       lock_sock_nested+0x32/0x80
       iso_conn_del+0xbd/0x1d0
       iso_connect_cfm+0x226/0x680
       hci_le_cis_estabilished_evt+0x1ed/0x500
       hci_event_packet+0x39c/0x7d0
       hci_rx_work+0x2bf/0x950
       process_one_work+0x569/0x980
       worker_thread+0x2a3/0x6f0
       kthread+0x153/0x180
       ret_from_fork+0x22/0x30
other info that might help us debug this:
Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_ISO --> &hdev->lock --> hci_cb_list_lock
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
 *** DEADLOCK ***
4 locks held by kworker/u3:2/53:
 #0: ffff8880021d9130 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
 process_one_work+0x4ad/0x980
 #1: ffff888002387de0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
 at: process_one_work+0x4ad/0x980
 #2: ffff888001ac0070 (&hdev->lock){+.+.}-{3:3}, at:
 hci_le_cis_estabilished_evt+0xc3/0x500
 #3: ffffffff9f39a080 (hci_cb_list_lock){+.+.}-{3:3}, at:
 hci_le_cis_estabilished_evt+0x1b5/0x500

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 61 ++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e23aabf4e0cf..035bb5d25f85 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -261,13 +261,13 @@ static int iso_connect_bis(struct sock *sk)
 
 	if (!bis_capable(hdev)) {
 		err = -EOPNOTSUPP;
-		goto done;
+		goto unlock;
 	}
 
 	/* Fail if out PHYs are marked as disabled */
 	if (!iso_pi(sk)->qos.out.phy) {
 		err = -EINVAL;
-		goto done;
+		goto unlock;
 	}
 
 	hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
@@ -276,22 +276,27 @@ static int iso_connect_bis(struct sock *sk)
 			       iso_pi(sk)->base);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
-		goto done;
+		goto unlock;
 	}
 
 	conn = iso_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
 		err = -ENOMEM;
-		goto done;
+		goto unlock;
 	}
 
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	lock_sock(sk);
+
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
 
 	err = iso_chan_add(conn, sk, NULL);
 	if (err)
-		goto done;
+		goto release;
 
 	if (hcon->state == BT_CONNECTED) {
 		iso_sock_clear_timer(sk);
@@ -301,7 +306,11 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-done:
+release:
+	release_sock(sk);
+	return err;
+
+unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -325,13 +334,13 @@ static int iso_connect_cis(struct sock *sk)
 
 	if (!cis_central_capable(hdev)) {
 		err = -EOPNOTSUPP;
-		goto done;
+		goto unlock;
 	}
 
 	/* Fail if either PHYs are marked as disabled */
 	if (!iso_pi(sk)->qos.in.phy && !iso_pi(sk)->qos.out.phy) {
 		err = -EINVAL;
-		goto done;
+		goto unlock;
 	}
 
 	/* Just bind if DEFER_SETUP has been set */
@@ -341,7 +350,7 @@ static int iso_connect_cis(struct sock *sk)
 				    &iso_pi(sk)->qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
-			goto done;
+			goto unlock;
 		}
 	} else {
 		hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst,
@@ -349,7 +358,7 @@ static int iso_connect_cis(struct sock *sk)
 				       &iso_pi(sk)->qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
-			goto done;
+			goto unlock;
 		}
 	}
 
@@ -357,15 +366,20 @@ static int iso_connect_cis(struct sock *sk)
 	if (!conn) {
 		hci_conn_drop(hcon);
 		err = -ENOMEM;
-		goto done;
+		goto unlock;
 	}
 
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	lock_sock(sk);
+
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
 
 	err = iso_chan_add(conn, sk, NULL);
 	if (err)
-		goto done;
+		goto release;
 
 	if (hcon->state == BT_CONNECTED) {
 		iso_sock_clear_timer(sk);
@@ -378,7 +392,11 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
-done:
+release:
+	release_sock(sk);
+	return err;
+
+unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -832,20 +850,23 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
 
+	release_sock(sk);
+
 	if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
 		err = iso_connect_cis(sk);
 	else
 		err = iso_connect_bis(sk);
 
 	if (err)
-		goto done;
+		return err;
+
+	lock_sock(sk);
 
 	if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 					 sock_sndtimeo(sk, flags & O_NONBLOCK));
 	}
 
-done:
 	release_sock(sk);
 	return err;
 }
@@ -1101,28 +1122,22 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct iso_pinfo *pi = iso_pi(sk);
-	int err;
 
 	BT_DBG("sk %p", sk);
 
-	lock_sock(sk);
-
 	if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
+			lock_sock(sk);
 			iso_conn_defer_accept(pi->conn->hcon);
 			sk->sk_state = BT_CONFIG;
 			release_sock(sk);
 			return 0;
 		case BT_CONNECT:
-			err = iso_connect_cis(sk);
-			release_sock(sk);
-			return err;
+			return iso_connect_cis(sk);
 		}
 	}
 
-	release_sock(sk);
-
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
-- 
2.37.3

