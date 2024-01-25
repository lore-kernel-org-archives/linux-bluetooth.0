Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29571339B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209698; cv=none; b=cpDAg1Bvi6Bna2YySLj9sqLyfJvKHFACXtvsrkF5yLKx7uekxGlPxkEV+bnDmWve9vKTeB1ZUBC1qMTU7vqstbzro/b1JCa38MO/Mmnh/zd+M6a2cYK/4jNm6+cmWraQfATLAMI3eQ2nC7x0fbc2sX+MPZ4BC6BdWeApZ/jNrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209698; c=relaxed/simple;
	bh=LmNYPxbyewhVFnClXjrGP4+mfa7j8oKqiQCqFrnbb40=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lxjf+LfSj3u1MiZ4+G0zosimrp15NCq3ghOr7KgHy+D3V9B9onxHkn/7vU/Cc3NfIm/fhK2UiwGPAF/YgfEz6YFawm5SD6xvf58oOp7tEAT61zeufj3mVgl93ksracL9e0FpQVM23wt/gAqPaD+F1d/PmhrvFs3jwApjlvmJ6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CaJQDRyt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CaJQDRyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706209695;
	bh=LmNYPxbyewhVFnClXjrGP4+mfa7j8oKqiQCqFrnbb40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CaJQDRytx3eoQOFpN6yNFqA3hPiX2zePWLTVQm2Y3joNewrQKr8xbpfdHZDYGUk/L
	 w8HNmmZhhn53DIScVq2x2Yudz7lvY0BpmdzMQDmROPMlyLAmVaWTb1L9sYXd3Zrkf9
	 jIK3qsTU9fCaRivmH0VMXXRslcSHm6cNaK/+KrEIPNepKozkEVA7LxdR73krc3RsfH
	 WEgq3mKja6bUAEL7XZH9k+wFmjZg0uCvvLrXHYC4O96lSN8e56UTLbU2IlxKmF3M/L
	 hsDAkgPkxWqz/CtzpSRxbnnhVHyXkFONTB9MLW1au+WJXYz6fOC5yeBW9+6yqZqHiX
	 /BGpNCBJOkDnw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 020EB3782031
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:14 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] btgatt-client: Add function to search service based on UUID
Date: Thu, 25 Jan 2024 20:08:03 +0100
Message-Id: <20240125190805.1244787-4-frederic.danis@collabora.com>
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

This is requested to pass PTS GATT/CL/GAD/BV-02-C test.
---
 tools/btgatt-client.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 3bcb7e1cf..99a123697 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -33,6 +33,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/gatt-helpers.h"
 
 #define ATT_CID 4
 
@@ -1353,6 +1354,72 @@ static void cmd_set_sign_key(struct client *cli, char *cmd_str)
 		set_sign_key_usage();
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
+	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
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
@@ -1389,6 +1456,8 @@ static struct {
 			"\tSet retry on security error by elevating security"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
+	{ "search-service", cmd_search_service,
+				"\tSearch service"},
 	{ }
 };
 
-- 
2.34.1

