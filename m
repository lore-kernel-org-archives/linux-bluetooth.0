Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DA1FF7C8;
	Sat,  4 Apr 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292690; cv=none; b=kw/AeHZhBdA4xqXjCj6XKjlxwvoUVTAMP3aca+JPOZIdenApOB7nIuibfY7HcAy0BNYrxe7/78R7JtASMaVKCRnxjfLAQBwPxA5bCYGLXkRkHC4M1NpakO2ES2uSr7Hm6AQzWY6OoPrnqoZOC6JTCPVczapO2iaH8fZv86EjVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292690; c=relaxed/simple;
	bh=WRw1bxyb6uIlTxQSz9IZ4RDVQ6UJeNWe3qwUutsSzAM=;
	h=From:Date:Message-ID:To:Cc:Subject; b=R80GVmwGpRCLdZb5kynyDQCO2771m3QjjKZGY05K3Eh4rhCC6YHA7+xPe5C2Kpntje7D9iatbfIBBiB76jvGn44arvOvDVzaFzCw5MuOl/9qAbwrqUlMpsJzYPzNqPC+G0tm3Dvq/Bsao0UQktUUbmu2cCVKMTJD1yrscnRWLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0002-bnep.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowACHFwsG0dBp_7RzDA--.49444S2;
	Sat, 04 Apr 2026 16:51:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 3 Apr 2026 16:56:12 +0800
Message-ID: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] Bluetooth: BNEP: validate control header bytes before reading
 them
X-CM-TRANSID:zQCowACHFwsG0dBp_7RzDA--.49444S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfCr47AF4DXF15uw1xXwb_yoW8Zw1kpF
	W5uFs8Kr4kXr13AFWxta1rWa4Fvw1v9rnFkF4qvasIvr13tr1Sg34xGFy0qa12krZYqr47
	GF10qF1UWwn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_Grv_XF1l8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbb_-PUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

`bnep_rx_frame()` pulls the first byte from the skb and immediately reads
the control type from the remaining data. Short control packets can leave
no bytes in the skb at that point.

The later control-message pull logic also reads `skb->data + 1` before
proving that the length byte or 16-bit filter length is actually present.

Validate the required control-header bytes before each dereference and
drop malformed frames through the existing bad-frame path.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/bluetooth/bnep/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d44987d4515c..0e7a7fb758c9 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -299,18 +299,27 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
-	u8 type, ctrl_type;
+	u8 type;
 
 	dev->stats.rx_bytes += skb->len;
 
+	if (!skb->len)
+		goto badframe;
+
 	type = *(u8 *) skb->data;
 	skb_pull(skb, 1);
-	ctrl_type = *(u8 *)skb->data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
+		u8 ctrl_type;
+
+		if (!skb->len)
+			goto badframe;
+
+		ctrl_type = *(u8 *)skb->data;
+
 		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
 			dev->stats.tx_errors++;
 			kfree_skb(skb);
@@ -326,12 +335,16 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		switch (ctrl_type) {
 		case BNEP_SETUP_CONN_REQ:
 			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
+			if (skb->len < 2)
+				goto badframe;
 			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
 				goto badframe;
 			break;
 		case BNEP_FILTER_MULTI_ADDR_SET:
 		case BNEP_FILTER_NET_TYPE_SET:
 			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
+			if (skb->len < 3)
+				goto badframe;
 			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
 				goto badframe;
 			break;
-- 
2.50.1 (Apple Git-155)

