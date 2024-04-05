Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186F174ED4
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350113; cv=none; b=R7RZXELF6SeiJeYg5VzZv9av5fK5pZzs94+R32zDqu5YR3/Wafv1NBIoBAD8NmTOq9sa45IS4qCTG2VFyVlOY+smXLJss1yX4NGWExXSa3fg+RhTCuYHS7sDXj5iYdRNJlUG5BPYEqLWKcBw4zBuK4ZhhsLblSQNQQn+Et8vSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350113; c=relaxed/simple;
	bh=H8eFOwRAoV4DFJBAuNi4Irj7C8f2JaeHDdVlNWxOuZk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gNXKt+8cAcfgL9cIuXED+kTKSS4unLzM+t8D1eskndwopTfd1iwU7WOWYD+GP/VxoJ3ZVb3iCVLejdSieDumVcOyoLHLDDddUsfS6xDL90wAN7vBQCnTBliADHSWJuhYXq2pn0z6tHVjfZGlZGMmMU4W9J2j8VvsxhLpw2+HQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrYBxrTL; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrYBxrTL"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d88360fd7bso1857352e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712350109; x=1712954909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=KrYBxrTL3++unDpXhLXDOVQzYLH6aZAujd5a/cPl7T7vpooiqvo0VsVUJRBms6H+ST
         04NLlTQRrPWa6isl//unLee137EP9H+FV8LvWYYNcXqbLawzk9LJP+ipv4iAVhYEJJmA
         rd24A+nzYiAWZehaCVYyhw5uuie9eP2vSAmOuIH2Teo5gCakUJajXnlSXuvqRtnsKiF8
         XCPed2n8V1Gm20kDEmeCoFsZM+kZcfZIeODXb+6s8ADPVy3vWITef0Sz4vMlulwZHDNo
         o11982t6E/Fnm1HUcj5mts1Qicd07eCKpqQDRZX03cU8PLxX+fyXH5+mP1REJVU2I47I
         tJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350109; x=1712954909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=Q4PrMka4xlw5TVPHQ+xXYB4Z/5QtJWUun+FEWztTctX6N+Djch1ANwIBvN14bNfv9D
         xTGfOmRhqXKGpue+0UOBxiJ9TaIMRvx+6L0uW1eJ0PRmV9q8ovr0JuMeb2vVoZCE2jld
         q0N+h/PKCGLRvGkBy49AV2uizYaLWYj/oFaxuR3bv3mKlIWlKgQh0KUtw4ciiDUp1MQl
         7DJu0Fl4/WJ5e8/Tc/IfLvnrob1+sAfjgf+yITfDJGAKNUznfihzr327Mkfg79kTH3aN
         HzcMKdkCDoFln/h9ePx2CKvVEwoG/ejGcSOVxOnxc+1rDGihSmPCPlRyhd0q1YgK0mx1
         67ow==
X-Gm-Message-State: AOJu0Yxd9wK04rDbEkSMzJnHohPNckS6wQcPCt2oSMO/3aVPs4MUoDdK
	nTN6a317uoT2f30fCh8Sz0lBI3e1x5p9oY0pdU730z40cbYM8cXPmAfQ3D0C
X-Google-Smtp-Source: AGHT+IFsZr8V9ZLSz2D7O5U9BC1mlAbJqARZzqJ442YAplL67jyBn1ooYJT/oPgUdTBooj3ArMGnZA==
X-Received: by 2002:a05:6122:16a6:b0:4c7:7760:8f14 with SMTP id 38-20020a05612216a600b004c777608f14mr2608617vkl.7.1712350109467;
        Fri, 05 Apr 2024 13:48:29 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y72-20020a1f7d4b000000b004d8a496db23sm336004vkc.1.2024.04.05.13.48.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:48:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: SCO: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:48:23 -0400
Message-ID: <20240405204827.3458726-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

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
---
 include/net/bluetooth/bluetooth.h |  9 +++++++++
 net/bluetooth/sco.c               | 23 ++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1ada4f85e982..431c907155e7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -586,6 +586,15 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	return skb;
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
 __u8 bt_status(int err);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 99c2b713d826..cc72f05d4f0e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -839,7 +839,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_voice voice;
 	u32 opt;
 	struct bt_codecs *codecs;
@@ -858,10 +858,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
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
@@ -878,11 +877,10 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
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
@@ -905,10 +903,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
@@ -949,9 +946,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(buffer, optval, optlen)) {
+		err = bt_copy_from_sockptr(buffer, optlen, optval, optlen);
+		if (err) {
 			hci_dev_put(hdev);
-			err = -EFAULT;
 			break;
 		}
 
-- 
2.44.0

