Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87313D28C;
	Thu,  6 Jun 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674215; cv=none; b=KcpKP/ZEkid6wc7AXQ7Dvvdb4cBHi2MiiXu80qHN/EsOyyeGAq2jPtgemHq5Pjr2HO+yj+7Th90eR6Fw00E6YAIXoTGTv6yOFIQstFfylT+T31PQxsJb8Tko7b1FcxZEw3Fsdey9UdYCTVYD6zJzD14NHdlUh8TxOTfW/kTU4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674215; c=relaxed/simple;
	bh=Hd6WVWO+3k2N6W88Frd2llpJ37EzLkQNE+lWirexqIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kk96xCLn7080Qz8PSOpC107r7+g1YsYwZopNL2ZrrBu59JiD1QJ+aH52KIdhjSTyUFgi5QMm5H/s3+Sw/fBKcMNs1XtZgnUlrTaH4kIDyUzftKuSXFisQABm2Mn78MYJ2C8nvsAdeUZR1y/eosc2rEti2FmU5p81no+DQPCH2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oRY3G565; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oRY3G565"
X-UUID: fdf5e29823f911efa54bbfbb386b949c-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MRbM1go2u6MZUEVsoScl8wXxNgQ/01QqJmmjheGQRzE=;
	b=oRY3G565LU0akhW6Exz5hqo5u/SzHj5k/w53OyvSN71fbiOBEbhlIlkUThMAaQ6jwASAywlMtEg3ZNnoyx0j4GQuZjgzFN4jrQnyPFGoJVX0rn0f1WvEwJ+mn8vgTBv28oCTXk/4uGd6n9CghsyO1x0wH7q9LIlZlPnmlN7tM0Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:9c6b5f93-a310-4444-b6dc-67eda4ce4a1f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:0dfd4a88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fdf5e29823f911efa54bbfbb386b949c-20240606
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1471530254; Thu, 06 Jun 2024 19:43:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 19:43:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 19:43:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 1/4] Bluetooth: net: add hci_iso_hdr function for iso data
Date: Thu, 6 Jun 2024 19:43:18 +0800
Message-ID: <20240606114321.30515-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606114321.30515-1-chris.lu@mediatek.com>
References: <20240606114321.30515-1-chris.lu@mediatek.com>
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
	ve7l/C2qxiqnR+5LS88BtjkcfRMmqUDn8NFEhJAcngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AEnRE+fI6etkkroJNCGM2Se8Cz2wcr1lhTBwAKaEHfCaXzAGEEECqNaBIf9dSYxrVWS8m
	ZD0ewtoOzz1wbZMiRv8xNn7O/cul3/t0rZPZuWgICE5xpCtDRTUbJFyh4XXyqYo/TPOlMB4bCh3
	zE4wqa8DUCRr8oin+k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.944900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 44C0343066305BB1E34FC06E99E17ABA3BDB8006A6C9FE3EA6DEEE506803DCF42000:8

Add function hci_iso_hdr to get skb->data when packet type is ISO.

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

