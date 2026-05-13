Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEF3ACA43;
	Wed, 13 May 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698596; cv=none; b=Ark+VjkcA8GaLgQfCs39x2vVijPZBZ2P+zZxi/ACC7uGqKD63pg40FDchP7wnaqnCbClWVxrrxFTF3ry6gqpth204rJJqa1asB/J2x5YAzsjUBnQcxX0TwBLcXqJFa29alaqj9fk6yBFYq8u7HYSi/geznWfpCBBfKx7zHdTX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698596; c=relaxed/simple;
	bh=w6GLU1QWnWXVcH13iWcyIkNryJyiygPRfwYCrbG+NPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jXfYaXERvMHoe2vEG4o9QYO9dguy5XP3IhkW9sx+Gb92agKmZjK2Bv+T0NA9tS8WWDndkGagzzW5GlUOwqTp1aSiHEPXgV10YOcvKjV7QRVVOmj8rvV83KM/fJzRFpldnr772F201MlPDRulOKkH2I+pW2jEAcN2rHxIPDlEIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lW7pxsK8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lW7pxsK8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YWKyEvPS9YYJo6Vfcy/T7LXw6l87JIRxlNyOtO3cngQ=; b=lW7pxsK8QnUIbj19EHNjAZAZxs
	FKX4R7GT3+Lkq68qfO39RmlriVGVD3dIZNXGvzc5QrjYMsLhdQGAANCKLo2xIUhnsv5vsdjL54zbL
	6Ru/KRe/AVFSQNiwfOCiinOcvZF1kkwELKDl6tuZe2mC7acIHsSz8ag8h0emG3NFWV4dtAidlK7Vh
	pRBh4P5+Y33SLprgXEh3WSzZpNSAyJkoq9/ciyarVcOTB+F1twhTLRlpTTzUEUPFU2gSCe72nhHZI
	100ZSKvsuEskpFIzVjGD3eJGpMLZ3+jS893D4L79fNU3PEbStS/K/mNu/EzJT+M8KDwMNx8CcRlTH
	J0/tpAEQ==;
Received: from 177-136-93-131.vmaxnet.com.br ([177.136.93.131] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wNEko-00A6FQ-5f; Wed, 13 May 2026 20:56:22 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Wed, 13 May 2026 15:55:23 -0300
Subject: [PATCH] Bluetooth: hci_core: Don't queue tx_work while draining
 workqueue
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3YzkzPji1LwUXTMTAyNLg5RU88TkZCWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQBLU7D6bAAAAA==
X-Change-ID: 20260513-hci_send-640290de7acc
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gustavo Padovan <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2

Syzbot reported a warning when L2CAP calls queue_work() on the hdev
workqueue while it's being drained. This can happen during device reset or
close paths for hci_send_acl(), hci_send_sco() and hci_send_iso().

The workqueue is drained in hci_dev_do_reset() and in hci_dev_close_sync():
  - hci_dev_close_sync() clears the HCI_UP bit before draining
  - hci_dev_do_reset() sets HCI_CMD_DRAIN_WORKQUEUE before draining

Add these checks before queuing tx_work, and free the SKB if it's not
queued for transmission.

Fixes: 3eff45eaf817 ("Bluetooth: convert tx_task to workqueue")
Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97721dd81f792e838ba0
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/bluetooth/hci_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c46c1236ebfa..5d5f8ad7d1a8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3278,6 +3278,12 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 
 	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
@@ -3291,6 +3297,12 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	hdr.handle = cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
@@ -3374,6 +3386,12 @@ void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	hci_queue_iso(conn, &conn->data_q, skb);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);

---
base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
change-id: 20260513-hci_send-640290de7acc

Best regards,
--  
Heitor Alves de Siqueira <halves@igalia.com>

