Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6913399E
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209698; cv=none; b=n1SlqxU7NHNdzeQSndLVZ74W+4UwrJrUpTvVTMZUS2PTmGzJqpHGnQy/n3p2XB4Ep0ebadsdoAYLKg6wzWBEwh2MKiftEeLxgI5qDQ/DniPjfIYK0OmqPSuoAN+fyJAb4XZ296FdANy7rjGrIPsIMKmLhbu7p+h1RQeDeAEc/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209698; c=relaxed/simple;
	bh=HzGzbnE/z4iKIte/jzMHhTp803l+ZrpBDBSWSeqH0mk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stVWV+XeGEduZrjm3jfHnjzaXPQmnz4ohO4ICwtCdkO/nejXGOfDihTWvLHgvAJ7ee0aaZbxNV4fHoQGpwkGIZnes/qubwS9qwbaZKglx2AsQvrvIJ561Pj88tIymAhvlrwApC7lZO/MfxBTdT9gLWR3W7rCINeHtuhzrPb2tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KBKlnPOj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KBKlnPOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706209694;
	bh=HzGzbnE/z4iKIte/jzMHhTp803l+ZrpBDBSWSeqH0mk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KBKlnPOjCBWsOYUgqtM3PaVCIvAt/hScNnFnESc2oLL8dlc61b2rySp8Wrf+CCGEv
	 hV5oAGZhE13SDEyvZUgn+ngo6kYZPjPUODyR/sEjltT5/Gf7/EMsdY8nKv2vd46DDl
	 na31uAVScaoWKmc2WmFNHDDYs4pnpcM0xhtjFIw5vhwZBB7nLb5lE8AaxrNzTdo/lI
	 OUCVXE4Y4/d8c2tf+clep/rkeFOn93y4Sj06Wu30jrA+UC7QAsJ2I1AgbeOS0RSRai
	 T/6XY5HBH+eWQvrXPz6CTmn5m+0XCLFs0IJ1PJlJTjKtx48CQcpQIgkGbrD+kMrplq
	 ceBPlAit3IKQw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A64383782021
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:14 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] btgatt-client: Add command to prevent security level change
Date: Thu, 25 Jan 2024 20:08:02 +0100
Message-Id: <20240125190805.1244787-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125190805.1244787-1-frederic.danis@collabora.com>
References: <20240125190805.1244787-1-frederic.danis@collabora.com>
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

This commit adds the ability to prevent to change the security level.
---
 tools/btgatt-client.c | 84 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 12 deletions(-)

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

