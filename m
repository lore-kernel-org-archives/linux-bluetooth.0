Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C072242D6A;
	Fri, 16 Jan 2026 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550857; cv=none; b=JBJ67sepWd7LJfqNWuCFJWcwZIiG6uqvr+LImR5CWyKLsY0bMWSGCJfvJZV2AnyvTgBRwXjJEpfbNr018upnOiF8T1ve4yiDbusMkcHLk24R6aG6+HPoq4CD2IySSb+xA73s6IbAmJUEqxVUQUsSIT26bUXifXFAf4uyYQOlhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550857; c=relaxed/simple;
	bh=y6m1uHq6UjS8WL5eHZiISR8a3O8G1M7YNaChsWq/KN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R49MwgAp7m0OSpI59PGmIWuCjUDgQaIi83m6ujawNfU9nj4UdjX/clgJgOJ97Vy4INrM+rmv/Cc4LW5nOMJ8Tbej3OSX64vInIZg7JWZrsJJm9JtB22FJCHS8IzO7Zg8x32eEOdHvdIjLi88Q94A9XzGzNzE+p8B2a/gMg+bXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAHEci88WlpTu5RBQ--.27225S2;
	Fri, 16 Jan 2026 16:07:24 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] Bluetooth: btintel_pcie: Remove unnecessary check before kfree_skb()
Date: Fri, 16 Jan 2026 16:07:03 +0800
Message-Id: <20260116080703.379903-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHEci88WlpTu5RBQ--.27225S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF17GF1DtrW7Cr1xurWDXFb_yoW3Xrb_ur
	1rA3W7Aa4UGrnIkF17urW5Z34Ykr9xXFWkXFnIqrW3J347Ar4ku34j9r98G3WfWrW8GF9F
	yr4UAr48CryUCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26rkl6F8dMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjTitxhQUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The kfree_skb() function internally checks if the skb is NULL,
so an explicit check before calling it is redundant and can be removed.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/bluetooth/btintel_pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2936b535479f..3b035cb6a111 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1190,8 +1190,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	skb = NULL; /* skb is freed in the callee  */
 
 exit_error:
-	if (skb)
-		kfree_skb(skb);
+	kfree_skb(skb);
 
 	if (ret)
 		hdev->stat.err_rx++;
-- 
2.25.1

