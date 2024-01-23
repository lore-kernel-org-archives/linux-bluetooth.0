Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD6FC14
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020322; cv=none; b=H/h8vgWaw2rt8fYFlGRnOlek+yMuJ8hII02IFWpUZvyew3Eay4neTGJk9KRNPMnpu6aOWGqkpcjW4vxXQYfYD7AfjID7PeK7mDR1QzmnvQCzLdQkRydhNsWgSPbiLe5+q3mM57+ciHFF7ofJEI8NBNqakkCCJm5sgefSS5JUGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020322; c=relaxed/simple;
	bh=FC+9pgSINxVbv8TKyD9qVRj5fjcBXeSQmgiihqqgTVE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdbgvaDAQvTdNKOw/Gem72m5TMZeEwIM9qLUPwAgOtr/sziu96Ael5caWJ+hRXQ+gkRR2+w6bG3nYYt6vS87SiymcXsXboTxn5sUAiA/WwAlOOPo0yYj/Gn4cnw5LgV9G2CCCncqDTTseYCjbFunOZUksbHOe1ow2gU4QHpy5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eKG/eLoV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eKG/eLoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706020319;
	bh=FC+9pgSINxVbv8TKyD9qVRj5fjcBXeSQmgiihqqgTVE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eKG/eLoVB6UixAmodeOp6jnHYJzgqliTDo6EoPSk1VKm//KSPVOmLlyeq9gC5at6z
	 O/Sg8yJywdS9smtfbaAWVkzZdc+m1+H4WU3lEYmocqUXbs7NiV8PeLiEpwBwwe/fRt
	 c8CbUWXmLxt8SUyjVvGe9X2SIlqIDr9zQrSfRu89G5M0qr1AbwphJDqgO33itl/fCN
	 pb46jyYaW7G0+puAO7EoQpIh1idzJEjtJJ1oyPvBz2E6aPP+LcwhxqZo8E+uLqd8U9
	 jODQ4uo5HlLhJYlH/ugx/c4ZPbJIIx/DvfrtNKBzRveKsTOvjRI33tDgR1PmYZ4f8L
	 d11CwqcKgkckQ==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0BEBE37820B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:31:59 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] btgatt-client: Add function to search characteristics
Date: Tue, 23 Jan 2024 15:31:50 +0100
Message-Id: <20240123143151.541787-4-frederic.danis@collabora.com>
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

This is requested to pass PTS GATT/CL/GAD/BV-05-C test.
This search characteristics based on UUID, start and end handles.
---
 tools/btgatt-client.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 99a123697..04fd3ce0f 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1420,6 +1420,86 @@ static void cmd_search_service(struct client *cli, char *cmd_str)
 						NULL);
 }
 
+static void search_characteristics_usage(void)
+{
+	printf("Usage: search-characteristics <start_hanlde> <end_handle> "
+		"<uuid>\n"
+		"e.g.:\n"
+		"\tsearch-characteristics 0x0001 0xFFFF 1800\n");
+}
+
+static void search_characteristics_cb(bool success, uint8_t att_ecode,
+					struct bt_gatt_result *result,
+					void *user_data)
+{
+	struct bt_gatt_iter iter;
+	uint16_t handle, length;
+	const uint8_t *value;
+	int i;
+
+	if (!success) {
+		PRLOG("\nCharacteristics discovery failed: %s (0x%02x)\n",
+				ecode_to_string(att_ecode), att_ecode);
+		return;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		return;
+
+	printf("\n");
+	while (bt_gatt_iter_next_read_by_type(&iter, &handle, &length,
+						&value)) {
+		printf("Found handle: 0x%04x value: ", handle);
+		for (i = 0; i < length; i++)
+			printf("%02x ", value[i]);
+		printf("\n");
+	}
+	PRLOG("\n");
+}
+
+static void cmd_search_characteristics(struct client *cli, char *cmd_str)
+{
+	char *argv[4];
+	int argc = 0;
+	uint16_t start_handle, end_handle;
+	char *endptr = NULL;
+	bt_uuid_t uuid;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 3, argv, &argc) || argc != 3) {
+		search_characteristics_usage();
+		return;
+	}
+
+	start_handle = strtol(argv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		printf("Invalid start handle: %s\n", argv[0]);
+		return;
+	}
+
+	end_handle = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		printf("Invalid end handle: %s\n", argv[1]);
+		return;
+	}
+
+	if (bt_string_to_uuid(&uuid, argv[2]) < 0) {
+		printf("Invalid UUID: %s\n", argv[2]);
+		return;
+	}
+
+	bt_gatt_read_by_type(bt_gatt_client_get_att(cli->gatt), start_handle,
+						end_handle,
+						&uuid,
+						search_characteristics_cb,
+						NULL,
+						NULL);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1458,6 +1538,8 @@ static struct {
 				"\tSet signing key for signed write command"},
 	{ "search-service", cmd_search_service,
 				"\tSearch service"},
+	{ "search-characteristics", cmd_search_characteristics,
+				"\tSearch characteristics"},
 	{ }
 };
 
-- 
2.34.1

