Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA647A6A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567929; cv=none; b=dqpyZE2wNDwmMivU02wrq8VmSWoatSXx6g6F9Z0z2EN0VNimbCgCJB0T36Y75nRKKPSP8cYXfzs/L7huQNPDKXSntkmeAsP+GkNt7QejWRbhXUVxSDlBXEOcBl7bpSeB73wBZrPC0XxZqex42SoPDumF9vpBPFo6mtQhzgC891o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567929; c=relaxed/simple;
	bh=qtwPI1qL+AOO+vwZwWzhKKYZrJ4AUsr99dOpvzZ+6F4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmDul7DOz4MHPVlphUyw4MSnKs5ekNgVMrx/i42q+bfC+Or8UngRTwA0KTVn2Mq0Kgl/AgQFMoQAHxuY2pMhjSFdupaJB92kiED+oAeoeXTBRYVkwHZdyYmZje4elmQMt0OTg5DxOaDT5BzYJ/YYse4bfDUDmyMta0eo0ljueCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jpaNeX09; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jpaNeX09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709567926;
	bh=qtwPI1qL+AOO+vwZwWzhKKYZrJ4AUsr99dOpvzZ+6F4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jpaNeX09j+JeXIuvDnR7M4x/QqwzHL1igAwH+B2FHs6BuyP7v91mg11bRBBZlXFjE
	 15PuswfJLDYE/oUF2qSH85oobFgsAqexJBIE+jZunRTCXC7NJZRP+rF6Kg7EGQ5o6V
	 QrqRm8QEqcCXjEnJ+GlB2HvwdcAC9eFwyjWx/ug9y4BpL/8MpF3oFMkBM0v1PA7Ica
	 XzHdWgN1HcRdc2ovZC6UKHaTm6pvRr+fXJgVMtWchLd4Y/4aTE27N3Hd8eNsHIU6xn
	 /Lp2wBr3CTjWzYo7rr23SBDYtxg9DHlTJotQJcpqzfms9DnTzqtVJqN5oHP1iFCTz7
	 FK+EMM462kcpQ==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BFA7037820C8
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 15:58:45 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND PATCH BlueZ v2 1/2] gatt-server: Add support for signed write command
Date: Mon,  4 Mar 2024 16:58:38 +0100
Message-Id: <20240304155839.48888-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304155839.48888-1-frederic.danis@collabora.com>
References: <20240304155839.48888-1-frederic.danis@collabora.com>
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
v1 -> v2: No change
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

