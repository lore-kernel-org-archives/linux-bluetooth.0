Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3B370AC7
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188132; cv=none; b=K7p8NFT7v1R06GUdCWplXNbwU67/Cnwel5DGWKp3tqr0gs61Aa5ZCq670Zrg0mvHYOai7zs2oGlxjyAcS7ohJqDoHy7ePWtzAw7WWgQ9R63yueJGmo9ErgnEbdnxRu+XlDMpPFct7W7wEUCoE8mknZ/ellE+K6wHvIWL6pXzW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188132; c=relaxed/simple;
	bh=auLWGMDRDFJB5jOEMVzgazNgvhn9teBdoqgjT+VtN28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brObNHsd5pZ+b1IXH1w8z266SNPz7dvvu90p8ocxbT84AJz++XJ2yzyYnXav0390O2R5EYhHXRju0iwrD+NVrR291jL5uhkEFYHflKfisQP9QaW7haJrKFGL6TLSYonwMLi8cAZ4Pjtcfa3+a7TW6Do/Zfu6VUn9WGyrPnY3tWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cC8jgbGJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cC8jgbGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779188124;
	bh=auLWGMDRDFJB5jOEMVzgazNgvhn9teBdoqgjT+VtN28=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cC8jgbGJ4zFbewYn/xCKqHGbZDxrBjYjdgZ+24AhDIFjozojaq2Y/j0bkAm8s5EKH
	 NGjXALhR9Oc+e6Mdv3tY4KCYpgvTUWkQ0tY+K0lYo+4meaA+DovKEuuf9G88KJmYBt
	 vl49nIAj3FhUSXArQJNAk+nJbpdq9hLPL4Pcocagz8m4Xsa2sR+SNXhaVu3KdRKMfG
	 Y5XnVRfpaofvhqX5x8ULI1lASsLwuRq3y8v0eDgrqrhnsO7CTHyRw2urYoTgpnetZC
	 SzGanZayfG7ztPT7eOcoXtW+46eiJphDmaYoKS1b+g+uNgxeCCu8nD47QAaanRxZA6
	 3+1yG1/mq08qg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B13CC17E12C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] client/btpclient: refactor read-commands bitmap building
Date: Tue, 19 May 2026 12:55:17 +0200
Message-ID: <20260519105519.226648-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519105519.226648-1-frederic.danis@collabora.com>
References: <20260519105519.226648-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add add_supported_command() and use it across all btp_*_read_commands
handlers.

This replaces fixed-size bitmask assembly with a dynamically growing
command bitmap based on opcode index, avoiding shift-width issues with
higher opcodes.
This will allow to add opcodes like GAP_SET_EXTENDED_ADVERTISING
(0x21).

Refactor core, gap, gatt and bap read-commands paths to build response
bitmaps through the shared helper and preserve existing error handling
for allocation failures.

Assisted-by: GPT:GPT-5.3-Codex
---
 client/btpclient/bap.c       | 27 +++++++++++++----
 client/btpclient/btpclient.c | 25 +++++++++++++++
 client/btpclient/btpclient.h |  5 +++
 client/btpclient/core.c      | 29 ++++++++++++++----
 client/btpclient/gap.c       | 59 +++++++++++++++++++++++-------------
 client/btpclient/gatt.c      | 39 ++++++++++++++++--------
 6 files changed, 139 insertions(+), 45 deletions(-)

diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index d64828894..0302fc1c0 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -27,7 +27,13 @@ static bool bap_service_registered;
 static void btp_bap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
-	uint16_t commands = 0;
+	const uint8_t supported_commands[] = {
+		BTP_OP_BAP_READ_SUPPORTED_COMMANDS,
+		BTP_OP_BAP_DISCOVER,
+	};
+	uint8_t *commands = NULL;
+	size_t commands_len = 0;
+	size_t i;
 
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_BAP_SERVICE, index,
@@ -35,13 +41,22 @@ static void btp_bap_read_commands(uint8_t index, const void *param,
 		return;
 	}
 
-	commands |= (1 << BTP_OP_BAP_READ_SUPPORTED_COMMANDS);
-	commands |= (1 << BTP_OP_BAP_DISCOVER);
-
-	commands = L_CPU_TO_LE16(commands);
+	for (i = 0; i < L_ARRAY_SIZE(supported_commands); i++) {
+		if (!add_supported_command(&commands, &commands_len,
+						supported_commands[i]))
+			goto failed;
+	}
 
 	btp_send(btp, BTP_BAP_SERVICE, BTP_OP_BAP_READ_SUPPORTED_COMMANDS,
-			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+			BTP_INDEX_NON_CONTROLLER, commands_len, commands);
+
+	l_free(commands);
+
+	return;
+
+failed:
+	l_free(commands);
+	btp_send_error(btp, BTP_BAP_SERVICE, index, BTP_ERROR_FAIL);
 }
 
 static void btp_bap_discover(uint8_t index, const void *param, uint16_t length,
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index ee46966dc..0d124bc7a 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -38,6 +38,31 @@ static struct btp *btp;
 
 static struct btp_agent ag;
 
+bool add_supported_command(uint8_t **commands, size_t *commands_len,
+							uint8_t command)
+{
+	size_t cmd_byte = command / 8;
+
+	if (cmd_byte >= *commands_len) {
+		size_t old_len = *commands_len;
+		size_t new_len = cmd_byte + 1;
+		uint8_t *tmp;
+
+		tmp = l_realloc(*commands, new_len);
+		if (!tmp)
+			return false;
+
+		memset(tmp + old_len, 0, new_len - old_len);
+
+		*commands = tmp;
+		*commands_len = new_len;
+	}
+
+	(*commands)[cmd_byte] |= (1U << (command % 8));
+
+	return true;
+}
+
 struct l_queue *get_adapters_list(void)
 {
 	return adapters;
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index e26a08413..8a5ea2172 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -7,6 +7,8 @@
  *
  */
 
+#include <stddef.h>
+
 struct btp_adapter {
 	struct l_dbus_proxy *proxy;
 	struct l_dbus_proxy *ad_proxy;
@@ -54,3 +56,6 @@ struct btp_agent *get_agent(void);
 bool request_default_agent(l_dbus_client_proxy_result_func_t reply,
 						void *user_data,
 						l_dbus_destroy_func_t destroy);
+
+bool add_supported_command(uint8_t **commands, size_t *commands_len,
+							uint8_t command);
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
index 772178670..f5d64904f 100644
--- a/client/btpclient/core.c
+++ b/client/btpclient/core.c
@@ -24,7 +24,15 @@ static struct l_dbus *dbus;
 static void btp_core_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
-	uint8_t commands = 0;
+	const uint8_t supported_commands[] = {
+		BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
+		BTP_OP_CORE_READ_SUPPORTED_SERVICES,
+		BTP_OP_CORE_REGISTER,
+		BTP_OP_CORE_UNREGISTER,
+	};
+	uint8_t *commands = NULL;
+	size_t commands_len = 0;
+	size_t i;
 
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_CORE_SERVICE, index,
@@ -32,13 +40,22 @@ static void btp_core_read_commands(uint8_t index, const void *param,
 		return;
 	}
 
-	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_COMMANDS);
-	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_SERVICES);
-	commands |= (1 << BTP_OP_CORE_REGISTER);
-	commands |= (1 << BTP_OP_CORE_UNREGISTER);
+	for (i = 0; i < L_ARRAY_SIZE(supported_commands); i++) {
+		if (!add_supported_command(&commands, &commands_len,
+						supported_commands[i]))
+			goto failed;
+	}
 
 	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
-			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+			BTP_INDEX_NON_CONTROLLER, commands_len, commands);
+
+	l_free(commands);
+
+	return;
+
+failed:
+	l_free(commands);
+	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
 }
 
 static void btp_core_read_services(uint8_t index, const void *param,
diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 68e029dcc..916626f1d 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -99,7 +99,30 @@ static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
-	uint16_t commands = 0;
+	const uint8_t supported_commands[] = {
+		BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
+		BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
+		BTP_OP_GAP_READ_CONTROLLER_INFO,
+		BTP_OP_GAP_RESET,
+		BTP_OP_GAP_SET_POWERED,
+		BTP_OP_GAP_SET_CONNECTABLE,
+		BTP_OP_GAP_SET_DISCOVERABLE,
+		BTP_OP_GAP_SET_BONDABLE,
+		BTP_OP_GAP_START_ADVERTISING,
+		BTP_OP_GAP_STOP_ADVERTISING,
+		BTP_OP_GAP_START_DISCOVERY,
+		BTP_OP_GAP_STOP_DISCOVERY,
+		BTP_OP_GAP_CONNECT,
+		BTP_OP_GAP_DISCONNECT,
+		BTP_OP_GAP_SET_IO_CAPA,
+		BTP_OP_GAP_PAIR,
+		BTP_OP_GAP_UNPAIR,
+		BTP_OP_GAP_PASSKEY_ENTRY_RSP,
+		BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
+	};
+	uint8_t *commands = NULL;
+	size_t commands_len = 0;
+	size_t i;
 
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_GAP_SERVICE, index,
@@ -107,28 +130,22 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 		return;
 	}
 
-	commands |= (1 << BTP_OP_GAP_READ_SUPPORTED_COMMANDS);
-	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST);
-	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INFO);
-	commands |= (1 << BTP_OP_GAP_RESET);
-	commands |= (1 << BTP_OP_GAP_SET_POWERED);
-	commands |= (1 << BTP_OP_GAP_SET_CONNECTABLE);
-	commands |= (1 << BTP_OP_GAP_SET_DISCOVERABLE);
-	commands |= (1 << BTP_OP_GAP_SET_BONDABLE);
-	commands |= (1 << BTP_OP_GAP_START_ADVERTISING);
-	commands |= (1 << BTP_OP_GAP_STOP_ADVERTISING);
-	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
-	commands |= (1 << BTP_OP_GAP_STOP_DISCOVERY);
-	commands |= (1 << BTP_OP_GAP_CONNECT);
-	commands |= (1 << BTP_OP_GAP_DISCONNECT);
-	commands |= (1 << BTP_OP_GAP_SET_IO_CAPA);
-	commands |= (1 << BTP_OP_GAP_PAIR);
-	commands |= (1 << BTP_OP_GAP_UNPAIR);
-
-	commands = L_CPU_TO_LE16(commands);
+	for (i = 0; i < L_ARRAY_SIZE(supported_commands); i++) {
+		if (!add_supported_command(&commands, &commands_len,
+						supported_commands[i]))
+			goto failed;
+	}
 
 	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
-			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+			BTP_INDEX_NON_CONTROLLER, commands_len, commands);
+
+	l_free(commands);
+
+	return;
+
+failed:
+	l_free(commands);
+	btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL);
 }
 
 static void btp_gap_read_controller_index(uint8_t index, const void *param,
diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
index 9d847141c..d384b9c74 100644
--- a/client/btpclient/gatt.c
+++ b/client/btpclient/gatt.c
@@ -44,7 +44,19 @@ static int create_uuid(bt_uuid_t *btuuid, uint8_t len, const uint8_t *data)
 static void btp_gatt_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
-	uint16_t commands = 0;
+	const uint8_t supported_commands[] = {
+		BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
+		BTP_OP_GATT_DISC_PRIM_UUID,
+		BTP_OP_GATT_DISC_CHRC_UUID,
+		BTP_OP_GATT_DISC_ALL_DESC,
+		BTP_OP_GATT_READ,
+		BTP_OP_GATT_READ_UUID,
+		BTP_OP_GATT_WRITE_WITHOUT_RSP,
+		BTP_OP_GATT_WRITE,
+	};
+	uint8_t *commands = NULL;
+	size_t commands_len = 0;
+	size_t i;
 
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_GATT_SERVICE, index,
@@ -52,19 +64,22 @@ static void btp_gatt_read_commands(uint8_t index, const void *param,
 		return;
 	}
 
-	commands |= (1 << BTP_OP_GATT_READ_SUPPORTED_COMMANDS);
-	commands |= (1 << BTP_OP_GATT_DISC_PRIM_UUID);
-	commands |= (1 << BTP_OP_GATT_DISC_CHRC_UUID);
-	commands |= (1 << BTP_OP_GATT_DISC_ALL_DESC);
-	commands |= (1 << BTP_OP_GATT_READ);
-	commands |= (1 << BTP_OP_GATT_READ_UUID);
-	commands |= (1 << BTP_OP_GATT_WRITE_WITHOUT_RSP);
-	commands |= (1 << BTP_OP_GATT_WRITE);
-
-	commands = L_CPU_TO_LE16(commands);
+	for (i = 0; i < L_ARRAY_SIZE(supported_commands); i++) {
+		if (!add_supported_command(&commands, &commands_len,
+						supported_commands[i]))
+			goto failed;
+	}
 
 	btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ_SUPPORTED_COMMANDS,
-			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+			BTP_INDEX_NON_CONTROLLER, commands_len, commands);
+
+	l_free(commands);
+
+	return;
+
+failed:
+	l_free(commands);
+	btp_send_error(btp, BTP_GATT_SERVICE, index, BTP_ERROR_FAIL);
 }
 
 static bool match_attribute_uuid(const void *attr, const void *uuid)
-- 
2.43.0

