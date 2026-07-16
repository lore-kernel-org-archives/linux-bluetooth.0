Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA040BCC9;
	Thu, 16 Jul 2026 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201113; cv=none; b=jxvokVk3iDqluKWKR1AMGlwMyV6OOgC4N4l25SN5WT8YbS/Ole82qwfqs5z5kJRMqoqQ1xy0S9GbfQ0m1hKLujEDMTmpcxJqxybiAFrxPqNUsZbhgfaFhche9X3E3Va1XFJ6c0ODeu/L5FFmvj7z9PqmH8wTc6HBjyccTlKvuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201113; c=relaxed/simple;
	bh=DyK2eE6lhD2W2V4XOqaRKy5zKoUhkV/fPJSATSKB5XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPXEo/Z1uhQmXbUoeTa6Q/khGc1RrMOvOVCRxJWdJ1wShin5FncsohhL06ad13qKFKvaC6amjp3tt/8dNxUBugK5YV0sHNWUS3c2dZdNZUvacEV2KLietZX3Qi3BMrWD0zyoLEkene/dzHJ4Wg62jI/TFmSvJPYzDT5Rzz8SmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dXJP+/ip; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dXJP+/ip"
X-UUID: d5920502810811f18dc8c9802ae25ab1-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C+s7inpwIyIPl0XDwjxGv1Kdxla/17XK6YBQgY/NWHM=;
	b=dXJP+/ipFOlQO46PA/A5UVKfdSSc35isL41Tanbhm+5kzFfEOyaiTl30lmUzvKDazzPQXMdOoatBJRA2ImVFmjXhj/wX7q5Q+2ds55S5gzZ3Jn56dN5fdjdFnYiU/tObfUNshEG+RRD5aJ8do9cBwRTV2HfK73xnCjiUqXc3u6k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:cd993d5f-20bc-4453-9bb6-4d9900ce967a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:295f563f-46cf-453a-bd84-ad9fc7cb0e8c,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5920502810811f18dc8c9802ae25ab1-20260716
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1109369696; Thu, 16 Jul 2026 19:23:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 19:23:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 19:23:56 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v13 4/7] Bluetooth: btmtksdio: Remove redundant firmware filename override
Date: Thu, 16 Jul 2026 19:23:49 +0800
Message-ID: <20260716112353.2192865-5-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260716112353.2192865-1-chris.lu@mediatek.com>
References: <20260716112353.2192865-1-chris.lu@mediatek.com>
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
index 088fdfb56231..4a160d5131f1 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1164,9 +1164,6 @@ static int btmtksdio_setup(struct hci_dev *hdev)
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

