Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6835A103
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942212; cv=none; b=bGqjKdU9sAGXrxkRI2oW1tOr25MDtxaNwCMFcfMdAre2FQ/KOgAoOZOnqakYZCHiBvW8xbT25BzmCBQ6UoTHiGBEWFDQ16gfm5+248x4KpIZ3cPBLuWhEpqpDxBcXd4QBmnB/DB05eRnmeNab7CE4ZaN59v8sKLhSAEfy9LdNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942212; c=relaxed/simple;
	bh=Hj5JqDOHqud7iRXnSOhTzvi87Bol9LHWmMYFr5ubMXE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBvmeeb49wd1nRBtguvUd00ekOvDP0qfVWbZH4g4z2p2imxBYhk6gMPHZ/Ra13HGxmPKEIDiXPmOk5mz2iMKSqfNPbz7/ofzaWW3673VfiMir2d2UIsJmp0CNytCERQeaSJU9gwz2A+VVGPhHFNZuj4ghRe2gb1DsCfe0TjpKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WEdapMP/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WEdapMP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942209;
	bh=Hj5JqDOHqud7iRXnSOhTzvi87Bol9LHWmMYFr5ubMXE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WEdapMP/+OJo2De+sDgSTj3dSImKCVaHAeRw3ZpnknbizHm1zE64qG5Te+uXbQz8Y
	 6sQnmzYM+7i/6+QK1ZC/OZaNLOcxuO3pMvb38YQMJQU1IQQT47bXuVyFSf4R1ioIOj
	 K1lMf8Q4dSF/58UpQ7kLqiILBPLwChY0ipUR2t9KyBEpL6ku78O94ypB8Eu1md3gs1
	 68Vrevdy1xK6zl1VoqgO5B++qjPnoh+W1iO8C8dLaafojxctsdC9uiuKMSEgxFGwST
	 KGvX84P7XheyD6s0Nf1L6ElV0vWiXu0ZUDJRTQokUxv/tH9VhrloQed4hmis9dw8vf
	 KxZI2lvzHkbqw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A194C3782009
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:09 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] btgatt-client: Add function to search descriptors
Date: Mon, 22 Jan 2024 17:49:59 +0100
Message-Id: <20240122165000.279381-5-frederic.danis@collabora.com>
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

This is requested to pass PTS GATT/CL/GAD/BV-06-C test.
This search descriptors based on start and end handles.
---
 tools/btgatt-client.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index bb0822658..a7d5d76ba 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1490,6 +1490,83 @@ static void cmd_search_characteristics(struct client *cli, char *cmd_str)
 						NULL);
 }
 
+static void search_descriptors_usage(void)
+{
+	printf("Usage: search-descriptors <start_hanlde> <end_handle>\n"
+		"e.g.:\n"
+		"\tsearch-descriptors 0x0001 0xFFFF\n");
+}
+
+static void search_descriptors_cb(bool success, uint8_t att_ecode,
+					struct bt_gatt_result *result,
+					void *user_data)
+{
+	struct bt_gatt_iter iter;
+	uint16_t handle;
+	uint128_t u128;
+	bt_uuid_t uuid;
+	char uuid_str[MAX_LEN_UUID_STR];
+
+	if (!success) {
+		PRLOG("\nDescriptors discovery failed: %s (0x%02x)\n",
+				ecode_to_string(att_ecode), att_ecode);
+		return;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		return;
+
+	printf("\n");
+	while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
+		bt_uuid128_create(&uuid, u128);
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		printf("Found handle: 0x%04x UUID: %s\n", handle, uuid_str);
+	}
+	PRLOG("\n");
+}
+
+static void cmd_search_descriptors(struct client *cli, char *cmd_str)
+{
+	char *argv[3];
+	int argc = 0;
+	uint16_t start_handle, end_handle;
+	char *endptr = NULL;
+
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	if (!parse_args(cmd_str, 2, argv, &argc)) {
+		printf("Too many arguments\n");
+		search_descriptors_usage();
+		return;
+	}
+
+	if (argc < 1) {
+		search_descriptors_usage();
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
+	bt_gatt_discover_descriptors(bt_gatt_client_get_att(cli->gatt),
+						start_handle, end_handle,
+						search_descriptors_cb,
+						NULL,
+						NULL);
+}
+
 static void cmd_help(struct client *cli, char *cmd_str);
 
 typedef void (*command_func_t)(struct client *cli, char *cmd_str);
@@ -1530,6 +1607,8 @@ static struct {
 				"\tSearch service"},
 	{ "search-characteristics", cmd_search_characteristics,
 				"\tSearch characteristics"},
+	{ "search-descriptors", cmd_search_descriptors,
+				"\tSearch descriptors"},
 	{ }
 };
 
-- 
2.34.1

