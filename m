Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] core: Store signature counters
Date: Wed, 25 Feb 2015 15:42:10 +0200
Message-Id: <1424871733-14610-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
References: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores signature counters in LocalSignatureCounter and
RemoteSignatureCounter entries so they can be reloaded later.
---
 src/adapter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3353297..32faa26 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6156,7 +6156,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 
 static void store_csrk(const bdaddr_t *local, const bdaddr_t *peer,
 				uint8_t bdaddr_type, const unsigned char *key,
-				uint8_t master)
+				uint32_t counter, uint8_t master)
 {
 	const char *group;
 	char adapter_addr[18];
@@ -6190,6 +6190,7 @@ static void store_csrk(const bdaddr_t *local, const bdaddr_t *peer,
 		sprintf(key_str + (i * 2), "%2.2X", key[i]);
 
 	g_key_file_set_string(key_file, group, "Key", key_str);
+	g_key_file_set_integer(key_file, group, "Counter", counter);
 
 	create_file(filename, S_IRUSR | S_IWUSR);
 
@@ -6230,7 +6231,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 	if (!ev->store_hint)
 		return;
 
-	store_csrk(bdaddr, &key->addr.bdaddr, key->addr.type, key->val,
+	store_csrk(bdaddr, &key->addr.bdaddr, key->addr.type, key->val, 0,
 								key->master);
 
 	if (device_is_temporary(device))
-- 
2.1.0

