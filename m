Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B569411A00;
	Fri, 11 Sep 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123370; cv=none; b=AdVTgtlPHeX/dwjMv0FWD65l6ukA8ko9dflaVgj0e7hbDHBZAnm4n1ysYKWgtKMXO4LTynbZmsPNn/+BTeJHzAl6a5V46xN8RY7rwUg6MqJsPRZsXaipXkN4QpRX7DMwLncg7lvhjGTjKH5MEvjfx55Qps0BJmeOQE6JOrWdo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123370; c=relaxed/simple;
	bh=q/lVAk7JZlfzR5zP+kvhDsqByrrvyU+Qfh6rN2qBcm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adizhMA1/l7OGf9QX59AlZTgjgnfc/yYWjEdSQ4LBVtKngB/PfTx+vWgJWS/KiPdaaJFSQ7mrIsJwn+diiNFWGhdsNCsyLtOM7YvapjbDeyNQrSNR+vNRPXcTkPg597gbX5k+hrm7HKZRtoI7phY0mcEstbNg/S7/ckqP4chCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rqZdzF2Y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rqZdzF2Y"
X-UUID: 81d78062adcd11f1b1788b6acf885367-20260911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nGFTkEwYB6tHniCOU10/jNmsJ6sUyQiWxjI5epJSI60=;
	b=rqZdzF2Y5Uj5NlmNphAVmQrqESrKGOazZFyQ02x6uYArpst/tdixlc5Mb43gmqrzhlyQKLpIoikyqKDMIwk6KWtF7AQ14bo0ydj4uPWM3tuSy0HDizwUH8NgfNHv2lPf2DYtXtMIFYC8aZyPrGT8Lq1NYLZdRqNQ+QwMsNddTWQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f49ff773-4fcf-4ece-89a6-0a5236ad4c26,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7d5964e3-ea51-4dda-a022-9ba6608a11d1,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81d78062adcd11f1b1788b6acf885367-20260911
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 337214274; Fri, 11 Sep 2026 18:42:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 11 Sep 2026 18:42:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 11 Sep 2026 18:42:37 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 3/3] Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access
Date: Fri, 11 Sep 2026 18:42:34 +0800
Message-ID: <20260911104234.2276126-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260911104234.2276126-1-chris.lu@mediatek.com>
References: <20260911104234.2276126-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio.c and btmtkuart.c cast a received WMT event straight to
struct btmtk_hci_wmt_evt and read its op/flag fields without checking
the event is long enough to contain them, unlike btmtk.c. The
FUNC_CTRL case then further casts to struct btmtk_hci_wmt_evt_funcc
and reads its 2-byte status field, again without a length check.
Firmware that sends a short or malformed WMT event makes both drivers
read past the end of the received SKB.

Mirror btmtk.c: validate the base WMT header with skb_pull_data()
before touching any of its fields, and when a FUNC_CTRL event turns
out to be the short, header-only form (a plain enable/disable ack
with no status word), decode the result from the header's own flag
byte instead (0 = success, otherwise failure).

Verified setup on MT7920, MT7921, MT7922 and MT7925: no regression.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Fixes: e0b67035a90b ("Bluetooth: mediatek: update the common setup between MT7622 and other devices")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btmtkuart.c | 20 +++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fe4ca9395aa3..a8ebcd0c005c 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -217,7 +217,14 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	}

 	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)bdev->evt_skb->data;
+	wmt_evt = skb_pull_data(bdev->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   bdev->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -233,6 +240,17 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(bdev->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			/* A plain enable/disable request is acked with just
+			 * the WMT header and no trailing status word; the
+			 * result is carried in the header's own flag byte.
+			 */
+			status = wmt_evt->whdr.flag ? BTMTK_WMT_ON_UNDONE :
+						       BTMTK_WMT_ON_DONE;
+			break;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 27aa48ff3ac2..4af6fbbbd302 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -151,7 +151,14 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	}

 	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)bdev->evt_skb->data;
+	wmt_evt = skb_pull_data(bdev->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   bdev->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_wc;
+	}
+
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -167,6 +174,17 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(bdev->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			/* A plain enable/disable request is acked with just
+			 * the WMT header and no trailing status word; the
+			 * result is carried in the header's own flag byte.
+			 */
+			status = wmt_evt->whdr.flag ? BTMTK_WMT_ON_UNDONE :
+						       BTMTK_WMT_ON_DONE;
+			break;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
--
2.45.2
