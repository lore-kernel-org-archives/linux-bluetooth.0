Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66E36AF6
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997759; cv=none; b=LP85aKcwxhxT6wDN7OrZ8tHKmkwEftkMjrWA5suEMhnMNFlGQxJQFJpkOJkPlbJjB4bL3iRkElsT7w7881yiHZc6fEyaZKrIhO4uvzW5/DpR/BAIJnw/2OoigbvAcIFKqCv3qXhpAlz6DmI0jrLD95JPQE/UBF5CDvn6UrwqpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997759; c=relaxed/simple;
	bh=3gUS5VaFFiple/h4cebb3m+zxevEkB1uaILwaddg7L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhyur+0fT/Nd+z4H9YoVs3TUpoEDcmGkt/XMaukUToXWj1+E8YCUVf5Jk7NKjxH3trvbtP/4o9L9y7DftVZ1AcfuDy4jsXMCb1irzft3LrHKmlegX+sCdB90sAxE2lzQHkW88j1sl58UNOiery/BSRwTOX4+r/H5ZjNYTQAcKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=wlgUPMTd reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="wlgUPMTd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=RE5G6mOyXu
	6bETRT2X5hfMS8gyJm6/FrvNVMDaFdMOo=; b=wlgUPMTduTEEYDqf3ZoEf1zNPD
	+ZkRAo8RQeCdT8u1A8iGiXqA8aUNUmFVLr30yEkn3P03vhjH18NsRP0cw4WSfpxu
	MwBjBDsUc57hEvJ3YRJbdnKUG8/Ox2Nxm2mnfaaomk8hd/SpRLZyPfeV2EVulM48
	40dQmu/cNs8XsCSs8=
Received: from LAPTOP-JT1HMN2S.localdomain (unknown [113.54.240.51])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkC23DbtWQlquUsgAg--.36952S2;
	Sun, 17 May 2026 14:02:23 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	linux-bluetooth@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH v3] Bluetooth: btintel: Use skb_pull_data return for bounds check
Date: Sun, 17 May 2026 14:01:42 +0800
Message-Id: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkC23DbtWQlquUsgAg--.36952S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7CF1xJF18GFyUGrWrGrg_yoW7CF4rp3
	43CFZ8ZrZ3Aw4aqF1Yqas5GFn0vryfGw1rGrZ2yw17CwsxK3W3J3ZrA345Ca98Kr4kZF1f
	uw4vvrs29rn5t3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUejgxUUUUU
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

The length check at the top of btintel_print_fseq_info() verifies
the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
function actually consumes 74 bytes (2 * 1 + 18 * 4). When firmware
returns a packet of exactly 66 bytes, the last two skb_pull_data()
calls return NULL, which is passed directly to get_unaligned_le32(),
resulting in a NULL pointer dereference.

Remove the insufficient length check and instead validate every
skb_pull_data() return value, branching to a malformed label that
logs the error and frees the skb.

Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer information")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
 drivers/bluetooth/btintel.c | 106 +++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 27 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090bd8..0c42ee53fe2e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3358,14 +3358,9 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
 		return;
 	}
 
-	if (skb->len < (sizeof(u32) * 16 + 2)) {
-		bt_dev_dbg(hdev, "Malformed packet of length %u received",
-			   skb->len);
-		kfree_skb(skb);
-		return;
-	}
-
 	p = skb_pull_data(skb, 1);
+	if (!p)
+		goto malformed;
 	if (*p) {
 		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)", *p);
 		kfree_skb(skb);
@@ -3373,6 +3368,8 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
 	}
 
 	p = skb_pull_data(skb, 1);
+	if (!p)
+		goto malformed;
 	switch (*p) {
 	case 0:
 		str = "Success";
@@ -3396,65 +3393,120 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
 
 	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Reason: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Global version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", val);
 
-	p = skb->data;
-	skb_pull_data(skb, 4);
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
 	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
 		    p[2], p[3]);
 
-	p = skb->data;
-	skb_pull_data(skb, 4);
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
 	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
 		    p[2], p[3]);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", val);
 
-	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	p = skb_pull_data(skb, 4);
+	if (!p)
+		goto malformed;
+	val = get_unaligned_le32(p);
 	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", val);
 
 	kfree_skb(skb);
+	return;
+
+malformed:
+	bt_dev_dbg(hdev, "Malformed packet received");
+	kfree_skb(skb);
 }
 EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
 
-- 
2.34.1

