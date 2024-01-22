Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6A5A0F3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942211; cv=none; b=eAgwFGCzi4dMR37TsXoqHC/QzIfLfkc8i0xqSDZHL3x2aPvbKEeGEmMNTrLpmMke9tSoKc3iPQzBqH568p/PXOMg5ukAJ3jL11CWn8HfEmLHbApZ8M5HUux6jhydtrn6Gyfj7xAqJ9GvftrAKXPLYRbwUw40pXXrMZVCaZYFufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942211; c=relaxed/simple;
	bh=gIJATtkupiUzXndeX3DY2J5pSRzEjj+Qm08q+Oi9/Os=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otx34QYPF6PasDcWfEIJKQ2Sp6uirQ+Tdp/vOKVEPMh6bK7bwlK633JAAYhY7OTvaW6O9XyW/yjO+etWsk4q7KqOeLyLjYJ8n6xmPA1JDlqlLdZOcyCPdeu4pqKaVoK361rBTAoYpiLY5ftNmV5+MItxTZ5jUo/Sg8JMSap9JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NKcvFhxM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NKcvFhxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942208;
	bh=gIJATtkupiUzXndeX3DY2J5pSRzEjj+Qm08q+Oi9/Os=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NKcvFhxM3zALoMZw4gAygBBXO0YeMe0dmOT6M4nT1x/k+zGaZZ6a4Tjk7bhQNlD/t
	 rD7Jnxde6u6aY859ffOWSRWC7GMRWZ8PTafZXRoeOL4RIxqk53baiuDJFZZE9mWrmf
	 meLyINb9f/NJ0nuHj1dqfVsUwK1uPVms04TcLH0yyNNdi3Xo+ZuRvYW2JL9UTUFVXo
	 9W93oH1KvemL1l07C+B0GStJc5UwP5YPBcMIuI+j+GNEe0uIrxqj0pfmtLNSMVxpva
	 IGWG/Q0kc2DK4gRcmB51Celcuo+Ht/Q0ZEv19p5yBT+w8ukDqaAI7C+eRndS3pf1CK
	 WSESJiLNbzl1w==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8877D3781492
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:08 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] gatt: Prevent security level change for PTS GATT tests
Date: Mon, 22 Jan 2024 17:49:56 +0100
Message-Id: <20240122165000.279381-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122165000.279381-1-frederic.danis@collabora.com>
References: <20240122165000.279381-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get the
security error and do not try to change the security level.

this commit adds a variable allowing to prevent to change the security
level.
---
 src/shared/att.c         | 14 ++++++++++++++
 src/shared/att.h         |  1 +
 src/shared/gatt-client.c |  9 +++++++++
 src/shared/gatt-client.h |  2 ++
 tools/btgatt-client.c    | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 62c884b65..decc24314 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -87,6 +87,8 @@ struct bt_att {
 
 	struct sign_info *local_sign;
 	struct sign_info *remote_sign;
+
+	bool retry_on_sec_error;
 };
 
 struct sign_info {
@@ -786,6 +788,9 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 
 	*opcode = rsp->opcode;
 
+	if (!att->retry_on_sec_error)
+		return false;
+
 	/* If operation has already been marked as retry don't attempt to change
 	 * the security again.
 	 */
@@ -1262,6 +1267,7 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 	att = new0(struct bt_att, 1);
 	att->chans = queue_new();
 	att->mtu = chan->mtu;
+	att->retry_on_sec_error = true;
 
 	/* crypto is optional, if not available leave it NULL */
 	if (!ext_signed)
@@ -2042,3 +2048,11 @@ bool bt_att_has_crypto(struct bt_att *att)
 
 	return att->crypto ? true : false;
 }
+
+void bt_att_set_retry_on_sec_error(struct bt_att *att, bool retry_on_sec_error)
+{
+	if (!att)
+		return;
+
+	att->retry_on_sec_error = retry_on_sec_error;
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 4aa3de87b..8ed89ba80 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -110,3 +110,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
 bool bt_att_has_crypto(struct bt_att *att);
+void bt_att_set_retry_on_sec_error(struct bt_att *att, bool retry_on_sec_error);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5de679c9b..b484db9db 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3818,3 +3818,12 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 
 	return false;
 }
+
+void bt_gatt_client_set_retry_on_sec_error(struct bt_gatt_client *client,
+						bool retry_on_sec_error)
+{
+	if (!client)
+		return;
+
+	bt_att_set_retry_on_sec_error(client->att, retry_on_sec_error);
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index bccd04a62..fdb841df0 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -134,3 +134,5 @@ unsigned int bt_gatt_client_idle_register(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 						unsigned int id);
+void bt_gatt_client_set_retry_on_sec_error(struct bt_gatt_client *client,
+						bool retry_on_sec_error);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 58a03bd48..76c74c7a8 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1295,6 +1295,42 @@ static void cmd_set_sign_key(struct client *cli, char *cmd_str)
 		set_sign_key_usage();
 }
 
+static void set_retry_on_sec_error_usage(void)
+{
+	printf("Usage: set-retry-on-sec-error <y/n>\n"
+		"e.g.:\n"
+		"\tset-retry-on-sec-error n\n");
+}
+
+static void cmd_set_retry_on_sec_error(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc)) {
+		printf("Too many arguments\n");
+		set_retry_on_sec_error_usage();
+		return;
+	}
+
+	if (argc < 1) {
+		set_retry_on_sec_error_usage();
+		return;
+	}
+
+	if (argv[0][0] == 'y')
+		bt_gatt_client_set_retry_on_sec_error(cli->gatt, true);
+	else if (argv[0][0] == 'n')
+		bt_gatt_client_set_retry_on_sec_error(cli->gatt, false);
+	else
+		printf("Invalid argument: %s\n", argv[0]);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1329,6 +1365,8 @@ static struct {
 				"\tGet security level on le connection"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
+	{ "set-retry-on-sec-error", cmd_set_retry_on_sec_error,
+			"\tSet retry on security error by elevating security"},
 	{ }
 };
 
-- 
2.34.1

