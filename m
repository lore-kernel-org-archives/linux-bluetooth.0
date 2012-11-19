Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] neard: Add support for nokia.com:bt type
Date: Mon, 19 Nov 2012 16:03:57 +0100
Message-ID: <1353337438-21865-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
References: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for parsing nokia.com:bt type supported by some Nokia
NFC enabled devices. This is not fully documented Nokia extension so
to keep implementation sane and simple only PushOOB method suports
this type so only static handover is possible.
---
 plugins/neard.c |  198 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 8319445..4627f52 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -322,6 +322,194 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 	return 0;
 }
 
+/*
+ * This is (barely documented) Nokia extension format, most work was done by
+ * reverse engineering.
+ *
+ * Binary format varies among different devices, type depends on first byte
+ * 0x00 - BT address not reversed, 16 bytes authentication data (all zeros)
+ * 0x01 - BT address not reversed, 16 bytes authentication data (4 digit PIN,
+ *        padded with zeros)
+ * 0x02 - BT address not reversed, 16 bytes authentication data (not sure if
+ *        16 digit PIN or link key?, Nokia refers to it as ' Public Key')
+ * 0x10 - BT address reversed, no authentication data
+ * 0x24 - BT address not reversed, 4 bytes authentication data (4 digit PIN)
+ *
+ * General structure:
+ * 1 byte  - marker
+ * 6 bytes - BT address (reversed or not, depends on marker)
+ * 3 bytes - Class of Device
+ * 0, 4 or 16 bytes - authentication data, interpretation depends on marker
+ * 1 bytes - name length
+ * N bytes - name
+ */
+
+struct nokia_com_bt {
+	bdaddr_t address;
+	uint32_t cod;
+	uint8_t pin[16];
+	int pin_len;
+	char *name;
+};
+
+static int process_nokia_long (void *data, size_t size, uint8_t marker,
+						struct nokia_com_bt *nokia)
+{
+	struct {
+		bdaddr_t address;
+		uint8_t class[3];
+		uint8_t authentication[16];
+		uint8_t name_len;
+		uint8_t name[0];
+	}__attribute__((packed)) *n = data;
+
+	if (size != sizeof(*n) + n->name_len)
+		return -EINVAL;
+
+	/* address is not reverted */
+	baswap(&nokia->address, &n->address);
+
+	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+
+	if (n->name_len > 0)
+		nokia->name = g_strndup((char *)n->name, n->name_len);
+
+	if (marker == 0x01) {
+		memcpy(nokia->pin, n->authentication, 4);
+		nokia->pin_len = 4;
+	} else if (marker == 0x02) {
+		memcpy(nokia->pin, n->authentication, 16);
+		nokia->pin_len = 16;
+	}
+
+	return 0;
+}
+
+static int process_nokia_short (void *data, size_t size,
+						struct nokia_com_bt *nokia)
+{
+	struct {
+		bdaddr_t address;
+		uint8_t class[3];
+		uint8_t authentication[4];
+		uint8_t name_len;
+		uint8_t name[0];
+	}__attribute__((packed)) *n = data;
+
+	if (size != sizeof(*n) + n->name_len)
+		return -EINVAL;
+
+	/* address is not reverted */
+	baswap(&nokia->address, &n->address);
+
+	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+
+	if (n->name_len > 0)
+		nokia->name = g_strndup((char *)n->name, n->name_len);
+
+	memcpy(nokia->pin, n->authentication, 4);
+	nokia->pin_len = 4;
+
+	return 0;
+}
+
+static int process_nokia_extra_short (void *data, size_t size,
+						struct nokia_com_bt *nokia)
+{
+	struct {
+		bdaddr_t address;
+		uint8_t class[3];
+		uint8_t name_len;
+		uint8_t name[0];
+	}__attribute__((packed)) *n = data;
+
+	if (size != sizeof(*n) + n->name_len)
+		return -EINVAL;
+
+	bacpy(&nokia->address, &n->address);
+
+	nokia->cod = n->class[0] | (n->class[1] << 8) | (n->class[2] << 16);
+
+	if (n->name_len > 0)
+		nokia->name = g_strndup((char *)n->name, n->name_len);
+
+	return 0;
+}
+
+/* returns 1 if pairing is not needed */
+static int process_nokia_com_bt(struct btd_adapter *adapter, void *data,
+						size_t size, bdaddr_t *remote)
+{
+	uint8_t *marker;
+	struct nokia_com_bt nokia;
+	int ret;
+	char remote_address[18];
+
+	/* Support this only for PushOOB */
+	if (!remote)
+		return -EOPNOTSUPP;
+
+	marker = data++;
+	size --;
+
+	DBG("marker: 0x%.2x  size: %zu", *marker, size);
+
+	memset(&nokia, 0, sizeof(nokia));
+
+	switch (*marker) {
+	case 0x00:
+	case 0x01:
+	case 0x02:
+		ret = process_nokia_long(data, size, *marker, &nokia);
+		break;
+	case 0x10:
+		ret = process_nokia_extra_short(data, size, &nokia);
+		break;
+	case 0x24:
+		ret = process_nokia_short(data, size, &nokia);
+		break;
+	default:
+		info("Not supported Nokia NFC extension (0x%.2x)", *marker);
+		ret = -EPROTONOSUPPORT;
+		break;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	ba2str(&nokia.address, remote_address);
+	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
+
+	ret = check_device(adapter, remote_address);
+	if (ret != 0) {
+		g_free(nokia.name);
+		return ret;
+	}
+
+	DBG("hci%u remote:%s", adapter_get_dev_id(adapter), remote_address);
+
+	if (nokia.name) {
+		btd_event_remote_name(adapter_get_address(adapter), remote,
+								nokia.name);
+		g_free(nokia.name);
+	}
+
+	if (nokia.cod != 0)
+		write_remote_class(adapter_get_address(adapter), remote,
+								nokia.cod);
+
+	if (nokia.pin_len > 0) {
+		/* TODO
+		 * Handle PIN, for now only discovery mode and 'common' PINs
+		 * that might be provided by agent will work correctly.
+		 */
+	}
+
+	bacpy(remote, &nokia.address);
+
+	return 0;
+}
+
 static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 							bdaddr_t *remote)
 {
@@ -371,8 +559,14 @@ static int process_params(DBusMessage *msg, struct btd_adapter *adapter,
 
 		return process_eir(adapter, eir, size, remote);
 	} else if (strcasecmp(key, "nokia.com:bt") == 0) {
-		/* TODO add support for Nokia BT 2.0 proprietary stuff */
-		return -ENOTSUP;
+		DBusMessageIter array;
+		uint8_t *data;
+		int size;
+
+		dbus_message_iter_recurse(&value, &array);
+		dbus_message_iter_get_fixed_array(&array, &data, &size);
+
+		return process_nokia_com_bt(adapter, data, size, remote);
 	}
 
 	return -EINVAL;
-- 
1.7.9.5

