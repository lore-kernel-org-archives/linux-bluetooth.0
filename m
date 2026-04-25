Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458339D6D5
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777121769; cv=pass; b=f4tJDUXIZpJKa6x1sxRiRHKQU19CCd4UrqUXkfB+o0e2y7BKLP6van9hSIuy1AGtfjUYIGqWWp8Mf6Y4dhuxLA54eRLnRluliKBHcwIlhJMDB05lP2R+Dg6r/c30zk1FJ10Yb2dPdX7dle2HSCKueu7Yz5plg7CCfk6BknM4IoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777121769; c=relaxed/simple;
	bh=J78BG+6Vr3/BREqH8LEBG5R47nqvMu2JRLpZ4lKyayU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOPbjmuewBSsu455RLi8fQknnPszxEf1jL1aRmtu4OLyCGd+UUti4mO8Q8XRR6+zQzLPp439ZQo7uAturR/mYqXf83UaU5rZX46oVnAWbuYnbtEy04tn6QWSoBYULTFeV5X2mgp4R4F3fJAinlOsXPK3JjcJnZra1D4gqOTrCLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=aKMtkm0E; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="aKMtkm0E"
Received: from monolith (unknown [193.138.7.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4g2qZW6WSBzyQH;
	Sat, 25 Apr 2026 15:56:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1777121764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SZuM00xQCJ9SQ2uX+LJVCZK3MPfrZawFfZ2Xb8E/2s4=;
	b=aKMtkm0EaI52qzj7Tl97eYU70YCX3LuTbA5qnhu/EIXueIjFgswiPxU8QYIbElGW2/tniS
	tsTuQaQxLYEuBSIat+ESy568ELmRXWbo57pnTwtsgBs+sFen04cYuC6V4PR1a/84YCwq8m
	vZDvqLXCBp262QebZ89qhCzDs/fT6SY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1777121764;
	b=C8USSztDHHl4b0/mNjUxEpE0vabil+YQZ6KJlJ0m6LYUhrV2a72jMY+b1yqY+DdFxhNKVr
	gopjokNI8PkyQmtCwHXjh6Lp1ZbQyuaj6XUgwhDoYxP9ZGA1IwXeP0hn3aZJmUTTsGi8JT
	2SdrCCHRQklVfcI8ioonGSelisrG3fg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1777121764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SZuM00xQCJ9SQ2uX+LJVCZK3MPfrZawFfZ2Xb8E/2s4=;
	b=xc6OBqPcbyfZtUChCGiipyP5Niu1l3RHNRkCMiAB5D7sg5xJkI0AqyrML93EtdCZmIfzpA
	PJP8zhGu/8fICDBrVqFTSTxF07i2/Ww8V4tALwJI5frK/wDO4XFpRKx7xXs5TH+S5uekAF
	NP2TBfen40C2+7pIIBgn74SLlu4SzgM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-mediatek@lists.infradead.org,
	chris.lu@mediatek.com
Subject: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Date: Sat, 25 Apr 2026 15:55:31 +0300
Message-ID: <621d8a2b651aba8e3c2197017ca94f06ec77b824.1777121590.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With MT7925, received URBs for ISO have urb->actual_length of
MTK_ISO_THRESHOLD (264) and contain ISO packet data followed by zero
padding.

btmtk driver ISO handling added in commit ceac1cb0259d ("Bluetooth:
btusb: mediatek: add ISO data transmission functions") assumes the data
contains only payload, and generates bogus packets to hci_core from the
padding, resulting to printk errors "Bluetooth: hci0: ISO packet for
unknown connection handle 0"

Add check in btmtk that a new packet is not started if we have only
trailing zeros left in the URB. If so, skip them and emit an error once
per hdev, since this doesn't seem to be the intended behavior. This
reduces spam to user logs.

Limit this behavior to the 7925 model.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - limit this to the 7925 model, as that is the only one tested
    
    If there's confirmation from Mediatek the zero padding instead of short
    USB read is intentional, the warning is not needed.

 drivers/bluetooth/btmtk.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ab34f1dd42bc..934daf004dd6 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1088,11 +1088,34 @@ struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(alloc_mtk_intr_urb);
 
+static bool check_isopkt(struct hci_dev *hdev, void *buffer, int count,
+			 int pktsize)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+
+	/* With MT7925 we receive URBs that have size MTK_ISO_THRESHOLD, with
+	 * trailing zero padding following the ISO packet data. This appears not
+	 * intentional, so flag an error, and skip rest of the URB to not
+	 * generate ISO packets from the padding.
+	 */
+	if (btmtk_data->isopkt_rx_pad && pktsize == MTK_ISO_THRESHOLD &&
+	    count < pktsize && mem_is_zero(buffer, count)) {
+		if (!btmtk_data->isopkt_padding_seen) {
+			btmtk_data->isopkt_padding_seen = true;
+			bt_dev_err(hdev, "Zero ISO data (only first reported)");
+		}
+		return false;
+	}
+
+	return true;
+}
+
 static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 	struct sk_buff *skb;
 	unsigned long flags;
+	int pktsize = count;
 	int err = 0;
 
 	spin_lock_irqsave(&btmtk_data->isorxlock, flags);
@@ -1102,6 +1125,9 @@ static int btmtk_recv_isopkt(struct hci_dev *hdev, void *buffer, int count)
 		int len;
 
 		if (!skb) {
+			if (!check_isopkt(hdev, buffer, count, pktsize))
+				break;
+
 			skb = bt_skb_alloc(HCI_MAX_ISO_SIZE, GFP_ATOMIC);
 			if (!skb) {
 				err = -ENOMEM;
@@ -1250,6 +1276,15 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 
 	spin_lock_init(&btmtk_data->isorxlock);
 
+	switch (btmtk_data->dev_id) {
+	case 0x7925:
+		btmtk_data->isopkt_rx_pad = true;
+		break;
+	default:
+		btmtk_data->isopkt_rx_pad = false;
+		break;
+	}
+
 	__set_mtk_intr_interface(hdev);
 
 	err = btmtk_submit_intr_urb(hdev, GFP_KERNEL);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c83c24897c95..bd97e37afd99 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -177,6 +177,8 @@ struct btmtk_data {
 	struct usb_interface *isopkt_intf;
 	struct usb_anchor isopkt_anchor;
 	struct sk_buff *isopkt_skb;
+	bool isopkt_rx_pad;
+	bool isopkt_padding_seen;
 
 	/* spinlock for ISO data transmission */
 	spinlock_t isorxlock;
-- 
2.53.0

