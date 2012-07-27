Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH v3 BlueZ 03/12] core: Fix reading from "aliases" and "names" file
Date: Fri, 27 Jul 2012 16:43:14 -0300
Message-Id: <1343418203-15335-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

---
 src/adapter.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8820e27..0394ec0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2801,16 +2801,26 @@ static gboolean pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer,
 		return TRUE;
 }
 
-static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
+static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
+			      uint8_t peer_type, const char *file)
 {
-	char local_addr[18], peer_addr[18], filename[PATH_MAX + 1];
+	char local_addr[18], key[20], filename[PATH_MAX + 1], *str;
 
 	ba2str(local, local_addr);
-	ba2str(peer, peer_addr);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, file);
 
-	return textfile_get(filename, peer_addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", peer_type);
+
+	str = textfile_get(filename, key);
+	if (str != NULL)
+		return str;
+
+	/* Try old format (address only) */
+	key[17] = '\0';
+
+	return textfile_get(filename, key);
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter,
@@ -2868,7 +2878,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	/* New device in the discovery session */
 
-	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
+	name = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type, "names");
 
 	if (bdaddr_type == BDADDR_BREDR) {
 		legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr, data,
@@ -2888,7 +2898,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		mgmt_confirm_name(adapter->dev_id, bdaddr, bdaddr_type,
 								name_known);
 
-	alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
+	alias = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type,
+								"aliases");
 
 	dev = found_device_new(bdaddr, bdaddr_type, name, alias, dev_class,
 						legacy, eir_data.flags);
-- 
1.7.10.4

