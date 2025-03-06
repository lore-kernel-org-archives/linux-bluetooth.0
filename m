Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABCF26E96F
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289020; cv=pass; b=NF2Mx8uX46guKx+JfIr2tYdasOBByYkbr5HUb/9rBTfHpGlMG7eJiNtUGBL2H7P2LPtYFawUE5iXADEClXonYZI7sXomX7MQdN4+Pb8LhYtD8gxyRiYHL79+oHAJ1FKIUsHVe88z4qKXRzhRgjpGODE1r4BvRJsdakVZnkm/4Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289020; c=relaxed/simple;
	bh=W5a8F5HNlBiuiPXzc/epgOQKIZbMjH5XVHitdO8H+vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R01+UH0zYSVSFuwywfXjJWT3Y9/ISDvza+CPLCJg2T1b/WBAJ5dj6kCPY2tWWYsKA1kb32wFeP1q7PaQBa+UZywDrhMDTbaQAhQminRUXa93/fzOFid3HcsaTYC+kdghjhKpBUTBZNbW2fQwLN03hV3pYdtzGzRdM0mHI65UTv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FVZEOalp; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FVZEOalp"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7zqD1Zlrz49Q47;
	Thu,  6 Mar 2025 21:23:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwh6UqcG+jhVY1HsM9XalcRjs8/srX4OCt8aHBIoTMM=;
	b=FVZEOalpTaM356QIM2R6gkx3/qlMZEEzgwzFa7eXFxAIHQK9BfNhzpTk8X9GJTECSZMr5j
	zrfpVo2LtvxOMFMl/q/2llAn3SimqOAhEbNdS4CTwtBXDMkvx7FKw/lneuQddXWuFjjCTC
	q6vETdYhbx10g1cbiKl+z37xcF0N8fiuzqdLNhblpW0yT6JikQRE4FzwDQ/TRu/YJVtQlD
	pye1fdq1WmAECwC7mDRWNeBBzpMHmWkvwnul0W9Jzzp3NQzNlaSdaUL5kJe5xZBy4+L8Hk
	qxjqZ7nQ4qY5LiOS4lwpAdH8fFqiHHuGnWS0F7QHZTnUfge0l0GBt801gy1kBA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289016; a=rsa-sha256;
	cv=none;
	b=kaitNleVGtZ//zpnZRFCnYwwzDUtpOhi8zGcv9oRGMn68GZu3ONwthFUg0/tk5wWsIyebN
	+bPZIuy1LSh5aXzXlzolRduPMzO6P3D1FLCTqO38/fU4Bw41PbfpOAKykCEhnV1ieRmDIl
	HUiztnsRlNGI08ZTxcpwQG7xUO6TQKDZI4SFuobGeM1DVbjYr2ZSyPEcY07gcyOaj4PJbs
	7byUxyQPjzscnlVXA9DtOaIcGBijfjnz4WUpl5IPoaAOM/+7b+3f4sE9PW9HwzAu74J4is
	R1Efq1yKBnUXuoEZgkz7Qb4VdshiogcI1e6MA1J3tpsGQUpAMiJTgqk33jTRgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwh6UqcG+jhVY1HsM9XalcRjs8/srX4OCt8aHBIoTMM=;
	b=UTEZQOhRmhQWsRrdr1E/OG/bQndMIlczJhlwb/OJhv3gzwYlyaGwQHJ6OzrP73Sx3YNTFT
	drEof0yI7QgE3Bkp8QbH+mmsIB53XZIt3j3LZGaRWHZhbr4+cyPCrBTjqyG7a4Xb/gmEtS
	pX9nWpDily4BZwibJnRL+zaAPKKs49Q5iH2JfOBP5RDNpKViF69RRyoICJjy8x/Xqe8AiI
	lnDt+yD4yXXHthn+YyB+yXwrTkcwZLJMoYfPu+sstmpHs7VFZYGz1Nf/KSBniezEuTWb1C
	JJY4/2Xf2+J5JwGvT7Zte60vrzYmyIXAGTDBd0EYQROpMm80C+25a5mcJ9QWPA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/6] btdev: send SCO setup events to bthost
Date: Thu,  6 Mar 2025 21:23:14 +0200
Message-ID: <f95f44e55cae99c6af1e1cd5219acbb45e145a22.1741288951.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
References: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send required SCO setup events to bthost conns, so data can be passed to
the linked connection.
---
 emulator/btdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 51cb60a41..3542fdad5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1415,6 +1415,10 @@ done:
 
 	send_event(dev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
 	return 0;
 }
 
@@ -2824,6 +2828,10 @@ static int cmd_enhanced_setup_sync_conn_complete(struct btdev *dev,
 done:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
 	return 0;
 }
 
@@ -2870,6 +2878,10 @@ static int cmd_setup_sync_conn_complete(struct btdev *dev, const void *data,
 done:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
 	return 0;
 }
 
@@ -7674,7 +7686,7 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 
 static void send_sco(struct btdev *dev, const void *data, uint16_t len)
 {
-	struct bt_hci_acl_hdr *hdr;
+	struct bt_hci_sco_hdr *hdr;
 	struct iovec iov[2];
 	struct btdev_conn *conn;
 	uint8_t pkt_type = BT_H4_SCO_PKT;
@@ -7694,7 +7706,8 @@ static void send_sco(struct btdev *dev, const void *data, uint16_t len)
 	if (dev->sco_flowctl)
 		num_completed_packets(dev, conn->handle);
 
-	send_packet(conn->link->dev, iov, 2);
+	if (conn->link)
+		send_packet(conn->link->dev, iov, 2);
 }
 
 static void send_iso(struct btdev *dev, const void *data, uint16_t len)
-- 
2.48.1

