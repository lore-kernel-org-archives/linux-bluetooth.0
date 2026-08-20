Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F73E3DB8;
	Thu, 20 Aug 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217572; cv=none; b=cMypjJjlOFRQBzToV8e4JY/712tbNY6BronjwxWa+H5Ic4Uh4wGOPTx9d7qcXzVOX2HIKiZbZ8M/EDlIQq6YJ0kPv0S6J+fTKIXUtbKQqBNMhkcE13tBhMKkYH61Sqr+b0YIP5gXRokVV10AilU6C9zZUq6xy4Cd/gDseDAg2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217572; c=relaxed/simple;
	bh=wABNHtf/jhl+bCNfxQywUxmlPEEYiVZNUBWI1h1LDXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzND8nJRCrK5Ekf4bK++tsADgSt3AzSZU+evB/VNbskzIjkez1ctdHLY90hyeAiKGE4pdx12mYbS0+D9d63ejCcwpeZ4qWV9jzL8tLawzcrXX1jpeEkRr6/ZCz0KSRT02/Iujdwv2msGadvizHFbJMUn8ZZ92NnjJY5gPRLeQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E58AmQHY; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E58AmQHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787217529;
	bh=esuAdSeFMgBZzfHd91AAGsnCrEFkcP/WEbPLnlNUfJA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=E58AmQHYPvW+xuKbryDf+aMG2fMFgSnSgx7YRmNf3ZjGNwbRt59Wn7jKV39AunoMA
	 VkG+OspGiH7BloLHNxFRMJG6NjKqitqlkC/Z7alA2UXYefrADRIjDji/VO0ov5eq/R
	 Enr6gmwSPWqzgd5ridoslNd/bxzFF8NKqSnppD4Q=
X-QQ-mid: zesmtpgz4t1787217524t79f4ffad
X-QQ-Originating-IP: 8FtOVKAp088ggL563eHGGJT4HGNEB+CM8HTvtCnnIoE=
Received: from [10.10.7.64] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 17:18:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4207000441139473809
From: ZhaoJinming <zhaojinming@uniontech.com>
Date: Thu, 20 Aug 2026 17:17:39 +0800
Subject: [PATCH 2/3] Bluetooth: btintel_pcie: Fix bounds checks in TX
 completion handler
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-btintel_pcie_bounds_fixes-v1-2-c9dcd1ac8bf6@uniontech.com>
References: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
In-Reply-To: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OWfylOJ3yY502n6RMmKVAeKagMtJudRQGOOSm6i08j1wC8+DkO/vu8iO
	Emt0kBc9vp0xGbCmvD1Mud4RoOoPMRhpoeP8xdk8Hn4jIiS7oNnTSqOA2jKaq7yWoDcsNux
	xK+eX9fh4h+BHrGsoyqqPUs6K7MOXSIlvbuunn/V8Mqv+c//9CZfiGzBqaLiPhZRT/11LwC
	enQCzP0i6pnbSJiJJrNK0ffetYLHh0+drl5mRyF2L9f3Qz9mHnCL1iBVd2SEgT1YO3Q4eUt
	Z/NZOWnOvYIjdg7pTLPCVxzsSy8LV6Hd8RXeyzTy3v2GIyFXvDbd2EfUpRfon9ty+vYVChk
	aWjLt7IILQVrzE+3P2CzugLNGbUidEwZ2bef8d+iFnG4ZUfuk7u5NtUOOCG3ljengN1GbAG
	Gn3je8N5xIlflr6KMLSjqm7POzd3HG8aBGz4P5TrIaaj4UKo/vcJJAoy0+XLki7BpxmaCTK
	S6G8Rv8gVJHQZ5PARuRwgFBXBh6wXGNAfPnjN4gc3YJpj9Rg49ktLyHxK8rJIkTbS42mnHX
	vgo3G7JVc9U9EVuWroPd9YXgWeCpHSSIlb1ADnO0rhUitTbt+evTj64XgVNsExk7vlme6yh
	doY6nNtucMfD6SnuZT2u4s5vcoD5earBRoKBUPB6xEQVcQLmsTWqj7gP+YI1Mm+njvNs9/U
	N8mQpxJ2UUtE0GJEkHgMOwGPsHJh/sc/aufeE0lfUtqMgef5KxAkb0DyG1Suy0qUo/qhz4c
	fd+yvsMvuwNKIgtSg2Mwh1OxyqtemWrCR313CI/E83x4HMETAwGwE1p/x0O+92+74LVQCA3
	seBBwTwgp1WttZiWC9ZuZhuk2+Il5XxnVhl7iociEyPP58qCKJkaBSUq3Y1PKo44Yeb0LHI
	8ANJsAlE+qDkPwWeAf4cNMObu+6H8T1LgidWOy7I4n4ndSjG74GJkIxAlXCVM9WHjH+VQcB
	B+/Hwppb8pA1dUO2o9npyP6Wf5p5a2rk+h+dhb0ratOHlx/viDP9tJTle2hu6AGG3DV+eVS
	ktTVEdDvsVLs2HKxrZH+U0O+UFs3V7dUt29FL4IduYYR8xBIsYWCjXqo3EbEELYMMUi8Spi
	w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Fix two issues in btintel_pcie_msix_tx_handle():

1. cr_tia is a device-controlled value from shared DMA memory
   (data->ia.cr_tia[]) and is used to index txq->urbd0s[] without
   a bounds check. An out-of-range value could cause an out-of-bounds
   access when indexing txq->urbd0s[]. Add a bounds check before the
   array access. When cr_tia is out of range, reset the ring consumer
   pointer (data->ia.cr_tia[]) to cr_hia so the queue can recover on
   the next interrupt.

2. The existing check on urbd0->tfd_index uses '>' instead of '>=',
   allowing tfd_index == txq->count (32) to pass. This check guards
   against a device-controlled value, so the comparison must reject
   all out-of-range indices. Read tfd_index via READ_ONCE() to
   ensure a single atomic read from DMA-coherent memory.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/bluetooth/btintel_pcie.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fe50c5699e12ef3819577e0f0bd1b79d4340bd9e..c1fd5feb9f81bbd70fabd12b12eb4a1708f6a91f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1081,9 +1081,10 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
  */
 static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 {
-	u16 cr_tia, cr_hia;
+	u16 cr_tia, cr_hia, tfd_index;
 	struct txq *txq;
 	struct urbd0 *urbd0;
+	struct hci_dev *hdev = data->hdev;
 
 	cr_tia = data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM];
 	cr_hia = data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
@@ -1094,13 +1095,36 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 	txq = &data->txq;
 
 	while (cr_tia != cr_hia) {
+		if (cr_tia >= txq->count) {
+			bt_dev_err(hdev, "TXQ: invalid cr_tia %u >= %u, contact device vendor",
+				   cr_tia, txq->count);
+			/* Reset consumer pointer so the ring can
+			 * recover on the next interrupt.
+			 */
+			data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] = cr_hia;
+			break;
+		}
+
 		data->tx_wait_done = true;
 		wake_up(&data->tx_wait_q);
 
 		urbd0 = &txq->urbd0s[cr_tia];
 
-		if (urbd0->tfd_index > txq->count)
-			return;
+		/* tfd_index is a bitfield in DMA-coherent memory;
+		 * read the full word once with READ_ONCE to avoid
+		 * TOCTOU race with the device.
+		 */
+		tfd_index = READ_ONCE(*(const u32 *)urbd0) & 0xffff;
+
+		if (tfd_index >= txq->count) {
+			bt_dev_err(hdev, "TXQ: invalid tfd_index %u >= %u, contact device vendor",
+				   tfd_index, txq->count);
+			/* Device provided invalid data. Leave cr_tia
+			 * unchanged so the error remains detectable
+			 * via repeated log messages, aiding debug.
+			 */
+			break;
+		}
 
 		cr_tia = (cr_tia + 1) % txq->count;
 		data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] = cr_tia;

-- 
2.51.0

