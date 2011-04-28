Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 04/13] Move legacy verification to a new function
Date: Thu, 28 Apr 2011 19:37:00 -0300
Message-Id: <1304030229-6672-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030229-6672-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3a671e6..c14e6e0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3119,6 +3119,29 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	adapter_emit_device_found(adapter, dev);
 }
 
+static int remote_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
+					uint8_t *data, gboolean *legacy)
+{
+	unsigned char features[8];
+	int err;
+
+	if (data) {
+		*legacy = FALSE;
+		return 0;
+	}
+
+	err = read_remote_features(local, peer, NULL, features);
+	if (err < 0)
+		return err;
+
+	if (features[0] & 0x01)
+		*legacy = FALSE;
+	else
+		*legacy = TRUE;
+
+	return 0;
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				uint32_t class, int8_t rssi, uint8_t *data)
 {
@@ -3128,7 +3151,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	char *alias, *name;
 	gboolean new_dev, legacy;
 	name_status_t name_status;
-	unsigned char features[8];
 	const char *dev_name;
 	int err;
 
@@ -3155,15 +3177,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
 	name = textfile_get(filename, peer_addr);
 
-	if (data)
-		legacy = FALSE;
-	else if (read_remote_features(&adapter->bdaddr, bdaddr, NULL,
-							features) == 0) {
-		if (features[0] & 0x01)
-			legacy = FALSE;
-		else
-			legacy = TRUE;
-	} else
+	if (remote_legacy_pairing(&adapter->bdaddr, bdaddr, data, &legacy) < 0)
 		legacy = TRUE;
 
 	/* Complete EIR names are always used. Shortened EIR names are only
-- 
1.7.5.rc3

