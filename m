Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183C288A8;
	Tue,  8 Jul 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954535; cv=none; b=sRrPqdeL/qdtBWrGLBJ0y7PDzStBIRwyTA4z5V4BBIxkuSiWMbhydSDxAfdtQy5ElNj9qI7nBdxCI9e6T3R4Cl6C+p1Ku6aDYAigYSCS7PnHe/yftfEg/Fo0VIvkgzBdQiwR5e84vVnR9EX1mDXsx1LJOHganXALWDrCSBENoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954535; c=relaxed/simple;
	bh=giYT7I/4HDvp3JpNR5592PFV8m4RxRGaeyaV9WxlkB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0NQZbd1zKcmKxf9hKgsPmuiR9lWrTOb3Tn/lk7qhiurzTg+5weNVezT4ATjH2Hgpe6EQq5IMiZ9t6ty2RuZ2Fx0eB9vO13nwr+yGcxJldbuY4Rj0wpXuutVQ6keQbJOH6ELN5toxJRwd+bzdz9FKvU0xuyngfanhjlflLOlTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=geoNyks+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="geoNyks+"
X-UUID: 13f5d3fa5bc111f0b33aeb1e7f16c2b6-20250708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SmnDLQMvlZ5p5M7y6ywDYdMNOlGcOTiBdLsaKeylsC4=;
	b=geoNyks+i8qD7f3U50D7AdEQidRFcDS6V5+Fg8oWMRfajdG13CIZ82n4ziYha0knhLeBvf0d61ZYtjb9ML+u4I1AY6KwtL0QC8f4mCsfp2sGxxCeXyxf7QO9SypOZpO1Uyh630geSljAyo5SSMvQ8lgMC+6d0RS2POppZ9rhE9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:e2497827-cdd6-4cf9-a4b6-9a8dd67f8c75,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:8572a518-744b-4ed9-9ccc-90bf001fb3bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 13f5d3fa5bc111f0b33aeb1e7f16c2b6-20250708
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1826436405; Tue, 08 Jul 2025 14:02:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 8 Jul 2025 14:02:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 8 Jul 2025 14:02:04 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, Wallace Yu <Wallace.Yu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v6 0/1] Bluetooth: mediatek: add gpio pin to reset bt
Date: Tue, 8 Jul 2025 14:01:47 +0800
Message-ID: <20250708060150.27375-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Reset Bluetooth using hardware pin via dts

Compared with the previously submitted version, the following
information are some specific revision histories

V5-->V6 modifications:
-Add specific revisions in the changes from v4 to v5.
-Add hardware pin title and descriptions to dt-binding submission
   information.
-Modify the title descriptions in the dt-binding file.
-Add 7925 what is it.
-Wrap the descriptions of MT7925 chip uses the USB bus appropriately.
-Change the compatible string to mediatek,mt7925-bluetooth in
   the dt-binding file and driver code.
-Drop gpio-controlelr properties in the dt-binding file.
-Modify the descriptions of the reset-gpios
   properties in the dt-binding file.
-Change the node information of reset-gpios in bluetooth
   from high level valid to low level valid.

V4-->V5 modifications:
-Correct the spelling error of word provides mentioned in V1.
-Drop the xhci0 node and status property in the dt-binding file.
-Modify the bt_reset tag node to bluetooth in the dt-binding file.
-Add #gpio-cell descriptions to properties, nodes and requests.
-Make a separate patch for the changes to dt-binding.

V3-->V4 modifications:
-Modify submission information why use hardware pin to reset Bluetooth.
-Write historical commit information into the cover letter.
-Modify dt binding format information and
   the explanation text in the dt-binding file.

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
-Modify gpio to GPIO, SW to software,
   and fix other obvious spelling errors.

-- 
2.46.0

