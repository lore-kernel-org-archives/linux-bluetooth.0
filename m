Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C215B146;
	Wed, 29 May 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953451; cv=none; b=BHOeJu/TcVV/JtzwOUyyGQz6tTStimEthDfiuAt6XL0Garma9zezrROC3GBA8sBOrvHyePGH1C8gVbKjq2UGTcCeQCDXJD58Ys8kTWeD6rTJHcX1E6/vZMLXarTUFeMgGdpFrRXkeExUqJF6qQ1zT8NRM/lVijdqQvZEHLBk5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953451; c=relaxed/simple;
	bh=npoc+tLCgORcX3+Xd3WFDMV1tlPhhBwlx6soQQcSPEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrQgM5818w6JoSsoiXISi0YHcaTdUBlIgCEu3wq4l38QD444HdufeSzMzoJyjsaj0zArNEmzDun7Pe2AduaakF2ywvcoCXUbdv1ulkFvWpWJNtQj66dM4zqEDbR6ztAd/MmUmupRwGR3gV3NO9KJg4lA9EBNvTH+6vASru+Tzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eOTT6iTF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eOTT6iTF"
X-UUID: d507e1681d6b11efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mTQrmF36jYllv3mP9Yybi+HEjaafjrlWHqq19OeW1oU=;
	b=eOTT6iTFDxZ9Bb4MNrDGJ22EQb4yOeUMSFThh/GNL5Hq++A8I/0Hy+RHawK1hAq5SVFX1QmhVv23kdDIduy72QETefZHL5C6lD2sJlKGPn+UmeX4JqFlUWyNyQmuINrFzdoeGI0yURiQpVZej6DBfzaLO4FPBpqybV1dHnBAFPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:b4c08df2-9760-498e-8608-a099f13996e0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:1ac3ee43-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d507e1681d6b11efbfff99f2466cf0b4-20240529
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1248307800; Wed, 29 May 2024 11:30:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 20:30:43 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 11:30:43 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/3] Bluetooth: net: add hci_iso_hdr function for iso data
Date: Wed, 29 May 2024 11:30:36 +0800
Message-ID: <20240529033038.28458-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240529033038.28458-1-chris.lu@mediatek.com>
References: <20240529033038.28458-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add function hci_iso_hdr to get skb->data when packet type is ISO
which is similar to other packet type.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/net/bluetooth/hci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e372a88e8c3f..b9f8f91f6c7f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2898,6 +2898,11 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 	return (struct hci_sco_hdr *) skb->data;
 }
 
+static inline struct hci_iso_hdr *hci_iso_hdr(const struct sk_buff *skb)
+{
+	return (struct hci_iso_hdr *) skb->data;
+}
+
 /* Command opcode pack/unpack */
 #define hci_opcode_pack(ogf, ocf)	((__u16) ((ocf & 0x03ff)|(ogf << 10)))
 #define hci_opcode_ogf(op)		(op >> 10)
-- 
2.18.0

