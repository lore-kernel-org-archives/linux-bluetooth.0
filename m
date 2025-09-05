Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98519DFA2;
	Fri,  5 Sep 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061698; cv=none; b=RRyDyPtjK63HNquEnqd/QfOg+EBHjjPqqIlSONlSNopTSdE72RX23WBvugVDTBTnOmkUzXmR8HmL9e3awddzizPz74sIG7u3KFxdncQxRd0ZjzoXAeFQjX77f8IlG9NGzyIlq95DTQV92wKk1QdrkrYM1bT62axq1lzIkjkzkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061698; c=relaxed/simple;
	bh=xpswsPrMvvYTQuUcFGaAZv8HUtKCUdoybCK4qVuMDt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+F0/eXqoHZL4U2S9mivfPNo14anyxbyvAcjbFjL04aMefg7LnODjYdWCfL+3KyGqoMNuVLJz/+bP1+YSw8oswVTU1sUqTJNp6ECkzWhwQE8am0dM1Swf7Ynpwmtz+iv27s8ttnNiTihRsvSa+N7T0Hk9RouiprzazRcdx5XIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pZjViwq1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pZjViwq1"
X-UUID: 1d8a695c8a3411f0bd5779446731db89-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/ApVjdharpTsVHJoBGegLRFCgG6a9IZVSTLoR2olrcA=;
	b=pZjViwq1u11OvDEYbU8ALC8ItbmQjMmlbYefNHoSF8uyK25AwKwcHHhykLdFmr7CpNVVdWRFRt2JTWUp8iasuIXDXlTfwqjpnOlwdJ1imn8hmZDXb+5mgMkJl0NNhtT1OoxthOMYnvQVsea3oiuI34U76QHNq3+sQljbXprdmLg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ffd8fcbc-e974-4878-b438-cd2fc142b099,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:f1326cf,CLOUDID:a0273c6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d8a695c8a3411f0bd5779446731db89-20250905
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1267618094; Fri, 05 Sep 2025 16:41:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 16:41:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 16:41:25 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Luiz Von
 Dentz <luiz.dentz@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v7 0/1] Bluetooth: mediatek: add gpio pin to reset bt
Date: Fri, 5 Sep 2025 16:40:58 +0800
Message-ID: <20250905084059.26959-1-ot_zhangchao.zhang@mediatek.com>
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


V6-->V7 modifications:
-Change the gpio_direction_output interface to the gpiod_set_value_cansleep
   and gpiod_put interface.
-Remove the schedule_delayed_work asynchronous operation.
-Delete the #gpio-cell attribute in the yaml file, remove the #gpio-cell
   in the required field, and simplify the contents of the descriptions.

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
2.45.2

