Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cVZ/ZHsc"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A985
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 09:41:59 -0800 (PST)
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D183166072EC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 17:41:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702057318;
	bh=HF1g9cViX30uRBYxDSw1IVBn0aCEsL6e0HQm7B7fH9Q=;
	h=From:To:Subject:Date:From;
	b=cVZ/ZHscvmjhDxxWAZJeni8ZueZt5c4wGAqaoMNhlZHALF151hdRUDHOADVennaAz
	 3Y2z8Pj+WGspzS4zouLtVNQTzGQVRObqSd9DuWCcUzGY29sXwrIisTgMAdGS+wHVQI
	 Wox0Pm97EdG65/W9rqNYj+90CaojnqoMJJWKIfi9o4RGnG4VRmB7HikhC6QWdGH3gX
	 mtpLJ/MqFFTEGMiya7zkzy4vcuTY/J2Na6V78DiVb+ddVQkZTuihC2SgABB6itetGj
	 V6to2eKVtpEHpx9oItST/hdPZ7oYhdAiqoP0j6KMc1JLOGXjusSq65KAexsVkLK3qX
	 etG5TQpkbsdxQ==
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Send reject on command corrupted request
Date: Fri,  8 Dec 2023 18:41:50 +0100
Message-Id: <20231208174150.1313389-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

L2CAP/COS/CED/BI-02-C PTS test send a malformed L2CAP signaling packet
with 2 commands in it (a connection request and an unknown command) and
expect to get a connection response packet and a command reject packet.
The second is currently not sent.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..baeebee41cd9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6492,6 +6492,14 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 	kfree_skb(skb);
 }
 
+static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
+{
+	struct l2cap_cmd_rej_unk rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -6517,23 +6525,24 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
+			l2cap_sig_send_rej(conn, cmd->ident);
 			break;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
 		if (err) {
-			struct l2cap_cmd_rej_unk rej;
-
 			BT_ERR("Wrong link type (%d)", err);
-
-			rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
-			l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
-				       sizeof(rej), &rej);
+			l2cap_sig_send_rej(conn, cmd->ident);
 		}
 
 		skb_pull(skb, len);
 	}
 
+	if (skb->len > 0) {
+		BT_DBG("corrupted command");
+		l2cap_sig_send_rej(conn, 0);
+	}
+
 drop:
 	kfree_skb(skb);
 }
-- 
2.34.1

