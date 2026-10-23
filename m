Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767691;
	b=aMVrNoarpgqYoOrOvSuYKEFrHbB8fwvcRyVhOY9tlT/iLrt+4XoWCMOpFaG51saW5znC
	 DCEqmcJG6HhGWwdrbQy3Vp0x7PBWOxLbmPa0qxuKySZnBkOq9+h0hLAHnk2z1ADp9qjcA
	 PcF8urHsEK/qiZspIKJ+dum2hj5XUqva8SAXnC0w/ehtYp34kX4svM7i5VVmy+iea9tY0
	 DFxTfQhH+EHFWUytzyN4DjHubPZhwkhusXGPo75eeXhfLRe9hzkDFNjdvwjgSgsvzAz4L
	 VakCmJYg2DE3PQm25mFQ7XFRNtxNpte0fRW/PoyKYHJQWgvTSNw2AJalLtYPp99JiGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767691;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KFfSUgFVIYAX9WRth7yOHnJ2nf5NJBzd5nfvs77EkkQ=;
	b=XyGkf/jUjxiU4gPlBHVRNgk1kJv7VwauFDVjcX4bshkQouJuIGofAdA7elk7cN7K1t/5
	 cAe9vRxQV6nth3HNVRBJZ/5MhP/iSSbHsPjRrFXtEXjC6zL6upJAWag3CO42WDrHMBuBv
	 6VwJkpcpvTpALz4G7mEneA9J07Ao3X383STAYkPZD0+UUJkrHh0AHvaG62w+mSG9TakZ6
	 29JNtiK/s6aqgGluK2UtC6RuuOK0X9MSCoa8Ta5mshYKRwYnXkGFVXGfKlzAoOvcWVsHA
	 dH+lfDqPlwazBoX82afUsNXwuAtdtlRzQeWjUhBhZbb1PEDrEH9Mhv+UI0VKJwU7n1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=exZjcPmQ;
	arc=none smtp.remote-ip=43.163.128.48
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960F606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6960F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=exZjcPmQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792767687; bh=KFfSUgFVIYAX9WRth7yOHnJ2nf5NJBzd5nfvs77EkkQ=;
	h=From:To:Cc:Subject:Date;
	b=exZjcPmQa3cdACHaY+CXGgHvoGnVegL1gSM3mnHO8G5BbZu8OSVBCQjRAoKjgQrZS
	 Qe1jVMjiUfWsfUscNzHAvLbjNzC7uPdHX7APSEGKzeAZYhkgvOGLOMsgOSU89UTEsI
	 NE9MdRAOs9ZFvk0M2Ndlq2hiuMTD+Hku93r2hngo=
Received: from shuai-VMware-Virtual-Platform.localdomain ([223.88.55.50])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 59092AC; Fri, 23 Oct 2026 23:01:25 +0800
X-QQ-mid: xmsmtpt1792767685ty02f62lp
Message-ID: <tencent_311037416C6C02CC1D493A83255C1EBD8905@qq.com>
X-QQ-XMAILINFO: OM3uHlRavgX72icQZXzblrNVAqFYyu10+oGcRz0bdDKkw9KvHOMp45aJMqmbr0
	 LECtflV3soEofCJT9IweBKaIEusVpNE1DQfNeAAACodIfFc9TKksZkj53sLJFTEFR/S5Bbesp0Lp
	 rlH+9g2HwgYCQICdcvTi91PnHBAZAQxoPOb3eViEbX5em7nBqZhB59ElthpYZ3nZI4KuB+v7lbcF
	 xOwlTJuKr8xRSwXb01i4oohR4IcAljUVeavJFRbYBOC+1M0yuzpb5J9sT+PRQVr8Za7pi+7oyONb
	 N4aGG1TjpMN/x/o+dE88DLTFae6VECRHg5zOYNL7Ewa8IC7J26AMqopCdf02n2xsOeAQP4LrT0IC
	 czEjWgkEWBsEueoyCPmPmPgFUNS8z73l4J1voG1VAMeDTemOd8ioOR8zcvPfVGERICiLCOyBVsOn
	 ASgUD3rpwn+Y/6w3AI7d0HX0YeN8cjuvgGMbQqvmylEIyU5kyR4Gs0hMrn0wlHRKHAfq87soJ0cG
	 ZW/83UHfDEWPr//Zfuu+HGTd+FYM3wmkvaPMN9p58S+eWcK7S9yri05vg57WMly7zQG+hOECfKW5
	 3G4yYoqcPzAGIyTyjYYo2fo/8KqaSJVDUg1aS0H3Kb6zXdnGOmTM8s2+cshrjd5UGu1c5egIRp/f
	 Ib0X7E3FNt1NPtPr1sY4bZ/5EFyeNAVWLLyRCilPd0+MmBSUQaI0Gy5QV5rac+bGoFkp6ZOGd/YQ
	 RlF32slSOCY+9gAeKhr8I8UUmXkFTidCCMUoCi8kw9sJZImfZe8O6e2iQ19S8frn7s9HTK3ddERw
	 3d96kaBxp7ycSjefT+m/AAts6KJa8XCz53zF5sTqT0uh2XXxzaXcl4Rkgudo1TMrJPV+FJE3Pu1a
	 wj47D/HlXy4Wp7IWcl7j/YK+zi+xojfLzfnH9x43p1V4dFlmf/XCP679+57/PKma5vBrNNWDh72F
	 mHv2jW1w6OZ49KwbFRe9kD+iBI/XM8NVHqZjlNIln0e/eZeyv6N5aUtZHOfrUxSm0qLN948BVXs/
	 r6TF9O9B6L87rQxaN2boNm9D0ETODa9juGcO58mL9gCFka1CN/kxNzDQVeS/5joG9CU8QH6s7wPd
	 4TaOgdvbUm9/E+gVrNsuCooQYSwp6fgnPPAFz7
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Shuai Liu <847807867@qq.com>,
	syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_core: Fix queuing rx_work after workqueue is drained
Date: Fri, 23 Oct 2026 23:01:24 +0800
X-OQ-MSGID: <20261023150124.296524-1-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_recv_frame() and hci_recv_diag() queue hdev->rx_work unconditionally.
They can run from the driver RX path (e.g. vhci_write) while
hci_dev_close_sync() is draining hdev->workqueue (HCIDEVDOWN racing with
a driver write). Since that queue_work() is not chained work from the
rx_work worker itself, __queue_work() sees the queue marked __WQ_DRAINING,
warns "cannot queue %ps on wq %s", and drops the work:

  workqueue: cannot queue hci_rx_work on wq hci0
  WARNING: kernel/workqueue.c:2436 at __queue_work
  Call Trace:
   queue_work_on
   hci_recv_frame
   vhci_write

hci_dev_close_sync() already sets HCI_CMD_DRAIN_WORKQUEUE before
draining. Route the rx_work producers through the same guard via a
shared hci_sched_rx() helper, mirroring the existing hci_sched_tx()
fix for tx_work.

Fixes: 525daaea459f ("Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close")
Reported-by: syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2344fb8002f3ef5b1712
Signed-off-by: Shuai Liu <847807867@qq.com>
---
 net/bluetooth/hci_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd9391..dd6bc1628bca 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2892,6 +2892,17 @@ static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_skb_pkt_type(skb);
 }
 
+/* Queue hdev->rx_work, unless hdev->workqueue is being drained by
+ * hci_dev_close_sync(), which would otherwise WARN and drop the work.
+ */
+static void hci_sched_rx(struct hci_dev *hdev)
+{
+	rcu_read_lock();
+	if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+		queue_work(hdev->workqueue, &hdev->rx_work);
+	rcu_read_unlock();
+}
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -2945,7 +2956,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	__net_timestamp(skb);
 
 	skb_queue_tail(&hdev->rx_q, skb);
-	queue_work(hdev->workqueue, &hdev->rx_work);
+	hci_sched_rx(hdev);
 
 	return 0;
 }
@@ -2961,7 +2972,7 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 	__net_timestamp(skb);
 
 	skb_queue_tail(&hdev->rx_q, skb);
-	queue_work(hdev->workqueue, &hdev->rx_work);
+	hci_sched_rx(hdev);
 
 	return 0;
 }
-- 
2.53.0

