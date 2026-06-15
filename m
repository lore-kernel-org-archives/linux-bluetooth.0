Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78881403E96
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537398; cv=none; b=TRFYUzP4n1l0/ZijeXvIB2KShUUu8+HsGrP0+FNPdAiZt521I/nRdIQRwGP27hfy0hU1hnZNOo/h5V2dsV7M2+L3QDwbiziXHlTOPfBTT7o2vf/y+r2hGQc6qAs8bVXumBDOc8ML0kmGzU25rOWtGfVtDIjI5tCIs1pkQCY2654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537398; c=relaxed/simple;
	bh=VY9MaB+udtwVkQ5QkrCEmhX2XOq6NlZwoe460CbCgZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GqVA4ufXYWWDyJoU8CZ+kdKNwY+TBBooPkEO91M1+zYs0gScwCjKuxRhmiQMqjH/ByHmKnLsO3ieBB1pkMLolFvWOT0kd6rtXJPPo66QZV0fcRApKgmtz5FdhXVTD7CtZ5KS4ar9GG1eg5Q+XgBvkLqXaiG+BMyv84r1l1Vh20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsxJajVT; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsxJajVT"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59bbe027424so3171903e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781537396; x=1782142196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ahaST7nj1R3mXZy6uBsTD3TcAvfVmBiuliMDXJ3vnA=;
        b=hsxJajVTen4jt6RLXRGJTERJilVkgKWrBOg21bgX2bPG4wiYv6ywJndLgzwZuQzGbT
         IHgXkuUv/ioMaGfVHrOUq3ftcKEAhGXJHUy2mF/9FuzTUH+b8tYmtJqj1BCt2VtleZyD
         nPHHHgluzc7Tr43lwWKeOFKD9lW3irYsx7UpFR3Q2qVuR3h3alIxf+WIfHuA1Kq6GJCk
         Mi0+vFaO7rj6BnTM0d1HWRilJgptUmdCIu//IRV3eSefypt+LtwUIPTbXthT/dXbZ5NH
         Zk6Z5/SPLVk+oqe8PP0Q9SfasMH/DmOJ3zTbm6tszTDIsmUCdbmI3AGHX41y/R/dXSoQ
         CK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537396; x=1782142196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ahaST7nj1R3mXZy6uBsTD3TcAvfVmBiuliMDXJ3vnA=;
        b=brrELz3UUUJP4/tj4J4n+Y8qSPdnStgk4/CHmfd4dhGSElmjNMAMc4ELFZ8ssGyS1A
         qgZBHZS3iikhx+bFcs2zS8SWww1ftSeMdjOdSmft3OoRF5d5v4dqu/RNOdKBuLKgjLv1
         ITBRRmMq53YkBzOE70hxGNzK9yKkGuvXIybbt8Cp3gIkJoPDcCeR+rJIpoqanOvTXb9d
         D5aKfyQG+JjbRqSsdPe69i+ypFOBojxVrrPbGrlGiYy6pwmM+nMWvC47QcY9fD28LZRc
         wRdVP1s9CGOGUmBCEcrebT2bMx+CXXpz1TV+m+DzCb4qq/WCsxqmHzmu8s0FcE71D1Do
         CxyA==
X-Gm-Message-State: AOJu0Yx7ZUnYd8oFvh5kvmxFR1doYfU5ruBIuJJD7N50eOkLQ9CX+jIX
	51FbZJjNCe4t0b5Cy/P5R7uy94BLatjBW8HOtZhjS127vGf3U+FHmtAGHi2ETPzL
X-Gm-Gg: Acq92OFu5Pw0ebHk/3dDLsV2cmnG9P2NBUrruO7Fa9VyfKsQHo8myD9/EB1R7ht+Rf6
	HUBxtcxuLUY8NVYSrnM3EfSG/EHBtQvk6TgJ6+YHML/FLQv/le7p8gfIb1I1pWOkkNFoBKY9ABM
	MkoehUTqyAXvY2Nvc6PO86gXjBFA0FVR5uB+mJyyTqmqx3thpC1dWyS/y+r90VscxZEIWLQQx6X
	2Oo9O9WWi7aT73KZwBysI2Yt4eOaTT8ig6nedlbsPslAoMmN4+f4hkHUuuQBDTQAsvvDPdVGYaH
	MvaiRl9zw7LzvKRRssJr36UM6sr33YfQW+v+zHHYH6HNszw47etbVvmxUr2YGRoXJibUdZx4xEs
	wC4h+6PfoRHJzf3xWDgRtZqbbFmdY1jC6q8fGHSkxo/D491dBIb4+nP3s09Gcs1cHUVBy6hlMM8
	3drEdatvrrFzFJVPvwrpSKPaS6U+2MmtKMvVH8HgvwtUUMwC455IcTKd12q0rGVL6wfu/NEKPgx
	aZl0+ysMaDIBoXeHA==
X-Received: by 2002:a05:6122:d29:b0:578:9e26:e439 with SMTP id 71dfb90a1353d-5bb79bb61admr6232508e0c.10.1781537396348;
        Mon, 15 Jun 2026 08:29:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb90016c6csm3780139e0c.8.2026.06.15.08.29.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:29:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev
Date: Mon, 15 Jun 2026 11:29:48 -0400
Message-ID: <20260615152948.776154-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
conn ref") don't reset the chan->conn to NULL anymore making the bt#
netdev not be remove once the last l2cap_chan_del is removed.

Instead of restoring the original behavior this remove the logic of
keeping the interface after the last channel is removed because it
never worked as intended and the l2cap_chan_del always detach its
l2cap_conn which results in always removing the channel anyway.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..962e0e885105 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -797,20 +797,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_btle_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	bool last = false, remove = true;
+	bool last = false;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
-	if (chan->conn && chan->conn->hcon) {
-		if (!is_bt_6lowpan(chan->conn->hcon))
-			return;
-
-		/* If conn is set, then the netdev is also there and we should
-		 * not remove it.
-		 */
-		remove = false;
-	}
-
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -837,10 +827,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (remove) {
-			INIT_WORK(&entry->delete_netdev, delete_netdev);
-			schedule_work(&entry->delete_netdev);
-		}
+		INIT_WORK(&entry->delete_netdev, delete_netdev);
+		schedule_work(&entry->delete_netdev);
 	} else {
 		spin_unlock(&devices_lock);
 	}
-- 
2.54.0

