Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DF1E52A;
	Thu,  6 Jun 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674222; cv=none; b=HwxtjJTjSe0KzdxpAicbdJQeD6qv/lwCWcfN/JZgElsqle0pF2ZW3o3sRiNQPK7g7IwWdc+kNEwXovhBAU+FN/Ivczw8qKx4pCridAZRAuEAJwV28oPwU1Efmqg2KLvARnV+LzeJgFyqtOJcEiUZql1E4eRMVYVWNUVaPISHYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674222; c=relaxed/simple;
	bh=FDnueRf+2MzqwXJoheUcGcduJQ5JIlmb+4zXn6XlAxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CYEStWzdpvEWc8dGPnWIiuLnZxFcaI2ItVM90BdFK0xNsZnzSn0YUwT99JiHJaxnTgtIPOhpxPcasdm4KQr3pB8B+5aIDeQGfYOGN4CAmjCy6/Bs0ri8lAJVna512oUp1eWaLAqyQaLeJ0fa9+c5aXxunOpO4iWgC3yeawmVwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MS2T/TYU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MS2T/TYU"
X-UUID: fdebacec23f911efa22eafcdcd04c131-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L3Crh55HpJgMsbpemIUlyV71/GIWueUo5x4/xsk0kZ0=;
	b=MS2T/TYUhNm6B6Trl9jyDu5vEI5d7XdLuhrrhg/3byPDFFnLSb8L02I86qbV57tBGUN3bgWch3W5cr2fQfWwq28smOw4gnU78aQxMPNIKbwIMEpfVn/VOuB6MCnTUOezZ4K4Mkt/cc8d71jRerADoEgIN4PjeVORv68v2CTTK5k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:72e1f765-749a-46d3-b36a-bf23c31a3e8d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7b0ccb84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fdebacec23f911efa22eafcdcd04c131-20240606
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 295124760; Thu, 06 Jun 2024 19:43:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 19:43:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 19:43:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 0/4] Bluetooth: btusb: MediaTek ISO data transmission
Date: Thu, 6 Jun 2024 19:43:17 +0800
Message-ID: <20240606114321.30515-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.764200-8.000000
X-TMASE-MatchedRID: cjXKuyuuhFvaYQdwXEMf70j2sPWKvtn0DRi0jfY6gL1oNGY/OdYkWWAI
	1go6d1sNmMN+S0FpW+8dHzBmTYIGm/Iejw19Z0aTuIwLnB3Aqp1A8I/PJy4EU70rWM4nIpJrqbD
	mzbecxFu6ecT5yQFR4KKT+xko6AZvfDPEC/yQgPRDmVmiQbM5qlrhZu06i+HhgrAXgr/AjP3jgE
	Ok7iIqjBT6+KIPEGWdHFxA3IUbfplu/4kI/vPqmG095hplj6TXNACnndLvXwedohxAwFG9tKPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8Krfnm12b+L5a/urQJ9XZkSaeEFtG8SsxZdpqpmNAT74h6d/b6
	R7yBaPhDDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.764200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4B0F7AB31589667B9A4E6B797403A6C4246EF00A638FC613BF15D88E693767FF2000:8

Since SIG has not yet clearly defined the specification for ISO data
transmission over USB, MediaTek has adopted a method of adding an
additional interrupt endpoint for ISO data transmission. This approach
differs from the current method used in the Bluetooth upstream driver,
which utilizes existing bulk endpoints. The interrupt endpoint provides
guaranteed bandwidth, sufficient maximum data length for ISO packets
and error checking.

Certain new functions related to USB transportation, such as urb
allocation and submission, are implemented in btusb.c to leverage
existing functions and data structures defined therein. Meanwhile,
vendor-specific functions unrelated to transportation have been moved
to btmtk.c to streamline btusb.c.

---
Change in v4:
-Fix warning report from bluez.test.bot in btmtk.c.

Change in v3:
-Refactor ISO data transmission flow, keeping the parts related to USB
transmission in btusb.c and moving the rest to btmtk.c

Change in v2:
-Fix warning report from bluez.test.bot in btusb.c, align with other
packet type to parsing dlen when getting iso data.
---

Chris Lu (4):
  Bluetooth: net: add hci_iso_hdr function for iso data
  Bluetooth: btusb: add callback function in btusb suspend/resume
  Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
  Bluetooth: btusb: mediatek: add ISO data transmission functions

 drivers/bluetooth/btmtk.c   |  94 ++++++++++++
 drivers/bluetooth/btmtk.h   |  61 ++++++++
 drivers/bluetooth/btusb.c   | 276 ++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h |   5 +
 4 files changed, 436 insertions(+)

-- 
2.18.0

