Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="aoTLaCan"
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0DD1
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Dec 2023 02:55:22 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35da160de2bso10815455ab.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Dec 2023 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1702119322; x=1702724122; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MG4jydi7FwQ/P6uh4CDazT0KKgYS2mBRXY5lcwogMaQ=;
        b=aoTLaCangIlhY17Ys6KVP+Uh0ON8Yg6SEwfBWYsY1OXundq1TbRKJeB41i8ko5ynJl
         4rdmYTo9Z7WlIP2xm0PXkVZEnREGdG8k0+fxfrbZNzZtSO9XWCJ0UpiU0EX4n8cCGX7O
         24HaaNr0AS2Z5HNAlL3qioSSdnc1zEC1GLL54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119322; x=1702724122;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG4jydi7FwQ/P6uh4CDazT0KKgYS2mBRXY5lcwogMaQ=;
        b=QJ+UoXDrI1g8y8dxOOYmce/ItBIDHAUC/ESzuxtg4OHdlWD+EpGOQ/lGlpHm2xl4br
         tULU2uS+QVKINuujF+EjEa7tIYOPvXh5NPCQrzFUoXHZveQUSy1q9NKIgjdScIVsBd0k
         mlGd9XP5oTZR0uDTj+Af8+8brlTo7Vli9XyL4/6rgQp/j8g3bQ7ZnzctUtoJzypR8Dmh
         lMDEfTG6bg9erxzy4TgkSoGHkh5+ahEAEuxgSiXjPM9Pl3Yn7fyCRskoqJfQBZNqZz3n
         pnlJ1nXitzWC7u2n+ZMFZTE9i8R7CxckA2okVWxjDkveJCrpt6TqRTwZMrEbdnsTuxKP
         jE9g==
X-Gm-Message-State: AOJu0YwW7Ra6q5WeNwUlE/LMRfhSN9BEmTcYODiUvaztbl0rDQ5X3ALu
	53w01Y9qdkOPbiVv/ic2DPqAFw==
X-Google-Smtp-Source: AGHT+IEG8hcDyp0gWoRii8IXwKXCaboHOibhgtrXqUfz0o9eH0Run9m/DiYief+IQmpRPYs+CAx5KQ==
X-Received: by 2002:a05:6e02:20e7:b0:35d:54dd:5b78 with SMTP id q7-20020a056e0220e700b0035d54dd5b78mr2136139ilv.23.1702119321928;
        Sat, 09 Dec 2023 02:55:21 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001cfb971edfasm3155451pls.205.2023.12.09.02.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:55:21 -0800 (PST)
Date: Sat, 9 Dec 2023 05:55:18 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: v4bel@theori.io, imv4bel@gmail.com, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg
Message-ID: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Remove duplicate release_sock()s
---
 net/bluetooth/af_bluetooth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 336a76165454..b93464ac3517 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -309,11 +309,14 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	lock_sock(sk);
+
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			return 0;
+			err = 0;
 
+		release_sock(sk);
 		return err;
 	}
 
@@ -343,6 +346,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
+	release_sock(sk);
+
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
-- 
2.25.1

