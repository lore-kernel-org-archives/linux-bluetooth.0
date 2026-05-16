Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF532236EE
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903515; cv=none; b=IzURcziXXQU+7J+yawOoP8n8BPp1yEjw2VGTJ56HtqPeDez3LFHbIwdowMIGQ7crtfG34f03227Mx7zBsls9xKXFELoydvbI4670fvBtnp/Dk/+hwJNasLanfFgCYJ2FNwhOz97wKLbVT7npBbW7/7OoAjG9x+xZnTp6HCz0LTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903515; c=relaxed/simple;
	bh=Lt3qNKQRTpNNgLHIHyjDsZHxXYL2J4pC9fV4vKZ0ji8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Sn14SAmWmrXZXPVRd1bM7yWvdxYJ3HTJq0iU/0cvYH9NWKP0fAmIOySFzbL8O3FDAvLFdby1vNaa4dUk+hLxiCt9oVmlbmPTq8q/Mkj6rqcthJQGASV7QIYF0T803tUWzcfqWjdPMHFGYfDI8Dyqq430pF4UKvsLAhRL7U0eIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=X0CO8fMa reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="X0CO8fMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:To:From:Subject:Cc:Content-Type:
	Content-Transfer-Encoding; bh=f/CX+T14RA0QmiPEv1zrh7fx3H/aUUkHJk
	zIZx8hvHo=; b=X0CO8fMaOr2QCJGTc98VGZRTQX6/RlyoXU8+k6pMd1CmeEwulS
	KUtz4/3PLbWnI4kVT3gY2hYZWKCHvbAoC/2a5VF1usfTQIAa5nIIFi39sx+02ttq
	H9G1Z6ywRQtBd3fK6kjFYuKgxdOuz60pYXZhvkzqBpbCTnZoMq6yZRMas=
Received: from [IPV6:240c:c983:1:5c8b:50d3:b7bc:dd73:c1ad] (unknown [240c:c983:1:5c8b:50d3:b7bc:dd73:c1ad])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkD2lrLG6QdqTD0dAg--.26510S3;
	Sat, 16 May 2026 11:51:35 +0800 (CST)
Message-ID: <7dc0dfd1-7e23-43d5-a855-d1c73943d40c@std.uestc.edu.cn>
Date: Sat, 16 May 2026 11:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, marcel@holtmann.org,
 "luiz.dentz@gmail.com >> Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
From: Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH v2] Bluetooth: btintel: Use skb_pull_data return for bounds
 check
Cc: 2022090917019@std.uestc.edu.cn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkD2lrLG6QdqTD0dAg--.26510S3
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7tF4xAr4DZF17trWrXwb_yoW7KF13p3
	43CFZ8ZrZ3Aw4aqF1Yqas5GFn0vryfGw1rGrZ2yw17CwsxK3W3J3ZrJ345Ca95Kr4kZF1f
	ua1vvrs29r4kt3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vEOx0_Gr4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x0JUq385UUUUU=
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

The length check at the top of btintel_print_fseq_info() verifies
that the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
function actually consumes 74 bytes:

   2 calls to skb_pull_data(skb, 1)  =  2 bytes
   18 calls to skb_pull_data(skb, 4) = 72 bytes

When the firmware returns a packet of exactly 66 bytes, the last two
skb_pull_data(skb, 4) calls return NULL, which is then passed directly
to get_unaligned_le32(), resulting in a NULL pointer dereference.

This patch refactors the function to check the return value of
`skb_pull_data` instead. This ensures that every time data is pulled
from the `skb`, we explicitly verify that it didn't return NULL,
guaranteeing safe access. A `malformed` label is added to handle
early termination in case the `skb` is too short, preserving the
original `bt_dev_dbg` logging behavior.

Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer 
information")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
v2:
   - Remove manual length check and validate every skb_pull_data() return.
   - Add 'malformed' label for unified error handling.
   - Fix GitLint title length warning.

  drivers/bluetooth/btintel.c | 108 +++++++++++++++++++++++++++---------
  1 file changed, 81 insertions(+), 27 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dcaaa4ca02b99..053be9f88f7c3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3356,14 +3356,10 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
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
+
  	if (*p) {
  		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)", *p);
  		kfree_skb(skb);
@@ -3371,6 +3367,9 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
  	}

  	p = skb_pull_data(skb, 1);
+	if (!p)
+		goto malformed;
+
  	switch (*p) {
  	case 0:
  		str = "Success";
@@ -3394,65 +3393,120 @@ void btintel_print_fseq_info(struct hci_dev *hdev)

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
2.43.0

