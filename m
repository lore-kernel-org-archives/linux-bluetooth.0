Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCF3F7AA9
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082809; cv=none; b=YrVQoe/UOWKZdnxn3s9f82jgO9PD2+ejiFIGBX4LlAWAkv1bZmAke22MHubTrRE+JmE+NdmXBEIfi0jUmKJFhhJTmUn8DyanAiINZZqhJy8hWm2ooJBx4qJ6zdGDzcujOEmVtG+mlWQNEsA446ZSZOeuZvd5PeMjVwf426oGbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082809; c=relaxed/simple;
	bh=w9O93c/TS75EBL7gXp2NzdWnKQVcKaTpl0/IVtuSNCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMZKCDuBOIRcsIP4iKHyDwSWRrUXZCNBbtyfnhza8GJ5jZxMn3loeoRUc6NYGZWmOmOYCslmWhTWJIQrsCwWdI41RQwaapc/kDQCOQj/D59x0wIJIVwqrYDeu5Wi7WpaGO3WqHXorS09GdUjgSMU//8TNcMi9BbccoCpYLUNOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrv1q2a/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrv1q2a/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad21f437eeso9153995ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082805; x=1778687605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQI53mMLR1YvrIwV+lGUVh6mVBJCqebaV/1Oy2Pn6Vg=;
        b=Yrv1q2a/DcY2ESuhTqLC5BDb655xO1H6iK03avvAMMHQ2ORelzwD9W2O5j4KF1OA2y
         YgrWtVN/8Xd7dy4zXuxCT0oJTN/NR9J6MgYrI4Sa4E2DGejqNkydZexlV62kzdxFMUQF
         xJp1MQZ0S+wSqZ2i1b3uo8DG/M362h7qcB/vt7aCalbUh8geefklUGGs7DY/Cui3LBXr
         pb8LvSGo15zp7FoXTlbXkdojCNJLpXHH0izgkQu9t9EQe/llvtXY/qev6h8qKeW3w7/0
         0NdlR5v5cHC+kR40rNQeCIckb43IBPry9OfKrG2txOmtiv8qX0vHAZJ451xn16WPoZXr
         HA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082805; x=1778687605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQI53mMLR1YvrIwV+lGUVh6mVBJCqebaV/1Oy2Pn6Vg=;
        b=NjPsJrc8WfgBfNG9se8mQpXDuFk9vY3fdTmVRs8CV2U5ll0GPi9mkYkSDez+GXoFuG
         VG5O/dKQhT5Y+jDN2YxKVFrGHwKi7Rqvq5MPnbW+o+9WDgZM2AlAjvVi8JsWCnIRAa1Q
         Bn8uOUce/KIx1vXNtfLNFjOF3SlQO5ZVx9drwmduq0Ll0di8x+DxTK7DKJRvpCwHgoD5
         Td8EiRQcRAd5tv4v2tkhrx5Iz4QjC2Ltl3GQWaTGRtC7gKx/q56vzW9YcvdCOMzxExBL
         iC6mPojhNc0kHpYc/ngaa2wg7qwISgtgGnOfVIy78I4Nqqz/oW8JhV3NvKZg11DGGMcx
         WFpg==
X-Gm-Message-State: AOJu0Yx7QdkPN37oZw9qh+h6BNxFo/gmkR/d59RSonqgIB+FP8bD2eKF
	lpAHvXjazofJb8tS9Ceem4MJYf+Dz2MexBNxYCBprOvJiwHagGT/6QIr
X-Gm-Gg: AeBDietvUPeOXPohF5YWv6Gd72mmv0QCVxWHUItmprAVixJLy+GJ1Zhm9dol+D4ML5T
	SKspU0IDdbXCIIHG1xB2aYJqCImGGXnmPY0i1jqM26fU5kiLCoYsKHMEbs36kyNsZ4aCPoGLZ9p
	a+yv4HxwRGRYQXbO4ksHG0AsSX9hytb5iEOILaq/Djkr2tRVcJkzTgbox13PfM6ukoC/yyS8dOz
	k8glEDg+U9GsreAoDmRqCbDKLEkqm/n6Qo50qLTzZsMdsl2FGrJF7mJ+G4up+GnKxB5P4gkNucF
	+/0BaQdLErxgggJxDQsP5iyWVd/2FBKofVGMTXQnp7jxQWALNNEAx0RxLcVTk9w7ccbj217ldlQ
	REVDeXcRyUz1zckuRwysnEw+ZOF0C7IBf12jk8r2GIlTS1MMMFcAP8y2a8Rn6g4wOykX2Ko4NNB
	a5ZuC0mFtSYIu7TZ1gzAPtQL9pc1v1
X-Received: by 2002:a17:903:448:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2ba4e49bf03mr53410165ad.18.1778082805086;
        Wed, 06 May 2026 08:53:25 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2cd19sm29522485ad.24.2026.05.06.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:53:24 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: avoid using hci_conn after dropping hold
Date: Wed,  6 May 2026 23:53:13 +0800
Message-Id: <20260506155313.1412894-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_connect() drops the temporary HCI connection hold after
__l2cap_chan_add() attaches the L2CAP channel and takes its own hold.
The function then checks hcon->state to see whether the channel can be
started immediately because the underlying HCI link is already connected.

Keep that state sample before hci_conn_drop(hcon), and only use the
cached result afterwards.  This avoids dereferencing hcon after the
temporary hold has been released.  Use READ_ONCE() for the sample because
HCI connection state can be advanced concurrently by the command-sync
worker while L2CAP is setting up the channel.

The sampled state is only an optimization for the already-connected case:
a stale non-connected value leaves the L2CAP channel pending for the
normal HCI connect confirmation path.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/l2cap_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39bd..40e84c1623a9c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7078,6 +7078,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
+	bool link_connected;
 	int err;
 
 	BT_DBG("%pMR -> %pMR (type %u) psm 0x%4.4x mode 0x%2.2x", &chan->src,
@@ -7222,6 +7223,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->src_type = bdaddr_src_type(hcon);
 
 	__l2cap_chan_add(conn, chan);
+	link_connected = READ_ONCE(hcon->state) == BT_CONNECTED;
 
 	/* l2cap_chan_add takes its own ref so we can drop this one */
 	hci_conn_drop(hcon);
@@ -7236,7 +7238,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->sport = 0;
 	write_unlock(&chan_list_lock);
 
-	if (hcon->state == BT_CONNECTED) {
+	if (link_connected) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			if (l2cap_chan_check_security(chan, true))
