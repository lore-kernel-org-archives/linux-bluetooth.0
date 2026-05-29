Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9AF1A6801
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060364; cv=none; b=tdP+FaYNbMBa3ZmQtL4waY0Ese3F+Aq9X1sMp1/8j0asgosD7tl1TUbWG8ByKMhxlx5YfYpK3TVbUWAZ3DsgJ2EnsNH0Z4U+sFZEy9UwMeYgH1Ev2tV6YVC6zoFVodofarKcuKtuaYPRcak579h7Ym8g/Wd+JNMykco2g2i3gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060364; c=relaxed/simple;
	bh=+sRwW0oyFOrhEoo2QyLjICbbjkX2pfB2x//iBnGeNk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5Jzs9i4J71cJmQj0vOuLnlv4mvYjCf5hArOoUXY7YhmXlrF+loAuHBnGu84vohmiCJxoUWETRWVdf47pYteozBbFPQTGVrM78AjpMzyeTQvxNNtCe/XkNdjXCV5EHEaq1Is6rUbUCZBIHDfO/KnCEuWnTUwZdNTRdiKxXniHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowADngwu+kBlqc0gTAA--.40960S3;
	Fri, 29 May 2026 21:12:33 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	ravishankar.srivatsa@intel.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	xuyq21@lenovo.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] Bluetooth: hci_codec: validate capability record length
Date: Fri, 29 May 2026 21:12:25 +0800
Message-ID: <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779633761.git.xuyq21@lenovo.com>
References: <cover.1779633761.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowADngwu+kBlqc0gTAA--.40960S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW3Gry7Aw18XrW5JrWrXwb_yoW8Gw4xpF
	W3WFnxtrZ7Jr12yrn7ZFWIvayUC34kuFy7KFZ8tFy3Xws8tr48Jr109FW0vF17ZrZ8Gr1U
	Z3WvqF93tw1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQECCWoZTE8FgQAAs-

From: Yuqi Xu <xuyq21@lenovo.com>

hci_read_codec_capabilities() validates each capability entry before
adding its serialized size to len and advancing the skb.

The current check only compares skb->len against caps->len, even
though the code consumes the length byte and the payload. Validate
the full record size so the cached capability length matches the
bytes available in the command response.

Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/bluetooth/hci_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 3cc135bb1d30..5bc5003c387c 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -100,7 +100,7 @@ static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 transport,
 				caps = (void *)skb->data;
 				if (skb->len < sizeof(*caps))
 					goto error;
-				if (skb->len < caps->len)
+				if (skb->len < sizeof(caps->len) + caps->len)
 					goto error;
 				len += sizeof(caps->len) + caps->len;
 				skb_pull(skb,  sizeof(caps->len) + caps->len);
-- 
2.54.0

