Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467D1339A4
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114191; cv=pass; b=Mx138UXCCe6FknQ9ubrdViYG8wllHvm+8p59fJk93ehzFvFSCwu1WldBuKnD6dcVcLXsx/R7k75s9/jAGQ4nWmustKn5bkt/bNhbKT4Ekh03DNslCr+Lu/1Ib9L3s4ZDIDN6oFh9O7pcSClfaL1qryJSFNXKRIYxzGEak2c0BJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114191; c=relaxed/simple;
	bh=NkuKgrRVIzhBFJUFOBlO1H9NkQsjda1mqtu3nrdcvMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2vpBOQC0qudq0zXnv6tXlpZPGOt/+0JtpHwWtNUTJzdOwHzC3rA8JDjJodPdsmu1L0EefMtsZg86UEvEZkxwC5h7cQxSLAbbnugSQUdu7NCdjhdTdbA7pcoL+j7LtYPvSBtj0MFcVyJadsmd/UObm8iD4kwmyGAPGU7pObJCL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oOk5CuEh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oOk5CuEh"
Received: from monolith (unknown [193.138.7.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4g2mmn3GqjzyWV;
	Sat, 25 Apr 2026 13:49:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1777114186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R0RDApUvTDSQuO7JvFyT884tiIpjJP6ULN7AmzTd54M=;
	b=oOk5CuEh2p11ar3Hj96LElgYwPOO+nOZp8pGkvUQ1bKLAE0HUCpEyrHyacZleyDBcyj5/b
	z++sURvlNrEAouFD8oIqXMsrJZKyyztOyyYZmmL6NRFFBhU/UHKlBEUVHFkICRCfoFz5Ed
	z/WVFuPR8+cLKkE5Bb/t3ZSSwIZVyl8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1777114186;
	b=JCFxzYzOxuy0+oes+EdVVODvdTy4kxdVGjZsfcV/NRUav8D+3sSTl1zqM3tkt5QTW/0f9D
	U0Ytqk1vwsEdmnBl3gpr74t9uVW12W2AjTVE1XoEZZJScXTZrxDVRejiPtKuRqHNGodxsu
	PtNT6IK+aEVsZ+lN2WgrqKIC/BYn2Qc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1777114186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R0RDApUvTDSQuO7JvFyT884tiIpjJP6ULN7AmzTd54M=;
	b=Zghijovk9HiOuly/GCfsCHI2dDpdM6veVsFO3AJQOngrYgjtNSUcfbJP/7fUYf4p7cYUqT
	kMSYliTqxqTQv+yZGpv7lZa28IBsubHlWUw/WzIjLTnDKFbh5dngw8mNMaSoULRoqLo15x
	YNtcgHALAl4leyfBRWLnzfBRkuP4Xag=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-mediatek@lists.infradead.org,
	chris.lu@mediatek.com
Subject: [PATCH] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Date: Sat, 25 Apr 2026 13:49:13 +0300
Message-ID: <8f988c1ccaaddf60c259890a2ca636830f7e4578.1777113390.git.pav@iki.fi>
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

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    If there's confirmation from Mediatek the zero padding instead of short
    USB read is intentional, the warning is not needed.

 drivers/bluetooth/btmtk.c | 26 ++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ab34f1dd42bc..397caacbe9fd 100644
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
+	 * zero padding following the ISO packet data. This appears not
+	 * intentional, so flag an error, and skip rest of the URB to not
+	 * generate ISO packets from the padding.
+	 */
+	if (pktsize == MTK_ISO_THRESHOLD && count < pktsize &&
+	    mem_is_zero(buffer, count)) {
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
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c83c24897c95..46fbdb98a716 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -177,6 +177,7 @@ struct btmtk_data {
 	struct usb_interface *isopkt_intf;
 	struct usb_anchor isopkt_anchor;
 	struct sk_buff *isopkt_skb;
+	bool isopkt_padding_seen;
 
 	/* spinlock for ISO data transmission */
 	spinlock_t isorxlock;
-- 
2.53.0

