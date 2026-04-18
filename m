Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A60346E6C
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490476; cv=none; b=u8pJN8vlr/j0zrJVtL3SiZnA6kCY/vAnOoqkh+mCenVnLxuyUDDCcBSLgPnNE/bwBwN290SK0YwskuzKbESRhs6g/YGSJHrhhjktjJrURX7oPjjynitkRZ5xs/uF9pJp+8FxuaJxUzRYIx0meYgIA2Afk7lXwBk+Hq0IKvrIR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490476; c=relaxed/simple;
	bh=ZnOAyes5CApyxa4LVMptpnmk61/+ReVizQGGbcTr3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwgZ964BYqHQmQLudMHNba07XkMmUG7h0x++fcKSvvMW4au32+QhTd8DFEgCneQro8zWrG1fL0VLuITxsfKf2SrBgCyrxJ5Db7uZGkWjob9RILB2IJfHwe/HfImH6c5YoZtodd/yIGplnx5yOydgz3pScFAtlYb3iJmu7NusQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqnlxoEZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqnlxoEZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b4583f0a1aso7970145ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490474; x=1777095274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moJK8j1PeysA2HLtwd4ur3AEjzXIvTcplo5qR2WzdzM=;
        b=pqnlxoEZJaI93YOA9MgOipcyRmPCLLH3Y05Mh8Hxwe6XQN/6xHeo3ltDgxU9G24KKZ
         QXy47f2bfq9+k6gg4jqYakaUWjT1XZ9Hbs4IO+mTwTt4DCDkYB3pVRpgulG45kp5HgP6
         tNPo0o3D5qSu8oZq5UJn6JlGpyfeAHzs0efB7uC9T2yz46KfvcRmoZ8w9CyAdshr92nb
         Ql8rw//OxcEhGwrfC2SMc6S18rfpBf0qP6siDND5cf17x2SyxdeI28VNidnwZagr1Xia
         SbDzd9qW0AtjL2fyY2svE62FSodhU9kRdoz8EcTIXwtIIsiP+UWoFSyxhNkkt+MofU6i
         TpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490474; x=1777095274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moJK8j1PeysA2HLtwd4ur3AEjzXIvTcplo5qR2WzdzM=;
        b=f3mEbJEf06QvVy2ve6MfTpYS2QApNsfS0Bjr4aSqHAS8l4uiWmpupyXPUfEBbnoCNp
         ED0u5bIxT/Wzfa4WhytUMN8C3CZxtLMaS9YW2ETUMz0jjS0C7uYm0eEQX+FAPFHN/Eoo
         AdNRTaIysGilpWUQHchMhk9c6O/3B3yz4yW4RsVcFEVUkJdkzwAHzZGGpqaFqUjdjrmr
         H8S37oCFzam6JmG6VQUwK+tYapPTdObSPpeFGqMU2Bq0HzyZ+IAzh0z5o5V6SaAA9Cro
         KIbEyI2sMLQSGxepPJazpNp6/uAbLXde2H7dTLwBArjpWLD4RsaVT4ygs2uzTz87uN5M
         CdQw==
X-Gm-Message-State: AOJu0Yy6W2CHwSMwx2mjyOZ1t05xTFT/XcBaAsn5aFFdIHlhcsudWeYt
	OQCOtHIwu6Ttd9l/YPjopqz6gpqglVhRt1QG9j0LXFQHER94kzJTfB9y
X-Gm-Gg: AeBDiess1LkrHRsiYwEC0oCag5pjttN2Xdxnfz65QYJcFNnJYxH0ctcYLZ4udMTpVTX
	L++MKHpW9CBhUDXaZH+7C9uQoCxj/VgAK5SmutWg4diW2d0/Oa3JrLhjtg/Cc5KjJP9Tgr53j93
	fhGHz6xPxsvCdUTYDU9qQCopbS/bxa1GTUzb2aPyGveEXzkVw3Q0i77bDon6uRQo6TwSE2NgK+O
	4sYrGNcB+g3PY4Vw0Chf02avStfv3957JFVvkE0asLJII0mOo+iaEPDA5HHRfu2LumYqC8ydDoQ
	yQDDZ/rENYC7J6+C18wXiE2o64mp/adxOImb+tTAsxBJBpnbrYw3U54nrz9QmOIDw6hf00AoAYE
	tQQYeUx4hMBtNJtHWondgREBtWQczzyueAQWonWqi5JpcLG/HesUED/iGBBvrDFcT84t6We03Je
	QvSXUVxgrtr4AGJmtVSvjjpnrRIVOGKMrmf2zwHRVFZOSV+OcXRLz+LATQ2g==
X-Received: by 2002:a17:903:890:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b5f9ef3e8fmr41044065ad.18.1776490474181;
        Fri, 17 Apr 2026 22:34:34 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:33 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
Date: Sat, 18 Apr 2026 14:34:01 +0900
Message-ID: <20260418053401.128483-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418053401.128483-1-suunj1331@gmail.com>
References: <20260418053401.128483-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several iso_pi(sk) fields (qos, qos_user_set, bc_sid, base, base_len,
sync_handle, bc_num_bis) are written under lock_sock in
iso_sock_setsockopt() and iso_sock_bind(), but read and written under
hci_dev_lock only in two other paths:

  - iso_connect_bis() / iso_connect_cis(), invoked from connect(2),
    read qos/base/bc_sid and reset qos to default_qos on the
    qos_user_set validation failure -- all without lock_sock.

  - iso_connect_ind(), invoked from hci_rx_work, writes sync_handle,
    bc_sid, qos.bcast.encryption, bc_num_bis, base and base_len on
    PA_SYNC_ESTABLISHED / PAST_RECEIVED / BIG_INFO_ADV_REPORT /
    PER_ADV_REPORT events. The BIG_INFO handler additionally passes
    &iso_pi(sk)->qos together with sync_handle / bc_num_bis / bc_bis
    to hci_conn_big_create_sync() while setsockopt may be mutating
    them.

Acquire lock_sock around the affected accesses in both paths.

The locking order hci_dev_lock -> lock_sock matches the existing
iso_conn_big_sync() precedent, whose comment documents the same
requirement for hci_conn_big_create_sync(). The HCI connect/bind
helpers do not wait for command completion -- they enqueue work via
hci_cmd_sync_queue{,_once}() / hci_le_create_cis_pending() and
return -- so the added hold time is comparable to iso_conn_big_sync().

KCSAN report:

BUG: KCSAN: data-race in iso_connect_cis / iso_sock_setsockopt

read to 0xffffa3ae8ce3cdc8 of 1 bytes by task 335 on cpu 0:
 iso_connect_cis+0x49f/0xa20
 iso_sock_connect+0x60e/0xb40
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffffa3ae8ce3cdc8 of 60 bytes by task 334 on cpu 1:
 iso_sock_setsockopt+0x69a/0x930
 do_sock_setsockopt+0xc3/0x170
 __sys_setsockopt+0xd1/0x130
 __x64_sys_setsockopt+0x64/0x80
 x64_sys_call+0x1547/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)

The iso_connect_ind() races were found by inspection.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 54 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 14963ba68597..3ba13769be3a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -347,6 +347,7 @@ static int iso_connect_bis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!bis_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -399,13 +400,9 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -421,9 +418,8 @@ static int iso_connect_bis(struct sock *sk)
 		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -444,6 +440,7 @@ static int iso_connect_cis(struct sock *sk)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	if (!cis_central_capable(hdev)) {
 		err = -EOPNOTSUPP;
@@ -498,13 +495,9 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
-	lock_sock(sk);
-
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		release_sock(sk);
+	if (err)
 		goto unlock;
-	}
 
 	/* Update source addr of the socket */
 	bacpy(&iso_pi(sk)->src, &hcon->src);
@@ -520,9 +513,8 @@ static int iso_connect_cis(struct sock *sk)
 		iso_sock_set_timer(sk, READ_ONCE(sk->sk_sndtimeo));
 	}
 
-	release_sock(sk);
-
 unlock:
+	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -2259,8 +2251,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 			iso_pi(sk)->bc_sid = ev1->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2271,8 +2265,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
 			iso_pi(sk)->bc_sid = ev1a->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2299,27 +2295,35 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 					  ev2);
 
 		if (sk) {
-			int err;
-			struct hci_conn	*hcon = iso_pi(sk)->conn->hcon;
+			int err = 0;
+			bool big_sync;
+			struct hci_conn *hcon;
 
+			lock_sock(sk);
+
+			hcon = iso_pi(sk)->conn->hcon;
 			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
 
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
-			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
-			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
+			big_sync = !test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
+				   !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
+
+			if (big_sync)
 				err = hci_conn_big_create_sync(hdev, hcon,
 							       &iso_pi(sk)->qos,
 							       iso_pi(sk)->sync_handle,
 							       iso_pi(sk)->bc_num_bis,
 							       iso_pi(sk)->bc_bis);
-				if (err) {
-					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-						   err);
-					sock_put(sk);
-					sk = NULL;
-				}
+
+			release_sock(sk);
+
+			if (big_sync && err) {
+				bt_dev_err(hdev, "hci_le_big_create_sync: %d",
+					   err);
+				sock_put(sk);
+				sk = NULL;
 			}
 		}
 
@@ -2373,8 +2377,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			if (!base || base_len > BASE_MAX_LENGTH)
 				goto done;
 
+			lock_sock(sk);
 			memcpy(iso_pi(sk)->base, base, base_len);
 			iso_pi(sk)->base_len = base_len;
+			release_sock(sk);
 		} else {
 			/* This is a PA data fragment. Keep pa_data_len set to 0
 			 * until all data has been reassembled.
-- 
2.52.0

