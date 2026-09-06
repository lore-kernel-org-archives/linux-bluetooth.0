Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85D30EF97
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708096; cv=none; b=QSfZV9InKzCdc4Kbh1iYQW5RWVQPJi9qDcVzWuAomWvN7dkJw/EibVrZy7ghJ3Y/CHOAbZB6VCZiRmPsjsl1HzC2PeidVHtp1QXm+3SjGcnuDqKpcGjtin7oXikct1i6loM/D31ZFHm5CcfrBrs4xKOhrPf1qoqKaNVfLWOYkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708096; c=relaxed/simple;
	bh=lLyxlJfRE39Tj+iJIm02qG9HnuwjVSNBq6tbsH9GWpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caS5HDvWYaUp2hEBbNXJLeF/ql+o5IbwewQFY0vLvIvt3ALjcfXDPkH5FZn/XbMRl7QVhJOkd5XWbZcNohWZaAihJZpGig/oBc4XwoJw3lC0EKwuOFC+Od2VrPLGyRSibDXHxE+9gFTO4VP53+pTXlqpgkQCtYihVN4/EA3tCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCYDcS2E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCYDcS2E"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so27869665ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788708094; x=1789312894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=abDPKRanrTrYguIEAEG/83Z6cCjRN2d65bDHkDSxwTM=;
        b=WCYDcS2E3tkunajC6AAIFWDltVthRnhSPzVj4GLy15khYzViMxFL/CqKothmLuoZxi
         euDBsP5xfvge2jj2ECPg87xblnw1bQNcuGKH432Ns1xkq797ZQVOg7r0EgfbOhEEJ+Wv
         BMOjCSUJYNvdXAzN5kkBGg1WyGLTavHRGBTtcUNB6sOzVttCGjz19rMrWEeIF/dFZuvv
         nPTPfyMakgYV80/DJ0U0kO0IuQoPDdWWpQhbHuZqFw6+WOwsFGHJMoxXIOWIK4aMQhj4
         yu23P3psfsQ8HXb6pmUmstoYNv03dPjFXQ4FDUhgHLAlS/C/eT8BylPzY7fYUcD/aGwM
         qePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788708094; x=1789312894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abDPKRanrTrYguIEAEG/83Z6cCjRN2d65bDHkDSxwTM=;
        b=fumm2pB8EZB2NcEBeJql2V9InM1EGNWnFOT2teSaqGQ+5zPBmQMq/87/kmRTw9SBUe
         vIPIGieDFzxTPyqlQejugS1HQ4p+lYfNy2rPTev+T88Qu3/uOJ5QUa6kjPm+E1Z2pxvR
         HKQlbWja6TtGHCC1lRv3V1uUDWv+1+Y5b7QDzBnE05P4sAxiIXKGvLPgQwNmtAME87yo
         uXSBkCbqStQRzdA5RFLL/K0U+r9qcbKJAcMWw7ow0AGH3yIbV0LkGj3HVRRwjdrDT+Vy
         kOZwKTMCsZRG7Cj6U4zZPmBS5lT7l16J8yNBOhkuJU6nff24SYUrLvoD+0mYxpfafLaZ
         1eng==
X-Gm-Message-State: AFuF++kjPPqmQ3n6JEBNqzupbKdXtnQ1U4C7L++nWNMm1xT+ojnD58NN
	WKKT0kNPewd9ZUbNjKtXQdj69ts2J5Xm1qzRZVJMS3ywzZzRJygtNffursL6gQ==
X-Gm-Gg: AYBFou15t/SZSofcXdYnSaXY5G3Zjf9Ex31vcL5E0dI0RiDf9l2gZ5WAYisJBAfgX1c
	T+DPqsxH8xx822A+6C8pzCukPbfM1imJRQ8vp5d8KTJcMSiuERHtI/wtgZ3mNqmgwSLfqq/lCVT
	/U50GTdGnLDIscZ2jKEZ9EQf8egkxWFlWfHF2Tjd2Z49CF6NVzaJknkpTNgYje9HFBrIf6Eoq30
	mFeLZp2tMYiJI5Cw420MQ/VyuljzV5o43GXL9pavm1wgseeOhXfZvqOasXfq5/qh9lcJKdmRAbF
	Ag9cOJbnIs11ha6sW1vJKyGcqSCyANpcEbNrjUQ4Yj/at6rS9rZrKn1z6Sr4ltKlq4MRxslNT2G
	nQk5lWrKN7uPEllDRWmXriAClelCp90eD5jxlX2eQ0qbuyJTgE5y/HkQl7UvQXBXzEwIn5YF8uY
	JjUxJlUNzlOvSsu6WGL6mGlVEIbWOxUJgZwoRR91+BV5Aw6VirxMnNrpLHrHazWZn2yeD8P0+xD
	pi3frF5oAE+wMxeYfU=
X-Received: by 2002:a17:903:3247:b0:2d7:2edd:d140 with SMTP id d9443c01a7336-2db1232e1cemr260326515ad.3.1788708094006;
        Sun, 06 Sep 2026 08:21:34 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:7bb9:b8bf:8aa8:fb0d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149591a0sm33456055ad.26.2026.09.06.08.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:21:33 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ThangNN99 <ngocthang2710.1999@gmail.com>,
	syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained
Date: Sun,  6 Sep 2026 22:21:27 +0700
Message-ID: <20260906152127.90734-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_send_acl(), hci_send_sco() and hci_send_iso() queue hdev->tx_work
unconditionally. They can run from the L2CAP/SCO/ISO socket send path
while hci_dev_close_sync() is draining hdev->workqueue (HCIDEVDOWN
racing with a socket write). Since that queue_work() is not chained
work from the tx_work worker itself, __queue_work() sees the queue
marked __WQ_DRAINING, warns "cannot queue %ps on wq %s", and drops
the work:

  WARNING: CPU: 1 PID: 5985 at kernel/workqueue.c:2352 __queue_work
  Call Trace:
   queue_work_on
   l2cap_chan_send
   l2cap_sock_sendmsg
   ...

hci_dev_close_sync() already sets HCI_CMD_DRAIN_WORKQUEUE before
draining, but only hci_cmd_work() and handle_cmd_cnt_and_timer()
check it before queuing. Route the tx_work producers through the
same guard via a shared hci_sched_tx() helper.

Fixes: 525daaea459f ("Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close")
Reported-by: syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 net/bluetooth/hci_core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 35a1be57e386..09cd49b9a939 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3236,6 +3236,17 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	bt_dev_dbg(hdev, "chan %p queued %d", chan, skb_queue_len(queue));
 }
 
+/* Queue hdev->tx_work, unless hdev->workqueue is being drained by
+ * hci_dev_close_sync(), which would otherwise WARN and drop the work.
+ */
+static void hci_sched_tx(struct hci_dev *hdev)
+{
+	rcu_read_lock();
+	if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+		queue_work(hdev->workqueue, &hdev->tx_work);
+	rcu_read_unlock();
+}
+
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = chan->conn->hdev;
@@ -3244,7 +3255,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
-	queue_work(hdev->workqueue, &hdev->tx_work);
+	hci_sched_tx(hdev);
 }
 
 /* Send SCO data */
@@ -3269,7 +3280,7 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "hcon %p queued %d", conn,
 		   skb_queue_len(&conn->data_q));
 
-	queue_work(hdev->workqueue, &hdev->tx_work);
+	hci_sched_tx(hdev);
 }
 
 /* Send ISO data */
@@ -3340,7 +3351,7 @@ void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
 
 	hci_queue_iso(conn, &conn->data_q, skb);
 
-	queue_work(hdev->workqueue, &hdev->tx_work);
+	hci_sched_tx(hdev);
 }
 
 /* ---- HCI TX task (outgoing data) ---- */
-- 
2.43.0

