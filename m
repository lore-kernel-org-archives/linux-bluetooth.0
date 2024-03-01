Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4B3A1CE
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319041; cv=none; b=M4XShkH3it/hu2ACtWTvhjY5WHd/zZuLg6dwHQQu2uUM3xwqWcc5pFEXmercTOY59Iy/JIiQtxgji4B7ToyIsV1PUZbCxXLLNxr+0frRAHRyZJqPbHTGbvhfvnaY5c6KeueXV6kZ8F6KhlcS8re85eprnkLSrj1q/RWQ61ZC42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319041; c=relaxed/simple;
	bh=xuye60bvSGZ6o0vzrJzUgSm3W36dDGK3ghlJZu/0Krs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OvABAZLCeXoMJoiN6D2ukfunTHPo7eRW4bOojuF6xL+r51Q/uZVMW+NcdmozNRE3Hwos1qW50BKktncLdJuqMKhx0NQA9th0fuWPsH5yJdFAqtoOrdhKmDOw0DyXBfGtTI/wFeKXiRLPvc8DmeTigneluNLv5rvtK728nAQvI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R44CAi9/; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R44CAi9/"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7da6e831958so659526241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319038; x=1709923838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TE5bn+C2B9Bj3KGIBfc2vBOiz9vkYoPpr5eFjeqE7bY=;
        b=R44CAi9/nQ0mnxHRKLt++eTfzey44xt+S4A9N2nTp1zKBbcsTIUac8v+8Db7+j8lyv
         zE3bledk+9/3HXRUyUubjHNgTXwqS0wbsiWb/lCTtg4cgIOf2J2ZUE0gfnZ6hgA0VY+B
         pKpV7W6Xnqk+R/ToZtePZsV3vuZJh8r8GMyZHaNn4g2ZOiJa6PDYAfW3mQHSwJ1boMXn
         nOd0Oze38dLkvvwmEAl1eszD4CNTZ022eHsM09kDdgSwVVtEVYFj+6cFN7gIY8KjwbeV
         4WoSsvyJ7JfUvxYeEew1jW6VZ4N29sXjyyld3Wonl7Rk6Aup9cV3wS/sq9CKWeVypCSq
         7H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319038; x=1709923838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TE5bn+C2B9Bj3KGIBfc2vBOiz9vkYoPpr5eFjeqE7bY=;
        b=IudZQ88ysS7mMIpL+AXxLHopGFSQLpyIk6M8TqDGlcD9JwIBiCqYEV+QrVjZzhGbg7
         chU/SDYZwHJjQEEnforYHOufN6SZ5I8RgmMmX8EQzXc0HcHGwVdBUEkSZYbg1v3iodh8
         EBr3jrIYdXgWA0r/FmJIcmStV9Ee9tp9aLhdmrAWbH8mrPCCc0bZOWPa1iGYGpjdMZmT
         ojq2a0lFhC+B1JrdIDLzWJMTN3EOfcGn1Osx/L4dnUJB/qbDrFcvP2+tz1BbfnLJwMu6
         3whpGFcj92wsI5x6Zhh+hF9AylCpBSc7i96zEfjRNudYf88nHJxqNczOkTWh+5aNiiTx
         W3hA==
X-Gm-Message-State: AOJu0YypJBjdpidCqWO3+rAick7rbLQ5gtmTfnSeUqLjbMuU4prhBDeJ
	EfaxTnj0XhIi8kycTYBCfcTRroDDnEBi09Ber/HlIPHf1PBDDcB4IS4MONYp
X-Google-Smtp-Source: AGHT+IEicbpa/0cqe/sTkgDQ4+7l8zLNI0aKyojAE/7TWl0EYX5Dg3U44kmXzU4D8ZzFwJZZuotRIw==
X-Received: by 2002:a67:eac9:0:b0:471:e8d5:8c8c with SMTP id s9-20020a67eac9000000b00471e8d58c8cmr2647163vso.26.1709319037211;
        Fri, 01 Mar 2024 10:50:37 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ic12-20020a0561024b8c00b0046eb7f99601sm468396vsb.20.2024.03.01.10.50.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:50:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: af_bluetooth: Fix deadlock
Date: Fri,  1 Mar 2024 13:50:34 -0500
Message-ID: <20240301185034.2756103-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Attemting to do sock_lock on .recvmsg may cause a deadlock as shown
bellow, so instead of using sock_sock this uses sk_receive_queue.lock
on bt_sock_ioctl to avoid the UAF:

INFO: task kworker/u9:1:121 blocked for more than 30 seconds.
      Not tainted 6.7.6-lemon #183
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __schedule+0x37d/0xa00
 schedule+0x32/0xe0
 __lock_sock+0x68/0xa0
 ? __pfx_autoremove_wake_function+0x10/0x10
 lock_sock_nested+0x43/0x50
 l2cap_sock_recv_cb+0x21/0xa0
 l2cap_recv_frame+0x55b/0x30a0
 ? psi_task_switch+0xeb/0x270
 ? finish_task_switch.isra.0+0x93/0x2a0
 hci_rx_work+0x33a/0x3f0
 process_one_work+0x13a/0x2f0
 worker_thread+0x2f0/0x410
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe0/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 2e07e8348ea4 ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/af_bluetooth.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b93464ac3517..67604ccec2f4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -309,14 +309,11 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	lock_sock(sk);
-
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			err = 0;
 
-		release_sock(sk);
 		return err;
 	}
 
@@ -346,8 +343,6 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	release_sock(sk);
-
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
@@ -570,10 +565,11 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		if (sk->sk_state == BT_LISTEN)
 			return -EINVAL;
 
-		lock_sock(sk);
+		spin_lock(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
 		amount = skb ? skb->len : 0;
-		release_sock(sk);
+		spin_unlock(&sk->sk_receive_queue.lock);
+
 		err = put_user(amount, (int __user *)arg);
 		break;
 
-- 
2.43.0

