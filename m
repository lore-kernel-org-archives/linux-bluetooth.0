Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614920E334
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739900; cv=none; b=AlKw0bC1zEJ7KuyAxhw42CNZ/LBydbxAWXKEbCUO/cyoAFc/CYhYR3e6myn5RfeeWOWwnhOdXVNbBDZwoJ1avEhWXA+3b/KWqxDX/rPvdghW4U8s5mIiFMnV+4uSUKoiZd1kHSsbA8Np8CPNIB2ponPGpiMuJnQ4dYHZKOi8w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739900; c=relaxed/simple;
	bh=G6EucweGipD57HLWUEZy8wLPFm0RSeFlWDd+/DdrBh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+oA6zYxPAreZJ7hJt38SHxPWmYmb9g0ySmZxUu3X0YmuYc+UxJt84SLl0iu5KRVR4QjfJGpdnagQfap2KNQsPH00kV1WIe7YeX7IZFiQg79yfRJrpJeITxev+eXwL6gj9K/rZtpfskGv8kg0MRBEr5LeXkpYo7+x8E08ZEQtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf7En0Lz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf7En0Lz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c79506f3c40so1360953a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739896; x=1777344696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6CkX1W+ZbhTJntNCnbZ/XkAbWDrFK0aGMkks9U/5UI=;
        b=jf7En0Lz3TQ8qGhBdMeTvaTdj9PoDo6LHSITXiVce8yZc8WbIBAGBgMHOWano359yb
         rTlgMF0S+zvCh/drjltuUYQl6omBTP17yB02o/9hhNGpIwwaw2dM5wOwIkHWX/Fda0od
         NryGPjqX/YE83bToGXm/laBjAAUN8aTckWpmyrUA+dzNpmhQHEH4eB8ptZFmLthqAqZ4
         NQ9jgOOivlSYpDV6v6UlCP1yOcl8690TotsDstBSasS8LCK3sSCOczoN5dIbIoQB7zkn
         Uv3FBrlyCfK5Y37wLLVYiTB9PTARdpQPGzkuRm5T/uCZvXar0O3xf9rOM2TbBHk0WngK
         eYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739896; x=1777344696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6CkX1W+ZbhTJntNCnbZ/XkAbWDrFK0aGMkks9U/5UI=;
        b=XEhcUwQE9RZPfFudfmr0W1boTXGXtmNOYxEQmF1OX2ocCJMm3BtDNcif/i3gNlDXAh
         MhuGr1qTUF5bAd0B/F4YCkewp+F9rYv6lOAVmG1P1TQrY6J32S7N2zFusOMv8OO0Vnw1
         kVd0w4qLF8KVjSkWzX8DL8iMQjCmVEIlvKT8Rn3HVfagHZzkO9ADrrhuTqDyDY1mKuyo
         dGps0Ke4sAroQv29DI8s7DJgJitblKepigUfWKO8Ic3dZsCRCJSkzKs3kpTa6E0J6fpP
         EkocqYQ2CLTgoubd2Zy/cE28bQLmzybfnhNGOxfMUGPsGR02sQvmskZozrb5M/PwdQd+
         sgMQ==
X-Gm-Message-State: AOJu0YxzrSEvcamvEjysNRO94Gx3KNsoXID3Q0nYTjnErD+5DeUNWy6b
	Habaae2qlOY7V6dQa/hhWi5W2SWSLi/qLEuEHUM86WGmLcIYUn658AXn80AdCX0n
X-Gm-Gg: AeBDietPQ6jgYV/ob5z/r+1u6u2UHy/a6A/JXdxxhCepunXB/fyBUnE1VFXOtD4d2Nf
	XYf5MImx40+QUKxkEnUUbEAtTlnbf4cr2FvbEGJhKtEKRt8BiMcf/QdYmgbKRp6+2lpKuSmDrDr
	ZBf2qz1zwa6jajXDlXmAb8NCUL5fJD2VwDj8CLHBuD19H2vdICDmukrXkoUE+4yVoKDm4VVCMyu
	88Fxo2raOZFM90oPXRbkWBWT/zfLkGybzWs6O4yE+MTibPyqEVmhWZY7h4RAPIO7+DCSfmLlxi8
	e3/dNhdi+lLQ5xrkJ6o7OR80J1mSTNvIztTVfbNWZjztLrB0m/4teP7rmL/5byw99jjxoxmVPa4
	cngMBgMgtZ6c2YIRCQwb6KaNpLk/UEZaed0ffXrbfI2kb4r6UDgQYLhZCQG9fY61ik7OyPvpW3P
	F+5SqR0Rl6Vpf3ySqICEiCthnuFVF2usGAl7PQNA9GsCvLrL/mvOf2Um0isg==
X-Received: by 2002:a05:6a00:92a7:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-82f8c87e27fmr16393573b3a.10.1776739896103;
        Mon, 20 Apr 2026 19:51:36 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12823502b3a.20.2026.04.20.19.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:35 -0700 (PDT)
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
Subject: [PATCH v2 2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
Date: Tue, 21 Apr 2026 11:51:22 +0900
Message-ID: <20260421025122.55781-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421025122.55781-1-suunj1331@gmail.com>
References: <20260421025122.55781-1-suunj1331@gmail.com>
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
index 290a1b9a9daa..7cb2864fe872 100644
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
@@ -2256,8 +2248,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 			iso_pi(sk)->bc_sid = ev1->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2268,8 +2262,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
+			lock_sock(sk);
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
 			iso_pi(sk)->bc_sid = ev1a->sid;
+			release_sock(sk);
 		}
 
 		goto done;
@@ -2296,27 +2292,35 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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
 
@@ -2370,8 +2374,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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

