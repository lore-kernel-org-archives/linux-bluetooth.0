Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA161FC101;
	Sun, 12 Jul 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783865678; cv=none; b=DYE0+ssJabRU7dB3+UaoKFfik7XCLq/2EK57C1Aw+/LS9xfFYtJKL2rxKJZGvw7+VN0fj6xU0/GzbsSPyua4wJrIEK1EMnsaipvSuASK7dWfxxTZNCVA8KtS9e538bwhwOQu9Q0zSkF+e75oVrrHcp7JSeW+jEtx84Amdcg4BNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783865678; c=relaxed/simple;
	bh=2i3dWpBEPVYhwCIHuCMg86nb+4MhRDmjMslrzexl62E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RsU5BEUN+/H3iKy09/LvzKEZFjkh2lzSc5IdF5JF5eClF5WEhwoJZWztTS/T7rx9oxTLivywfzUurpdYml/QrS3qSu3bm2Ronf35F+b151RD9oFRqEvU5xMYRbnKJG9oa3zrSMxEhj5aTTFqSyEOYW0ywDjCuSF6yJnBxdFSDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B0I+KoZh; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B0I+KoZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YQ
	DH13ats/TZG7nL0B3A1Hus2i8X5UhqBoPufkQ2Q0g=; b=B0I+KoZh323Oi1/Jh4
	BTVt0wo+pMc66N2yc2C/NFH+McUPADglDEkedO94tHkJ7eOzrnlng+q3Pp5PYaDA
	Uq2mUqsgbxjglztgRZ2Tj90mOGxL0fixUbhFDr2JJHgMmg7pg+qoabuQJGi0M5Xc
	+IZrq9fZxbR2VG6VuMa2SMKoE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3H803oVNqUqQzIA--.1452S2;
	Sun, 12 Jul 2026 22:14:16 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Bluetooth: 6lowpan: fix uninit-value read in bt_xmit()
Date: Sun, 12 Jul 2026 22:14:14 +0800
Message-Id: <20260712141414.3188583-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3H803oVNqUqQzIA--.1452S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWxXr48uF1rKF1rJF4fKrg_yoW8Jw48pw
	43CFZ8JrW8Gr4fAr1vyr48WFZ8Ars8Wa47WrW8Z34Fvrn8ZrsIkr12gay29Fy8Aa9ay3yS
	gFy8Zwn3Crn7Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pir-BAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhjlIGpToTgImQAA3i

The bt_xmit() function lacks the skb->protocol check for IPv6 packets
that commit 3a5f3f7aff18 ("ieee802154: 6lowpan: only accept IPv6 packets
in lowpan_xmit()") added to the parallel IEEE 802.15.4 path.

A non-IPv6 packet (e.g. ETH_P_AOE) queued on a Bluetooth 6LoWPAN netdev
reaches setup_header(), which unconditionally treats the skb as IPv6 and
reads 16 bytes of uninitialized memory, causing a KMSAN uninit-value bug.

Add the missing protocol check to reject non-IPv6 packets before they
reach setup_header().

Fixes: 3a5f3f7aff18bcc36a57839cf50cf0cc8de707f3 ("ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/6lowpan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d504a363a30f..5729c6fbaf15 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -524,6 +524,11 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	 *   0 - this is a multicast packet
 	 *   1 - this is unicast packet
 	 */
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	err = setup_header(skb, netdev, &addr, &addr_type);
 	if (err < 0) {
 		kfree_skb(skb);
-- 
2.34.1

