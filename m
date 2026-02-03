Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A8378D8B;
	Tue,  3 Feb 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099923; cv=none; b=ezAVgKAMchhZdideq2o7pZqEwEuJIT0DgURixJGuQ/Rme4k6Q30yfTT0qvPypc6VtAnPdNtTF00TbVNjcuKDnqdOYP2Oh/tEc0wwlDJC1IwguU0JTP/5fkPC2eumXdGkui/XxhrQei0BpAx4KgI6TvkQLk2Oer8etj47+z6+P18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099923; c=relaxed/simple;
	bh=y66Jl5nGXfeTN6v80oRcrlYYMQvdlUcjSEMC4i5VeZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBP27gCZ6fEeOo82b8KWhh7re5MMJUTKNWMeXm5HVIOyskLIy+UbH4pRt2VHHePD/30llIzpuJ9yVi/jnYywpiKOkKGuWt1IeeL/rRDyLb2uaFIE18XjsNyRIJpobZKbibJ7UFbdrvbaKrwP+omDkTh70wJl6PNuadjDJK+1tPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EAosnp7y; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EAosnp7y"
X-UUID: 19451bce00c911f1b7fc4fdb8733b2bc-20260203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=95EAtHNCfW3joYN6/vrJZUu1+v1Xt2a63nk/beT1mfI=;
	b=EAosnp7y/4EPp3oyTat8GjYvpZjTuyz2XGYeChHlGAleTIJJgaYFcPZB1G10QdkemPDfNNL9SW7HKJtphriDVrT8c9+bq4niAJvbco2FLQ7oVhDwTBOylTwEGeLYXtLmuCGFTj57QYyjF9F1yWGwaMlITsL8K0PNGlJptjwIHeM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:b999e877-e934-46c4-829a-2f3bc7da1942,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:f493dd5a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 19451bce00c911f1b7fc4fdb8733b2bc-20260203
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 885279598; Tue, 03 Feb 2026 14:25:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 14:25:12 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Feb 2026 14:25:12 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1 2/3] Bluetooth: btmtk: add status check in mt79xx firmware setup
Date: Tue, 3 Feb 2026 14:25:09 +0800
Message-ID: <20260203062510.848761-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260203062510.848761-1-chris.lu@mediatek.com>
References: <20260203062510.848761-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To prevent abnormal controller states, it is necessary to check
status in another part of the mt79xx firmware setup. During this
process, receiving the 'BTMTK_WMT_PATCH_PROGRESS' status is unexpected.
If this occurs, it should be treated as an error, and driver must be
prevented from continuing execution.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b0f87b04046e..67db5a48c3e4 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -213,7 +213,6 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 
 			fw_ptr += section_offset;
 			wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
-			wmt_params.status = NULL;
 
 			while (dl_size > 0) {
 				dlen = min_t(int, 250, dl_size);
@@ -231,7 +230,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 				wmt_params.data = fw_ptr;
 
 				err = wmt_cmd_sync(hdev, &wmt_params);
-				if (err < 0) {
+				/* Status BTMTK_WMT_PATCH_PROGRESS indicates firmware is
+				 * in process of being downloaded, which is not expected to
+				 * occur here.
+				 */
+				if (status == BTMTK_WMT_PATCH_PROGRESS) {
+					err = -EIO;
+					goto err_release_fw;
+				} else if (err < 0) {
 					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
 						   err);
 					goto err_release_fw;
-- 
2.45.2

