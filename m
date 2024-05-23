Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA214A611;
	Thu, 23 May 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455951; cv=none; b=UzTRxPSPQWNiMSGD45asdI2bBXtHIx8z3YdXV+FcukrHkpC/8aDdcQ8HXcFTs/jXYez6ODqcHvR05L59Au5jBPmDrPJG76MvI8YoIPgy0W40IVqu2CSXte2iYDKihTQ5eJ8RbKtwLc52qe9x93STFTDKT5jxe3cMwohw5F4UbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455951; c=relaxed/simple;
	bh=tQuy0uP30EbfAn8TGq5g9Z9/8T+P9+C+ScEtuin+UOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llT4p/hefvLlil7c7RFGB4ohYVOgFHIxu9G1Ynod9k9mbY/yZsxmFiYr7d3PWgRfmHaUlhG/b6fFdpQkZ7nm4bzbM3dcz9uln0+0ZHioUetURnEA0bj2guR7fTe+eyFhE7UaRblOP4bOhu/AUdDmroMry2wwkbqGuu4/eOiS+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7aa799b418e511ef9305a59a3cc225df-20240523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:cc5c2a70-4647-4726-9717-05fe619875fc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:cc5c2a70-4647-4726-9717-05fe619875fc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:6128a8db6d4a1389b61d91186139327c,BulkI
	D:240523171858W37SIIWU,BulkQuantity:0,Recheck:0,SF:17|19|44|66|24|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7aa799b418e511ef9305a59a3cc225df-20240523
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1359282934; Thu, 23 May 2024 17:18:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 62D2DE000748;
	Thu, 23 May 2024 17:18:55 +0800 (CST)
X-ns-mid: postfix-664F09FF-2518491106
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2EF4BE000748;
	Thu, 23 May 2024 17:18:54 +0800 (CST)
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	yunshui <jiangyunshui@kylinos.cn>,
	syzbot <syzkaller@googlegroups.com>
Subject: [PATCH] Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
Date: Thu, 23 May 2024 17:18:50 +0800
Message-Id: <20240523091850.1117138-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot/KCSAN reported that races happen when multiple cpus
updating dev->stats.tx_error concurrently.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
---
 net/bluetooth/6lowpan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..b8906f55e2b2 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -295,8 +295,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_d=
evice *dev,
 			goto drop;
 		}
=20
-		dev->stats.rx_bytes +=3D skb->len;
-		dev->stats.rx_packets++;
+		DEV_STATS_ADD(dev, rx_bytes, skb->len);
+		DEV_STATS_INC(dev, rx_packets);
=20
 		consume_skb(local_skb);
 		consume_skb(skb);
@@ -323,8 +323,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_d=
evice *dev,
 			goto drop;
 		}
=20
-		dev->stats.rx_bytes +=3D skb->len;
-		dev->stats.rx_packets++;
+		DEV_STATS_ADD(dev, rx_bytes, skb->len);
+		DEV_STATS_INC(dev, rx_packets);
=20
 		consume_skb(local_skb);
 		consume_skb(skb);
@@ -336,7 +336,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_d=
evice *dev,
 	return NET_RX_SUCCESS;
=20
 drop:
-	dev->stats.rx_dropped++;
+
+	DEV_STATS_INC(dev, rx_dropped);
 	return NET_RX_DROP;
 }
=20
@@ -445,13 +446,13 @@ static int send_pkt(struct l2cap_chan *chan, struct=
 sk_buff *skb,
=20
 	err =3D l2cap_chan_send(chan, &msg, skb->len);
 	if (err > 0) {
-		netdev->stats.tx_bytes +=3D err;
-		netdev->stats.tx_packets++;
+		DEV_STATS_ADD(netdev, tx_bytes, err);
+		DEV_STATS_INC(netdev, tx_packets);
 		return 0;
 	}
=20
 	if (err < 0)
-		netdev->stats.tx_errors++;
+		DEV_STATS_INC(netdev, tx_errors);
=20
 	return err;
 }
--=20
2.34.1

