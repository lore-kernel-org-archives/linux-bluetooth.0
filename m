Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BF1D9A6E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696802; cv=none; b=kasz1E2b1Pxh+8FeewJaN1qTHgiildu1DT3XCwXOLS/seI8t5ktIqURw1M8gkoCH0LV3KTg1cTFmZkTXf9F5nDMV95zKHTrVyJNIcFjsh+Sjm/3CxesZ8UO+dqdu/ATQB7fdFDn9rmRCvdKvVA2MyIwoN9t6pjJtt1GwkoHmPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696802; c=relaxed/simple;
	bh=9TwfPJm+4wNI5n6SCunLRgnDQ11vB9kD9G4+q5M0gow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwu1kn3jg0f19+f+nvt9isMr9SU2XMGS1ZzPO20a/hS7TfNduepMNrOefuRWzvpnpR7k8j3fvWBRBQjpxcto/PDZ1Xh/qwO9MAA3zyYV5fy+fnkFCmjL0pSjG7NzEUl6jHigeRcS2wf7VGLsJuql1DD/3i/K5oZl0r6wKmv34nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J9ymgMaE; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J9ymgMaE"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb82fc512aso31675b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 21:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696800; x=1738301600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BxsvFjdifDMCEzVvid3wWn2QEdrTgDVVG6osbP3A9U=;
        b=J9ymgMaENRwn5EIvADksxPSu9/vdyxWcxq7OzZmhfrfgcN3ZLuuKUN0FktY6ShPgtW
         RjtK/JbaSNdL+hjlX2LTCNf+ZDpka4+fERbEzGrNRBa4ppD5lDQPZSIjv6VuGDA58/dc
         cNRH64OkK0nAj39/azPcAtt5QXhgIJaQ3Ed3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696800; x=1738301600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BxsvFjdifDMCEzVvid3wWn2QEdrTgDVVG6osbP3A9U=;
        b=cFhUCtzABVoC5Q3AZMBALvmdqori3IpSLgV6UjkBLuZtvhZf7uWNeJCFos932gKBFD
         sd8G3YaUo9NA1iw2Y2TyxvMzIrR3RK6sTH2TntZGsTJETmWbEQ/ZI0hY7us0fA9JyJvg
         1gKpJJOcwlcjBRJYsaXRY3YyaH8/vCtJiOsDu+mrrbAZ1T7W2lmMKtMfSdjNSUuWBp9M
         r5Qz6DG0ZHsoAP0NKJfTpJGv6epiHkT6BPtqNDR5OlRkrO/JAE7CIITbmFgG3Thdy7A2
         egyUr7sluyRMNQMOopx0qqLAGl0QOhXlKWdxw8BXvoc0xwrJkZWt8yL3eoFs1g8qtnkY
         iPNw==
X-Forwarded-Encrypted: i=1; AJvYcCXdyTZ6+TObbaoknJ0RqhUhAKZI9+OvwyDg4VFTI4XzmvECBlWeRanNdYTU3X3CWt9buu582RTC8N8Eq4vzIEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVY5TDZ8EW2fXu2M7Lm8SG+ZRxHzEd42WVWNJvaj8teXqGKPK
	ORmqpYUGrIVa/bomiHa+U5+m18gOr0jCH8VCCsNsF4lCPGGzJXWWT7ARtJPdRw==
X-Gm-Gg: ASbGncvrr7pOBHf8EHK/b8HLlVDsJBrtN/UJ3eSTV+1iSKXOnENHPWJhdmNpjz7bgh8
	kGKP7zgeM03PPjQoFOMpq1QftNzsm+NygDp16kJsMqdWa+qW2rV92hsyxoMNbXV5qVQXeNHYJKS
	FE2WIGrt6vAnkROzbT/Xx3kQIAfkmcSDj4YW5m55nhdgwtJkT+s1mLXg3heioTUbnN3cw0pA+cS
	nY8PNiwciWDz8trDLh7RV/21MkxOQLleaih/FRj9wvvyaXsjCtog6d4h52nVAI2EbYhL1t2zyCG
	tfWWB76OZJWBn7hEGJu7uYA8hmqlnlEZOkCXMfRZlaJJjE26
X-Google-Smtp-Source: AGHT+IEi3RyjmC0ik8fH/2Da/etESXZAUEVuRyOYQxOzDSO+XQQGAt8fPxU6bHBCYhyZa1Q4f9YMPw==
X-Received: by 2002:a05:6808:179d:b0:3e9:1bdb:4133 with SMTP id 5614622812f47-3f19fc03facmr6293553b6e.2.1737696799709;
        Thu, 23 Jan 2025 21:33:19 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:18 -0800 (PST)
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
Subject: [PATCH v2 v5.15.y 1/2] Bluetooth: SCO: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 05:33:05 +0000
Message-Id: <20250124053306.5028-2-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
References: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 51eda36d33e43201e7a4fd35232e069b2c850b01 ]

syzbot reported sco_sock_setsockopt() is copying data without
checking user input length.

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90
net/bluetooth/sco.c:893
Read of size 4 at addr ffff88805f7b15a3 by task syz-executor.5/12578

Fixes: ad10b1a48754 ("Bluetooth: Add Bluetooth socket voice option")
Fixes: b96e9c671b05 ("Bluetooth: Add BT_DEFER_SETUP option to sco socket")
Fixes: 00398e1d5183 ("Bluetooth: Add support for BT_PKT_STATUS CMSG data for SCO connections")
Fixes: f6873401a608 ("Bluetooth: Allow setting of codec for HFP offload use case")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/net/bluetooth/bluetooth.h |  9 +++++++++
 net/bluetooth/sco.c               | 19 ++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..49926a4aa16c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -420,6 +420,15 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 	return NULL;
 }
 
+static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
+				       sockptr_t src, size_t src_size)
+{
+	if (dst_size > src_size)
+		return -EINVAL;
+
+	return copy_from_sockptr(dst, src, dst_size);
+}
+
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 98a881586512..b1a905b195fe 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -822,7 +822,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_voice voice;
 	u32 opt;
 
@@ -838,10 +838,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
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
@@ -858,11 +857,10 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		voice.setting = sco_pi(sk)->setting;
 
-		len = min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_sockptr(&voice, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&voice, sizeof(voice), optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
 		/* Explicitly check for these values */
 		if (voice.setting != BT_VOICE_TRANSPARENT &&
@@ -875,10 +873,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
-- 
2.39.4

