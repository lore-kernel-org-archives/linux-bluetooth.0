Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272E38D687
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076057; cv=none; b=kgQEcKWTNIZ8UotY9TjprYRdcW4PRwufDh2H0GjOxY3aDv3Au3wv+UDtT5hgLIFMjv8sZpk5leDTg1yIvtI5HyiAj0IvJVcyjbf8nsjvXbtqBgf8IRVWDPnX1W2GH2miV5Ppf7vpiYyCv6aUuV43uKLUkWsdRNGEYksYf84GJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076057; c=relaxed/simple;
	bh=azSALTPQ56sMNNtKHXYrGxYYobQm99m8pEWlJiJK9HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSMEGBfTZIEVPp8nIMj2Gm1y4Q0yroR9zjg9u7+TbfiJBcNPkMZYrdCyRZe5D+uhKlhXFFLMi4nacp2qnE4hb5WS3XTUmQFUrkd/e2XtvGH4nKtdRjtNugcNwpNfsuYKgtKLg8tGCC/j0MIwd0FaBFD32AfHgLC3/46qEymMgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS71q5r7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS71q5r7"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c857fba35cfso213196a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076055; x=1780680855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inVdfYyaHrC2ebCMrnnMifw7kxLNFvRNmB5wGenE+qI=;
        b=PS71q5r7pM26gIbNTzdQ4Fz73II7UYS+5ziyaE2TTAXIpmwQ7rn2BwvbscFK0qYnL9
         Y6WYPFSaB1Wrp18cSkYeltTygTe444qCD5xAMPXFLRga1yY1sPPD6V/uC0oyiY9coyVr
         u9vflWh+saYxQ1rdx3Mupz7PmHEIzwO4I7XMK//HT0DjZ6wViTzK1viZwrSZ3t9r3g7+
         Cz7mYCU8ppibw5b0demkqErx0RaiYhxcCu4dQNvZVlrasleWjviRAeCRC6czbsxQeSEa
         CvhglmHeXGojhwxtPIkJxyOvNDu7SQvw9gyz2xgk47F4YSwYK4PkTrlUwKI87QauCb1E
         FKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076055; x=1780680855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inVdfYyaHrC2ebCMrnnMifw7kxLNFvRNmB5wGenE+qI=;
        b=TE6zBa2B2sfdlH5ccNs/cihrnIrOUpdoQqpLV82xlSSrcbH8mYJPuOyWZ6vXfpqGpj
         26NH2kUmWBgBATQx/Ks0Zqe2xfmSDRfOPJNL+i3AbD9FlpHslv3Dc3kq7WmlM1HyNdQn
         DtEmipAtqvdv8dePvM8uyq21/tN6OIUOJOm1ghpA2JDMdIj30JzPY61Cl6ngXQaeHo+b
         lNmifubkkWnas8W4evNS+NrhMyeayI3p6cGP+gF/325Yrg+x0nT5fgcuRjtxroFQuApO
         dihFI7SfiIkX4bvqTht97BBjMKrTBUaiyX7MGSolUoVEVX88j2gItSvexD4JpeoH1F9C
         aXAg==
X-Gm-Message-State: AOJu0YyjYBmFl4kIQg9zy/kQ6BNqOuKh7+ry+JledT4w1IOvv1uxG/mE
	bbgFPqb8vYQLbXqkhTQiHhUCiDQLaTK9O4I0dpMdqiviE80Vko54SjW6
X-Gm-Gg: Acq92OEC6veB7jmSEZo7Wxb0CZj/9fMT+2u7nFsxw9nl/FldND/HkOcV9kucaympXea
	wDxWPqeQw6EdY1DfJOilVv+kwFeXpSv4U8AsWwoBuG60dB+kORVUG4sgikD4lfgWYJ/Drtk+QbT
	sZ+3Fyas7MPOqLTqqgHuKMgx5lxKsJLGitf4Ny2l8XUeuqDF+vKRxnmzxgf+cg1+Y4FgdOg/BPU
	dUBzn0ctF33MX1wE1QoNi0XP+IQDgrakr1VWHRNKP4gw52tTvsGN49P4ypwYopKNq/LS1rQzK6J
	khVfALq5x/SR84arT97wc84xaN4LK61dNVqizDDfc8Fbs0fxQ/cE4ukpzt6BRTezb+EdI0V+Hc4
	sttNMIxYYGQfVUwfF9NW7G5ObTQUyTXFa3sybKJWZ1/sUGGo0nR0WYl2gI9FnZAXKQgyHUJDDWm
	szYI81eHETC5/yGMcmSJ6pyAwpla2P9YJzi5TdByCqR4S07DqkOEu/VZVx+g==
X-Received: by 2002:a05:6a21:4e01:b0:398:840d:39aa with SMTP id adf61e73a8af0-3b427f7611dmr225863637.29.1780076055124;
        Fri, 29 May 2026 10:34:15 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772ba4adsm2361027a12.23.2026.05.29.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:34:14 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 1/2] Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
Date: Sat, 30 May 2026 02:33:46 +0900
Message-ID: <20260529173347.43967-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529173347.43967-1-suunj1331@gmail.com>
References: <20260529173347.43967-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_connect_bis(), iso_connect_cis(), iso_listen_bis(), and
iso_conn_big_sync() all call hci_get_route() reading iso_pi(sk)->dst,
iso_pi(sk)->src, and iso_pi(sk)->src_type without holding lock_sock.

These fields can be concurrently written by another thread calling
connect() or setsockopt() on the same socket, leading to torn reads
or TOCTOU mismatches.

Fix by snapshotting dst, src, and src_type into local variables under
lock_sock before calling hci_get_route() in all four functions.

BUG: KCSAN: data-race in memcmp+0x45/0xb0

race at unknown origin, with read to 0xffff8880122135cf of 1 bytes by task 333 on cpu 1:
 memcmp+0x45/0xb0
 hci_get_route+0x27e/0x490
 iso_connect_cis+0x4c/0xa10
 iso_sock_connect+0x60e/0xb30
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 241f51931c35 ("Bluetooth: ISO: Avoid circular locking dependency")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d7af617cda45..58bb3a10d49f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -337,12 +337,19 @@ static int iso_connect_bis(struct sock *sk)
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t src, dst;
+	u8 src_type;
 	int err;
 
-	BT_DBG("%pMR (SID 0x%2.2x)", &iso_pi(sk)->src, iso_pi(sk)->bc_sid);
+	lock_sock(sk);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	bacpy(&src, &iso_pi(sk)->src);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
+
+	BT_DBG("%pMR (SID 0x%2.2x)", &src, iso_pi(sk)->bc_sid);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -430,12 +437,19 @@ static int iso_connect_cis(struct sock *sk)
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t src, dst;
+	u8 src_type;
 	int err;
 
-	BT_DBG("%pMR -> %pMR", &iso_pi(sk)->src, &iso_pi(sk)->dst);
+	lock_sock(sk);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	bacpy(&src, &iso_pi(sk)->src);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
+
+	BT_DBG("%pMR -> %pMR", &src, &dst);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -1210,11 +1224,18 @@ static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
 	int err = 0;
+	bdaddr_t src, dst;
+	u8 src_type;
 	struct iso_conn *conn;
 	struct hci_conn *hcon;
 
-	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &iso_pi(sk)->src,
-	       &iso_pi(sk)->dst, iso_pi(sk)->bc_sid);
+	lock_sock(sk);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	bacpy(&src, &iso_pi(sk)->src);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
+
+	BT_DBG("%pMR -> %pMR (SID 0x%2.2x)", &src, &dst, iso_pi(sk)->bc_sid);
 
 	write_lock(&iso_sk_list.lock);
 
@@ -1227,8 +1248,7 @@ static int iso_listen_bis(struct sock *sk)
 	if (err)
 		return err;
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -1564,9 +1584,16 @@ static void iso_conn_big_sync(struct sock *sk)
 {
 	int err;
 	struct hci_dev *hdev;
+	bdaddr_t src, dst;
+	u8 src_type;
+
+	lock_sock(sk);
+	bacpy(&dst, &iso_pi(sk)->dst);
+	bacpy(&src, &iso_pi(sk)->src);
+	src_type = iso_pi(sk)->src_type;
+	release_sock(sk);
 
-	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
-			     iso_pi(sk)->src_type);
+	hdev = hci_get_route(&dst, &src, src_type);
 
 	if (!hdev)
 		return;
-- 
2.52.0

