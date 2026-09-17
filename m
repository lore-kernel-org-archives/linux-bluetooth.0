Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6103B994F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617618; cv=none; b=kKs8TZEih0HBjWCClRDDopoRpidgjE2MNoO+TQYEcuX/vr/OYBBrkSfx4JkJ4TZETa1bFj/p9G394RzAGolpI9v6O3T5JHQy+6baufwysvwhtSpxLqTvjb8/PycCCP7QJQAN2AcCJi/4RW5u3NtytXt3oan9VhZplcbGVZssHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617618; c=relaxed/simple;
	bh=t6kqad3R5WgeKWtDof9fjSN4rKNL6g8fBl1fgnljyQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlkZc9tVZ356ADHBxXTdOfVdBAOJfD/Uz/pijfJA0IbC2t92MAE2WwwvkyhXPQpmPk9E+knBMTv+sLYZ2KNHf2O++TWY4CDUBX8hoF2G1jGqY27DyxpjY1VRoOXGu9gZC0T9AoWjQMqm/AwEYmc1SAZIoehM1xJeVsWJ9KpxmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRWCu49k; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRWCu49k"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so3341175e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789617615; x=1790222415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBijyL0HZR3/5g7v7DmejWL3K0668IdfViWW12KzHHg=;
        b=KRWCu49kYszdxlHpATD5vkmIMj2m8Kip6NJW/tt5iDBcrV/mep4+DF9I4W2VDvb8h9
         ILHMmk21bIooIfHTXBz1Bb0xqQ700Fu20BGvp3ouDBSdHijiXkhhJzocpnM7ln3nSpr2
         x1a1n68/0oqhei9FtT+kVAjxDMx8FuV1n15jsPw5iYCkCoa1d/MeagS1gTUTf/Td/zBc
         fR+pDGybqD19mbkla1VMryN7fsbV12WqJoPCPEFKsNg6KEoh8WbWNf4tFuKNrkP3IyBd
         +XvxiX/9D2QPrbMTI9bjdIp1y3k8xkC6bz7TX9AFon1zUedDHya+wDhYOAx1vB8eDJJk
         4vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617615; x=1790222415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBijyL0HZR3/5g7v7DmejWL3K0668IdfViWW12KzHHg=;
        b=xmMFXl+wvuhP2oDcO4ZZRmzKNh2ZirQI7AglsgNv2/YzDCk5d0sYXnDR1a93UaInKv
         3EbsaXToX6DvaPUilDcwr7ZJJgiQdkb3v5U1nHIFanBkaViCfbbUtMUColY1X65LekLd
         Uqdlw8uC/KeHfGVTm5BzngAQAc++B7WfcIEgZZsu+he4QJZav6IajSoWJ4djDOir8PxO
         rg5UGvjn2Wey7RjRzKZeLVwPK4hFF3UIVAcWCBqWbUKjjTViP3+KejcIJ2N5DNczscZ+
         J3f3t9RgBvXxf4lx1OnlcXDHQcdy7XkOultq0xASQitj9QGjTxIx3xjR35csDp3xWuGv
         MhZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFZV8o2DBLDgvdRkS8n6aT091RFuGsGJTdmZW+mK1PxGBZLocXWsSAmn4+MY+Bl4BNIke5Cf0DsbOhL5Wm6D4=@vger.kernel.org
X-Gm-Message-State: AFuF++lHpI+UekeX4K4P04EFHL8GGTCdZlT+tD1hEdTlwBzrcj5Ecjbz
	xtAZrGCLCCF6qRm/dz/0fVf7ZOTpA44rRiG7UcDp0v57TkCVmqXVoArl
X-Gm-Gg: AYBFou39uCZjFDkbi7KVJyRVrKtBJGDo1e9WNvaKo8jvubidVcOV/zDUmZ/w/dnutrj
	Wvwogo/x3twP7+XtllaLtElpHkedkR+qFg5Ily+ZNY8vUqNQYzFkO6ChJWFGihm6OHsllGOOWTJ
	FjzArCcUejxtD/XCAys/QO8VO7yOBf/a45r7361KtN5iBJfWQhTljGci+6DiU57h/S+dSDJyr4S
	YV2dZ8p006qSlnkgrnX+YapqLkogvHdiend+N1Cw3u3fBZCR5A69UA4DVIvre2Vcsza8uD27Ojy
	N6nOrckUTPnpzppQAyyPTU0G0Vp4cTEWbwlsa6fEOTuokApPqs50X3FHbezfAKQApbGkYNvZPGj
	GhoshgaCBVTcbm4MLCee0gtppA8GSAnuvVahJzTW+GqXC3kjppoHnrFNdWdfgx2gxmfCOEOtrOm
	AjAWOpOr8m2EVtns59SqZex5qHHbRkq0Qd5LSy6fcd4ZTQFTfaUSQSMPrXb/U2+g39diN3yxfG/
	HY3n4hhwnesqWDpbTAN1afWLHLGXyxBTLnE7DnutbHR1eYHQZQjQUwKu4u6rFoY5iwMnbSltfBQ
	P9L96qThVrwrA/IU9CpV8m/6Urv2Bv7C+t5j04PTDN6NGAhE6PStl3P5t9L5D+l262pdqkLaERV
	k
X-Received: by 2002:a05:600c:3e0a:b0:49e:81db:4926 with SMTP id 5b1f17b1804b1-49eac4638femr61582055e9.5.1789617614946;
        Wed, 16 Sep 2026 21:00:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9dc6-c001-54ee-4741-4927-0a28.310.pool.telefonica.de. [2a02:3100:9dc6:c001:54ee:4741:4927:a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbfd935cfsm6880015e9.0.2026.09.16.21.00.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 21:00:13 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	eadavis@qq.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	pav@iki.fi,
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Subject: [PATCH 5.15.y 1/2] Bluetooth: L2CAP: Fix deadlock
Date: Thu, 17 Sep 2026 06:00:03 +0200
Message-Id: <20260917040004.21041-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260917040004.21041-1-kmehltretter@gmail.com>
References: <20260912065526.833703348@linuxfoundation.org> <20260912065546.976652519@linuxfoundation.org> <20260913202907.3100-1-kmehltretter@gmail.com>
 <20260917040004.21041-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit f1a8f402f13f94263cf349216c257b2985100927 ]

This fixes the following deadlock introduced by 39a92a55be13
("bluetooth/l2cap: sync sock recv cb and release")

============================================
WARNING: possible recursive locking detected
6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
--------------------------------------------
kworker/u5:0/35 is trying to acquire lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_sock_recv_cb+0x44/0x1e0

but task is already holding lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&chan->lock#2/1);
  lock(&chan->lock#2/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u5:0/35:
 #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
process_one_work+0x750/0x930
 #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x44e/0x930
 #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

To fix the original problem this introduces l2cap_chan_lock at
l2cap_conless_channel to ensure that l2cap_sock_recv_cb is called with
chan->lock held.

Fixes: 89e856e124f9 ("bluetooth/l2cap: sync sock recv cb and release")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Karl Mehltretter: backport only the l2cap_core.c changes. The HCI
  changes are from an unrelated patch accidentally squashed into this
  commit. The l2cap_sock.c change removes locking added by 89e856e124f9,
  which is absent from 5.15.y, so the quoted deadlock cannot occur. The
  core changes are needed because c531e63871c0 was backported without
  the matching lock. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 34f89f7f993b..f1d7a6cdd8aa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7992,6 +7992,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
@@ -8009,6 +8011,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	}
 
 drop:
+	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 free_skb:
 	kfree_skb(skb);
-- 
2.51.0
