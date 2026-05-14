Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FA33A007
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777369; cv=none; b=K145kMidcbxyA3FUz2ELHu9c7+OV3kBjfcK2G5Wv6HIYXiiNxA+jDQwMfZWyJ5dQh0HuQV+gHYGcfpEAiK1Qa+Qp2I5AJKGlp3ZmaxJKnkjtiW6HHKoWkwCjjkYcbLa62m+HiaA6X1F9X8j/numjW2XRujTHTnDNnSV7ulH9r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777369; c=relaxed/simple;
	bh=l+xmCVEyPdAb9K1ctr9c/Ygy/JE438VcPj1UnVYn4A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tlVDeAC0KWav50aN+Ml2ZLWyAsULeFSk2qDzRh1RNpxxaaBr2GAWAUcYf9ibSav4ME3nCTcfnqVVgu5UNJ/OlBfZpuk0pl24gNDENNWqq+F5fJnHZKr6BpfUTTUGiRK4qgMx/yd6YfOSnd8LjVa5K9Rak+BgxA1QN0fUgS2u0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=S98Cp1uA reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="S98Cp1uA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=c97RPJcOUO
	W/mKWk18UVkwinIbG8O02sSWjnkaxk8pE=; b=S98Cp1uAFQlpclSzZS8lJrAgTM
	5WAP+sG+zoxz5l6w9eYtq5OpnYQkCGIooRshW5sZ05SftF91hDHT+yQ8frXOlMFl
	QUMak3d1fqWdSDDQgI4ScTk/XKIn/Xc3dbdewSW2cbj/GmFdMqNOUOs5P8hg33XI
	GjuIzB5JEL8kh6Gaw=
Received: from hotaru.tailb307d0.ts.net (unknown [183.94.22.109])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkDWu7sM_QVqXvsVAg--.62713S2;
	Fri, 15 May 2026 00:49:18 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: linux-bluetooth@vger.kernel.org,
	kiran.k@intel.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH] Bluetooth: btintel: Fix insufficient skb length check in btintel_print_fseq_info()
Date: Fri, 15 May 2026 00:49:13 +0800
Message-ID: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkDWu7sM_QVqXvsVAg--.62713S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Gr48AF4DAFW7ZrWkWFg_yoW8JFW8pa
	y7GFyUAFs3Gw4IgF12qF4rAr90vw1fWa43GF97Aw15Zwn8CrW0gFZ8KFyjqa4DCrZ5Aw1Y
	y3Z2qFn7GF1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

The length check at the top of btintel_print_fseq_info() verifies
that the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
function actually consumes 74 bytes:

  2 calls to skb_pull_data(skb, 1)  =  2 bytes
  18 calls to skb_pull_data(skb, 4) = 72 bytes

When the firmware returns a packet of exactly 66 bytes, the last two
skb_pull_data(skb, 4) calls return NULL, which is then passed directly
to get_unaligned_le32(), resulting in a NULL pointer dereference.

Fix the length check to account for all 74 bytes actually consumed:
  sizeof(u32) * 16 + 2  ->  sizeof(u32) * 18 + 2

Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer information")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dcaaa4ca02b99..114a8beeab92d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3356,7 +3356,7 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
 		return;
 	}
 
-	if (skb->len < (sizeof(u32) * 16 + 2)) {
+	if (skb->len < (sizeof(u32) * 18 + 2)) {
 		bt_dev_dbg(hdev, "Malformed packet of length %u received",
 			   skb->len);
 		kfree_skb(skb);
-- 
2.43.0

