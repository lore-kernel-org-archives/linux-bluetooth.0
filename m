Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3065EADC
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443787; cv=none; b=oq9cATm30O9wuuFi88gHAuyWaUkKMFVin172R01vkYJ3wpv0BhrSKBT4PxORJV4H6OKdzd9DQGyb2KsiF1lR2ar3jwheTYJxpQ6XT3NcJDOjmK2lthuMx8ilSP7CdSDt643Qaii1uUxIKhmdv3EMci6H+cE04ud3X41/D87JaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443787; c=relaxed/simple;
	bh=NlwSszoIBre9bKSK1UXhz1qJmpvA3NSXJRqmGYvgn3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnwACdthzy7Yx6hQyo9wNVWoxliLkqCXxkL5sto1dKQfsTM3mw8IaPlqFsd6DLCT9D6YoQYuT7jCcgkHdSNC9cztwdJhhewUjAuhFzPjDiQ3ogU7l8J63FWRjEcVfw3gKdb+7XimYp4/okiDw1wg9+EU7wN/uJvb9OT7sRELmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pi6gn3P2; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi6gn3P2"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14373bcbfe5so65338c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443782; x=1791048582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZR4eMpCTpuEPKX/C1QUYZ5YAS1lPSlz1YAX/XqcZv8=;
        b=pi6gn3P2j0IXDZrrG9X3DDQly2uCOiccX8JAsYeEjVLieGKgtLO0CZi9pxLopzxAkx
         9s3RYtL47z+Xd/4VCTiuETKLRS6geNvaWLWx5KFjqEkpsMRjTea/mqZnhmCjmS6rKQ8L
         J7AP9JlZ3EJLHqs2NgBkYQhcFgvEpKbeZ1QRpoaZpCovRxmvuvHtnbZ1UyxOXzhyK+Fj
         HP3bFUtP/AA5KuypFKxD8g2tkn3UFZ9MR75gP3ADwrJVlXGdkiVCVpngiOhD8HJ0iGYd
         Cy0y2ovC642C0hmOIPHu4RQ5wMAdzob4FuJ1WMNVIdUMHaygJYWAiNS2iep21v4jVMVG
         6VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443782; x=1791048582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZR4eMpCTpuEPKX/C1QUYZ5YAS1lPSlz1YAX/XqcZv8=;
        b=0A18DVI4dE05oGw82C4ww3GfnxQlOPo5D/4MTDYZ74HvBMg5XddAx49IKGB6NPcZh1
         nbxZubhGWl0LSfS+uQQRJ76S+dDQCCcb4381Z88g4lnv/PRtCX4p9T2rfwAVAMQfOyQS
         tAqHbmjS7DyNoKCCI1tIt3MJhIaQ2kF5r6ZNciTTn/AHWeWRELOUjhkhejYv/AbwX0Eb
         cpHV9qROg8ad3st2ycKSCGi5WAJj6UsaEIeoN/xOICbXc6fgJCA9wT6FsRY9g8MtTlYo
         +Va5PAIO8F7ZqVu+hUs0liw9BVfShlN7efLt6qarFoJDCsUm163W8nImWY6r1KiOGBXh
         wdnA==
X-Gm-Message-State: AFuF++mWJ6IWv9tu7lzxXaSSTTZSbZnGjdCFFMjzWMLigQ7wvvp9gqYh
	yrbgXZmo6+a9HJhW8Nwu6rCCEA1Q6HzxVNnAuoQkaVoP178AX50zh+3c
X-Gm-Gg: AYBFou2PjPyqvg5Va9KwQInzvxPkxh1Blq9KsZgY1q+YmsNZoy+WlTgongHP8eXeJl/
	77wdrqWCLelaFo+oCTmHw/bG3WuPcmch66J6LubfJqBI5sIBkYbc1PTu0r7XmrA6JoaBzQoEFlh
	zYZukT7gM/bVKHu5sn4IndKvnREbJs/HpmJngT3RB2wZ+CfU/c8i6xHYpWrxCXtQ2yL1qy7DLwz
	dCIw7tnrqC40R+GHvAFSuizJeA1DUVv/0qDcTwWoSW9KGf2StK4Vo3va3+p4vpwSkUsSm9Pcsvl
	IfpMNrz1HjalM0s5nSiiw8Mv3fEGO3p6gzjqvJuaoemxTM96tV5cUpdyfAZGxZia4GEaiGbq8fQ
	jR+UzmUght70tEgthhYIedb9hx5V4wVhBlwkeZ8tYT0WhZQrghwocplsghnz35GLc0ngSdRsRGX
	walGxBwN36qylXV646XFypUPaX3pL3GlDDp0kSYRKPzMXIdkAinSAKBJSZ/9ZVJakWzF/QTDyvf
	rUwzXphm7DobwOhJdu/gp8csiX1Mx0vSO/gV3Vx7RfNQxHggM0U74GDC7K8clhvumk9hw==
X-Received: by 2002:a05:701b:4590:20b0:147:d430:7322 with SMTP id a92af1059eb24-147d4307565mr2627681c88.1.1790443780969;
        Sat, 26 Sep 2026 10:29:40 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acd3d8eesm13125977c88.8.2026.09.26.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:29:40 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Serialize fragmented ISO packet queueing
Date: Sun, 27 Sep 2026 01:29:35 +0800
Message-ID: <20260926172935.2423925-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fragmented path in hci_queue_iso() calls __skb_queue_tail() without
holding conn->data_q.lock. The socket lock serializes senders, but the
transmit worker can concurrently remove packets from this queue using
skb_dequeue().

After an insertion saves the old tail pointer, hci_sched_iso() can dequeue
that packet and pass it to the driver. The driver can free the packet
before the insertion resumes and writes to the old tail's next pointer,
causing a use-after-free. Concurrent updates can also corrupt the queue.

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_send_iso+0xc7d/0xe10
  Call Trace:
   hci_send_iso+0xc7d/0xe10
   iso_sock_sendmsg+0x710/0x900
   __sys_sendto+0x34a/0x3a0

  Allocated by task 86:
   __alloc_skb+0xdd/0x820
   alloc_skb_with_frags+0x7e/0x770
   sock_alloc_send_pskb+0x67a/0x820
   bt_skb_sendmsg.constprop.0+0xc0/0x6c0
   iso_sock_sendmsg+0x44e/0x900

  Freed by task 90:
   kmem_cache_free+0xcb/0x3d0
   vhci_read+0x33f/0x4d0
   vfs_read+0x177/0xa20

Hold the queue lock across the entire fragment batch, as hci_queue_acl()
does, to serialize insertion against dequeue while preserving fragment
ordering.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9063..9ae1b25d7f60 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3325,6 +3325,8 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 		skb_shinfo(skb)->frag_list = NULL;
 
+		spin_lock_bh(&queue->lock);
+
 		__skb_queue_tail(queue, skb);
 
 		do {
@@ -3339,6 +3341,8 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 			__skb_queue_tail(queue, skb);
 		} while (list);
+
+		spin_unlock_bh(&queue->lock);
 	}
 
 	bt_dev_dbg(hdev, "hcon %p queued %d", conn, skb_queue_len(queue));
-- 
2.43.0

