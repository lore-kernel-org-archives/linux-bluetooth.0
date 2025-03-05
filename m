Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5563250BE7
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190320; cv=pass; b=Z1KDYVNsk4W5SoKgY0a2FL4R0UCoJPVe7XiOt/tqjGWV1ynG73ybU9gfdVtah3Ft7PVoXh4503LbTZcqt9FYIM5glB7gkDJU8XI5WNbM5S6mrTIb1nfO0jCiAsSGx5uB7/7vVRoeBbOLqsonYhcujqAfSHslIQdHWowkHz9SdHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190320; c=relaxed/simple;
	bh=TzUs4zoNWKGSp4AfjdyZMPEZPOs8PR7c3SNgM5m97WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H40Es+872oI3CyponLMQStAev4BMpBIHGMrldBc/MFDYukDZ9AKj/mR4PzvV/ngXbB2ebaiiZPlxJAoq0m8e2ITaUIyJQrDS9kYFu7DY981l/2/b0rzHzC5Wbk2Q3DQYG0eCrV0vvbRn5+Bjooduoab2c7btdG6qEXNpty9fBls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ae0AkVQ9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ae0AkVQ9"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z7HK12nC7zyR6;
	Wed,  5 Mar 2025 17:58:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1741190310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aFVHk/vXAyGGZ1aMhFUkoONu6YwPW3nNOVmX3+zC4QI=;
	b=ae0AkVQ9Tyeu6AYmbl3QYJR7df4vhvYH7OKInT7GKisCVN4pSbIxTRvl3UqffaqZ6kCvto
	/A/l9WiYAVKkTiHAgXDQang4UT91TKnBqIHf5j/apDB86hPysvJ0ANtZlZCfZTf/1dGMYM
	HGUDuvxrtLF9ewQHQtv+yvOeLiFi590=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1741190309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aFVHk/vXAyGGZ1aMhFUkoONu6YwPW3nNOVmX3+zC4QI=;
	b=DWXdOHJWoFDEQUw6S0aLIphhn2nq/JQtO18GsrIiuV9s5sKuGGJWh/R9Lhl3xD4SKBoxpR
	RFESFPw4qjie/g0lhl4q8WPd4d4uPIg0mgZSG6cjSwP9RM16EMcEsTpMi5MK4wW086aHny
	PbdCZXgzDKe2ErqMfxu1pFtKsw7dRY4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1741190310; a=rsa-sha256; cv=none;
	b=UwyTJGIy8T+c5QBndi6OpJwiWnqXA9Q8xSQ5evOt2XKUQ7EPvvt8u58NdZzAXlOU3tu7Bt
	LEdwXe2Q8ndX7ykKMk7cHiD96Rz+63JOaECNA7MhYLdT9ffIfRQNoKk0Tfl6R7/eGpcMIX
	/KGqpJaAfHRMkcBbAKAYstlHUf/yhm0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] btdev: pass sent SCO data to bthost
Date: Wed,  5 Mar 2025 17:58:24 +0200
Message-ID: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Actually send SCO data to the linked connection, if any.
---
 emulator/btdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ec52c5242..c44b52c49 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2807,6 +2807,10 @@ static int cmd_enhanced_setup_sync_conn_complete(struct btdev *dev,
 done:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
 	return 0;
 }
 
@@ -2853,6 +2857,10 @@ static int cmd_setup_sync_conn_complete(struct btdev *dev, const void *data,
 done:
 	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
 
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
 	return 0;
 }
 
@@ -7655,6 +7663,33 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 	send_packet(conn->link->dev, iov, 3);
 }
 
+static void send_sco(struct btdev *dev, const void *data, uint16_t len)
+{
+	struct bt_hci_sco_hdr hdr;
+	struct iovec iov[2];
+	struct btdev_conn *conn;
+	uint8_t pkt_type = BT_H4_SCO_PKT;
+
+	/* Packet type */
+	iov[0].iov_base = &pkt_type;
+	iov[0].iov_len = sizeof(pkt_type);
+
+	iov[1].iov_base = (void *) (data);
+	iov[1].iov_len = len;
+
+	memcpy(&hdr, data, sizeof(hdr));
+
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(acl_handle(hdr.handle)));
+	if (!conn)
+		return;
+
+	/* TODO: flow control */
+
+	if (conn->link)
+		send_packet(conn->link->dev, iov, 2);
+}
+
 static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 {
 	struct bt_hci_acl_hdr *hdr;
@@ -7702,6 +7737,9 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 	case BT_H4_ACL_PKT:
 		send_acl(btdev, data + 1, len - 1);
 		break;
+	case BT_H4_SCO_PKT:
+		send_sco(btdev, data + 1, len - 1);
+		break;
 	case BT_H4_ISO_PKT:
 		send_iso(btdev, data + 1, len - 1);
 		break;
-- 
2.48.1

