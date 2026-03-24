Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F33D9DB0;
	Tue, 24 Mar 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342307; cv=none; b=Rw86BsmqRrlXUTm+qi9HM03eO0Zb8Hwni28M/czYuJi0U4SJ7V/bHrOKfK79rRAYiPFkom65iTIClwCm1X3cyMqegUTg8f6PJfVc1c/Qfpg4Ul0n4PvcQrIfT8S3LEwp1vADt2yLZ0ESY2j5Ty+xVth62VW9nXeooz675eUdtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342307; c=relaxed/simple;
	bh=g6RKEge0GayQZJaveOGeMqx8x1x7iWGaa6lu3XLRlb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTUfuHqRbi287qzAj7iPc1wjCxmN70Jpks/k3/FzykcxXELl9GzttjPbfO8dUiOHWj3iN/ca1rsbLQU5Hes45XY1Go2uWr1MR7SRQJja8MemehoR6kgLKC0FwV1SN2DllpT5ETb27V/z1xmv1Avc1LtPTxgV5a/u4qsBaU23/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADnj2ufUMJp96b8Cg--.2045S2;
	Tue, 24 Mar 2026 16:51:43 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Bluetooth: btintel_pcie: validate completion ring indices
Date: Tue, 24 Mar 2026 16:51:43 +0800
Message-ID: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnj2ufUMJp96b8Cg--.2045S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1Dur43uw47AFy3Ar13Arb_yoW8WrW8pF
	WqgFn0yF1kXF12vwsxAa1rXFW3Wrs3A347C34xZ3yrWFn8tryktay5tF9Fq3yq9rWrGrW3
	ZFs8Wr9xCr1UWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU0VbkUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The MSI-X RX and TX completion handlers trust the shared ring indices
read from data->ia.cr_tia[] and data->ia.cr_hia[] before using cr_tia as
an index into the fixed urbd ring arrays. If the device reports a stale
or malformed completion index, the driver can step past rxq->urbd1s[] or
txq->urbd0s[] before it gets a chance to recover.

Validate both completion ring indices against the queue depth before
walking the descriptor arrays.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btintel_pcie.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..06c2b81f2b6e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1008,6 +1008,13 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 
 	txq = &data->txq;
 
+	if (cr_tia >= txq->count || cr_hia >= txq->count) {
+		bt_dev_err(data->hdev,
+			   "TXQ: invalid ring indices tia=%u hia=%u",
+			   cr_tia, cr_hia);
+		return;
+	}
+
 	while (cr_tia != cr_hia) {
 		data->tx_wait_done = true;
 		wake_up(&data->tx_wait_q);
@@ -1403,6 +1410,12 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 
 	rxq = &data->rxq;
 
+	if (cr_tia >= rxq->count || cr_hia >= rxq->count) {
+		bt_dev_err(hdev, "RXQ: invalid ring indices tia=%u hia=%u",
+			   cr_tia, cr_hia);
+		return;
+	}
+
 	/* The firmware sends multiple CD in a single MSI-X and it needs to
 	 * process all received CDs in this interrupt.
 	 */
-- 
2.50.1 (Apple Git-155)

