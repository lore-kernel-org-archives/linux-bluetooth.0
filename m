Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01E174EEA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349645; cv=none; b=RbpTSmM6RfnwqzTrtHBm/Min2PXgocLPAPd/EYa1M1ScX/ZvFkBxyHFsjQSzbkTITiLiZxPXQGSx+vgtQGXDiykcMU9Z8o/Yaz11vebhnUHSFFykwr/eqeMu4wUn4Komwbu/Nl71zf7O31Z3sB6pdU452+wW2MMaBcni76mWSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349645; c=relaxed/simple;
	bh=H8eFOwRAoV4DFJBAuNi4Irj7C8f2JaeHDdVlNWxOuZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Av8ZyIa9TxatUxA/QZqzxUmAOnAR0iRtzdF7pUFw3OfsXEgAeDQTValI52nxSul8RkUXOG9oFjbC1FdYl6sS/ge2yXWLBj4TwRNcV8SKOLj/PyDchfWztmAeRJmTm+FI18oN3qmjKJFgbUBwOqIsntfG9mFNkN/D0vkedEvu0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkBYeiEJ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkBYeiEJ"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e406cf6263so656732241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349641; x=1712954441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=lkBYeiEJsiLmFtXnD094L+RVbLCOqgQEgmEB7wpoowzzFdRcanZi0kMpBuCNMsojOB
         MwdhOJhb42RNIjLHjytH5tq7LOrf4bUqa7cIGSOvZfu2uHVpcG7fMN5WCTdc+KippaDb
         +sI/vMAmXxkxhZQ+MGkLq8CqNm3jN01ZMvYu3OApctRt+rayU4dKTwth5bH5uEzRl2a1
         8SdYhRNFk5U+S8yuP6/YXP2oekaA9NjteR6iu2o/YWR6DfmMfshXJu+vlwP512wNHhIn
         HIeBDqvxYR+ydbfqFwJUnF66oTqR18H/sXl500tIjq04jLp/2Zv5Y6fAN/GcrN1FopO/
         1TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349641; x=1712954441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIO8scaADKE+KJ2bsqCNzXMkWrnS8uUEUgoBXCePjUk=;
        b=qwXgRF4s2NkBKsxQw0YQzWZzdL4IVSVT5Z5teTXG8vd5ww0L7VEQ7hXQU6ExUc6DIN
         kAI1mz6UCmeDfAhExw8I0/AMei7swSenVNIB2XK8UwGoz4p/cPDzabTmWj4W5NSLceV/
         I9rmk4bPpuCsCLqNjqZJVklf5G8qfr2FqDd1moLRBjO85pUCuGVGRj+6T++AYfQNpuF5
         VKwOYIL/DLpJwhXxN7gTEBkLN0AHllqLrogTFWBpolBVOJTS5eO6iVTdyAqk2TSrMYhY
         twCvsBTe//GAZuFRHcl8kZmZ4notZMZzeVGB/EOHhZLa2izen/Ts+pnqO7ZxHBA+Fx9w
         UFMQ==
X-Gm-Message-State: AOJu0Yz8rqloKhXa0iG8Braa2sZrKEaEmbCBZ3MTYmE134Hv4af5DsHU
	QW48dVEPaVA/Ff1oymf7kyyr4+UQSSa5l9/FcOSZfjijV67zIR4k4BGQzxEV
X-Google-Smtp-Source: AGHT+IFOMSHJ1ZirR/H/9mtBKscnN2pp6pSLL/tO9VUrrE8WCiRupqFoY4EzJHrRhW4g3eETO9oGrg==
X-Received: by 2002:a05:6102:4193:b0:479:c365:3fac with SMTP id cd19-20020a056102419300b00479c3653facmr2885747vsb.12.1712349641542;
        Fri, 05 Apr 2024 13:40:41 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l3-20020ab07183000000b007e3a8a03f4bsm290902uao.26.2024.04.05.13.40.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:40:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/4] Bluetooth: SCO: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:40:34 -0400
Message-ID: <20240405204037.3451091-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204037.3451091-1-luiz.dentz@gmail.com>
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
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

