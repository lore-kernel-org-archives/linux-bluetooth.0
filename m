Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92335836E;
	Thu, 20 Aug 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217576; cv=none; b=fQYOxyaBWiLWW5mS2OGJmgNsFHQOFd0uX/vpGN7mEVzYknGP9iZoLbPhXHZKb9pE6CWkQLEmThu5/dK58nVOUR7dNYnPxNqI6ExW5DHhuUxTcv/OsLgq1dVGEZNEtkLSrXvoakxGPDEJKDdxUuTnO3ZQ0F3RKDuIRw/2Yqalh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217576; c=relaxed/simple;
	bh=nOtss0TxCtmWdavoL7v9pn+0B0ICzGQGg10gKsPVpVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7zHtA2gHEnnpAUvGlk51jkkwVCNI6BmU5S/WLe3iwTLyLR6CtCokVdntBmlro6C2WW5GOs8SQaX1nZMw4lB8zXR3bwXbb8G5MG1w/niZ8pQTwjcCIh+oC1y0Fc9nAt+DMWXMZboWW0+UpBCTzuXDafm5cQyetwCmpNsk2hQCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RqF6TXdw; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RqF6TXdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787217535;
	bh=GoEKBmJAt8A3ik2//Pv/SnjBVCtMlg5xJdeBJ33wumM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=RqF6TXdwW4HPgmVA/Su6gENwOYS7vSsO7ODvb36H0FkgrmGR0goWPEGwbxz7/ABL6
	 Hy00IIzedMWKdQZoKPWVrEoS481ds/kHW7Dkpa90lmfxoOM2JvKCnOTftAPcG8xmoW
	 22KDo4Msbq9t6ReCCrtmEFGCKZXMbmSSf0rAIOGY=
X-QQ-mid: zesmtpgz4t1787217527t383c08ee
X-QQ-Originating-IP: yAWf75JrCXRBpkI+bEOJlyQKFVf9z7Y1+lPGW1bKpII=
Received: from [10.10.7.64] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 17:18:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1403180757750471603
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 20 Aug 2026 17:17:40 +0800
Subject: [PATCH 3/3] Bluetooth: btintel_pcie: Fix bounds checks in RX
 completion handler
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-btintel_pcie_bounds_fixes-v1-3-c9dcd1ac8bf6@uniontech.com>
References: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
In-Reply-To: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MdzdX6p4PZzklCHKoGpLZBbFi7kvlpQe8XtDNQkiiOv8o7YodMQJHV70
	DUNxjC5iGkdpsuLgP4KSzgZQyJtXXwkdZ5TeN/Dn9wSC3HhgzrHg7rq0K7ldICNJYs4mNRq
	VpmkdO7XvqQoF+g8D6/4WNFALCAfuD9TarvS+LXqAzycEyPtRRmu/fJspEaLnnIYNsCEw+R
	38+rZy9gJjg2ToP5RLTcZnkl3SvNGno+DND6viiNv6bscus9WFPTnuKU7/IhB//8eeuocMn
	NzSQvEjl/up+UKShr+Wj7wN/4bLPCjN0jN6PYsgOXnO6SVxdsMdnUNq/S8suw5DuXi60nlU
	XSVgyX8+RYV733kkkNkk6WkQrAIw8f96VmPUstudU3in4zee4W12JsZy2HLfTmVjMJfTgr9
	NWWVkW4xbAyx6UKcPxdpxC89iVdnBA0+aBy0bzW93AgP4RgIA0R6hnG8hZ0x0iYfyDncRuK
	slt/+4wKdnzC5ohoowYmUUKdYGKt54ufpDPiIU2m2abmfRVG3CPFNLI45EJidFzMo3pYTxS
	8hpEDh4/llJzdtnnzvWT7uaeJzZO6oQCM6tbiEOJlgCbd+Am44eWzYNCcQfaQ4QvYebdleL
	0ml8o6n5KKmwwsckeROy4m5bx2VKKeSLYq5FloqOqqEQ05o/aLDH8sZ/JU3Gpqw/6rVmBbu
	pQFKL7sxpyVPF857zYgE7MCr5emv60SRx1N2BUJbE8uSoQmSZHL8hBhrlHsK8Fz8RO6QsMJ
	TK8PkxMU/AKPKs65X8lOrBKGB3uvhySYeVFh5XjfEG/WXxZgxE+5SEpvJthzPWAjDilUzU+
	z7f3hS6vl966zCwzA0OGmUI2nv7r/mmZIqrqAXkE+s8VGXsYwgSu+VOq1iVbKl6qVu7HHRs
	fjPQXm6Gp33iLEKduhf7F7UXZBIhu7kPRf/6TW/dRdmgDthHD4t7S+sUyr5lV23z+Sj4cd0
	sQZ8p8n/TbME6kWNEPhT2rMMec8HsY4st+OpamcHn85Mo37JWy5YDAUE5rm5He6Y9nKXCRi
	6o+Bdm/4EEH32PwLG9NQbZBydLTgWokJNdDAMlBteR7UkhxjQc
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Fix three issues in btintel_pcie_msix_rx_handle():

1. cr_tia is a device-controlled value from shared DMA memory
   (data->ia.cr_tia[]) and is used to index rxq->urbd1s[] without
   a bounds check. An out-of-range value could cause an out-of-bounds
   access when indexing rxq->urbd1s[]. Add a bounds check before the
   array access. When cr_tia is out of range, reset the ring consumer
   pointer (data->ia.cr_tia[]) to cr_hia so the queue can recover on
   the next interrupt.

2. urbd1->frbd_tag is a 16-bit device-controlled field (0-65535)
   used directly as an index into rxq->bufs[] (64 elements). Add a
   bounds check. Read the field via READ_ONCE() to avoid a
   Time-of-Check to Time-of-Use (TOCTOU) race, since the field is
   in DMA-coherent memory and the compiler may emit two separate
   reads.

3. All error paths in the while loop use 'return', which exits the
   handler without advancing cr_tia. This causes the RX completion
   queue to stall, as the next interrupt would process the same
   corrupted descriptor and exit again. Change to 'break' to exit
   the loop without further processing.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/bluetooth/btintel_pcie.c | 44 ++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index c1fd5feb9f81bbd70fabd12b12eb4a1708f6a91f..1f5537df620972d937f65e754701f65566e4655a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1586,7 +1586,7 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 /* Handles the MSI-X interrupt for rx queue 1 which is for RX */
 static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 {
-	u16 cr_hia, cr_tia;
+	u16 cr_hia, cr_tia, frbd_tag;
 	struct rxq *rxq;
 	struct urbd1 *urbd1;
 	struct data_buf *buf;
@@ -1608,21 +1608,53 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	 * process all received CDs in this interrupt.
 	 */
 	while (cr_tia != cr_hia) {
+		if (cr_tia >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid cr_tia %u >= %u, contact device vendor",
+				   cr_tia, rxq->count);
+			/* Reset consumer pointer so the ring can
+			 * recover on the next interrupt.
+			 */
+			data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM] = cr_hia;
+			break;
+		}
+
 		urbd1 = &rxq->urbd1s[cr_tia];
 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
 
-		buf = &rxq->bufs[urbd1->frbd_tag];
+		/* frbd_tag is a bitfield in DMA-coherent memory;
+		 * read the full word once with READ_ONCE to avoid
+		 * TOCTOU race with the device.
+		 */
+		frbd_tag = READ_ONCE(*(const u32 *)urbd1) & 0xffff;
+
+		if (frbd_tag >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid frbd_tag %u >= %u, contact device vendor",
+				   frbd_tag, rxq->count);
+			/* Device provided invalid data. Leave cr_tia
+			 * unchanged so the error remains detectable
+			 * via repeated log messages, aiding debug.
+			 */
+			break;
+		}
+
+		buf = &rxq->bufs[frbd_tag];
 		if (!buf) {
-			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",
-				   urbd1->frbd_tag);
-			return;
+			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %u",
+				   frbd_tag);
+			/* Unexpected NULL pointer; leave cr_tia
+			 * unchanged to keep the error visible.
+			 */
+			break;
 		}
 
 		ret = btintel_pcie_submit_rx_work(data, urbd1->status,
 						  buf->data);
 		if (ret) {
 			bt_dev_err(hdev, "RXQ: failed to submit rx request");
-			return;
+			/* Submission failed; leave cr_tia unchanged
+			 * to keep the error detectable on retry.
+			 */
+			break;
 		}
 
 		cr_tia = (cr_tia + 1) % rxq->count;

-- 
2.51.0

