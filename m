Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 05/13] Cleanup read name and alias from storage
Date: Thu, 28 Apr 2011 19:37:01 -0300
Message-Id: <1304030229-6672-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c14e6e0..dbdee8f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3142,13 +3142,24 @@ static int remote_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
 	return 0;
 }
 
+static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
+{
+	char local_addr[18], peer_addr[18], filename[PATH_MAX + 1];
+
+	ba2str(local, local_addr);
+	ba2str(peer, peer_addr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, file);
+
+	return textfile_get(filename, peer_addr);
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				uint32_t class, int8_t rssi, uint8_t *data)
 {
-	char local_addr[18], peer_addr[18], filename[PATH_MAX + 1];
 	struct remote_dev_info *dev;
 	struct eir_data eir_data;
-	char *alias, *name;
+	char *name;
 	gboolean new_dev, legacy;
 	name_status_t name_status;
 	const char *dev_name;
@@ -3168,18 +3179,11 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	else
 		name_status = NAME_NOT_REQUIRED;
 
-	ba2str(&adapter->bdaddr, local_addr);
-	ba2str(bdaddr, peer_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
-	alias = textfile_get(filename, peer_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
-	name = textfile_get(filename, peer_addr);
-
 	if (remote_legacy_pairing(&adapter->bdaddr, bdaddr, data, &legacy) < 0)
 		legacy = TRUE;
 
+	name = read_stored_data(&adapter->bdaddr, bdaddr, "names");
+
 	/* Complete EIR names are always used. Shortened EIR names are only
 	 * used if there is no name already in storage. */
 	dev_name = name;
@@ -3196,18 +3200,22 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	dev = get_found_dev(adapter, bdaddr, &new_dev);
 
 	if (new_dev) {
+		char *alias;
 		if (dev_name)
 			dev->name = g_strdup(dev_name);
 
-		if (alias)
+		alias = read_stored_data(&adapter->bdaddr, bdaddr, "aliases");
+		if (alias) {
 			dev->alias = g_strdup(alias);
+			free(alias);
+		}
 
 		dev->le = FALSE;
 		dev->class = class;
 		dev->legacy = legacy;
 		dev->name_status = name_status;
 	} else if (dev->rssi == rssi)
-		return;
+		goto done;
 
 	dev->rssi = rssi;
 
@@ -3218,6 +3226,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	g_slist_foreach(eir_data.services, dev_prepend_uuid, dev);
 
 	adapter_emit_device_found(adapter, dev);
+
+done:
+	free(name);
 }
 
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
-- 
1.7.5.rc3

