Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD285D8EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012127; cv=none; b=RLEGC+zHJ8chvl5eGBPloaVEZ3o1Ve0fO2fEpJa4jqGRMQlSGFfxwZ3uac9Im+qA/4q+6HmCobGOLvdhKxQAjfSjxgRf7qccFWTrBYxn2cM1kaN6qbrGzyk9JDywAdfunz0n/yY1ClWLh/9LB25ma2VyNQigAOVLxTFmmAKp0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012127; c=relaxed/simple;
	bh=OlixkxwYp388XfpC6M2p8+l0/0NyG8k1YIVBiewVi4E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=csNklysoY94PJvAYDcNIEqoplsR9kpFrLNnhZgi21QCqmtveg9tdU1gFtgrffAblqv9Tl66yN7uh/cgHorvOIke7ZmMWabTnj9Sfyx9GgWKoRq17sswxkK+z/S7LsYYMyBC267mvmRTxLL1VL0Tq4VBpxDZHWDnh8RXZotE7ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZtwTXT40; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZtwTXT40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706012124;
	bh=OlixkxwYp388XfpC6M2p8+l0/0NyG8k1YIVBiewVi4E=;
	h=From:To:Subject:Date:From;
	b=ZtwTXT40xaATLNxnD7kRCia/jjb8vfomtWwSX3ikPTUT4vsIfYrXGX0NEikH0T4on
	 G7kmtMVjfke6ygCKEq1KvkTKiSC5V6h7dNSfVMQ2vswk5Yf9yGZ9uzahjGYp5gdBmQ
	 Hi3DT7GeP7Jldgcwa2IVN1RnLpKXQvME+HcE/pvw6d4NDGfXF5ZSPLWmnXYhNzWDFw
	 2Hjog5G9h3VFerEaqlD0AVqJjsbMSwvdC2iC4UmLLelrilsAujGdS9MZVEest93s98
	 BlKXz00b8SwkZ9PdZl7LOzC7D2HHtwmvWVyxdfWaneMZiPy+eCJ8qpoepKDiHbOwEK
	 5HpoBXxhGRGBA==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7D5163781FD9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:15:24 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gatt-server: Add support for signed write command
Date: Tue, 23 Jan 2024 13:15:18 +0100
Message-Id: <20240123121519.523735-1-frederic.danis@collabora.com>
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

