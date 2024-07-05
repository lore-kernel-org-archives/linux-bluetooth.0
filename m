Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC1145FFF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=egMuZ4Y0mYVDXKkQM8CD67I2/PofDPXYL5piJTdFL43MKEsYfOAJFmfVnMtOwSiCO6dtax9zC/Uxc9Jq3uCToQCbjN/5PybO1ZrCrXov5jE/W8MpYUJh0LpRsioVfppLPyqFW8HTDwg4wZOG6+We/AY1bnkTZ/LGLdQwgK2xvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=ch4jcXh4i5Ulh/ewP/akSPzoVSZeMohj51lCQNNSAcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgyQmntqKG5TknqV5nw7qLKwmaJgEWyIZjqKUXBlPfuZHJ5b9mQ0erBW6NpA/9aD1vavw3CSJYgxqoeQFPjeZzdYMia8/dKA3O6L09xcn1NLYCEsMU25W72TErd/oR8q5NwU0FOsg1zcyF1aE8LyvN6zs70wbMioMMMNO5GFyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C29B60014;
	Fri,  5 Jul 2024 08:59:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 08/11] gatt-server: Fix integer overflow due to cast operation
Date: Fri,  5 Jul 2024 10:57:36 +0200
Message-ID: <20240705085935.1255725-9-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
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
index 66e370d1fe3d..e0e1776779cd 100644
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

