Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [RFC 2/2] Add type property to Adapter
Date: Wed, 30 Mar 2011 15:33:56 -0300
Message-Id: <1301510036-17282-2-git-send-email-andre.dieb@signove.com>
In-Reply-To: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
References: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    4 ++++
 src/adapter.c       |   17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index f34d58f..c199fa1 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -225,6 +225,10 @@ Properties	string Address [readonly]
 
 			The Bluetooth class of device.
 
+		string Type [readonly]
+
+			Adapter type (BR/EDR, LE or BR/EDR/LE).
+
 		boolean Powered [readwrite]
 
 			Switch an adapter on or off. This will also set the
diff --git a/src/adapter.c b/src/adapter.c
index 4ce7e4c..39a8d0a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -112,6 +112,7 @@ struct btd_adapter {
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
+	device_type_t type;		/* Type (BR/EDR, LE, etc) */
 	guint discov_timeout_id;	/* discoverable timeout id */
 	guint stop_discov_id;		/* stop inquiry/scanning id */
 	uint32_t discov_timeout;	/* discoverable time(sec) */
@@ -1361,6 +1362,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Class",
 				DBUS_TYPE_UINT32, &adapter->dev_class);
 
+	/* Type */
+	property = devtype2str(adapter->type);
+	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &property);
+
 	/* Powered */
 	value = (adapter->up && !adapter->off_requested) ? TRUE : FALSE;
 	dict_append_entry(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
@@ -2699,7 +2704,6 @@ gboolean adapter_init(struct btd_adapter *adapter)
 					adapter->dev_id, strerror(-err), -err);
 		return FALSE;
 	}
-
 	dev = &adapter->dev;
 
 	dev->hci_rev = ver.hci_rev;
@@ -2714,6 +2718,17 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		return FALSE;
 	}
 
+	/* Determine controller type based on LMP features */
+	if (dev->features[4] & LMP_NO_BREDR) {
+		if (dev->features[4] & LMP_LE)
+			adapter->type = DEVICE_TYPE_LE;
+		else
+			adapter->type = DEVICE_TYPE_UNKNOWN;
+	} else if (dev->features[6] & LMP_LE_BREDR)
+		adapter->type = DEVICE_TYPE_DUALMODE;
+	else
+		adapter->type = DEVICE_TYPE_BREDR;
+
 	if (read_local_name(&adapter->bdaddr, adapter->dev.name) < 0)
 		expand_name(adapter->dev.name, MAX_NAME_LENGTH, main_opts.name,
 							adapter->dev_id);
-- 
1.7.1

