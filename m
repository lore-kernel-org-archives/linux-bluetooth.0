Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F33378830;
	Tue,  3 Feb 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099922; cv=none; b=e9uSGkDVEla+M2INWOI88F03/K+u/wyAZZAq+xNAFcRqdlXmEeaVO01vFvR6XH+RyE+buNgDHW5KSOzBZGqp1Ziy/gICO8ZdY9Pdfpnq9YDKqZizshYGFRvCc9LiJdYllJvYAQ/ZS7dGu25to6neQ/5/OWBhIk7OO/Lzub6UFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099922; c=relaxed/simple;
	bh=mzUG5eHhHXKYpo0y8+YRUyaFI81Vak+UCqrG3WwW7dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPUgK/UlTr8HktHsizeQHjETC3HgTTgHSsHJqaXWmzQJdArAanISVl7gnvmwQ0NqLAWvIm7bFV0V1+sjrjYEgYXqtqItRyAgn121XIKLtRmPpQU7Tas36gSsalUA9ro+wMfGEKMCU3GKpfXYA5ZyzqRpNavFvvqRhYQso52Az2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V+0YIWwj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V+0YIWwj"
X-UUID: 192b130a00c911f1b7fc4fdb8733b2bc-20260203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hjdk4iVxARg9zIQBT0R8ldlsHzy0JD+kypYvSqzMChk=;
	b=V+0YIWwjx84ZhY0XvIbHPXO5A3zo9zRUYYhEDWF9gOQjctWoUZWxrWOS9wINbwA8q/b5yDfeY+Pr++ukRa9D0368jbnRvBueRpag75xBVYJNmZ/0N5Kwj0AttCCLARArdmPwFOGyUcEGp8QFlGFojgvsJo7C2d7SkbX0HYtBIAI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:4436d6d8-5852-48df-bdb7-ddc64c3f8348,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:fa82867a-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 192b130a00c911f1b7fc4fdb8733b2bc-20260203
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1359349422; Tue, 03 Feb 2026 14:25:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH v1 1/3] Bluetooth: btmtk: improve mt79xx firmware setup retry flow
Date: Tue, 3 Feb 2026 14:25:08 +0800
Message-ID: <20260203062510.848761-2-chris.lu@mediatek.com>
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

If retries are exhausted, driver should not do futher operation.
During mt79xx firmware download process, if the retry count reaches0,
driver will return an -EIO error and release the firmware resources.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a8c520dc09e1..b0f87b04046e 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -205,6 +205,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 				}
 			}
 
+			/* If retry exhausted goto err_release_fw */
+			if (retry == 0) {
+				err = -EIO;
+				goto err_release_fw;
+			}
+
 			fw_ptr += section_offset;
 			wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
 			wmt_params.status = NULL;
-- 
2.45.2

