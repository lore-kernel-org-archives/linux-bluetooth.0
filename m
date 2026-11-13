Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586798;
	b=ZKgGfACnxd4bmmWrQnOSSvvOAxciSrGc3qct2phHPqLtpOpRC0Em/KcEtoCTUUSEhHZO
	 iz5TYuYlxS/90cVCbFnSLW+Cp0R4naZHyG9GgW4CpBEctI+s9EuR2jmdZJAgIsjfq1O1M
	 hv302Njuzw5Qz6RjLydpzJ4PWomz0LlMNe/kv1/eXdfHie0DVnDfPbPjrihRYb7yi2sfk
	 HV+DuVxypdyJfY5hLDOSMDqmwjBvEAls8chFT8SZ0QRCWZjHugC0Kds6nN+cOVoq01D4w
	 lJB1nbuOcwE3u9YJJK/4wr2R0OnOeNOoZ34yM+tfGltYuSF21hq4cJuwGcVQq7mAFvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2bpTbbh1B6Gur/LofHfiQPTDkvaPlZd7pMl6FgTKSlY=;
	b=K7TGRgAZg8cSYbyn6AlZLopfZ8tqYT7d2g7CRfMf1VPWRFUw9Tok142KfVZBPO29ARgZ
	 qa8D4mbm6YjsUWUrfzVESHh+cyAqg76AgtQo1aSm4k3cQXDTO0w6Fh8XeF8fb5wq3KVrf
	 i3Uz9NBRHv3QljeTfUwsEyAUiomrFBlxIwC/WiPktX6wOPu/QtVklunAjMBjp4eo2gZW9
	 oz0aruVSEnnEMdg9VUUo56QAdo8r1AXVaIprXEtf9JbPxHy7N6BtZDc8E3pU00Mj8zegD
	 XmO651ETAyB7v/f1OqQJbaepyo+4XmQJ1Unfj/WrTWph5cultGuTF9SZN6hmAgn0QYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=li5TSezJ;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D593606A897
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D593606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=li5TSezJ
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eae12762c9so401011e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586797; x=1795191597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2bpTbbh1B6Gur/LofHfiQPTDkvaPlZd7pMl6FgTKSlY=;
        b=li5TSezJIVuIpOoTSvhTgu49bwhaFKwdV0zxQLLYuApsw3k4JClZWfvKsMY0UJ5zoR
         KzNDSpgHU4QaS9jY5tMGYLWQY+0u5TkGqFwqqo87zZhVY8XDkEiHvZXQzi7UpdNV2Xaj
         hK/Terh81bLr6Thurp/oG/wol2Tt3N3x1ZuaRQ9Nmuqvhq9aeYaTEcLPfadNaolqaVDV
         dtTFD5UMKhy2VRzKo6DU8wPBJN2NW6OGFHpM3mOc8ATEekSToJ+NKdQ88PkLGBcecU8L
         ElQmguChJQ5wbWI0ObrRGVxlWq7tAWeMu3StD1xMLN0ymwU3v6b7HY4JVbay0fxQdD8/
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586797; x=1795191597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bpTbbh1B6Gur/LofHfiQPTDkvaPlZd7pMl6FgTKSlY=;
        b=DsYteOTtLePC4BDIz9mr5YBns/9+J3MXsPpYf6YOmVbCFPyrkMwGF4NvmGF2qIZeRV
         AbHhttmxUl7QjSPzESLZ5IaWTVanL/Ll8U3Ahz6xSM+2UeiUn0Ej/BK9L97mOFp4dQwm
         EzqA/J3ciMSa6moU2TEL2rKPOK68GASTBOV19pr5iUopG2+y6IP9kG80CW/FSNatJtH9
         s+6/fQ1f4lFmSm9ApEm7sHi56MU+VErbeUYqOO9FyF5gnegG/lVaAZdbGqzElof5JTbN
         rW6XJ8YBX5eVMGIMQpbGdiQ1CqUAzQvcnx9EUXKxaNMflWebpL0xFjHUQUQSSud9r1CO
         j3+w==
X-Gm-Message-State: APuU4Z+WtiCSg2gBP073WPC0uDCIYiKDQ2u2Q7/zU3IKjC0DtbI0wRvX
	A31jcBC10I9bX6t4/JntpAxZ7Xe2FaytlpJTGEzlJII15/XQtsAoUVMDmo8jurh9mmk=
X-Gm-Gg: AYBFou1CqF6513DofcXZfi5YC+aKBQyNinJxzCsh0D0uqJDXJ5q+pKpxuPueL2mv0cZ
	O98Jx09viOPQ0Hxz5oTK8eBd5dRYE56YuYLKpkBVjyeCWH7THEK4hmtjNmczkXQZNJy4sP6rglh
	Lst03DXOQ+rQWUUUPTTOp3Ca71S4MtHotGj4BUuyXl35Agpc792GTCTakrr66eLbgLsdRuwQw1K
	Vb0r3PTmBuKKzYoQRy28qMQaYEi3YTOuH7IfEWH6B76DRpBEaep1wX3X+nrqLxmk+vAA54rtkby
	KhfwWbg363FWdc17ki8qpQR3xrug+Rs4DeO4QQxay++zhulg1ZFiwK3zdNJ6fAT96Z9QN3jGZ2A
	daqswZflqaaTb3T3bFMyJhynn7tpCXNRWWRVbaKe/Th3cIgDLPDjwVer4unskz2cxcIXQTBswE7
	ywncsM9mgBzY2nmSYoMedruhXx0Ughs3xx3Y9ebrVaAj7hoI4sOXxng8gBfN6ljuzYHbBNiSK0G
	YChYcbCb9pAjKMydVztQ7tiyzKgI6BctRkTJgQg+ISlEkZCYlUNto1zrQAQqAfLJk/u57LA5zBG
	Aiz1AnOcGQPFH1/K05MqR/HiH+H5hNFz8hGBY1xjaetcWNWqVRAa16gTUriiqiVnMBe3QCzgzc/
	/tzIj4TUDn38DyKMymM2UeAeJpSMjQ3NGNt/NEwvlkDNKd3bH5H3Y/dLkWWrik5J9N3PQGo9L5S
	bBKE8=
X-Received: by 2002:a05:6122:3a15:b0:5ea:db3c:4a3f with SMTP id 71dfb90a1353d-5ee3465a723mr1000093e0c.2.1794586797050;
        Fri, 13 Nov 2026 08:19:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e59f7csm1588547e0c.7.2026.11.13.08.19.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:19:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: 6lowpan: Always consume the skb in chan_recv_cb
Date: Fri, 13 Nov 2026 11:19:52 -0500
Message-ID: <20261113161952.926201-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The l2cap_chan_ops recv callback takes ownership of the skb on success and
leaves it to the caller on failure.  chan_recv_cb() violates this: when
recv_pkt() fails it returns -EAGAIN even though skb_share_check() may
already have dropped the caller's reference to a shared skb and replaced
it with a clone.  The L2CAP caller then calls kfree_skb() on the original
skb, over-releasing it, while the clone is leaked.

Make recv_pkt() free the skb on its drop path and have chan_recv_cb()
always consume the skb and return 0, including the lookup failures, so the
caller never frees it again.  A dropped packet is accounted in rx_dropped
and no longer reported as a receive error to L2CAP.

Fixes: 11e3ff707278 ("6lowpan: Use skb_cow in IPHC decompression.")
Assisted-by: OpenCode:claude-sonnet-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 8c51c20f6c4b..68ca2f49dadc 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -345,6 +345,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 	return NET_RX_SUCCESS;
 
 drop:
+	kfree_skb(skb);
 	dev->stats.rx_dropped++;
 	return NET_RX_DROP;
 }
@@ -356,21 +357,26 @@ static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	struct lowpan_peer *peer;
 	int err;
 
+	/* The skb is always consumed, so never return an error that would
+	 * make the caller free it again.
+	 */
 	peer = lookup_peer(chan->conn);
 	if (!peer)
-		return -ENOENT;
+		goto drop;
 
 	dev = lookup_dev(chan->conn);
 	if (!dev || !dev->netdev)
-		return -ENOENT;
+		goto drop;
 
 	err = recv_pkt(skb, dev->netdev, peer);
-	if (err) {
+	if (err)
 		BT_DBG("recv pkt %d", err);
-		err = -EAGAIN;
-	}
 
-	return err;
+	return 0;
+
+drop:
+	kfree_skb(skb);
+	return 0;
 }
 
 static int setup_header(struct sk_buff *skb, struct net_device *netdev,
-- 
2.56.0

