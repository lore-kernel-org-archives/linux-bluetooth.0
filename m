Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621FAD58;
	Wed, 25 Jun 2025 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824533; cv=none; b=Bz+t+GQiImXXgNNIOjQOAqyZgKQzjknBk0onWIosinXLWvEqlWdeQVuLlXV6nyiYu42gPPkLzfPnRj+qwjnm3/1KEn+8jojeKjUlyy54zeYrABB9GR0zfV/7qnG0y37eNp0M033E/ycLeNEEnwExSTf1ARfqCeQ7RuawnYADU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824533; c=relaxed/simple;
	bh=vgdvLRlPLCYrAhl1nOrGhy+5oImhNZsIBbEZYKIX/hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYsKAAJCtHT7Aury7og1U95KkSAai5tEUABdB44kdS+13QUtFUyhR6GFujrlicEyWBU41cFjuQv0J6a8Zs9guhrK0lizKWgC9yWUNWUbb4dxBQaKF6yYYUaDWf0uU7L71eZz6OviKdnx4YIW+hDLJNHfKLK2i+edxtYxQw+LZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACHCglJdltottQjCQ--.56888S2;
	Wed, 25 Jun 2025 12:08:41 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chris.lu@mediatek.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] Bluetooth: btmtk: Add missing usb_free_urb()
Date: Wed, 25 Jun 2025 12:07:03 +0800
Message-Id: <20250625040703.1021358-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHCglJdltottQjCQ--.56888S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF43GrWxJrWfZr4kXFWkWFg_yoWfXrgE9w
	10yry7Wr4UG3srA3W2y3yfuFZFkr1rXF97WF9agry3XFyDWr1UC3WjqFyDtasrWr4DKF17
	Aws5uay8Jr1xJjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8oGQDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add missing usb_free_urb() on failure path after usb_alloc_urb().

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/bluetooth/btmtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..a95b1074ad36 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1043,8 +1043,10 @@ struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
 	if (!urb)
 		return ERR_PTR(-ENOMEM);
 
-	if (btmtk_isopkt_pad(hdev, skb))
+	if (btmtk_isopkt_pad(hdev, skb)) {
+		usb_free_urb(urb);
 		return ERR_PTR(-EINVAL);
+	}
 
 	pipe = usb_sndintpipe(btmtk_data->udev,
 			      btmtk_data->isopkt_tx_ep->bEndpointAddress);
-- 
2.25.1

