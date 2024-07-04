Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755D1AB90C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088785; cv=none; b=meE5fa4LqQRCOPAIfu64tlv83INMA/Xyy3CJenpzWBImgrpkFys8fe5G5sao6gpOghFcYzRTrPqmBlSR9F1KqAdz8nxGHqp8wSWQjPA+Ys0/xOBMekLSd4VpDRTHgxiBLGUymoItutiepGfOf86247oBaf90o1Q9tOLMAb7UYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088785; c=relaxed/simple;
	bh=bqGvTGe2+9YaB6Gc6UdsM+ve3Y+abpuVl8rzLpwmHYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHaa6jU09r1CO43LWZmIabeVWTV597lHSq/5q/o8pdofV1m4TlUVrZUzAR3J4TyR7L2Q10diYWE12vKILUlkP4VPCc7gewBWBGG8cpvhcs3o+Zcpz8RMKA3yXQd3rp2P0Gir3Jk9o/GNk7TkIIfUt4edP+58zMfS0ZzOh4PJbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A294240010;
	Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 09/12] gatt-server: Fix integer overflow due to cast operation
Date: Thu,  4 Jul 2024 12:24:40 +0200
Message-ID: <20240704102617.1132337-10-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def25] [important]
bluez-5.76/src/shared/gatt-server.c:927:2: cast_overflow: Truncation due to cast operation on "((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - 1U : len" from 32 to 16 bits.
bluez-5.76/src/shared/gatt-server.c:927:2: overflow_sink: "((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - 1U : len", which might have overflowed, is passed to "bt_att_chan_send(op->chan, rsp_opcode, (len ? value : NULL), (((unsigned int)mtu - 1U < len) ? (unsigned int)mtu - 1U : len), NULL, NULL, NULL)".
925|	rsp_opcode = get_read_rsp_opcode(op->opcode);
926|
927|->	bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
928|					MIN((unsigned int) mtu - 1, len));
929|	async_read_op_destroy(op);
---
 src/shared/gatt-server.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index c587553d655d..6ced21248b75 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -908,7 +908,7 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct async_read_op *op = user_data;
 	struct bt_gatt_server *server = op->server;
 	uint8_t rsp_opcode;
-	uint16_t mtu;
+	size_t mtu;
 	uint16_t handle;
 
 	DBG(server, "Read Complete: err %d", err);
@@ -916,7 +916,7 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
 
-	if (err) {
+	if (err || mtu <= 1) {
 		bt_att_chan_send_error_rsp(op->chan, op->opcode, handle, err);
 		async_read_op_destroy(op);
 		return;
@@ -925,7 +925,7 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	rsp_opcode = get_read_rsp_opcode(op->opcode);
 
 	bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
-					MIN((unsigned int) mtu - 1, len));
+					MIN(mtu - 1, len));
 	async_read_op_destroy(op);
 }
 
-- 
2.45.2

