Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182D30596F;
	Mon, 14 Sep 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369026; cv=none; b=XeaFS8+zAXSnosq0zlWfgbuSTFNnvrZRuGty9RnsNHVfmJIa7lab6V6WobzShShKDc+fX+MX9ooOAu4rqWFFct/BS2LSR1ZFFNyqgPq9Zj6qKfxLFlNZlair9CCWV8DiWTaCW9f+Rqjang0ayw3l349qk3ooOmyikCatC1ZexUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369026; c=relaxed/simple;
	bh=IiAcSEjEkweZsqW5rZZe70kiLnEjvojllzLM8y47S0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJvA3LWAWBPYMvYt+EPYhUCsaPbh4W8ZUzoAtiKpDztoF7KEeI3v5AnVmSyzSbfRecwtVperqolZ1rQPIe0hxTCq5/m2fZ8V3g0+4q5xUBWobpUDvx9XxFTbVj734Mvl6ULtCb9TK/p6wc2cvG3zSvaC6I7zb9j72nm736La5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OtmI+C9M; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OtmI+C9M"
X-UUID: 79fa9a4eb00911f1b1788b6acf885367-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M+wbLc+QMBDELQI8j8VkH4b0X7LtW4k6/J0pAV5Iqbs=;
	b=OtmI+C9MKMDFcnCjc30dum+qfyP47pftd2WfmvaAOoxRYUT9dirCZc20Qbf0LKYcIW9peIeYfcPMdXaDcDxvLNMv3hIQgLKy054w2hKNG6RNk5Se7Gk5RXEUqDXyR2MhPkDyJGmTiK4Y9yFOHWvFmpdsp8IwYAPYue+5d/nZHJI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9351ce3e-d6aa-47b6-afc8-c5d9dedfad89,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a5593c0c-027a-4b0a-91ab-050fa8cdb9b0,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79fa9a4eb00911f1b1788b6acf885367-20260914
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1534605908; Mon, 14 Sep 2026 14:56:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 14 Sep 2026 14:56:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 14 Sep 2026 14:56:56 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 2/3] Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
Date: Mon, 14 Sep 2026 14:56:53 +0800
Message-ID: <20260914065654.102916-3-chris.lu@mediatek.com>
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
v2: No changes.

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
