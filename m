Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34F40BCB8;
	Thu, 13 Aug 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617502; cv=none; b=fHmKfY2svPyyxb1342z8ll+ePH7lIrENgJcgQw2lwzUX9Yjb49R92k/7SmftcixhTFcQTM/yCH8EsISLQwKeeFsexhS5QKuhEzzo4O4Na+0J9iRpHalCXa1MRCIdYyWFjwRIkVfPqdTX0uaCEwNZknHWI7MhvU0RquXgDmuPHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617502; c=relaxed/simple;
	bh=/kRVz1U3ZfegwFqQOxCUV4huwE7hKwGWipJrnzciWs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObAq4XPDjRibphm6U9ZW8PkBHJN72zUwq+vAzbUvbpZ2KpQ2ROQNE9hegLGuhjCPC0kGFMwoibu+N+n6dbboGa9zQ9bvjAMvKQ+aqXqfzUOJey/TWFVEJsM4BEMxuWIJ5PpFUIzHvbtYcJUW9hd/bodCAANO8OvV+mrvX0GF+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jWn/3hu4; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jWn/3hu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786617480;
	bh=IQyLvqN9dDAYZi5DwkH4unuif92cEgEkNYcYTlgaVi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jWn/3hu47y0uMkxmQu+b0Jf/qX9+ZQKE9Y7dmt98Nx2WTp1gkEUXNhSgJRa6/Ml8U
	 9q+cxgPgZzygmr6AdBm3LDd1CHnKuyUc6XEM059E8pxWV8Nw1BeMJzWvqL2HsNtIhj
	 6twOhW/otx70i75jPwyJIcWHB/y9zQ+XuNt2wg8g=
X-QQ-mid: esmtpgz14t1786617464t25468cec
X-QQ-Originating-IP: 4ViZsiiWz4vdabz+VkSGy9T46sLW7qLzow5ufxtS/jo=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 18:37:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6107983473547452707
EX-QQ-RecipientCnt: 7
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] Bluetooth: btintel_pcie: Fix array bounds check bugs
Date: Thu, 13 Aug 2026 18:37:34 +0800
Message-ID: <460316663D6D34ED+20260813103734.222955-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nm+M45NE9/e2H4astSyiSPH5eN/CK9jbMwaKLx8Fu4+K5MSJCKwha1Mf
	k74z6rToLK3EyklLS4PBq7PFl123xifAsk3kQSJTv5qWfRhpqXWAw2zwSjd4MyxUcNztIb/
	uPozU0p/XLet7ZF/i4BeSbexkhhh+3olXwbqEqUTnV1MMn3UJxJD7jtYYsVc/uaDpVBDM6p
	xhS9OrQ6J56yiuY5PX53uZf2IwqkTfyz6ovEHxj+ppt7uBcj6Q/6YUBA56aWDDcJB8U9wMC
	gHtraQzVR3E4xJFBWHAVE3U0YaDnAagdB3Ynxon/kDaRqWBrLc/XrrsustXgO5wsHR+i5Df
	5Hv0dZ+idORDKreh8lIxjYLkwvj0qcOfOanE2nhpVI5nG/5WIKYhkI+qnSUYUwTE2WENMpY
	ER20pcdE0UsFJBk0HHLez3V8FX5qSbuCW65W0o/2sxnYnRsx9gydydEBLvodo9CH1x5Hp4K
	mZqWJKWVPyohDHRh+Xp96qAUuTtNsV7Rs6o1fC/rrdrZGF3pphw/fefCUiCHW64uW85Q/Xj
	2oCRqLOm4iJj6b4UthioFZLjGO/YjnFEw3UcZV8vJiIr1tPnu3/jz2nkU3bkwC2Zs5yDOK/
	z0ltyin1SmWZNqb/Y1SBnULLbERVPcjWa61D4KHpgzw2dc1r5r887UDnuQg996rmOKNgvKm
	vIRbvvG504xPYzp2GXdd06Nv8R+W0b5varv/bod1sHTKxsL+WofgPrFOzDLidlGNyI6CP5f
	QhyQ+Td+ioyEl8MBB9nVrzl+DaaeCz6czcnQyGu+IV62BQvW+Zc3AnjKILCC65sjWQBl/Yj
	His6saO51qh9u3QuyV+jKU95D09Z+5icWRgMKdoaHH6DNGZFGwR9KVWjYTnVsfpEkfSpfNo
	FhBRoosHK8iCnjmRXahxhYnMYXIe7DCgSq+Yqk7vufRHQvjxy5i1PJ05h3Tpl6+BiIDi4dz
	dZBsqooGCOLH3J52ZSKY4U33qJTss1VN7uM0zzVCctv6oacdA4UcuFRxV4dlb3c3l2OKgFe
	JVslGz5BSw72e4LhGCP0UPmn6giscyd5lCmPLt1g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Fix four array bounds issues in the Intel BT PCIe driver:

1. btintel_pcie_send_sync(): bounds check for tfd_index uses '>' instead
   of '>='.  When tfd_index == txq->count (32), the check passes and
   btintel_pcie_prepare_tx() writes past the end of txq->tfds[] and
   txq->bufs[].

2. btintel_pcie_submit_rx(): same off-by-one on frbd_index.  When
   frbd_index == rxq->count (64), the check passes and
   btintel_pcie_prepare_rx() writes past the end of rxq->frbds[] and
   rxq->bufs[].

3. btintel_pcie_msix_tx_handle(): cr_tia (device-controlled, from
   shared DMA memory) is used to index txq->urbd0s[] before any bounds
   check, and the urbd0->tfd_index check uses '>' instead of '>='.

4. btintel_pcie_msix_rx_handle(): cr_tia (device-controlled) indexes
   rxq->urbd1s[] with no bounds check.  urbd1->frbd_tag is a 16-bit
   device-controlled field (0-65535) used directly as an index into
   rxq->bufs[] (64 elements).

Fix all four by correcting the comparison operators and adding explicit
bounds checks on device-controlled indices before array access.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/bluetooth/btintel_pcie.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b7231be5973..32cfa0f5af1c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -401,7 +401,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 
 	tfd_index = data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
 
-	if (tfd_index > txq->count)
+	if (tfd_index >= txq->count)
 		return -ERANGE;
 
 	/* Firmware raises alive interrupt on HCI_OP_RESET or
@@ -502,7 +502,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 
 	frbd_index = data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
 
-	if (frbd_index > rxq->count)
+	if (frbd_index >= rxq->count)
 		return -ERANGE;
 
 	/* Prepare for RX submit. It updates the FRBD with the address of DMA
@@ -1094,12 +1094,15 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 	txq = &data->txq;
 
 	while (cr_tia != cr_hia) {
+		if (cr_tia >= txq->count)
+			return;
+
 		data->tx_wait_done = true;
 		wake_up(&data->tx_wait_q);
 
 		urbd0 = &txq->urbd0s[cr_tia];
 
-		if (urbd0->tfd_index > txq->count)
+		if (urbd0->tfd_index >= txq->count)
 			return;
 
 		cr_tia = (cr_tia + 1) % txq->count;
@@ -1584,9 +1587,21 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	 * process all received CDs in this interrupt.
 	 */
 	while (cr_tia != cr_hia) {
+		if (cr_tia >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid cr_tia %u (count %u)",
+				   cr_tia, rxq->count);
+			return;
+		}
+
 		urbd1 = &rxq->urbd1s[cr_tia];
 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
 
+		if (urbd1->frbd_tag >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid frbd_tag %u (count %u)",
+				   urbd1->frbd_tag, rxq->count);
+			return;
+		}
+
 		buf = &rxq->bufs[urbd1->frbd_tag];
 		if (!buf) {
 			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",

base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.51.0

