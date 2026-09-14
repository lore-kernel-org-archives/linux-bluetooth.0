Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5B32A3C8;
	Mon, 14 Sep 2026 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369024; cv=none; b=kw3b8zTWqyhkFANwGt7vkcwktYGmSNFJpj6JD+j+fGmWPrlVG1QjOUxJgHgol3FNEwo2T8hyewGh2uSWMHHLBgjNdKUOxeTXfLmGS1aCST3w7rVfcP/zwRS08BNxR3jsi90MdGPx2ufqhtGF415Qqw4xGAyFIDCq0j2A8yPsduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369024; c=relaxed/simple;
	bh=TWWDLj90XRAuVu4D65TxeNSK1b9ZzjKFOo0P0HuwgYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2SL9RnLs0KJiAZ7gfcIMabkMuzXou6YdZlXIxwWCSUlMkkDzZVv4zeOh0tFkgU8p0RnBN09Nod2kvTEjwd9C0vAoYSionRPhIwxt3S53t2XwXnlDT/AX0vN5tCF4Fc/umLJgIiUMHReYDGNbvK05GAkGoXrGzPCD551g8zJQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cwJJ7eyl; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cwJJ7eyl"
X-UUID: 79e109d0b00911f18dc8c9802ae25ab1-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lXoHX0rruIcIzstzDAfy4nONDyIyMhoQ3ILdiO+rdOQ=;
	b=cwJJ7eylPKLDajoAPd4w+frC4A452T6tE4vX4tFXWiRYLmoVzxifBl3G+M16h3Uk9khLMftk75wZyMlZNEzwHJqEySwUu7jh+bRXwDPC4VVww+D+ZvzMhr/iXI9uYr81I/KgZwlkbXMBVynVJ86hox+LDl+BlqW2R7jE+aUtFDQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:903cc620-3ec6-473b-b405-cfbd4137dfaf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f661cee2-72a5-4ba1-af40-18bbd6ea8ffd,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 79e109d0b00911f18dc8c9802ae25ab1-20260914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 580446865; Mon, 14 Sep 2026 14:56:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 14 Sep 2026 14:56:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 14 Sep 2026 14:56:55 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 0/3] Bluetooth: btmtk: firmware debug event routing and WMT FUNC_CTRL status fixes
Date: Mon, 14 Sep 2026 14:56:51 +0800
Message-ID: <20260914065654.102916-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series bundles three independent MediaTek Bluetooth driver fixes:

Patch 1 is a resend of a fix submitted on 25 Aug 2026
("Bluetooth: btmtk: Route firmware debug event to the diag channel")
that received no review feedback at the time.

Patches 2-3 fix how btmtk_usb_hci_wmt_sync() (and its btmtksdio.c /
btmtkuart.c counterparts) interpret a WMT FUNC_CTRL event that carries
only the WMT header and no trailing 2-byte status word. Such an event
is a normal firmware ack for a plain enable/disable request, with the
result carried in the header's own flag byte, not a failure as the
current code assumes:

  - Patch 2 fixes this for btmtk.c, where a bounds check already
    existed (added by e3ac0d9f1a20) but defaulted to the wrong
    result.
  - Patch 3 applies the same fix to btmtksdio.c and btmtkuart.c, which
    never had a bounds check for this event at all and read 2 bytes
    past the end of the received SKB whenever firmware sent the short
    form. While there, it also adds the missing base WMT header length
    check that btmtk.c already has (skb_pull_data() before touching
    wmt_evt->whdr.op), since these two files were unconditionally
    dereferencing that field with no length validation at all.

Changes since v1:
 - Patch 1: review asked whether the exact match on the ACL handle
   (0x2efd) could miss a continuation fragment (0x1efd) if the
   firmware debug event ever spans multiple ACL packets. Confirmed
   with MTK internally that this event's wire format is fixed at a
   single ACL_START packet, so a comment was added above the switch
   in both btmtk.c and btmtksdio.c explaining that HCI fragmentation
   does not apply to this handle (and the other vendor-reserved ones
   already handled there).
 - Patches 2, 3: no changes.

Chris Lu (3):
  Bluetooth: btmtk: Route firmware debug event to the diag channel
  Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
  Bluetooth: btmtksdio, btmtkuart: validate WMT event length before
    struct access

 drivers/bluetooth/btmtk.c     | 15 ++++++++++++++-
 drivers/bluetooth/btmtksdio.c | 28 +++++++++++++++++++++++++++-
 drivers/bluetooth/btmtkuart.c | 20 +++++++++++++++++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

--
2.45.2
