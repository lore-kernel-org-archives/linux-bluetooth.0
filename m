Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759581D86C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696807; cv=none; b=fWp7aL5nuDxR10Y5LRhlt5MjljNQ33oFI6nKDFZGPYqbgbtILbkLs5ZCy4kIfLw40gBeKSGkEzfDIcb6/3Pf88uwRtmJ45QiNMpteTOr9yghrj46LPHCK9sOt20KNoUduCHjpthfoSJu4OUSzXc+wG+UxX/9VPhQgsL0Ssz1n10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696807; c=relaxed/simple;
	bh=wSIW9SJc6NZV6MAAaotVBRNDtbW5HnbEWkJPdDpU52k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkRfj7FXeVqTeCEE0lK27G3aEPoK/WoOIIBh/yH6zVxAzDSyyihUXD10jSIqhDcWkdQlnBXXSbYtg9d+/lw5gqfUTqud+aoT2nqJrD2ZPguWxRXSxKG+KOXHcmKc9ugwkctOqTXQ3GH38bsAPmQDKGgdwwxmG8fjh+23W6K/Mbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BFXBAUzT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BFXBAUzT"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f08fc17ef7so22292b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 21:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696804; x=1738301604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKI6M3Ga2oIUgZFOTflqzcS/S7V7PY/8wm6k/uUZ8oI=;
        b=BFXBAUzTx2f3k1K6SNB9JtJ1a4FZmUU3werNUcgFiXhCJp00tdkMbRaYe0/ALZfbc9
         x1FrEpFLgQM3FVJP0pEQH2fSEU4IbI9somC8w3PSFRUOpiZ39Swy3mZPVKfCdeYM3LcL
         KyHKe0wT2OIiwOlW2PkmzGHiCiFpFgMWNvyDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696804; x=1738301604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKI6M3Ga2oIUgZFOTflqzcS/S7V7PY/8wm6k/uUZ8oI=;
        b=AGnPvSkOBfXDFJnk+t+H6/lnWn9T65UEXwVra+d7/+n5TPILP0seQQRehhhKlpSxnE
         kOwAqc2etz0MygDJ4GAC942IS1Am5Wmbc3t+1x6iUlNh9xeGgCr31ar7YP2b2baxU0bl
         Yrvp3BxMtqG6iSdXkimWVYWi0NdDWydoHVa1HJXQ85lu6PrNcyeqRnyxhzq9H43yaMwA
         HHAjadhpNd54wOyTrUtlOOR4MkOdYKbRdaRgUyMLp6hujoS24DPovZXGdVQCREqi2ETB
         AFmwJ/ufGVv2QVe7qngy9gbmKVN/lUXnVZgyn7xdkiq+x29UYC2jcboC7ZClexGOF3Kp
         OQyg==
X-Forwarded-Encrypted: i=1; AJvYcCUiY4AdfhTSpTWmA2Rjxi+EuFzB5DxZNa9PoR6EVpJvgZ9qim/FOhh/QizvAjmtCHeIxW3rhGkdFsqxShqqcNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDDxPqolNcsQJt2GUJXq0HgdTWeJxmTPIlfLsGWmaZVyoOfDr
	DSgoF4j8AiDsmsO/QaIXYU2D/6iGAMcAA4+PIlnrU7QRliuaalKiixHL499LEA==
X-Gm-Gg: ASbGncsL8ZXVCFmYTdKdvZJ9joccZ2jH5VH9Auc62+BsDduWQ2x9W+DCShE7sYg6e2z
	n894pHOl4eCxriA+fcBODsDpoMtafclkmDAi4nMcOF2Qd6w+pt2B2EkszVNx+AoVa3rRqNKMDso
	hVZb8MS2IpxCJK20ZY9DuLjVq5VsCHDPN2i6XiG1UFwgSap/Q7W6MJT9j7I16naIee/gePy0+xl
	E/Ju+eBjSIko2OGbws1UIDmME5S6H2JhiurY2BwA/p9aTHRb5dk//6XJxsFn1q6/LbMvNztsZKW
	zz1UGH81YFJAQg/rNTCYnHn5QvIe6/Jr0PT/8KPPjnMxHCH1z8hWP+motQE=
X-Google-Smtp-Source: AGHT+IHhOD/kMjWyZMdu2nA2GSmKabRzevDKzcDq4NyCBezacU4HqyWOL9aAedfSaePPiXOJQvlzVg==
X-Received: by 2002:a05:6808:1896:b0:3eb:45de:8ab5 with SMTP id 5614622812f47-3f19fd4c5ddmr7038027b6e.4.1737696804592;
        Thu, 23 Jan 2025 21:33:24 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:23 -0800 (PST)
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
Subject: [PATCH v2 v5.15.y 2/2] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Fri, 24 Jan 2025 05:33:06 +0000
Message-Id: <20250124053306.5028-3-keerthana.kalyanasundaram@broadcom.com>
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
index 2c95bb58f901..47e2fd38b2e3 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -657,7 +657,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -692,7 +692,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -714,11 +713,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
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
@@ -734,10 +731,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
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

