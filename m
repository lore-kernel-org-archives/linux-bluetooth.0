Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFB33120A;
	Fri, 17 Jul 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274148; cv=none; b=VaRYx4caJeg7h8tQ0gp/BXiWJYHoxflEl8ASzavhOLO1lQftVaUofXVb+tfH+X13yOH0FNDNRCyVLCpnl64Ph0UOjcVhilGtaaQiRrOsznF900Z00nr7Sr1dmSPsWlTL/TFPcDi93ht/BgPxF2gVZFNS1OfAX3jXPXyq7EnRvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274148; c=relaxed/simple;
	bh=WIgORuWVdrDEXrfoC0yNjGXI4BbM26CRRdu+jUMvvVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE35VFeLXXKUf4UzF/6au36LvuHUsTjHJoJq6cjHlvtGcOzRyUh4jbDLXiSWrtwZ1o2opE3JfNVStSqCFkXElaa+HWmKAFzPH6a+IxFZyPx4Jumb9a0sysQAkEkqwkC2suKUa7OOWYFzKmSeq5GcLM1PbHnTYEohWlJS0TajcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ESi4vCsO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ESi4vCsO"
X-UUID: 045edb9481b311f1b1788b6acf885367-20260717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NzWtVOodND0t5OxLOVyEkpgN19ad/R8me0/vvCvwE/U=;
	b=ESi4vCsOZx1daHMoAYEja+m6gIKTUDb4YnUxlZs0Uz4hh4BLAmahnvsrxlsBTvqJ+xSOZ24tnxk5QcOi0YwBgJ2HEExuaKY1tSbCx4gwX53pi+R0nOjbo28gos4pApB8uFeD16mNw2YjoUu5KCLY4ipiYpHHpxiWAW8KzLuX6OQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:d1b5bf69-6655-427c-9ac8-7a266558b57d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:7a58f450-9df4-4a32-98eb-0af8dcdad6c0,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 045edb9481b311f1b1788b6acf885367-20260717
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 876836166; Fri, 17 Jul 2026 15:42:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Jul 2026 15:42:08 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Jul 2026 15:42:08 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v15 4/7] Bluetooth: btmtksdio: Remove redundant firmware filename override
Date: Fri, 17 Jul 2026 15:42:03 +0800
Message-ID: <20260717074207.2869999-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260717074207.2869999-1-chris.lu@mediatek.com>
References: <20260717074207.2869999-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_setup() calls btmtk_fw_get_filename() to generate the correct
firmware filename based on device ID and version, then immediately
overwrites it with snprintf() using a generic legacy format.

This redundant override causes newer chips (MT6639, MT7925, MT7928) to
request incorrect firmware filenames, leading to firmware load failures.
For example, MT6639 needs "mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
but snprintf() generates "mediatek/BT_RAM_CODE_MT6639_1_1_hdr.bin".

Remove the redundant snprintf() override to use the correct filename
generated by btmtk_fw_get_filename(), matching USB driver behavior.

Fixes: 7f935b21bee4 ("Bluetooth: btmtk: apply the common btmtk_fw_get_filename")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 1fdc24545e41..d895292103bb 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1175,9 +1175,6 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 		btmtk_fw_get_filename(fwname, sizeof(fwname), dev_id,
 				      fw_version, 0);
 
-		snprintf(fwname, sizeof(fwname),
-			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-			 dev_id & 0xffff, (fw_version & 0xff) + 1);
 		err = mt79xx_setup(hdev, fwname, dev_id);
 		if (err < 0)
 			return err;
-- 
2.45.2

