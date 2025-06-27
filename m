Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654BF10FD;
	Fri, 27 Jun 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004036; cv=none; b=B18EgaLA4jIOZ+RHQ4xUNoev+udIZte5LzYl44BUR+yMfbZk2XHNmaUcm9C6LN+vOCnIRZ8PEk28jTQ7esczqvlXWltcj0ybl/sFBdq/tP2t0JXgN74dwC/lUuLghrYvRWZiq1zJctoBXWLxCNk9JuSPB+UHnPHQmuK0xW1ZNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004036; c=relaxed/simple;
	bh=C1KgdmWprhl5U+uXvsGnZk9d+ZQfkc39FFNQwdfH6/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XVmJl6saLqrtCHXYqtlT2q4MXJAds52e1DpK/a21qmwggDoZQBthgiv/GMRQ2gLJrTo0/ogtQv7CfefqZ2iPDpoFQLRqEfGzzCHFqSCAdewoBUcHDedpMej4cU5LmJGcyTObPl71na5pYbvK9bv73nYOzH4KQJBT6lAwDxAnaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H/gj53fU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H/gj53fU"
X-UUID: 0727ab60531c11f0b910cdf5d4d8066a-20250627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/K+osIkO7d6Wgo0/BDUoDEQxbCQtNaMJbw5veeEUgyY=;
	b=H/gj53fU3JtwqjEuMQoKMNRfWDU2Sd7vPdw7WuauRCLKvPcVK2QhKAlAD9Zi4iJN5BgNqoCyFisaWYDxfv23xWLHXJpP4Ns78a1Y66F++IYGkc8Gk+DgNQI/BGxOymmeeLn/LhCSs1/J1EtOyxMwMA/2RUcYwfwVSDsEXSCPoGg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:ab3e5ac8-01be-4b70-b180-43e48999bee8,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:97ee9f73-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0727ab60531c11f0b910cdf5d4d8066a-20250627
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1302613216; Fri, 27 Jun 2025 14:00:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 27 Jun 2025 14:00:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 27 Jun 2025 14:00:25 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk=dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v5 0/2] Bluetooth: mediatek: add gpio pin to reset bt
Date: Fri, 27 Jun 2025 13:59:22 +0800
Message-ID: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The enhanced BT reset feature builds upon the previous software-based
BT reset by adding support for hardware pin resets.
To maintain compatibility with existing projects that
still use the software BT reset, both methods are supported.

When performing a BT reset, the system first checks whether the
Device Tree Source (DTS) is configured with the appropriate settings.
If the specified compatible and BT reset GPIO are defined in the DTS,
the system will pull the designated GPIO pin low for at least 200ms,
then pull it high to trigger the BT reset. If these settings are not
configured, the system will fall back to the original software
BT reset methods.

Compared with the previously submitted version, the following
information are some specific revision histories

V4-->V5 modifications:
-Modify the comments mentioned in v1.
-Modify dt_binding files and 
   make dt binding a separate patch.

V3-->V4 modifications:
Modify dt binding format information and
   the explanation text in the patch

V2-->V3 modifications:
-Changed the capitalization of co-developer names,
   using the correct capitalization of abbreviations and full
   name, and corrected obvious spelling errors.
-Add a revision history.
-Remove the "BT Driver" in the prefix.
-Add the bt-binding document, include inforamtion related to reset
   pin and compatibility matching.
-Add a comment before the schedule_delayed_work function call,
   although schedule_delayed_work is asynchronous, there is no risk.
   Even if it is not completed within 200ms, it will only postpone
   the subsequent probe and will not have any impact.
-Add a comment before the btmtk_reset_by_gpio function call,
   if the compatibility filed or pin cannot be found in the dts
   files, it can still reset bluetooth using software reset.

V2 modifications:
Modify gpio to GPIO, SW to software,
and fix other obvious spelling errors.

-- 
2.46.0

