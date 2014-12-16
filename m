Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 4/5] monitor/keys: use queue_find over queue_foreach
Date: Mon, 15 Dec 2014 17:03:35 -0800
Message-Id: <1418691816-40271-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use queue_find instead of visiting all queue items.
---
 monitor/keys.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/monitor/keys.c b/monitor/keys.c
index 4ccef22..e60aa93 100644
--- a/monitor/keys.c
+++ b/monitor/keys.c
@@ -99,44 +99,27 @@ void keys_update_identity_addr(const uint8_t addr[6], uint8_t addr_type)
 	}
 }
 
-struct resolve_data {
-	bool found;
-	uint8_t addr[6];
-	uint8_t ident[6];
-	uint8_t ident_type;
-};
-
-static void try_resolve_irk(void *data, void *user_data)
+static bool match_resolve_irk(const void *data, const void *match_data)
 {
-	struct irk_data *irk = data;
-	struct resolve_data *result = user_data;
+	const struct irk_data *irk = data;
+	const uint8_t *addr = match_data;
 	uint8_t local_hash[3];
 
-	if (result->found)
-		return;
-
-	bt_crypto_ah(crypto, irk->key, result->addr + 3, local_hash);
+	bt_crypto_ah(crypto, irk->key, addr + 3, local_hash);
 
-	if (!memcmp(result->addr, local_hash, 3)) {
-		result->found = true;
-		memcpy(result->ident, irk->addr, 6);
-		result->ident_type = irk->addr_type;
-	}
+	return !memcmp(addr, local_hash, 3);
 }
 
 bool keys_resolve_identity(const uint8_t addr[6], uint8_t ident[6],
 							uint8_t *ident_type)
 {
-	struct resolve_data result;
-
-	result.found = false;
-	memcpy(result.addr, addr, 6);
+	struct irk_data *irk;
 
-	queue_foreach(irk_list, try_resolve_irk, &result);
+	irk = queue_find(irk_list, match_resolve_irk, addr);
 
-	if (result.found) {
-		memcpy(ident, result.ident, 6);
-		*ident_type = result.ident_type;
+	if (irk) {
+		memcpy(ident, irk->addr, 6);
+		*ident_type = irk->addr_type;
 		return true;
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

