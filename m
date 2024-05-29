Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FF15FA86;
	Wed, 29 May 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964199; cv=none; b=n7/F+KtVuhorcFH4MP9tZ4pVyydEKtwDA9IcxgSSrKXEpzyMMx/668F2n0PDo2oXXEq+XznwyHhVrGM9W54z6f1nfZdym+ee4AnfwW73z8LIbfYhiZqJIMP6k2pkVLDFtPVBhWwyQQn/C3qeeqRpJqoBAcm2b8BS/ZqtzIr6lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964199; c=relaxed/simple;
	bh=npoc+tLCgORcX3+Xd3WFDMV1tlPhhBwlx6soQQcSPEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrRnGsnfkIWx8Ki88Zj/FdtNemfuUec7Zq2wYLgbLjI3lwsXcgX2ZVdmd/fEzF1yDGjxgjw/dpGt+YFghXllKeZRNwv+66POh9R41/Zi8JvSht1Yh9KTEoJee4RiNshFA3XApt0qDOo8cbkkKOt4/XFfthnGt18QkVm3ku168p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=h1AacdxM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h1AacdxM"
X-UUID: daa3756a1d8411efbfff99f2466cf0b4-20240529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mTQrmF36jYllv3mP9Yybi+HEjaafjrlWHqq19OeW1oU=;
	b=h1AacdxMHCUdJ+yaBTqcl4qRSCE6ihj4jJNMUgE6iLOIJb+pYqNdrAZ/gnlMUBFEjFCYbRoIQuVtWJ+KkCUxhT+H3mSewqLsjIaou/E1y6YoP+45Lf1+/vbZLF9hLARR+UCtClEp+qJbqpqOMTmYMakz4SRqX5p9wC9BZKdKWN0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e9f28a1a-cf0e-4c26-a4b1-a060fa37f751,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:842c5a93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: daa3756a1d8411efbfff99f2466cf0b4-20240529
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1551494241; Wed, 29 May 2024 14:29:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 May 2024 14:29:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 May 2024 14:29:49 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 1/3] Bluetooth: net: add hci_iso_hdr function for iso data
Date: Wed, 29 May 2024 14:29:44 +0800
Message-ID: <20240529062946.5655-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240529062946.5655-1-chris.lu@mediatek.com>
References: <20240529062946.5655-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.944900-8.000000
X-TMASE-MatchedRID: 6pbNFWS8cDs1vivz3L6ga7RtO1RC1Ep0Kx5ICGp/WtEXdhT0BAdFzpRr
	ve7l/C2qxiqnR+5LS88BtjkcfRMmqUDn8NFEhJAcngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
	uXd3MZDUal568aygjlwDNqFcrZhl00Q8h4POAWkHpYlKIIVMLV+2bU2tbIu66CcFQOTtUNa/abj
	DdQJjxYd51oESEPyiSjDor2nsFTtxMDUBOSIYddRdGg+ZY7eN6THB2Q+oKru8MTI34nyF36MJL1
	aANdU8KftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.944900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4F8063B7F206A5CC95ABE2625B562BDA2DA588139621891BC003A9B3D77E63312000:8

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

