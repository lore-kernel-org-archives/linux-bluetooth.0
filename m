Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5822533593;
	Wed,  9 Sep 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955242; cv=none; b=pndPHCf3fsKTzl9EDp4EhIF8fB0sElZziIuB/7erxDYT/FJv/cuwKBYVXuoEvofCkENhYq/6EJx4DyRE2XnmGiS8/R2aS6vLyyVAMrJdTuLe3w4jcWeWkW219e4+8N/qTT5w+PS+Jkr2bvPPEbNMwDFl1U7mooX08tOLe72qfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955242; c=relaxed/simple;
	bh=6ytdDyu+z2dx/LqddlafJ7bKpVfM51+v6bsQCEmLQmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrraUZK+0Pp7k5F1Y3gnPzh7ZI+QCTRVy90dj/aZvlRZnQ2BBrA8lLhMqQf44SS1TyxaODtVBWAxMT4GAP3NHfXunyctsStc4FzOoyBcNeMOkNbOZwlR4anaUBbmaUGL+qYqJ5JCOqwIIVAg3SEdVMS2NrZMeGmKwfT5k5+63u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VpxHxoLA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VpxHxoLA"
X-UUID: 0b304350ac4611f18dc8c9802ae25ab1-20260909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=C9QctYEqiTsdwLGcp7AZwfH3/JIDtpuPyDKHZOFDwwk=;
	b=VpxHxoLAM9Ez62LPhx/C49JI9EtFnWvQwIpxt+YDCZWGj5cC4Yk+qZU/APU0zeFp0uG1rk25f00OG2/IG8yXD88ZWqkNZhFxfRPPvh7ZtZeFx8f6X5pmJmX99l+maiKRAfmsJdMvauBsU5YqluXwwZ5o6p0QIQmn3A+kWAmIicY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:690bc7db-724f-4ae4-9614-9cdb180969dd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:63a191dc-e2a3-4c41-83fa-4adacd638ae3,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b304350ac4611f18dc8c9802ae25ab1-20260909
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1960534395; Wed, 09 Sep 2026 20:00:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 9 Sep 2026 20:00:14 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 9 Sep 2026 20:00:14 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 0/3] Bluetooth: btmtk: Harden firmware parsing and improve logging
Date: Wed, 9 Sep 2026 20:00:08 +0800
Message-ID: <20260909120011.1198001-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Three changes to the shared btmtk firmware download path, all in
preparation for MT7928 support but useful on their own.

Patch 1 bounds-checks the firmware image before the section map walk in
btmtk_setup_firmware_79xx(). Today the section count, the section map
array and each section's offset/length come straight out of the file and
are never compared against fw->size, so a truncated or corrupted file
makes the driver read past the end of request_firmware()'s buffer. The
section count is a __le32 from the file, so on 32-bit builds multiplying
it by the 64-byte map size wraps a size_t and a bound computed without an
overflow check would come out small enough to accept the file; both
helpers order their arithmetic so nothing can wrap. A section count of
zero is rejected too, since it passes every size check but would leave
the download loop with nothing to do and still report success.

The checks live in two helpers rather than inline because the MT7928
CBMCU download path added later needs exactly the same arithmetic and
should not carry a second copy of it. Bounding dlsize by fw->size also
removes an existing hazard in the download loop: dlen is computed as
min_t(int, 250, dl_size) from an otherwise unbounded __le32, so a large
enough value turned dlen negative and "dl_size -= dlen" then grew
dl_size instead of shrinking it.

Patch 2 makes the log line more useful: it never said which file was
requested, it reported the firmware's own hwver field as the HW version
rather than the device id the driver read from the chip, and it printed
the 16-byte datetime array with %s even though the array need not be
NUL-terminated. Both callers pass a real device id - btmtksdio reads it
from register 0x70010200 and btusb switches on it before getting here.

Patch 3 replaces the bare 1/2/3 sequence flags on BTMTK_WMT_PATCH_DWNLD
packets with a named enum. No functional change. The other bare flag
values in the driver belong to other WMT opcodes, where the field means
something different, and are left alone. Paul Menzel reviewed this change
in an earlier MT7928 series; the enum values are unchanged here, the only
difference being a comment added above it.

Testing
=======

Compile-tested with CONFIG_BT_MTK, CONFIG_BT_HCIBTUSB and
CONFIG_BT_MTKSDIO as modules, each patch applied individually, no new
warnings.

Runtime-tested on MT7922 (USB 0e8d:223c) over repeated unplug/replug and
Bluetooth on/off cycles; it comes up every time and the firmware download
is unchanged:

  [  365.233785] usb 1-2: New USB device found, idVendor=0e8d, idProduct=223c
  [  365.245951] Bluetooth: hci0: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
  [  365.245956] Bluetooth: hci0: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260605203811
  [  367.542038] Bluetooth: hci0: Device setup in 2244536 usecs
  [  367.601570] Bluetooth: hci0: AOSP extensions version v1.00
  [  367.601581] Bluetooth: hci0: AOSP quality report is supported

Chris Lu (3):
  Bluetooth: btmtk: Validate the firmware layout before parsing it
  Bluetooth: btmtk: Improve BT firmware logging
  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum

 drivers/bluetooth/btmtk.c | 92 +++++++++++++++++++++++++++++++++++-----
 drivers/bluetooth/btmtk.h |  9 ++++
 2 files changed, 90 insertions(+), 11 deletions(-)


base-commit: 701ca71884b3d101fd25b7adbf972355056ef352
--
2.45.2

