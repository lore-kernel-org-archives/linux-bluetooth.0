Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268118DB32
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370527; cv=pass; b=OZsktQkRsp4plaZqGuzCIpWYMGLaUw5IwLUYUHC6YCzr6H4DgeVFF1t1jZllnCa9s+XhqJCxSs+7UEpH2eeRviR66GQERcPSmzpy74ovinBM4iJQvMzyBp0On67xpeeWSeu6+spXjFDDRrn1K5rmE8vYcJ39Ri1otPUy4hxG4Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370527; c=relaxed/simple;
	bh=C0Do90qKo6MgHxBYqxRrNbdZ9aCoL7YzKaA6KN1+P3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpOyyIQgKojCjzhB9Rl0PgTD43kmEvKJ+YheexYITjDrkaZB/fIdK8ZGLcevk2zfg5iaoIeGruY2TB112zY4EN7ZcECbQcsLhS1FpiSwDz4yOokxGgeZUti5RNkT+78bWHZ+IVx3R8N4409HSKl2pURL9fRh670xM0waqvFweOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zQ47z9vF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zQ47z9vF"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z8YyW2glSzyVj;
	Fri,  7 Mar 2025 20:01:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741370516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynk+1nk0EbYUQNFVWk54Al5Mp+u70Xg+2RDakbNJR9Q=;
	b=zQ47z9vFel/c37SBU3Djo7MSzFXUWpFZBn8aSUgbE9oppExeqMbbXohQPPmb44SQn47ZNS
	v6nETl5s9PUSBsr9N9IcxdPCPBMd/1DOBhIMFSFGYcFl66BSVn9oYdpafsw4ct+MfsAeiC
	IKy0A1ESMPHBaL/M36Du9DhTS10axZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741370516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynk+1nk0EbYUQNFVWk54Al5Mp+u70Xg+2RDakbNJR9Q=;
	b=mla6JSTXRDhG9w2raV9MCFaFFdwOQ32zntGunt1Jswiy8QyPMNtQsXc5js/X8GPBOwrVkh
	7mttA8QpymShFpq30J+olrt4mzVcM0/cJ0Gvma2OtrX4OrrksOfb46hDQh9r//5MDAAF6F
	x9Nm/UJo4XzYHezEs+uIBYj+wth3cas=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741370516; a=rsa-sha256; cv=none;
	b=iFx11iy3RD9o1I6g6ckQpn4chlYWOV+3AjNN/atYHsM71h5oosTJEZoWicyv3tiITxxrFp
	l66dYDNFIBBfblSAHJ66CFesyjvbZzN5IFbBLK8VQ/Ic2i67UN4gxq8+zGtQBM3OwAHvxH
	SXfttzVGtPw4qQrlGbs7pGJzijNYPTk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/6] btdev: send SCO setup events to bthost
Date: Fri,  7 Mar 2025 20:00:55 +0200
Message-ID: <3be700331371fcf276b3dcf2fb6524513226b31a.1741370367.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
References: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
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
index 713ec7acb..bd8ea0d7f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1412,6 +1412,10 @@ static int cmd_add_sco_conn(struct btdev *dev, const void *data, uint8_t len)
 done:
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

