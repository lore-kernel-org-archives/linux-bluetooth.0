Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="FX6Nlydl"
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EAD5
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Dec 2023 23:02:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2868aeeb47dso482631a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Dec 2023 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701673368; x=1702278168; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbdWI3B3YH21k8Qw3umXOClHQvLtpy8oqAYW56A+gPE=;
        b=FX6NlydlblORbw3ziRf2vRRsfC8ZwItb+TzjBSvIH/DqnVUmXo3pqT+4/U5j/omX5y
         sLiOX0zedPdoGITCxyyNHOIpmMhdOz4HeEOaSxTqc6xvvZlXAiyxvxdxCCQboCIubvqE
         veoH/A6794f+qCvrrQM72duxFThDoQTKN7d/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701673368; x=1702278168;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbdWI3B3YH21k8Qw3umXOClHQvLtpy8oqAYW56A+gPE=;
        b=FIqoHtF/YK6bfFBbfi0dt7ewSTdWEiRx6f7NXnryDH+dE88lhQpoJ7FjzIiHerTURd
         urybfWUrHMilOm5tFuBqokKo2xKQ5MacI09wLly26fR0RSaSJvg3+COJNiK/KLBGVXSe
         /Kje5hHWuvA7cE4UorvK3QXXv5XEs8EqMYYAD79mPpsxSrFdwLgB2fLcv3oe5af4Ks0w
         j2vakjHRuX29rM/pvVllQhDiDn6LO5c7FHm9KRnGekEksCp+A5fls3c63+ZHat9cMm+8
         U8hYV/EKoBGJRc5ngfXws262MQE07+RxefHqgVro/Ck1vjwvoqE5XtCi0g395kqG/mAn
         OXrQ==
X-Gm-Message-State: AOJu0YzkQyy4A96VIAyw+4VZZKeHef2ETwgeeBlwQAXE/VA6yuNm4fxa
	b4AGxOA7vzBlOIyxCdzLzGfgeA==
X-Google-Smtp-Source: AGHT+IGB9EqRfY5Ik5QEvpEhrS+ICih6lHse+5YC1ez8FjwdjRMKWWSd+XrMsKbEdHEve7fyF4jJnQ==
X-Received: by 2002:a17:90b:17c9:b0:286:7c8d:fda1 with SMTP id me9-20020a17090b17c900b002867c8dfda1mr721651pjb.30.1701673367810;
        Sun, 03 Dec 2023 23:02:47 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id sf15-20020a17090b51cf00b00285994be9easm3321965pjb.1.2023.12.03.23.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 23:02:47 -0800 (PST)
Date: Sun, 3 Dec 2023 23:02:43 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: marcel@holtmann.org
Cc: v4bel@theori.io, imv4bel@gmail.com, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg
Message-ID: <20231204070243.GA16386@ubuntu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This can cause a race with bt_sock_ioctl() because
bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
and then frees it without holding lock_sock.
A use-after-free for a skb occurs with the following flow.
```
bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
bt_sock_ioctl() -> skb_peek()
```
Add lock_sock to bt_sock_recvmsg() to fix this issue.

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/bluetooth/af_bluetooth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 336a76165454..9def13ac816e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -309,11 +309,16 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	lock_sock(sk);
+
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
-		if (sk->sk_shutdown & RCV_SHUTDOWN)
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			release_sock(sk);
 			return 0;
+		}
 
+		release_sock(sk);
 		return err;
 	}
 
@@ -343,6 +348,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
+	release_sock(sk);
+
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
-- 
2.25.1

