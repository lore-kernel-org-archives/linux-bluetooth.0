Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887065A0F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942212; cv=none; b=pRp7Xv3UehoymJiYJ7ek6pXn+0CuLXj5uKzXqhB8yf58H+ZrktKmPBFUUSR5KUyvJVAh1B+Wqk+GM3fk7CKoO7AVFOOJFkal2pOytdYYwNu54eG8lKd/mA8kOqM+HKCUBZY8peeqOIFHbNd5x9y1WeYziTDiOiSv4TgutOtfCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942212; c=relaxed/simple;
	bh=fPQmdE+Oy2gu6q4gm52BqkJE2isNjgA/hC6NjUp7Om0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqg6I7sx5R0v4YXIk/Vs9PcDYmx8xx2zrVMzRWI2Jm1YRiU7JTe+nUq0kyRFW4ecWJzVIG+JDMS13+MadqQrfHXHIMO2qUy5oM1caR1pglWkMHXO5pdyH4ddkwiaNhc8xKVZvc0yYvEmSsOvdrjmw5D6eFK+8rtv+s/U4HdZWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sjVMTKOs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sjVMTKOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942209;
	bh=fPQmdE+Oy2gu6q4gm52BqkJE2isNjgA/hC6NjUp7Om0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sjVMTKOsxPstDTiI6PnlPPSrqHv/0Cm3EzqJziHuDI9A7FgUuoxXTxJJEk94quW8I
	 oLFWnflcHdCsEeWZsqafuEvywW1HRzsSueErO//NBkWmX7Ll6jnhqZKDvpWV3FQWhE
	 EFBIwllnPR3uaCkZCXPmyLyFC15YAxGTMd7iwYzkrpjeFyhFe2/Ca3JuFrDBpXFwIe
	 tqCMs41UJCP08TcgeTQ6wcXwDmfaXAJYj6U9CDsHSj0Oc9a64ZWxJMzopauHZrACy9
	 T9o9nz9QCElvc5biochIWrH/sa0lPFBKaSyfPwJ+p5ftz0EPRjrN2Gfc6aQOxzwaNc
	 xdulWAHMUbDIw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E237E3782006
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:08 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] btgatt-client: Add function to search service based on UUID
Date: Mon, 22 Jan 2024 17:49:57 +0100
Message-Id: <20240122165000.279381-3-frederic.danis@collabora.com>
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

This is requested to pass PTS GATT/CL/GAD/BV-02-C test.
---
 tools/btgatt-client.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 76c74c7a8..631e26879 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -33,6 +33,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/gatt-helpers.h"
 
 #define ATT_CID 4
 
@@ -1331,6 +1332,78 @@ static void cmd_set_retry_on_sec_error(struct client *cli, char *cmd_str)
 		printf("Invalid argument: %s\n", argv[0]);
 }
 
+static void search_service_usage(void)
+{
+	printf("Usage: search-service <uuid>\n"
+		"e.g.:\n"
+		"\tsearch-service 1800\n");
+}
+
+static void search_service_cb(bool success, uint8_t att_ecode,
+					struct bt_gatt_result *result,
+					void *user_data)
+{
+	struct bt_gatt_iter iter;
+	uint16_t start_handle, end_handle;
+	uint128_t u128;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
+
+	if (!success) {
+		PRLOG("\nService discovery failed: %s (0x%02x)\n",
+				ecode_to_string(att_ecode), att_ecode);
+		return;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		return;
+
+	printf("\n");
+	while (bt_gatt_iter_next_service(&iter, &start_handle, &end_handle,
+						u128.data)) {
+		bt_uuid128_create(&uuid, u128);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		printf("Found start handle: 0x%04x, end handle: 0x%04x, "
+			"UUID: %s\n",
+			start_handle, end_handle, uuid_str);
+	}
+	PRLOG("\n");
+}
+
+static void cmd_search_service(struct client *cli, char *cmd_str)
+{
+	char *argv[2];
+	int argc = 0;
+	bt_uuid_t uuid;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 1, argv, &argc)) {
+		printf("Too many arguments\n");
+		search_service_usage();
+		return;
+	}
+
+	if (argc < 1) {
+		search_service_usage();
+		return;
+	}
+
+	if (bt_string_to_uuid(&uuid, argv[0]) < 0) {
+		printf("Invalid UUID: %s\n", argv[0]);
+		return;
+	}
+
+	bt_gatt_discover_primary_services(bt_gatt_client_get_att(cli->gatt),
+						&uuid, 0x0001, 0xFFFF,
+						search_service_cb,
+						NULL,
+						NULL);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1367,6 +1440,8 @@ static struct {
 				"\tSet signing key for signed write command"},
 	{ "set-retry-on-sec-error", cmd_set_retry_on_sec_error,
 			"\tSet retry on security error by elevating security"},
+	{ "search-service", cmd_search_service,
+				"\tSearch service"},
 	{ }
 };
 
-- 
2.34.1

