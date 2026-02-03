Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22523783DA;
	Tue,  3 Feb 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099922; cv=none; b=BytgrKBhSYG3WTqJk/T1aLX2OJfLm+hHxdK2DrO1AV8c2ZhU1FtDqwF8tBl8KGkrHBlTZVNxInxMYoG6IoMZRaasIVyTz/Z1MXpfXZ9aoWbBxakInSUerc1lKSWsEAqxebYbvocvTTT8N9q/xhZkBqcIv/XKMzRR0GJ7PgRr+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099922; c=relaxed/simple;
	bh=iq7Y5QOiK4OMBhcK+S1vsEo2isUr0+K4j1CMpIFSjFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GcCY0xU2x2czFHHAoS/XlbJyIUqsPUXjjSp2poT990lqvKnq7uwwRdb1NEiX/tkm7/cJ2VyD6i5FaCwGoPSV3rq30vz1tnecyaaN6Sr2OOWPRrRvApQurRCoFINZ8sK68/i+bTHi9S5Y0NuM3W7R7NJKFMM/DCDFzj/A4ZftrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PofFxX+w; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PofFxX+w"
X-UUID: 19131cf000c911f1b7fc4fdb8733b2bc-20260203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OP2N/nleBhBlAyv2V95uSRI6uJfND7JrtKouTkzXdkw=;
	b=PofFxX+wQ+EAk82PxtmR351gWXOg2lLxwO2pg9ASnLn561SV5uyUWfDriNfKqgFHGkFClQTERXKL9NlNFF+Fe9BPhl8eZKCe5xpAVM3xxxyvZiyU0U/8gtwVHPq93y/UQvu1cKVj5PL2ioSo3u9mpdUuseEgD0jTBkwP5tINA3U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:311ab801-d751-4822-b43b-7f03d358c1bb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:f593dd5a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 19131cf000c911f1b7fc4fdb8733b2bc-20260203
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1985120293; Tue, 03 Feb 2026 14:25:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
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
Subject: [PATCH v1 0/3] Trigger reset if firmware status is abnormal when
Date: Tue, 3 Feb 2026 14:25:07 +0800
Message-ID: <20260203062510.848761-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the device unexpectedly restarts during previous firmware
download process, it can cause mt79xx firmware status to be
abnormal in the next attempt. In this case, a reset should be
performed to ensure everything starts afresh.

These changes include:
1. Optimizing the handling after the download function retry
   is exhausted, a reset should be performed.
2. Another download firmware command also needs to check status
   , and if an unexpected status occurs, trigger a reset.
3. Adding a flag "BTMTK_FIRMWARE_DL_RETRY": if download firmware
   process enters the reset mechanism, this flag will be set.
   After a successful setup, the flag will be cleared.
   If the flag is already set, no further reset attempts will be
   made to avoid endless reset retries.

Chris Lu (3):
  Bluetooth: btmtk: improve mt79xx firmware setup retry flow
  Bluetooth: btmtk: add status check in  mt79xx firmware setup
  Bluetooth: btmtk: Add reset mechanism if downloading firmware failed

 drivers/bluetooth/btmtk.c | 21 +++++++++++++++++++--
 drivers/bluetooth/btmtk.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.45.2

