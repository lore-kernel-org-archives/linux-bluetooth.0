Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA1EEC2
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020322; cv=none; b=HHU2MtjPk5m2rVjEFBGrPqOJkcXy7QrwoWrxofxXS43W66TV7G8tdzlDrVPLJF7k+vjXdlhRrtpqqOwj7kRaTt9igwp90K2pBTYAuPILjSH+lXTsrUKZxD/I8/VM81y+8hd1gQPWi5OsNi5sA5StCgyQARXMVm8DYzH0GodX6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020322; c=relaxed/simple;
	bh=OBbqHDS4QAbgxWCGo4L8thKvqc/xQuu4rwqY0/K/0uc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzxsobGT0jVr3Wp1Pe3FW0JTe6m/Eb5AyTjkzUj6U7nVjtAcL5tNARFA5NBHvUnGy8YqihEXbVXInx/DRUMP1GnBR4DeXM5IVadhyOfeJM/kYjwy22lW2l2Licn5/bCcmR6jZHEhMjV3V2lQ+wGI2Is/swF/KixN4ZGB1HCKh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YY3kpJXd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YY3kpJXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706020318;
	bh=OBbqHDS4QAbgxWCGo4L8thKvqc/xQuu4rwqY0/K/0uc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YY3kpJXddXeHZZWln1A8hDOxlrv+/+D/qPAXsMHdnRz6ep2bA1hGw+mxWeE1cS0a1
	 6l5YmXeiT7zIXkbcW0ITSFX2+875gHxi4ZVYP37TAsz1UiLMthun4Vv3Yz/8DumiYe
	 MTBfal5Wol5p6HOP7c3CAltLWgtLayqVSQDLxPamJwVZrOjXStcmtSPx5JwkeY+Hje
	 g4Omta93hpxxKxWN0EH0e2HvL4HjbaCmDuZ04rG7lHxaVrmXN45ImxOQjjgLrMhiBl
	 4gt4XYp/tnopQL6ffxSxIhlPZXGKor+HEbOE3iGsEQrW6eLVyWfdQX6B6uM1RildJp
	 NHpxyIYgh2iIg==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5182F37820AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:31:58 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] gatt: Prevent security level change for PTS GATT tests
Date: Tue, 23 Jan 2024 15:31:48 +0100
Message-Id: <20240123143151.541787-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123143151.541787-1-frederic.danis@collabora.com>
References: <20240123143151.541787-1-frederic.danis@collabora.com>
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

This commit adds the ability to prevent to change the security level for
an operation.
---
 src/shared/att.c         | 26 +++++++++++++
 src/shared/att.h         |  1 +
 src/shared/gatt-client.c | 19 +++++++++
 src/shared/gatt-client.h |  3 ++
 tools/btgatt-client.c    | 84 ++++++++++++++++++++++++++++++++++------
 5 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 62c884b65..485ef071b 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -2042,3 +2042,29 @@ bool bt_att_has_crypto(struct bt_att *att)
 
 	return att->crypto ? true : false;
 }
+
+bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
+{
+	struct att_send_op *op;
+
+	if (!id)
+		return false;
+
+	op = queue_find(att->req_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->ind_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->write_queue, match_op_id, UINT_TO_PTR(id));
+
+done:
+	if (!op)
+		return false;
+
+	op->retry = !retry;
+
+	return true;
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 4aa3de87b..6fd78636e 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -110,3 +110,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
 bool bt_att_has_crypto(struct bt_att *att);
+bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5de679c9b..6340bcd85 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3818,3 +3818,22 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 
 	return false;
 }
+
+bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
+					unsigned int id,
+					bool retry)
+{
+	struct request *req;
+
+	if (!client || !id)
+		return false;
+
+	req = queue_find(client->pending_requests, match_req_id,
+							UINT_TO_PTR(id));
+	if (!req)
+		return false;
+
+	bt_att_set_retry(client->att, req->att_id, retry);
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index bccd04a62..63cf99500 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -134,3 +134,6 @@ unsigned int bt_gatt_client_idle_register(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 						unsigned int id);
+bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
+					unsigned int id,
+					bool retry);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 58a03bd48..3bcb7e1cf 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -57,6 +57,7 @@ struct client {
 	struct bt_gatt_client *gatt;
 
 	unsigned int reliable_session_id;
+	bool sec_retry;
 };
 
 static void print_prompt(void)
@@ -172,6 +173,7 @@ static struct client *client_create(int fd, uint16_t mtu)
 		fprintf(stderr, "Failed to allocate memory for client\n");
 		return NULL;
 	}
+	cli->sec_retry = true;
 
 	cli->att = bt_att_new(fd, false);
 	if (!cli->att) {
@@ -488,6 +490,7 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 	char *argv[512];
 	int i;
 	char *endptr = NULL;
+	unsigned int id;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -514,9 +517,12 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 		}
 	}
 
-	if (!bt_gatt_client_read_multiple(cli->gatt, value, argc,
-						read_multiple_cb, NULL, NULL))
+	id = bt_gatt_client_read_multiple(cli->gatt, value, argc,
+						read_multiple_cb, NULL, NULL);
+	if (!id)
 		printf("Failed to initiate read multiple procedure\n");
+	else if (!cli->sec_retry)
+		bt_gatt_client_set_retry(cli->gatt, id, false);
 
 	free(value);
 }
@@ -558,6 +564,7 @@ static void cmd_read_value(struct client *cli, char *cmd_str)
 	int argc = 0;
 	uint16_t handle;
 	char *endptr = NULL;
+	unsigned int id;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -575,9 +582,12 @@ static void cmd_read_value(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (!bt_gatt_client_read_value(cli->gatt, handle, read_cb,
-								NULL, NULL))
+	id = bt_gatt_client_read_value(cli->gatt, handle, read_cb,
+					NULL, NULL);
+	if (!id)
 		printf("Failed to initiate read value procedure\n");
+	else if (!cli->sec_retry)
+		bt_gatt_client_set_retry(cli->gatt, id, false);
 }
 
 static void read_long_value_usage(void)
@@ -592,6 +602,7 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
 	uint16_t handle;
 	uint16_t offset;
 	char *endptr = NULL;
+	unsigned int id;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -616,9 +627,12 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (!bt_gatt_client_read_long_value(cli->gatt, handle, offset, read_cb,
-								NULL, NULL))
+	id = bt_gatt_client_read_long_value(cli->gatt, handle, offset, read_cb,
+								NULL, NULL);
+	if (!id)
 		printf("Failed to initiate read long value procedure\n");
+	else if (!cli->sec_retry)
+		bt_gatt_client_set_retry(cli->gatt, id, false);
 }
 
 static void write_value_usage(void)
@@ -659,6 +673,7 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	uint8_t *value = NULL;
 	bool without_response = false;
 	bool signed_write = false;
+	unsigned int id;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -740,10 +755,13 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 		goto done;
 	}
 
-	if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
+	id = bt_gatt_client_write_value(cli->gatt, handle, value, length,
 								write_cb,
-								NULL, NULL))
+								NULL, NULL);
+	if (!id)
 		printf("Failed to initiate write procedure\n");
+	else if (!cli->sec_retry)
+		bt_gatt_client_set_retry(cli->gatt, id, false);
 
 done:
 	free(value);
@@ -789,6 +807,7 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	int length;
 	uint8_t *value = NULL;
 	bool reliable_writes = false;
+	unsigned int id;
 
 	if (!bt_gatt_client_is_ready(cli->gatt)) {
 		printf("GATT client not initialized\n");
@@ -863,11 +882,14 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 		}
 	}
 
-	if (!bt_gatt_client_write_long_value(cli->gatt, reliable_writes, handle,
+	id = bt_gatt_client_write_long_value(cli->gatt, reliable_writes, handle,
 							offset, value, length,
 							write_long_cb,
-							NULL, NULL))
+							NULL, NULL);
+	if (!id)
 		printf("Failed to initiate long write procedure\n");
+	else if (!cli->sec_retry)
+		bt_gatt_client_set_retry(cli->gatt, id, false);
 
 	free(value);
 }
@@ -999,12 +1021,18 @@ done:
 							value, length,
 							write_long_cb, NULL,
 							NULL);
-	if (!cli->reliable_session_id)
+	if (!cli->reliable_session_id) {
 		printf("Failed to proceed prepare write\n");
-	else
+	} else {
+		if (!cli->sec_retry)
+			bt_gatt_client_set_retry(cli->gatt,
+						cli->reliable_session_id,
+						false);
+
 		printf("Prepare write success.\n"
 				"Session id: %d to be used on next write\n",
 						cli->reliable_session_id);
+	}
 
 	free(value);
 }
@@ -1236,6 +1264,36 @@ static void cmd_get_security(struct client *cli, char *cmd_str)
 		printf("Security level: %u\n", level);
 }
 
+static void set_security_retry_usage(void)
+{
+	printf("Usage: set-security-retry <y/n>\n"
+		"e.g.:\n"
+		"\tset-security-retry n\n");
+}
+
+static void cmd_set_security_retry(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
+		set_security_retry_usage();
+		return;
+	}
+
+	if (argv[0][0] == 'y')
+		cli->sec_retry = true;
+	else if (argv[0][0] == 'n')
+		cli->sec_retry = false;
+	else
+		printf("Invalid argument: %s\n", argv[0]);
+}
+
 static bool convert_sign_key(char *optarg, uint8_t key[16])
 {
 	int i;
@@ -1327,6 +1385,8 @@ static struct {
 				"\tSet security level on le connection"},
 	{ "get-security", cmd_get_security,
 				"\tGet security level on le connection"},
+	{ "set-security-retry", cmd_set_security_retry,
+			"\tSet retry on security error by elevating security"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
 	{ }
-- 
2.34.1

