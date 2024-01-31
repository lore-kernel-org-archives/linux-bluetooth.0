Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960655813A
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689147; cv=none; b=fIaX2g0hHZbFox5A4u9xQ+9eD2JfyKT+47iZbXrRw1wdAyTxZCXcULf5wVC+mQ7yP3TvuTN2c0gZDkcGq4eNScfuXDJZETITBUpD4rmSaB5TlEmVOrF0CdxyBY7QCeazKjP8JT5D30/6aZEFOAEjg9uxlzPs+HetHsbM1cnuMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689147; c=relaxed/simple;
	bh=OlixkxwYp388XfpC6M2p8+l0/0NyG8k1YIVBiewVi4E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bdSNvj/s5gFuiGW7lQKsd+8SPrQq8ZeNze+wxRbBuUZheO8MhPZ6mfk0JB+3h6O/6CkmSD1VBDoLtAGIdF+HbEq8f++WCWQD2pGzeq8mbLJTF1KCoZuwRLOX/v6r2neCnbQs+15MH+0OU2s2DZJLLuEJNtCz/V0XsATinsgCo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oulX/3TN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oulX/3TN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706689143;
	bh=OlixkxwYp388XfpC6M2p8+l0/0NyG8k1YIVBiewVi4E=;
	h=From:To:Subject:Date:From;
	b=oulX/3TNDY5eEaV3O5mzZA38Zah8S7ZYrVTLiF2kXLqQrhcqDFOUdOgnst/S+UUxS
	 Np6xTjDkum/kxecTjXmUP+wmGUZlT7Jc1SuqkEhclgBqGZywg3nawcxPp/crydoRyJ
	 X1+J5q9CWfxPREuO3R9aHKEOAgdjfA613T9lFvDaT94XVyQFCayjSJqVLkeRNh/d1c
	 UBYrUEx+J6T4wLrMh/YWydboAE6t2mT35I4Myb57lhOXTjn1Vi+8J+d1gvnmUgI+n0
	 MHqlTHYWb4AhztiPUa+43DTEvINlx2J6Vjc004rnjJWY2epYIaFC9nKhnZO7yvvM9/
	 MNCTxEwkP9vwQ==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 80DF93782081
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 08:19:03 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] gatt-server: Add support for signed write command
Date: Wed, 31 Jan 2024 09:18:55 +0100
Message-Id: <20240131081856.308071-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

GAP/SEC/CSIGN/BV-02-C request the ability to check that signed write has
been performed successfully.
---
 src/shared/gatt-server.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index c7ce3ec1f..0e399ceb1 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -106,6 +106,7 @@ struct bt_gatt_server {
 	unsigned int read_multiple_vl_id;
 	unsigned int prep_write_id;
 	unsigned int exec_write_id;
+	unsigned int signed_write_cmd_id;
 
 	uint8_t min_enc_size;
 
@@ -155,6 +156,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->read_multiple_vl_id);
 	bt_att_unregister(server->att, server->prep_write_id);
 	bt_att_unregister(server->att, server->exec_write_id);
+	bt_att_unregister(server->att, server->signed_write_cmd_id);
 
 	queue_destroy(server->prep_queue, prep_write_data_destroy);
 
@@ -777,7 +779,8 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct bt_gatt_server *server = op->server;
 	uint16_t handle;
 
-	if (op->opcode == BT_ATT_OP_WRITE_CMD) {
+	if (op->opcode == BT_ATT_OP_WRITE_CMD ||
+			op->opcode == BT_ATT_OP_SIGNED_WRITE_CMD) {
 		async_write_op_destroy(op);
 		return;
 	}
@@ -1628,6 +1631,14 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->exec_write_id)
 		return NULL;
 
+	/* Signed Write Command */
+	server->signed_write_cmd_id = bt_att_register(server->att,
+						BT_ATT_OP_SIGNED_WRITE_CMD,
+						write_cb,
+						server, NULL);
+	if (!server->signed_write_cmd_id)
+		return false;
+
 	return true;
 }
 
-- 
2.34.1

