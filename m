Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF34334C9;
	Fri, 11 Sep 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123371; cv=none; b=eBrG7hAAavkIWy1bWiY2EtN8elTPwKvNzzR2gplevDWzYHhUkDQ4Qa9htfDIIVMGdYp05dBSNtNZGxv8npspIIrCcqndEE/pgHjkdRALf0ylO6xnYczSAFWfdDCP0/tbo7O1kpG1E+uUiQ0ajaLK4hpeTYa7k7ZMRDHZb71eU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123371; c=relaxed/simple;
	bh=A2UUjumpJALQwB3PV73WqgCwkzFiejNqyd4nz7tZNDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3yFyJsovPiRaGIgoewJjBdTJfiSz/cYa7g6DyV9THfnFi0aVuaDacGpt4jd4OQWOD/ZznO8SvPZJq4HWGndMrK2ZtZIHQg4WLbFLweJJRnU404Wwt0IvQOSyrA3qCEJKlJ8keYMiqCVHYnXfBrH/riagyYa44mEswJqsr9JPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Esfr6rOY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Esfr6rOY"
X-UUID: 81d5e89cadcd11f1b1788b6acf885367-20260911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r+chzdE/1S/BzIaN/qocSSODG0oKFICuJeWiAt1OqGY=;
	b=Esfr6rOYvH7yzpKZPv1kPycCgNBjiRtuIYtpP2P0iNqr8Lr+16HyhsEG3kDARqDQCitdEdFsxqdcDcvlnoJkH1VVkcAbd2HBaYcQSHZqdtBspgYt3YuXlffU5djQjKuapd/KEMnXBt4r6X/lF+mSw8zF8splRfaO7bfjfbW34Jk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:34227e5c-7f12-4257-9976-2cd13a823daa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7c5964e3-ea51-4dda-a022-9ba6608a11d1,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81d5e89cadcd11f1b1788b6acf885367-20260911
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1287144272; Fri, 11 Sep 2026 18:42:38 +0800
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
Subject: [PATCH 1/3] Bluetooth: btmtk: Route firmware debug event to the diag channel
Date: Fri, 11 Sep 2026 18:42:32 +0800
Message-ID: <20260911104234.2276126-2-chris.lu@mediatek.com>
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

MediaTek controllers may emit a firmware debug event on the ACL channel
using the reserved handle 0x0efd, which shows up in the ACL header as
0x2efd once the start fragment flag is included.

Neither btmtk_usb_recv_acl() nor btmtksdio_recv_acl() recognizes it, so
the packet is passed to the HCI core, which has no connection with that
handle and complains:

  Bluetooth: hci0: ACL packet for unknown connection handle 3837

Handle it the same way as the existing firmware debug logging packets and
forward it to the diagnostic channel instead.

Verified on MT7922: under the condition that triggers this firmware
debug event, it is now routed to the diag channel instead of reaching
the host as an unknown ACL packet.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c     | 1 +
 drivers/bluetooth/btmtksdio.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 660ed5b02841..5b0a131bc9d2 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1076,6 +1076,7 @@ int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 		fallthrough;
 	case 0x05ff:		/* Firmware debug logging 1 */
 	case 0x05fe:		/* Firmware debug logging 2 */
+	case 0x2efd:		/* Firmware debug event */
 		return hci_recv_diag(hdev, skb);
 	}

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fe4ca9395aa3..9a1b6f9b0872 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -460,6 +460,7 @@ static int btmtksdio_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 		fallthrough;
 	case 0x05ff:
 	case 0x05fe:
+	case 0x2efd:		/* Firmware debug event */
 		/* Firmware debug logging */
 		return hci_recv_diag(hdev, skb);
 	}
--
2.45.2
