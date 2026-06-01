Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739A38947F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312772; cv=none; b=i0I0LfLYGKstCHEhvCbdUD3LUERqbLD2VwSu0jmK/0GHfBRegDWj5Y9ZbXWhOP6UftHNFP1JdCvlLsG2sWiyGbqn5EtURGQKrtAUerNLnCSIBWAS0tuPyWiAAKx7q4U0YnMWEHA+V2LGWKJq7C0NHZHwvYuuAE3xSY298QAjU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312772; c=relaxed/simple;
	bh=nLlwcEjDLyC35i9VEjYSXKxZ0ADnNQQjIajXHU0cpAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVYCLsWWo/J3Jq7qs+YgZV8ii0WFAO4jL8HE47zhpVMv/UtjzkUtcDVX+01ChatzgOlkDcGDkNvuPux2nVW0Dv1HFSenKpuJXKTWTUJ8W6mSe5fxL1OXI3WYV1dSJlG1An65CPD6jcqFz/reBCurUdltp0rpcyttisdhBoPvd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULRD0h8P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULRD0h8P"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3546924so8140665ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312771; x=1780917571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikdg5vb/DoCVKkC8Joypvv5J8aYetWNjGyB7PGOMDRs=;
        b=ULRD0h8PDiMe6dIQUki+UEtVQ8Fcwlnmsh3KJ9+fjMdHxCsRQU/45KsReeIj4Msy3/
         Mq2ljw1mXNyUw5gvbqk+dMyvHPLgx/uLRcNBE5DXuw9PJQjCTHZXcSPYx19zg9mlsVv0
         5fxwIirB9P2TEH7QcWjwOXIetIpKF2+GPAqUfHvUFLuxStBKrh0oVtgACtKkABXGJ8I4
         I5DOkqZAaC8bYcv6ZPrUWBUhbXx5YFY3jyLYep1hz9zaUOZEAO4tHrR5DkjZJBoV5J/n
         SnC1ny5kk0UKJZ2Fy/+nUQWG85NeBn2buGt6uk6yOUgkShhYx6cOHtxQ+jkJBt8AMSv7
         szxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312771; x=1780917571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikdg5vb/DoCVKkC8Joypvv5J8aYetWNjGyB7PGOMDRs=;
        b=UFBLaaRPWPaIWyGS+PMpVDrGhwrSNGK47CbNqketXOFQWK/d/OmQUbyQh39GnSHEVz
         yQ48C/xn5pjsM8d2Vw5lvGVfU/xr7Cszw8p6oiAgo0L56fhT7YoY+pgiNIkjXIgVGeDw
         ka+REyOHBPAaAfjiis/bzD3ls3pArEHWVas6V2VknFygZ4S67LgpDBp4siq/Jw7zjydG
         MR0TCMFejns6pNFQzHMADq1wE2H67qhRkfI9XAiUHJBSdILxUUG/M4Y3fkob1v1eiw8K
         zu53VU1rUAa2WRg4Pmcd/pSSytliWJXPGLhAsV8JDr2Re4z+4+N3J72HHcYRm16YqJ5i
         D1Mw==
X-Gm-Message-State: AOJu0YxTD412b88o0R+wK29TOgboQmmOf1MSzrgbDEhZUl5ow89tYsrk
	tSGe+nZHMrkMiyiPcMPYxGPRR2RCjGhjlv6xvelFZWaEWkMhFndg95P4
X-Gm-Gg: Acq92OESqp4FcAfWD207KgS8hDIY4pW/6ACrf2wLDysWCzwU9WStDjWXRwMHhlm0OQ6
	9DmO7KzqfvTzfw1Iz1+Wr0lmPLexm5UZV7SMVtb6VToQuSJq0rwrzG+SbN337SkNdS+UPw8X8T0
	hioFuH6RTRcuCn43teBOmUCdOoP/Pz2h9Ib4cYjaBRewWEgEPqW4EZMeljQKMS2jGV7hyW8zhiI
	F+b1C3DY/U+7TDjJPckBYbProPyRn7XF340n0E6pI+Ujqn5Pc14DH4mJGwiJt3Ea3bpocfncFfU
	BK7bHfXNM7icB7KEpwhgGj0C39XWOvo4isDkqFk25VNbHqdBCyUhtH4v6cDTu6LuWLAp2kE7qQb
	pMJWw8l6h97sKBCrwqfdCxVS/MY2osIVtViCPUr9t5p5yCWmzHdrGQZtfXME9P9GHNAmmsxMXjq
	mmjvxBtMcVABgB/2GbdfcNPCF7MueTbkM55oQ7tRUG3Eavjw96gA01hKbgYedr4d2CP1Av
X-Received: by 2002:a17:903:46cf:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c0c6254383mr63119995ad.37.1780312770646;
        Mon, 01 Jun 2026 04:19:30 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e702fsm104225475ad.4.2026.06.01.04.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:19:30 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect
Date: Mon,  1 Jun 2026 20:19:08 +0900
Message-ID: <20260601111908.232707-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260601111908.232707-1-suunj1331@gmail.com>
References: <20260601111908.232707-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_sock_connect() copies the destination address into sco_pi(sk)->dst
under lock_sock(), then releases the lock and calls sco_connect(),
which reads dst, src, setting, and codec without holding lock_sock() in
hci_get_route() and hci_connect_sco().

These fields may be modified concurrently by connect(), bind(), or
setsockopt() on the same socket, resulting in data-races reported by
KCSAN.

Fix this by snapshotting dst, src, setting, and codec under lock_sock()
at the start of sco_connect() before passing them to hci_get_route()
and hci_connect_sco().

BUG: KCSAN: data-race in memcmp+0x45/0xb0

race at unknown origin, with read to 0xffff88800e6b0dd0 of 1 bytes
by task 315 on cpu 0:
 memcmp+0x45/0xb0
 hci_connect_acl+0x1b7/0x6b0
 hci_connect_sco+0x4d/0xb30
 sco_sock_connect+0x27b/0xd60
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/sco.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f1799c6a6f87..140869e5b2df 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -312,11 +312,21 @@ static int sco_connect(struct sock *sk)
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t src, dst;
+	struct bt_codec codec;
+	__u16 setting;
 	int err, type;
 
-	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
+	lock_sock(sk);
+	bacpy(&src, &sco_pi(sk)->src);
+	bacpy(&dst, &sco_pi(sk)->dst);
+	setting = sco_pi(sk)->setting;
+	codec = sco_pi(sk)->codec;
+	release_sock(sk);
+
+	BT_DBG("%pMR -> %pMR", &src, &dst);
 
-	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+	hdev = hci_get_route(&dst, &src, BDADDR_BREDR);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -327,7 +337,7 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	switch (sco_pi(sk)->setting & SCO_AIRMODE_MASK) {
+	switch (setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
 		if (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)) {
 			err = -EOPNOTSUPP;
@@ -336,8 +346,8 @@ static int sco_connect(struct sock *sk)
 		break;
 	}
 
-	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting, &sco_pi(sk)->codec,
+	hcon = hci_connect_sco(hdev, type, &dst,
+			       setting, &codec,
 			       READ_ONCE(sk->sk_sndtimeo));
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
-- 
2.52.0

