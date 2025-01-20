Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67E152160
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355614; cv=none; b=arA4jnWHUE0XoQdlZa0aMEi/V39//pdDz6pzLUNIxRnYFjHYAiq2CvyuPs+yaG5ogsD2hnONl8FtSNmeYEFpM90NuMJNxCZ08HN8rzhXpTLmKApUbyrvzDqkPgmQc4oIygImfRxv/TqrpfAI/t3+8jFO/9HEibrpEp68kp9QANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355614; c=relaxed/simple;
	bh=5pqQZkMykC3JXMoqaN+ZurnKZHbS+SxjBXDSMJB8Nb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSSMO7LB8oPXSUjKeVxbnUk2WBNakuRnuseRHdiCbjGCwsLgT02GwrVzup1lRIrjtYkztSdik9g7Lp0DImOSiAiiQ2F8iEyURyVqH/FoCyDZ/J04SjXSLPlSHTIii2qnZnmd06L9GXqVEdbgMRUgbxKohzMPJWf3K5S6jAlAEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OiQw5maz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiQw5maz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so870193a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jan 2025 22:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737355612; x=1737960412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=OiQw5mazhRNet3UON4tn0A1XIpxYEPnnctU6hbJDOcpPTM5zf8Szjhe7fOIYDzow6v
         C4a8N0OmgiZ92voGrcOycR+kD1SFR8lNFFkDDHMrA9I5MxPjGYhSQ+VKoWjm2It3jZO2
         6tlfSn/omIpUg0RDsiIkWRuUsPXQPGHLDzJag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737355612; x=1737960412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=lbO/A4G7kwQ1qslR22lQyuGKsWkXvIL1xbzSfaUPVx+fHiWc4DU8OG68A2Xblg+ziK
         GrHin5su2Z5GOJPIRyk771BSZQ7AElYm7H2jjmIhKVxLZ597iR2KWEs+cW7jwYotpAA0
         IEh5TgzB4Cfz0YbSN9KhqhH+99390xFQN+ybdEXYDKPPBzDFGpKSZ/OiKokBEnSwau6O
         6kvmYuhreldH/BweUmMDHt/TahOr+4e9HFELk6Wt/ItxqZvTO+Pp3Gq0tzAP3+XGDnj0
         ntn+YAZDKM0YiNhh90hNxenC+8g3+iULFc1VU+SD4cYAtOzhoVhTqRgy4+MoTf1vuL0A
         U04w==
X-Forwarded-Encrypted: i=1; AJvYcCVCQc1xR7agDrx7ZtIA6NTJfLLD3juhyxyp0jjUEzdQB32p5nza/9FXZiPa4j8ed7YdsyTJD+K4wabkp1lylww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZWfdDXW3uFQVJv0EntuoX+MREh7FO+tKqfWK9LjdzLApr7ak
	YiLHNvuJ2R0bRTNV/XcswJaBm8OQC9ulz1nHYGtn/y06S16W/BApFDUVHeZEo5FuUjlC9wv2kQx
	/Fw==
X-Gm-Gg: ASbGnctphPImuuWddWGLv5hoR5u2BDo5Zpct4Cfd9wTqJ2oMKEO5XT6CyZ3pkITSvG8
	5Yr3MXOZEheNWw6nppqsdhLDW0QDnvfJg3Zm9tVrRQcQXlG7ODzSjLM3eHXUZRhvBUHnMY1k9yc
	R6wR8l0yAWyn+zcJznupXusPprn8FZyksvPKg6prtvm3LM5fVPff98A+fuqGAThjPs1xq0kW8O+
	vjQub7o+dK300l0zsGie1O/apLrYPLgPnXN5ps11z7tjAUvokH5fUcXm2DDDr+SFAF9qzdM76pn
	ExWy7gsPe1WibO0B1ZHRxxMK4kA+Eh1etVinwA==
X-Google-Smtp-Source: AGHT+IEYpgRdLItQd5/Tlw0NlvDB9gMR6mMU3xksiQtwizDh2l57h4EiKgvPCSa+k6iJA3IpTpnLkA==
X-Received: by 2002:a17:90a:f944:b0:2ee:f59a:94d3 with SMTP id 98e67ed59e1d1-2f782afea54mr6765626a91.0.1737355611976;
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c191e2fsm10949617a91.19.2025.01.19.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Mon, 20 Jan 2025 06:46:47 +0000
Message-Id: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]

syzbot reported rfcomm_sock_setsockopt_old() is copying data without
checking user input length.

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 1db441db4..2dcb70f49 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -631,7 +631,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -666,7 +666,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -688,11 +687,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -708,10 +705,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-- 
2.39.4

