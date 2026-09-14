Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324538D40B;
	Mon, 14 Sep 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369027; cv=none; b=T7xz7MMTgMOYYMRPR+64+ZD4g3cJ+EEZWJSCs+JwAZe9kuQjsAygpANbp2xIGUCVccp9F48X/VGim6t97idgn842IF4RleMCpFQV55hBGGmD0DPN9leR15nFI+Re+bcuxwE36qGbate2XBbOaNeTBnlm6/pi161LMNHin4Ad6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369027; c=relaxed/simple;
	bh=InWnSchOFmtnDRRPOkDjuk0ggAfdGCXzi6qozZkDWfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHyTZx6SXdH1hEI3L2OXWffov8P9vTAc/2QevJyN1+IfGsKq50dCNPwJN8yNNl6tb1LeVUxkAb9eghfPTsJPGktW0tlAgVLXPZtvY5DCJA6MnFHlvO9yOK48PzUVxgEmt3Pn09uLnnWLwAwZSiOt7LE0mpJPDVQx3mw7lAPjdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QjsUH/4Q; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QjsUH/4Q"
X-UUID: 79f0179ab00911f18dc8c9802ae25ab1-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NGfrSwb7kUfROhwGV7OHlue/a5Pn2gN3pKAVCv80KqY=;
	b=QjsUH/4QvL1OsWH7h7+UFLpST3Bb/4s2CoFtym961Zb8r0OPCgfarsLxRyT1Az/P/w8NL6+8x2sGqq1uj0Llg5+6iWLidTZraDVAhGBAd11jByJ9lCBBT7y6xHxzaaOR7uBYBhCOYWfKA4xsm8gpoF8R3oAGC0huB178DF4kwQ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f1bda98c-6277-4dbe-9874-ca6202d83bfb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1b153fd1-f9b0-4ba3-931f-dd1de252a72d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79f0179ab00911f18dc8c9802ae25ab1-20260914
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1958883300; Mon, 14 Sep 2026 14:56:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 14 Sep 2026 14:56:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 14 Sep 2026 14:56:55 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 1/3] Bluetooth: btmtk: Route firmware debug event to the diag channel
Date: Mon, 14 Sep 2026 14:56:52 +0800
Message-ID: <20260914065654.102916-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260914065654.102916-1-chris.lu@mediatek.com>
References: <20260914065654.102916-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MediaTek controllers may emit a firmware debug event on the ACL channel
using the reserved handle 0x0efd, which shows up in the ACL header as
0x2efd once the start fragment flag is included.

Neither btmtk_usb_recv_acl() nor btmtksdio_recv_acl() recognizes it, so
the packet is passed to the HCI core, which has no connection with that
handle and complains:

  Bluetooth: hci0: ACL packet for unknown connection handle 3837

Handle it the same way as the existing firmware debug logging packets and
forward it to the diagnostic channel instead.

Confirmed with MTK internally that this event's wire format is fixed:
firmware always sends it as a single ACL_START packet and never splits
it into a continuation (ACL_CONT, which would show up as 0x1efd). Add a
comment above the switch spelling that out for this and the other
vendor-reserved handles already handled here (0xfc6f, 0x05ff, 0x05fe),
so review tooling doesn't keep flagging the apparent lack of a matching
continuation case.

Verified on MT7922: under the condition that triggers this firmware
debug event, it is now routed to the diag channel instead of reaching
the host as an unknown ACL packet.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
v2: Confirmed with MTK that this event's wire format is fixed at a
    single ACL_START packet; added a comment above the switch in
    btmtk.c and btmtksdio.c explaining that HCI fragmentation does not
    apply here, addressing review feedback on v1.

 drivers/bluetooth/btmtk.c     | 8 ++++++++
 drivers/bluetooth/btmtksdio.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 660ed5b02841..ddf50ab9533e 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1055,6 +1055,13 @@ int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 	struct btmtk_data *data = hci_get_priv(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);

+	/* The handles below are vendor-reserved values MTK firmware uses to
+	 * tag out-of-band debug/dump data on the ACL channel rather than a
+	 * real connection. Each is always sent as a single, complete
+	 * ACL_START packet, so unlike genuine connection data they never
+	 * arrive fragmented (e.g. 0x2efd is never followed by an ACL_CONT
+	 * continuation, 0x1efd).
+	 */
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
 		/* When the firmware hangs, the device can no longer
@@ -1076,6 +1083,7 @@ int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 		fallthrough;
 	case 0x05ff:		/* Firmware debug logging 1 */
 	case 0x05fe:		/* Firmware debug logging 2 */
+	case 0x2efd:		/* Firmware debug event */
 		return hci_recv_diag(hdev, skb);
 	}

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fe4ca9395aa3..46cb143a99c6 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -451,6 +451,13 @@ static int btmtksdio_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);

+	/* The handles below are vendor-reserved values MTK firmware uses to
+	 * tag out-of-band debug/dump data on the ACL channel rather than a
+	 * real connection. Each is always sent as a single, complete
+	 * ACL_START packet, so unlike genuine connection data they never
+	 * arrive fragmented (e.g. 0x2efd is never followed by an ACL_CONT
+	 * continuation, 0x1efd).
+	 */
 	switch (handle) {
 	case 0xfc6f:
 		/* Firmware dump from device: when the firmware hangs, the
@@ -460,6 +467,7 @@ static int btmtksdio_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 		fallthrough;
 	case 0x05ff:
 	case 0x05fe:
+	case 0x2efd:		/* Firmware debug event */
 		/* Firmware debug logging */
 		return hci_recv_diag(hdev, skb);
 	}
--
2.45.2
