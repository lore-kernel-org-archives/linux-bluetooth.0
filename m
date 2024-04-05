Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE831327FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349665; cv=none; b=NnmwsmKIHPyWCKZHtDyTUO1onRQcm4S2CTB61VY/7a/hbkUrlyVNsv0sNieLizI81ZqpoW/1rY9sBFt9EoAq4h3MQwKn5BVdAHzteq769ZeR8+2n3qjcFVrUHQSQ2+SL88cVS6ZNzfFmX+8dym1rgB1DJEtzOpxVRgXgjrtUb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349665; c=relaxed/simple;
	bh=H8eFOwRAoV4DFJBAuNi4Irj7C8f2JaeHDdVlNWxOuZk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s2BmYVpcQQUa/pp3ON9KAWFAOzWp1TZT+Vvyu+MGmjyi1CzJe9taV+I5y3aXlCH2U8xjbDozyrxPFPUdpZHM1SSecDLQluW/4q3IffCCJYSIfHaE/e7PnX+n6OPvVf6/CZiieaS1ke2kooX3UF3k1QXaj0/w1JCkguhCBwmf+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7KyMBZd; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7KyMBZd"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4da5eb33c45so761478e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349661; x=1712954461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=K7KyMBZdhIBXUfc0Xl7h3viP8neePRJ3UOSHJgNwEIz8+M1OqHPUbYBme0I2R+r3u0
         /EdimPhUpKi/L5WIFAWTwT+4WETkD0JIb3f4LIXjo8RUqgRJjkE2kElJq9GNRM2eiJNt
         Bn8o9HmqpW++ioXLA6j1v2zUeNre7Wei9Ts0o1JCLBXNyc9QWV4L7Kmx9OY7wgP2rdCp
         QOjntk57Cxzo+sfbszGBSnSKZ81AW6H9TVEvkXSJAxdj5Lm4znu2bH+wSciQghLHssdV
         wXS1pMi9Sl7+nKsA+/Ae7jW2a77AiWv4ykSGZYegaSZoBAueyY+mY5/y1KVaRRCy9I1Q
         MW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349661; x=1712954461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=smjdQkroJwy7Pu56OnePjz1BKkos4rZHJk0MAXVmS92+TiOdv/mgbxsqWeqCAatO4C
         qOO/yB0exE4N9fp2mJJjIJ1FA4g1cwNLP+uoOr/nTT6aRDlcJSef1ccCX9T8ZBAzERK4
         yh8a8hBoSW4inSV2rCYHwptsxHeU0+mmWU6vzpZpBWjHOEl1CL5cxNMKKljDo1E3ayjG
         XhO6XF+0b9AJPF4HoW/Zc5o2zS2Tou99OBsclPnwSoKS8ygSmmU2Lgr4UEmPXnmKb1lK
         oKzdsZUACa000+3is/2mr9nqivHcJW3docjhKAoFPE/VsMwLz5teLb5o7X8ACRmz9KYc
         7Jow==
X-Gm-Message-State: AOJu0YwouFm06dOg4UOSFZZeYns/7xbxs3Ij9j7bg4R2BcqBKoYNBrtL
	wEhpGFE+mvnDadLH4ReyfNM0Y2/KwXPedkyherXzKGNuhxHHDTyHlPJCYyYc
X-Google-Smtp-Source: AGHT+IHcrOulM9BOLEyf5fscQsJCljvEnV6fiZXGpEnr0VsnNoikuldD9I5EN3Z1DXXV8knWmfCQ/Q==
X-Received: by 2002:a05:6122:180e:b0:4c0:2d32:612f with SMTP id ay14-20020a056122180e00b004c02d32612fmr2777152vkb.15.1712349659914;
        Fri, 05 Apr 2024 13:40:59 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l76-20020a1ffe4f000000b004d89b77e45asm326510vki.51.2024.04.05.13.40.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:40:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/4] Bluetooth: SCO: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:40:53 -0400
Message-ID: <20240405204056.3451243-1-luiz.dentz@gmail.com>
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

