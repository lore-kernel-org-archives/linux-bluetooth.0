Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAB82488;
	Tue,  2 Jul 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919866; cv=none; b=bH9oq2mPU4heYCBiRl3Jpkz0VX6eeiISkPH3kWqky/fg7nqHHD38ugFRIWghxUVLVQo1DWHhNJY7PR9Pzt5ffQZDBuV96jTWhGWUS+rX1kQcnVPLOr7PkdyQ468MsRWkQLDwbo3nxMPY2CvEE+DLPnfdYGsZijoQVqKRgM1GNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919866; c=relaxed/simple;
	bh=O/NaBstB9RnIYuECwX67sY3wFIDL8b0HrxUOGr1YdeM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMS0/QaQ3xgKAvxiWDmepd4eIOI38izocZnxEu0RlKnMphIgOvoo+McOzOWmLkMfp7mcKVSsdFhILwdvXwR7q0KUS/y6zaht70eGP1iZ5o+s3pwLgJLDigWZrPyvDGCl5Wp7Zr8oU/Lo12B0nKCgGdUt7Ub5czdOBFHodWjwDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UjtdM2Wn; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UjtdM2Wn"
X-UUID: 8c322960386611ef99dc3f8fac2c3230-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Evj1YWaQPw6lYLdYgH+5msLoO1mYU2S6QiKCnoWtnak=;
	b=UjtdM2WnKMrw32omIlQ+s+NKmE2+lYMRBPa6n98WVHLwQxqaxBqLIkYfdCV3/UWdfTA4y/5Hv8+CHJP5XlL61GFLyLrsYTsmGVHc6eY/Vo9dN2aFWoYczARodqnP+EU+hpjUu9bl8eYqW08oBFu/rGxIOp1Urw6JqemTN/rtlPs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:0f3126da-244c-47dd-8bd8-d3182b9d2021,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:61adf90c-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c322960386611ef99dc3f8fac2c3230-20240702
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2098175106; Tue, 02 Jul 2024 19:30:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 19:30:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 19:30:53 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v6 0/8] Bluetooth: btmtk: MediaTek ISO data transmission support
Date: Tue, 2 Jul 2024 19:30:43 +0800
Message-ID: <20240702113051.24372-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.277100-8.000000
X-TMASE-MatchedRID: YawPgqJMp2/aYQdwXEMf70j2sPWKvtn0DRi0jfY6gL1oNGY/OdYkWWAI
	1go6d1sNmMN+S0FpW+8dHzBmTYIGm/Iejw19Z0aTQpxiLlDD9FUTdZ2aR9/IIMA5YKm8dwM65iW
	++W4offu6ecT5yQFR4EBUIG+nR2ZxYwXAgt8PtiDJ1E39jKDimIB84MMvKleaQQ1XgvCe7sHYn6
	D1t7z3wzS82RAJWQKfrqh8I79FEaFo3s9tP0IpFlz+axQLnAVBgRykyfrH1xl0Rk5xb2PnlpYL7
	nsDLhyNsbZZJEWTIt0rUpVFYCuHihxy/wjCDOrangIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIx1FP
	lNAAmcCrXjPAr1KAIbBk5zWijuCdq9M4zAWcKz81caPWRVi5ap6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.277100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D7FCC029EC926081402D3949BD64AC2D0F04598942E4DB4F6CA4FBC4B0BED1292000:8

Since SIG has not yet clearly defined the specification for ISO data
transmission over USB, MediaTek has adopted a method of adding an
additional interrupt endpoint for ISO data transmission. This approach
differs from the current method used in the Bluetooth upstream driver,
which utilizes existing bulk endpoints. The interrupt endpoint provides
guaranteed bandwidth, sufficient maximum data length for ISO packets
and error checking.

Driver sets up ISO interface and endpoints in btusb_mtk_setup and clears
the setup in btusb_mtk_shutdown. These flow can't move to btmtk.c due to
btusb_driver is only defined in btusb.c when claiming/relaesing interface.
Once ISO interface is claimed, driver can use specific interrupt endpoint
to send and receive iso data. ISO packet anchor stops when driver
suspending and resubmit interrupt urb for ISO data when driver resuming.

---
Change from v5 to v6:
fix test bot report error
-move usb.h declaration position to each c file.
-fix returned value in btmtk.h when returning a pointer.
-simplify commit message to avoid word number limitation.
---


Chris Lu (8):
  Bluetooth: btusb: mediatek: remove the unnecessary goto tag
  Bluetooth: btusb: mediatek: return error for failed reg access
  Bluetooth: btmtk: rename btmediatek_data
  Bluetooth: btusb: add callback function in btusb suspend/resume
  Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
  Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
  Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
  Bluetooth: btusb: mediatek: add ISO data transmission functions

 drivers/bluetooth/btmtk.c     | 1059 ++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h     |   91 ++-
 drivers/bluetooth/btmtksdio.c |    1 +
 drivers/bluetooth/btmtkuart.c |    1 +
 drivers/bluetooth/btusb.c     |  751 +++--------------------
 5 files changed, 1219 insertions(+), 684 deletions(-)

-- 
2.18.0

