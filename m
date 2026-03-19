Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9E3090CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933382; cv=none; b=ZQM5tFVS1dfuAy3434VlzV3jjCnCS+qSC/bur6hQWt2YT9qicF/R/7vut4cHcpzQwJ7+cbp4PvcvGXhWJpxxsjyxcHWkwudNThU126pLETF7k5V4lVcdYTxVMiADEtAyf6ybS0HCzxdQzu3mzrXC7j22tMy/+MsNMcEOlflISxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933382; c=relaxed/simple;
	bh=0F6p5u/wbogRhJQ/NrA8++WYOg4MfeM1GBi/E7wjVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZnUgtfBU2XxvCDY+WavIK8vIvfwUDQSJx1h3O9ByCYfj7KZOWAVJibv70wsW9R7+U12qIJ05CtkCcC7Sce/vpiE/06wl8bDzLG3x2vXHUOz+V2IbQlbt32Cua2MxpXqiMnal9xVt8XavtZSfzCEVfQ5khBYeTBBWDctW6EOiIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsLDsJ6a; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsLDsJ6a"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab46931cf1so17957995ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933381; x=1774538181; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RKJor7Y/BDmZ6BhkUgQYpRjirocftKJ7xOheTvi/rQ=;
        b=lsLDsJ6alXGs+OP5UcyjV8Z5d1v64cQjww1Z+G+DkeLrYE7ZbX2/U4xpWALFriU3Dl
         LuRHWTT/ccSKljhbL7uGCoGHCQaJLzBjeqqpD/CoBdsmPeuq8jrkHAYZBMtRHv/wAclP
         Ph1R7gcwzNXyYqu+13qtOeRHDBpFtiC+E7oLKo5htew2A+QRevvKB557SynAETJ7v+sY
         4pPutm6SwXLcoxutScnJXGIu0alFqgbV0N0Cq263i2y/+xun6tyyJZhm/ZJ8EnY1FOir
         s4b3NXOSJqk55p2/r3dtpXdxc0Bk2frH9MewOROwTTe8d9FdPMC+U7lbi2v1h2sCrCJX
         z7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933381; x=1774538181;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RKJor7Y/BDmZ6BhkUgQYpRjirocftKJ7xOheTvi/rQ=;
        b=k0+6ElBFxelIXijYqJ6CgHZlR2n3PbJnKeLGbMNAe5gy/KGpCefddBZQI/loeycTET
         RZW2hxpb1Df7y1+MqLc91tHRNf2vMhYWnREyxtoQR6lfurgArtyqtMXpgDI1dzpYqh2u
         dsPkztyDgN9FFj8545zCJ3riYipnwgf5VhXkYsOUVur80XFh6rw8KyHHWMky9on5qxka
         AtzXT7xR/0nnXsafaAA2FYc6ghXh6Ep9slEgW9uK8mawpdQUUlZhNmIwa12nqPmIuXWG
         J05UWej9sdlIhz9kOXxmyb1oJC2LwsX1fTGvaEVsdwPGiwXgQYaeZSmgq4u7H2SIHQDP
         R6JQ==
X-Gm-Message-State: AOJu0Yx5QZaVAK7bBXKetHgm+R3tMwJp0ljkWYWxGGZ+udWAPpjSJDn5
	x3ZJx6eVQ+Td4dFnm4+YxRv53Ma8G9gDiNryYPpTK5eIATFwb9tMuYyW
X-Gm-Gg: ATEYQzyFbx1iqoSJoqcSgFK7ekBs/TFVLWvdroK3qfcY6hm5jna5scFpOV6w1TWAev8
	jpsJ09uYMR1qIvaezkScRlEVv3e4bRd+Cu70rFI7wdvfwlS6sOYCiYJT3wbm8vMakyryx7NiPna
	mLzFHCalA1yJDw1ZN1xTtPiehgTWbJs0Tf2aaFX3Y66dAoPHIbwzX9lY/dxbkfZ43sq6NlJQ+pu
	vSN57eo042vSymEmNdhAbsjcDg9UIXO5UKJDaGgXYiOEbCMzRMc6n/CjNWRR/deBDqKRHEvQKsL
	Pf8Hq4KQfcPqsDQBHNl4lQXYhqlgbic2wQaA+x6qfsm/EAlCAGlQeVlZjR4V3TeTTHeoAQZewnK
	KP3+GlMb9kgUeXr+2yk3pgNyfKBDTZe+6jsvEqy72AcjCcMa4YUmNob+14zr5QBik9T/VVEU8EE
	Rm7CJLI22jED/T7yXcK7YUZ0/hVtV2k1uOiFnRhvy9IQ==
X-Received: by 2002:a17:902:f682:b0:2ae:5a70:477e with SMTP id d9443c01a7336-2b0771d82d6mr34523075ad.12.1773933380876;
        Thu, 19 Mar 2026 08:16:20 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e441367sm61228565ad.30.2026.03.19.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:16:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:16:17 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Message-ID: <abwTQVhyDv0_x26G@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
and id_addr_timer while holding conn->lock. However, the work functions
l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
conn->lock, creating a potential AB-BA deadlock if the work is already
executing when l2cap_conn_del() takes the lock.

Move the cancel_delayed_work_sync() calls before acquiring conn->lock
to break the lock inversion.

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/l2cap_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a6ce09781083..68bc65b1c12a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1752,6 +1752,13 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	/* Cancel timers before acquiring conn->lock to prevent AB-BA
+	 * deadlock with l2cap_info_timeout() and
+	 * l2cap_conn_update_id_addr() which also acquire conn->lock.
+	 */
+	cancel_delayed_work_sync(&conn->info_timer);
+	cancel_delayed_work_sync(&conn->id_addr_timer);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
@@ -1767,8 +1774,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	ida_destroy(&conn->tx_ida);
 
-	cancel_delayed_work_sync(&conn->id_addr_timer);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1787,9 +1792,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_put(chan);
 	}
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hci_chan_del(conn->hchan);
 	conn->hchan = NULL;
 
-- 
2.43.0

