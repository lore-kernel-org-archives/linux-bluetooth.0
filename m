Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A1347BDC;
	Wed, 21 Jan 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963972; cv=none; b=sr9NROrHUfWWIIPuiPAv5J5fT66ZWP2KpsauutU+MmGaxGAL9m+cGVw5/gtfNiVivQbM9iWixcCHV6sSTl/uIKS+l/tlFLe28kDYN1ff86GK3C/ajYeuJjq1N+JlMS0+Z3yWegZeocib8/w3E9LJ4GccmAeRjxpZsHwQ0RLOO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963972; c=relaxed/simple;
	bh=zSrbq4gb+2d1ibai9lU732sHqM8zu+82T9buKHVXzxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWx5G8veuDw6EWfkUQ0d9Jb55f0Ig0tZgFtsVZExSnOWRKOUlLKGtSS1GOEDTIjTgB/FCPmJAACnfvyZTobKn0XS0F2kHKmhJZUNmqUvaj+0bY/Le/cVvG/txWIBBe/KFrnDtNUbet0WJgSFRTrfPdWDm0xKW5O9X5iF55Lmx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b6ff93af67411f0b0f03b4cfa9209d1-20260121
X-CID-CACHE: Type:Local,Time:202601211050+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5e9a4c2b-8d84-4fde-bb9a-f43a4f1a06b4,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:c355c25d5b97c17af5a519b70966a68e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b6ff93af67411f0b0f03b4cfa9209d1-20260121
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1298284442; Wed, 21 Jan 2026 10:52:32 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: Remove duplicate entry for 0x13d3/0x3618
Date: Wed, 21 Jan 2026 10:52:20 +0800
Message-Id: <20260121025220.2827845-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB device ID 0x13d3/0x3618 is listed twice in the device table.
Remove the duplicate entry and keep the one under the correct
"Realtek 8852BT/8852BE-VT Bluetooth devices" section.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded09e94d296..1ab44804f1ff 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -577,8 +577,6 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x13d3, 0x3618), .driver_info = BTUSB_REALTEK |
-						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
-- 
2.25.1

