Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285738F626
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076061; cv=none; b=YeVQ8TGJyC+Xa9JeOLBLbD3whQVwXU1bCin//5r6D1tskTFF+pI78lMl+Di5NHvStnH3PnEc6YwXKuQOQB81yza+7jGXfdfq3Y81L55+avqbIOCnKs7V5ZGr0ne01J9DMeLdDcXrtiFgWLXaxU3gqppuobXYkp5DYZJlKzVKmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076061; c=relaxed/simple;
	bh=RdQD4wue90+v4yUM2xCSZUvp66yPWE/ku+bI86gv7wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu4jKA73WTFr7ZYERIkTlFJ6nT85nG0qYR58M1L8qWvxQpxvlagAebLX0C0+VOGoGHLzrAbxZOiwoXCZ4xealXgJ3C1wERhTFPVa3zFzEdo/mHHSvy6quYJgJQ0Ae7XWY7tUkdY4aAmoy1RI3k4Hi1uGYyqj/4e5BqffAEaHP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCaGwlVI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCaGwlVI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3664df32e91so15763652a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076059; x=1780680859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSsUh1Q1AG0bKmm3IulRp5n1yyJwXsFuTPbDToRe2u0=;
        b=PCaGwlVIzmnF5fUNM9BmjrUJrDm5rAernFAyiHc9KCfR26fFJU9ASM/ulIg80uYGCX
         3sdCRwSuQMmlOUHj5yiLY+mS0Y21aEGqQRBL218rX+sBVSMVUcgAKmFRhT01cTAD4fzn
         pq63RyRdOf0qkL5o2/izvBoA6hFJh8b0UKYeqz1jmBm07BmwR1HQVoR6zht23v8wNw2U
         13P+2/oS1vCgwY4yKNftdn2KMdri7ct+EVS6j8ZSHYx9Qf9X7GiOg+abYLPeUHod+9yT
         imbTT4Cr4xpJfw3sPU2JNHyxyqR+xKb7AK8AA6eiVJ7exqXHhCuOu0VWVmhbIxPDigJq
         1vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076059; x=1780680859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSsUh1Q1AG0bKmm3IulRp5n1yyJwXsFuTPbDToRe2u0=;
        b=V80AeTFgG5JcaBGpf9jg819Ny/dw1SmwjxM9LeyaFg5qGTpTfSeWJmO1ZYcKRTT5Qu
         Q31v9QSBfIDucg3FYUHRPmjQ44vXniALVLMeq5Y345kkVjx630+vF53pd62YCeZYP/ur
         FMKOfdb7rVFF5m/ZANFZYTHMaTvEJw/l6pNrogDNNeSg/KtLrW9MNhwhHdY4TFXe97od
         ZoJRpUr0PH1ogYL9wr0rvdAKwPJAQgMDSzr6rExeBErNclwSuFrMsdOT92TuYOsQx3D7
         iCsm4KgQ4/8vbrHV9f5dr0idvbygQbkMXu4a7ETUDg08fzlZ7e0yLBSLvC0EaeP+bN0i
         bEbQ==
X-Gm-Message-State: AOJu0Yx75GCCRGwm1BL44e5s7gsG2SEVipMDkJxkBnAu67nGSdWyEkAP
	/rrJW8XzXzXUON/va8pxnlNZLQdjdpBxYvzVikgVxdftpWaJvTD1uLl8
X-Gm-Gg: Acq92OEYc9rh1BpuD4sOkD9p3O+cUDtAZBap/KC94hrS0XjFnIVhdxQV9z8VzkNR1kM
	Z39kHnNVXnUYZhhXiJLz/qd2ZU+dsT2W3BkDg9gm4SjLr+yFptD9E/7Q1lu7//pgpqw3WEz1cDw
	cxXseNTYp+a1VesRQFI/ekJw7aa4zT1m5vd92mqiW8/JHwxc3CyPJqI138Xg0BVuUwCYEUAve3B
	cMzsBFWW4g3IqrP+Dh7qLTd0fBWI68/CnWwwF7d4dCx77NJDFOgkVEu8/nLblUsj0M2x4SHv87G
	MXm6iTTcLHKT747qioMmIvoceakw8T8/hi7wiMtdYZtT/D2lkDRIXIgpTaBT8uScY585c4JEoVR
	M6tUjSKifjYquFqnecy4O9GXIYAIaBKm9o2vWT8w3abzhhXZVRZQYpp0m0k6NTS6mmeKnQM8vp4
	2DrtCPhlFaL1w+ISOilZfdWuyos234BOzgF7OBrADDsaLmoEEOLzo9D8ki1g==
X-Received: by 2002:a17:90b:590e:b0:36b:211f:fa75 with SMTP id 98e67ed59e1d1-36c4ff4cfd4mr188994a91.8.1780076059232;
        Fri, 29 May 2026 10:34:19 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772ba4adsm2361027a12.23.2026.05.29.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:34:18 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 2/2] Bluetooth: SCO: Fix data-race on dst in sco_connect
Date: Sat, 30 May 2026 02:33:47 +0900
Message-ID: <20260529173347.43967-3-suunj1331@gmail.com>
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

sco_sock_connect() copies the destination address into
sco_pi(sk)->dst under lock_sock, then releases the lock and calls
sco_connect(), which reads dst back without holding any lock in
hci_get_route() and hci_connect_sco().

If two threads call connect() on the same socket concurrently with
different addresses, one thread can overwrite dst before the other
thread's sco_connect() reads it.

Fix by snapshotting dst into a local variable under lock_sock at
the start of sco_connect(), matching the approach used for ISO in
the previous patch.

BUG: KCSAN: data-race in memcmp+0x45/0xb0

race at unknown origin, with read to 0xffff88800e6b0dd0 of 1 bytes by task 315 on cpu 0:
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

Fixes: 9a8ec9e8ebb5 ("Bluetooth: Fix three socket race condition bugs in sco.c")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/sco.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f1799c6a6f87..c9f6a8aaee57 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -312,11 +312,16 @@ static int sco_connect(struct sock *sk)
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
+	bdaddr_t dst;
 	int err, type;
 
-	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
+	lock_sock(sk);
+	bacpy(&dst, &sco_pi(sk)->dst);
+	release_sock(sk);
+
+	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &dst);
 
-	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+	hdev = hci_get_route(&dst, &sco_pi(sk)->src, BDADDR_BREDR);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -336,7 +341,7 @@ static int sco_connect(struct sock *sk)
 		break;
 	}
 
-	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
+	hcon = hci_connect_sco(hdev, type, &dst,
 			       sco_pi(sk)->setting, &sco_pi(sk)->codec,
 			       READ_ONCE(sk->sk_sndtimeo));
 	if (IS_ERR(hcon)) {
-- 
2.52.0

