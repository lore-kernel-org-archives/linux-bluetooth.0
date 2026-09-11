Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40863C4B79;
	Fri, 11 Sep 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123371; cv=none; b=jRhQ4PrAJWw3mHuKcwXiabEkYsqRnOP6hJbT3V3WOENcPGT3XdQThL/IpYUNVpaK3oW2gY0jg8Ox1nvsD3AAkUHf3XuLgDQkMYleUZI2OA5h7ACLzqiQIOcRmcXX5laOEPMyVeaoSAbdmpR/YUHciwNPOZ3O9Txy4CLBBzgSIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123371; c=relaxed/simple;
	bh=BBFPFt4elSEBBhU1WeB9V80GWMPu2gptr7oJ+jeqyFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn/okCMzjk+4Renrjv0A0YZZ2UlCmVT1cX1hhwONabzFtmdxhMmgyCZZXBE8J9AaCQIH6OIZdrDALDcJBFOv/1fk9aZ0EXeBTQGnv5gIFflV4h9H9af0onIfQVqlJxA4E2k4GBy3rTGdXtny/84/lT2AdHaMhA2l5kDxDGUQ4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sYbU+phQ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sYbU+phQ"
X-UUID: 81eda996adcd11f18dc8c9802ae25ab1-20260911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aVTVh9Z++/6pbgFWqeGo2Lyfp8+r2NN//RueXJp1Q3o=;
	b=sYbU+phQwtD5dAkqHftDSoHCWC15xH5gNq1/mnOG6ftmk+/ILWkw91YlvQXyB+WZkHx4rQWcUIz4vZJ/2CNwKeXWzJCj0VBmRCeOH5Qp3Il9rbI/HognA4yG1n6OlB3M9j0PVOgPQq+1Ued+rzgidgonEMYSQeuqDOfwPMSh9sY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a97db2bf-5743-4398-8aff-96d9c8b80457,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:845964e3-ea51-4dda-a022-9ba6608a11d1,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 81eda996adcd11f18dc8c9802ae25ab1-20260911
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 430717400; Fri, 11 Sep 2026 18:42:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
Subject: [PATCH 2/3] Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
Date: Fri, 11 Sep 2026 18:42:33 +0800
Message-ID: <20260911104234.2276126-3-chris.lu@mediatek.com>
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

A too-short BTMTK_WMT_FUNC_CTRL event (WMT header only, no trailing
2-byte status word) is always treated as BTMTK_WMT_ON_UNDONE. This
short form is how firmware acks a plain enable/disable request, and
the actual result is carried in the header's own flag byte (0 =
success), not a separate status word. Decode it from there instead of
assuming failure.

Verified setup on MT7920, MT7921, MT7922 and MT7925: no regression.

Fixes: e3ac0d9f1a20 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 660ed5b02841..03b99826b52c 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -791,7 +791,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	case BTMTK_WMT_FUNC_CTRL:
 		if (!skb_pull_data(data->evt_skb,
 				   sizeof(wmt_evt_funcc->status))) {
-			status = BTMTK_WMT_ON_UNDONE;
+			/* A plain enable/disable request is acked with just
+			 * the WMT header and no trailing status word; the
+			 * result is carried in the header's own flag byte.
+			 */
+			status = wmt_evt->whdr.flag ? BTMTK_WMT_ON_UNDONE :
+						       BTMTK_WMT_ON_DONE;
 			break;
 		}

--
2.45.2
