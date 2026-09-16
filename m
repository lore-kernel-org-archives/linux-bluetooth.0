Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538549B477
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573112; cv=none; b=BqFs5FDW5w6+tQm4Bm/2f0+DOWMIz2xZCewYM2EsBeGd7N4BKODmRzgF5XAY4uRBIOJmzbbyJhjOz2SgDkQ6iTV0jTkheoL23EJRL65M7rNjNAnEwqUkhc7gGBYWT3oGg7RFvPoMtINqyLG4YJsNrqu3iS2fvN8lhkH8gaH3yMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573112; c=relaxed/simple;
	bh=ISZJEItVJiQgJGUVeLdNnUbRuSbsORhE8CJvEj0f84o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joSHEev774BG9mYSTRiyBYgp11xwMJOY68XpJzHfgqjuGNn1piawBr3EHJ1C5kKG9JsbSo6Ubk3HL9RvVGJ1xP+QM1jHVFzVRMpjCV/q3j6W0ppUNXLgLgZsRPDOuAXdc3Ef1CbHR++qu8JuaTJ2jVJUijZxzCqJ9W5n97CkQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UduM5mIb; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UduM5mIb"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91a931f66so6954175ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573104; x=1790177904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TK4VaypLoqebFwLJd9cSb/TomPtSwVWfslqfBcVdmSs=;
        b=UduM5mIbVv6x2cZNSn4WjB2+JeO3Ots/73Zvlb7EPUVFYm2X87FG2SK2BlUywZEwvi
         JgCU2sfwi8IqYSlTe34y1nLwTj29RBPjSVk2Xv5T/t7cXeHTVq6yu5vPPZ9VdtWz8xaL
         Ko3DVaCzgFXo3An6E+rfA+BvD+sYkX2fRFnD2807xOv6PCIoTHiO7SwWBkA8JXLvMg9P
         JcW1JFiuACD9r9Ehelbb1vFm1pRO8bqyRD26S0vsK61SJebKKehSqyE0hQo84aDTAFXx
         zURBDBpjOeyAUjR8H7K8bgnvmAWiRF0kegkWYryplcVVjmO3pF0LdgzoNvXq/+Oyr3U0
         abeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573104; x=1790177904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TK4VaypLoqebFwLJd9cSb/TomPtSwVWfslqfBcVdmSs=;
        b=QuKWnlU8TfdgCmEG+tDeqDdwW1jffMbmzYn8ze9TK0jVgc7B2RUAsmlk8EZKzLDyT5
         kJsRLRZCp0b9epeBLvlQ+kNgJZJDfMcU3jFMoglWwiSonoAv7IU3NjuCf/FG6jNAF85P
         ohc5hFayMQQuFUdzZeA+NvCaSXJVtH4VDE3EeBAUrnRLYsFaEkAG5N5M1wgeYvIG0pq6
         uXMjELvZpdOZs00joDtW4RLM6hb4KeHgPKOfrhs4QCPq0dkeC8eP783NpJA7iWAYZShO
         JjYnetcLgUJgVxcvb3FkKtPx+s+GGGD+W+irHfJUoKVJBlKHyegI1qHq5rXtBfJglnB4
         TkyQ==
X-Forwarded-Encrypted: i=1; AKwUvByGq9tY4XNc1aR7ObsXgrn3jQifDc6kKAoOWX1q+hCvRhTIrNSs4VHwcIJ5G/1Ug2gGnbLWxh2A83X1hCN/z/E=@vger.kernel.org
X-Gm-Message-State: AFuF++m6RlCx3vv7vgj0lxuj8m43rDhlSxwx8GOHYjTcqGQIFQUIWyu2
	HOVw9cFi6rr1BI3vDAeJ8XLCZKcfo9z1T4EMxC/Fg9qdnnM1udcdaNnxr2zccA==
X-Gm-Gg: AYBFou1/RRoBfc92aF0JidUm63o4tJTdYPpiIvhSFu3el11oBkbQlFwoYlX8gfR1X88
	H3XlBudH51wDI1nf1lAgUpBHsenrSO4zalNL/zdqM2pscOuzrAHiB7hUoxSYTB10alYjT6nUrjZ
	qoUDEBWzy+8mFHOmKhvI49CtqFd/E/r7YJk4yhevTIWeJuaqd3EU8c0ilmEBkoufrwRT+V8k5Wq
	MNXXU2sFUYwknpZws9HhH26BAx15CpjsnaU1kNMJ0nw+YWYqnVmuGYco0pmO6pSgWJsm8aA+BYN
	0cdReD+u6TOER+vBZnWjGjh9Yqbr6kOjDUvLNGFD3SvxgXU5GwVDKALZUyuUHAArbQkl57Ptz/D
	+GLoY/TBptZ1awJWDMEv1P7mPiu3VIgekdExT/a6vRMU6577rA7wpRcmc62pqE/LGDs4Sv1k2F6
	RZUnRb0Zmoifu8HH0y51ZQVKcxpUj2JK5Qh4n8zRZ1jaQ/OVCyTHLpXk6U/6oXxk6Zysqqn2QQN
	7TOp1E5esl2wigImA==
X-Received: by 2002:a17:902:c94a:b0:2da:e634:370e with SMTP id d9443c01a7336-2dd8e40cfbdmr61697765ad.14.1789573103430;
        Wed, 16 Sep 2026 08:38:23 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3d29:e4bc:c9af:a918])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ebc548sm13965735ad.37.2026.09.16.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:38:23 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: af_bluetooth: hold a reference on parent in accept_q
Date: Wed, 16 Sep 2026 22:38:17 +0700
Message-ID: <20260916153818.24916-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sk(sk)->parent is a raw pointer with no refcount backing it, so a
child sitting in the listening socket's accept_q can outlive it. When
the child's channel is torn down independently (e.g. hci_error_reset()
-> l2cap_conn_del() -> l2cap_sock_teardown_cb()), bt_accept_unlink()
dereferences the freed parent, corrupting its accept_q_lock and list.

Take a reference on parent in bt_accept_enqueue() and drop it in
bt_accept_unlink() to keep it alive for as long as a child points to
it.

Reported-by: syzbot+534002670dd34a114fdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=534002670dd34a114fdc
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 net/bluetooth/af_bluetooth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393..f9aae18c6733 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -224,6 +224,10 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
+	/* Hold a reference on parent so it cannot be freed while sk keeps
+	 * a raw pointer to it via bt_sk(sk)->parent.
+	 */
+	sock_hold(parent);
 	bt_sk(sk)->parent = parent;
 
 	spin_lock_bh(&par->accept_q_lock);
@@ -265,6 +269,7 @@ void bt_accept_unlink(struct sock *sk)
 	sk_acceptq_removed(parent);
 	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
+	sock_put(parent);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
-- 
2.43.0

