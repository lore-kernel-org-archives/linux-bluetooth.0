Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133E39D6D6;
	Mon, 23 Mar 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268256; cv=none; b=HqAuB38w4UAwS+pCpi4jsMteYZ2SVLhI0YJt4bTa9NYM5O8yVcqZBuQGJbs0z+Qt5wq5e7LyVjQrND0RqS8mDTGxrDEQz55jOIO8ZYzeqDmenFnICAAzs6uTWyJvgNaGaYldeC32s85BE78kJ8ZdQkbffZbf+NbwUu0WWeQPRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268256; c=relaxed/simple;
	bh=GUvgLMNUxBLvvjgnvOazg4LxkQI0BauitzjZzHeUcck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m50XJtllr5AcbdOr/U/Cd6bxkrOj/zFmTM14W429FMsXrMkSueoEvpkbPq6qUDuR/4mph55QWivcqdMDp/aw6tGywZiGPLFvOS+ToNTihl3YpM3WsYGmWcJUnx2VZR1sOK65r1Dw61JzF+gBYNK1sp8/5BFpi30EDBDCfR+HMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowACXstlbL8FpYIuMCw--.14890S2;
	Mon, 23 Mar 2026 20:17:31 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Bluetooth: btintel_pcie: validate RX buffer tags
Date: Mon, 23 Mar 2026 20:17:30 +0800
Message-ID: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXstlbL8FpYIuMCw--.14890S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UJFy8KrWfKF18uFyfZwb_yoWktFX_ur
	95AasrZ3yUJFn3Ga42krySkrWFkryfXF109anFqFW5J34kGrsI934DZrn8W3WfW3yUGFy3
	Cw18ur18Ar48tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUU9NVDUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The RX completion path trusts urbd1->frbd_tag as a direct index into the
fixed rxq->bufs[] table. The table only has rxq->count entries, while
frbd_tag is a wider firmware-provided field and is not range-checked
before use.

Validate the completion tag before indexing the RX buffer table so a
malformed completion cannot walk past the descriptor-backed buffer
array.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..4f6b3f00a49a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1410,6 +1410,12 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 		urbd1 = &rxq->urbd1s[cr_tia];
 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
 
+		if (urbd1->frbd_tag >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid FRBD tag %u",
+				   urbd1->frbd_tag);
+			return;
+		}
+
 		buf = &rxq->bufs[urbd1->frbd_tag];
 		if (!buf) {
 			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",
-- 
2.50.1 (Apple Git-155)

