Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FF1547EE;
	Wed, 15 Oct 2025 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499126; cv=none; b=lBnnipdZB6hKPXGgRKcNbOn6T4d71ixoHFToKx8dbt2Wvh0A0+OUnT0cHTAx4wvS5FJutduEj4UIHJOhNZg+pnch8Amf/zUkVxzaWgyBC8/2mbIYb0T6bKXbSf/ecTIFaBbhj7+gMx81kfVOoIrqPKvz35f1nGpGAbCW3TqO8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499126; c=relaxed/simple;
	bh=s4/DsDuRlWceiLWQQXEKeREbUD4ZXOV2awEcyKm9yvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQjIR45mSD+AQOl/Rgcam35+DdReipISDOdXWq/Xw3xV4MeqcmVLuZVieN1Lg6ZNs2A97goO8dxgBreFrQR8kRI/83+aJZonz0Z4Kb44jvNcc1atwbz/s+sTRbNpsjPVbF2+4zwG1riLsDd6HWJSGW5D3ZlrrLt1E4D+TZcm330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MR1GCliP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MR1GCliP"
X-UUID: 811f7a04a97711f0ae1e63ff8927bad3-20251015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cHJINyY/HfM0Bk3CJ11w/F3lW9D9PJ3q9roxipCTsjI=;
	b=MR1GCliP50jDXy+kU/wJqXNHDQvvdiPeBNfELIpGDpU8CwFk22IhDhlISNB40bbIedP0czFXGhxsTeTN9toEpeCkdDDD367FG+sKP2GaivH41ZDXcVEqZpWMKp9FGekzZVmC2rPNNGFc7mSP81cXzRRwpBFbiA3TUR9Y7WwIFJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6fb3e8b5-bd05-4e69-be19-b07096002fb1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0c336602-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 811f7a04a97711f0ae1e63ff8927bad3-20251015
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 480920460; Wed, 15 Oct 2025 11:31:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 15 Oct 2025 11:31:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 15 Oct 2025 11:31:56 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 RESEND 0/2] Add two new ID for MediaTek's Bluetooth
Date: Wed, 15 Oct 2025 11:31:48 +0800
Message-ID: <20251015033150.498866-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In response to the customer's request, add the following two
VID/PID to the USB driver table so that btusb driver can support
the corresponding MT7920/MT7922 modules.

1. VID/PID 0489/e135 for MT7920
2. VID/PID 0489/e170 for MT7922

---
v1->v2: Change patch title
---

Chris Lu (2):
  Bluetooth: btusb: MT7920: Add VID/PID 0489/e135
  Bluetooth: btusb: MT7922: Add VID/PID 0489/e170

 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.45.2

