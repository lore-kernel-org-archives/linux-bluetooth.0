Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/14] neard: Add ability to parse 'State' field
Date: Thu, 7 Feb 2013 09:13:53 +0100
Message-ID: <1360224844-12280-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This contains hint for power state of remote device Bluetooth adapter.
---
 plugins/neard.c | 125 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 33 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 7df4544..668c46f 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -55,6 +55,13 @@ static gboolean agent_register_postpone = FALSE;
 /* For NFC mimetype limits max OOB EIR size */
 #define NFC_OOB_EIR_MAX UINT8_MAX
 
+enum cps {
+	CPS_ACTIVE,
+	CPS_INACTIVE,
+	CPS_ACTIVATING,
+	CPS_UNKNOWN,
+};
+
 struct oob_params {
 	bdaddr_t address;
 	uint32_t class;
@@ -64,6 +71,7 @@ struct oob_params {
 	uint8_t *randomizer;
 	uint8_t *pin;
 	int pin_len;
+	enum cps power_state;
 };
 
 static void free_oob_params(struct oob_params *params)
@@ -451,14 +459,24 @@ static int process_nokia_com_bt(uint8_t *data, size_t size,
 	}
 }
 
+static enum cps process_state(const char *state)
+{
+	if (strcasecmp(state, "active") == 0)
+		return CPS_ACTIVE;
+
+	if (strcasecmp(state, "activating") == 0)
+		return CPS_ACTIVATING;
+
+	if (strcasecmp(state, "inactive") == 0)
+		return CPS_INACTIVE;
+
+	return CPS_UNKNOWN;
+}
+
 static int process_message(DBusMessage *msg, struct oob_params *remote)
 {
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	DBusMessageIter value;
-	DBusMessageIter entry;
-	const char *key;
-	int type;
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -467,46 +485,87 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 
 	dbus_message_iter_recurse(&iter, &dict);
 
-	type = dbus_message_iter_get_arg_type(&dict);
-	if (type != DBUS_TYPE_DICT_ENTRY) {
-		if (type == DBUS_TYPE_INVALID)
-			return -ENOENT;
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value;
+		DBusMessageIter entry;
+		const char *key;
 
-		return -EINVAL;
-	}
+		dbus_message_iter_recurse(&dict, &entry);
 
-	dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			goto error;
 
-	if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
-		return -EINVAL;
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
 
-	dbus_message_iter_get_basic(&entry, &key);
-	dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
 
-	dbus_message_iter_recurse(&entry, &value);
+		if (strcasecmp(key, "EIR") == 0) {
+			DBusMessageIter array;
+			uint8_t *eir;
+			int size;
 
-	/* All keys have byte array type values */
-	if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
-		return -EINVAL;
+			/* nokia.com:bt and EIR should not be passed together */
+			if (bacmp(&remote->address, BDADDR_ANY) != 0)
+				goto error;
+
+			if (dbus_message_iter_get_arg_type(&value) !=
+					DBUS_TYPE_ARRAY)
+				goto error;
 
-	if (strcasecmp(key, "EIR") == 0) {
-		DBusMessageIter array;
-		uint8_t *eir;
-		int size;
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, &eir, &size);
 
-		dbus_message_iter_recurse(&value, &array);
-		dbus_message_iter_get_fixed_array(&array, &eir, &size);
+			if (process_eir(eir, size, remote) < 0)
+				goto error;
+		} else if (strcasecmp(key, "nokia.com:bt") == 0) {
+			DBusMessageIter array;
+			uint8_t *data;
+			int size;
 
-		return process_eir(eir, size, remote);
-	} else if (strcasecmp(key, "nokia.com:bt") == 0) {
-		DBusMessageIter array;
-		uint8_t *data;
-		int size;
+			/* nokia.com:bt and EIR should not be passed together */
+			if (bacmp(&remote->address, BDADDR_ANY) != 0)
+				goto error;
 
-		dbus_message_iter_recurse(&value, &array);
-		dbus_message_iter_get_fixed_array(&array, &data, &size);
+			if (dbus_message_iter_get_arg_type(&value) !=
+					DBUS_TYPE_ARRAY)
+				goto error;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, &data, &size);
+
+			if (process_nokia_com_bt(data, size, remote))
+				goto error;
+		} else if (strcasecmp(key, "State") == 0) {
+			DBusMessageIter array;
+			const char *state;
+
+			if (dbus_message_iter_get_arg_type(&value) !=
+					DBUS_TYPE_STRING)
+				goto error;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_basic(&value, &state);
+
+			remote->power_state = process_state(state);
+			if (remote->power_state == CPS_UNKNOWN)
+				goto error;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	/* Check if 'State' was passed along with one of other fields */
+	if (remote->power_state != CPS_UNKNOWN
+			&& bacmp(&remote->address, BDADDR_ANY) == 0)
+		return -EINVAL;
+
+	return 0;
 
-		return process_nokia_com_bt(data, size, remote);
+error:
+	if (bacmp(&remote->address, BDADDR_ANY) != 0) {
+		free_oob_params(remote);
+		memset(remote, 0, sizeof(*remote));
 	}
 
 	return -EINVAL;
-- 
1.8.1.1

