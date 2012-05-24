Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2 06/16] core: Fix reading stored data from "aliases" and "names" file
Date: Thu, 24 May 2012 15:46:03 -0300
Message-Id: <1337885173-9129-7-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337885173-9129-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a364935..2776204 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2833,16 +2833,19 @@ static gboolean pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer,
 		return TRUE;
 }
 
-static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
+static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
+			      uint8_t bdaddr_type, const char *file)
 {
-	char local_addr[18], peer_addr[18], filename[PATH_MAX + 1];
+	char local_addr[18], key[20], filename[PATH_MAX + 1];
 
 	ba2str(local, local_addr);
-	ba2str(peer, peer_addr);
 
 	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, file);
 
-	return textfile_get(filename, peer_addr);
+	ba2str(peer, key);
+	sprintf(&key[17], "#%hhu", bdaddr_type);
+
+	return textfile_get(filename, key);
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter,
@@ -2900,7 +2903,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	/* New device in the discovery session */
 
-	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
+	name = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type, "names");
 
 	if (bdaddr_type == BDADDR_BREDR) {
 		legacy = pairing_is_legacy(&adapter->bdaddr, bdaddr, data,
@@ -2920,7 +2923,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		adapter_ops->confirm_name(adapter->dev_id, bdaddr, bdaddr_type,
 								name_known);
 
-	alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
+	alias = read_stored_data(&adapter->bdaddr, bdaddr, bdaddr_type,
+								"aliases");
 
 	dev = found_device_new(bdaddr, bdaddr_type, name, alias, dev_class,
 						legacy, eir_data.flags);
-- 
1.7.7.6

