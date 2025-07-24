Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E732750EA;
	Thu, 24 Jul 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347091; cv=none; b=LhdChJqu+m3EB0/Ma8NDy6l3WilIHGPi9Toyfg4sGVxXnW/3hoaMTqXFpUQ5ORvtOMV0wFI4sE3URUAe7dsCtRV3sH+Qpe58tHXKI68bo8m47Tk5fXyc7/hoKdO8gN1EauTtenfJH0mgbt9JG0OzE1bLhQ5xHLTLgiPr3D6qx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347091; c=relaxed/simple;
	bh=0MF3y+rsrnzc2WPZ7ul+sUTsoHFEe6/Qvp6ikrIARSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoB2XDfuQVk4B3qAAbsxDLUYOBA8ifgM8gIrakdVGMTItHMbGdLPH1TuwdrrrplnwjO1cS0h6Wgdvn+ZNnNicToZ5UheHLYyhIhUZ+a6vZmKuNWk9mrx0wr+6p1ovMvwJHZcWVAnrVsXyNiyy8RvgGIuGb4X5J7iPvbiUrZNxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PEa0PoFt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PEa0PoFt"
X-UUID: 5efe3e80686b11f0b33aeb1e7f16c2b6-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Hdj2jKHN4mlD4Wq/VqFtggztXanlgzjUHfeEONfy21c=;
	b=PEa0PoFtYAW3ew4h8DuiB3andL2iBWlnJvidyGJnTLHqJC0iLvSmWiqzdl5Ln4EmIit4OGF2t2Ir4f2VGQNDaW+BPsuVVcVWIyzv+ow1pr4JkJT9gv7HHO8/lWItgif1YBHgwLk7Fug2xxheyr3aDRgAERkeMQDe9V63HTpVSN8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:913923d4-30ae-4216-83b7-2232315112e1,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:6d58399a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5efe3e80686b11f0b33aeb1e7f16c2b6-20250724
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jiande.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 391881407; Thu, 24 Jul 2025 16:51:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 16:51:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 16:51:18 +0800
From: Jiande Lu <jiande.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	"Will Lee" <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, Steve Lee
	<steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Jiande Lu <jiande.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown
Date: Thu, 24 Jul 2025 16:51:17 +0800
Message-ID: <20250724085117.2678313-1-jiande.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

During the shutdown process, an interrupt occurs that
prematurely terminates the wait for the expected event.
This change replaces TASK_INTERRUPTIBLE with
TASK_UNINTERRUPTIBLE in the wait_on_bit_timeout call to ensure
the shutdown process completes as intended without being
interrupted by signals.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..a8c520dc09e1 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -642,12 +642,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	 * WMT command.
 	 */
 	err = wait_on_bit_timeout(&data->flags, BTMTK_TX_WAIT_VND_EVT,
-				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Execution of wmt command interrupted");
-		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
-		goto err_free_wc;
-	}
+				  TASK_UNINTERRUPTIBLE, HCI_INIT_TIMEOUT);
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
-- 
2.45.2

