Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA023A901F
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765744; cv=none; b=h7H+IDgpT2v5ip4fsWXyyeoDpakyDrj/8FjBwBHTS/veEm/2L9UUk3N6Ub1hIG1TFWay2uM/qbct3hKvpoBKx0pIVnKkh6qN2kisYAQVOhcI3uC1V8RJX7H2cZIpkNHTZ46au6aP1f1UEnMe/paAIo30ZKzDDc7vbTUBk6vH2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765744; c=relaxed/simple;
	bh=rnxcw7J4R7Eg5F0T2dv/1y4FrmnZpn/k0T5LMYYH3XQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TD2FpqBmB+GlR7o3cnyQIf8rwXcaZ6R4k9Lrym02rxYlsxF0W4eBHtTQGBSUruszJ5d2bMqoewsTWiRurRyQeZML0DJwXmaLbh8xCzt+qDcTUHDmNMvLW6GeY/JnudE/N5x+vEza/Ppc0kqSZU/geDO8F2v1v7z3s6DJ1fJBXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QH2hcktD; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QH2hcktD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779765732;
	bh=sQy92Q+xfG3qNqoG0zsPkLGiLod6Eq2+4ca7v/BZtA4=;
	h=From:To:Cc:Subject:Date;
	b=QH2hcktDIY6l4RkgZN938JbA7om72sYPRT2r8/VODnpOHmwIHJnO556Saq9jzkxjF
	 5c/XkHRkJAopj0iZAFWqjU+y32bT8fM4MHYyIPK2VMAKyt+D7HjCiNz8wJQ8A5VrUn
	 xe2+nUmk1aI+yeWAkuEcYsJOg9DmTW468OW+A8pQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 58B31A26; Tue, 26 May 2026 11:22:11 +0800
X-QQ-mid: xmsmtpt1779765731t03p5e8yi
Message-ID: <tencent_859B04510A77948C6A97FF769CBB9262A007@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn6z2sDIcYzqvJHrUk5J+xRiIpcE7Sk7mt6Co9vQJcpJPOdF0cG6
	 eI7CHzTUJU8TsGxxEVkQxdJJzCRMPgtzfUxqcSDWbON8FUbyoXjVjWeFokrSQqUhBj45wh9Teq7V
	 76bPIi7HgVsZKQyME3FGfnlM6d3/XOpnes632NQBSLodeusPEX54PpVkrYNNQJ6euQcJSAtieJkK
	 +S9TdgAXqMrS85JFElcZdpBkxme66kuOeaE/ZUkOtw+5uwYPQG6pzEWXiaJZJvyd8bRky8BvhDPx
	 N3OWZBa3jDW7k/2H18xp9IeEWrzY/M9b8JdWoiUPKGYAAFV+dENgAMjumywpWMqqRTkdCqle+nH0
	 F4ZxiW3S1qbXccPmUlxep0RkYTn4NrQjY3AiIaa5d5VpKkzCW2YPGy3u3+PG0tvLG0vlWwKXyvJF
	 UQJRZRlBE+dtgIFAVtuORk7YT3IJaRORU7DOz8OaQ5SR86BmJeL+oGZMwTyMukKMqRXC/OfH3t8X
	 Lp4Ydn82cb0GYWVGdQPRB4/jW7t9PT96q63+g6tpgekIucPc0h/NVh+7/mmqg8zL3APWdZ7U0JY7
	 CeqmXkcDh5Uqld/FilzIC0diz9DagD1GztihP1aM4WZEMTo71NmCWmkcdXjeBWlXFguoECNAaL3j
	 xM4WlLIp7pHTdWcEKykzJummlPOhzNMbhXE3+7IPY5HbGQDZZLRIthme3KQOS0mchEjdq0T5fKrd
	 M2Zk1aSzcEuuw44rgnqvMpZ+GcnnHKVl4O+ZMJRtP9VKAWd/N79XU7+DBdqWUK3cRxDdsVgccIo+
	 0eiicDqCa6Uj0fNIrLCRzgC/jnMP7DCUbknB2h9tVcMk+AeXgQ2Wfyh0jtrNBOfmKA65L+Ij078Y
	 QEbA6JSWZ2dpznqjKbApPQ0O829Nv5rHTG8jsSpFJhllnZItToYjGNcfmdWFehsf+2XM5P0bupy8
	 LMgo0k0qr1mjv/WL5uWQt6Kv0UpuzsXEMPKkxuHvCPJJEfaS6uXkPGdzrnh6lL+YMggpzh+4Vk1O
	 H8n9L3rFFmmvTj7NO7crUjCbPtPiA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
Date: Tue, 26 May 2026 11:21:39 +0800
X-OQ-MSGID: <20260526032139.175296-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

The skb_clone() function can return NULL if memory allocation fails.
send_mcast_pkt() calls skb_clone() without checking the return value, which
can lead to a NULL pointer dereference in send_pkt() when it dereferences
skb->data.
Add a NULL check after skb_clone() and skip the peer if the clone fails.

Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..960a19b3e26d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -486,6 +486,8 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb)
+				continue;
 
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name,
-- 
2.25.1

