Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 03/12] Move legacy verification to a new function
Date: Mon, 16 May 2011 17:49:52 -0300
Message-Id: <1305579001-3019-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3188974..6f85abf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3002,6 +3002,31 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	adapter_emit_device_found(adapter, dev);
 }
 
+static int pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer, gboolean eir,
+					gboolean name, gboolean *legacy)
+{
+	unsigned char features[8];
+	int err;
+
+	if (eir) {
+		*legacy = FALSE;
+		return 0;
+	}
+
+	if (name == FALSE) {
+		*legacy = TRUE;
+		return 0;
+	}
+
+	err = read_remote_features(local, peer, NULL, features);
+	if (err < 0)
+		return err;
+
+	*legacy = (features[0] & 0x01 ? FALSE : TRUE);
+
+	return 0;
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				uint32_t class, int8_t rssi, uint8_t *data)
 {
@@ -3011,7 +3036,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	char *alias, *name;
 	gboolean new_dev, legacy;
 	name_status_t name_status;
-	unsigned char features[8];
 	const char *dev_name;
 	int err;
 
@@ -3037,17 +3061,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
 	name = textfile_get(filename, peer_addr);
 
-	if (data)
-		legacy = FALSE;
-	else if (name == NULL)
-		legacy = TRUE;
-	else if (read_remote_features(&adapter->bdaddr, bdaddr, NULL,
-							features) == 0) {
-		if (features[0] & 0x01)
-			legacy = FALSE;
-		else
-			legacy = TRUE;
-	} else
+	if (pairing_is_legacy(&adapter->bdaddr, bdaddr,
+				data ? TRUE : FALSE, name ? TRUE : FALSE,
+				&legacy) < 0)
 		legacy = TRUE;
 
 	/* Complete EIR names are always used. Shortened EIR names are only
-- 
1.7.5.rc3

