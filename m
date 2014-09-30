Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/12] android: Add support for more configuration options
Date: Tue, 30 Sep 2014 13:06:16 +0200
Message-Id: <1412075187-5518-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for system ID, serial number and PnP ID options.
---
 android/hal-bluetooth.c |  15 ++++++
 android/hal-ipc-api.txt |   3 ++
 android/hal-msg.h       |   3 ++
 android/main.c          | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/utils.h         |   6 +++
 5 files changed, 146 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 07e86b0..f7db416 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -438,6 +438,21 @@ static int send_configuration(void)
 		cmd->num++;
 	}
 
+	if (get_config("serialno", prop, "ro.serialno") > 0) {
+		len += add_prop(prop, HAL_CONFIG_SERIAL_NUMBER, buf + len);
+		cmd->num++;
+	}
+
+	if (get_config("systemid", prop, NULL) > 0) {
+		len += add_prop(prop, HAL_CONFIG_SYSTEM_ID, buf + len);
+		cmd->num++;
+	}
+
+	if (get_config("pnpid", prop, NULL) > 0) {
+		len += add_prop(prop, HAL_CONFIG_PNP_ID, buf + len);
+		cmd->num++;
+	}
+
 	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_CONFIGURATION, len, cmd,
 							NULL, NULL, NULL);
 }
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 81aab50..82067f2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -158,6 +158,9 @@ Core Service (ID 0)
 		Valid configure option types: 0x00 = Vendor
 		                              0x01 = Model
 		                              0x02 = Name
+		                              0x03 = Serial Number
+		                              0x04 = System ID
+		                              0x05 = PnP ID
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bb6b1e0..9ae8c24 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -73,6 +73,9 @@ struct hal_cmd_unregister_module {
 #define HAL_CONFIG_VENDOR		0x00
 #define HAL_CONFIG_MODEL		0x01
 #define HAL_CONFIG_NAME			0x02
+#define HAL_CONFIG_SERIAL_NUMBER	0x03
+#define HAL_CONFIG_SYSTEM_ID		0x04
+#define HAL_CONFIG_PNP_ID		0x05
 
 struct hal_config_prop {
 	uint8_t type;
diff --git a/android/main.c b/android/main.c
index 27f5c48..9ee9960 100644
--- a/android/main.c
+++ b/android/main.c
@@ -74,6 +74,12 @@
 static char *config_vendor = NULL;
 static char *config_model = NULL;
 static char *config_name = NULL;
+static char *config_serial = NULL;
+static uint64_t config_system_id = 0;
+static uint16_t config_pnp_source = 0x0002;	/* USB */
+static uint16_t config_pnp_vendor = 0x1d6b;	/* Linux Foundation */
+static uint16_t config_pnp_product = 0x0247;	/* BlueZ for Android */
+static uint16_t config_pnp_version = 0x0000;
 
 static guint quit_timeout = 0;
 
@@ -109,6 +115,36 @@ const char *bt_config_get_model(void)
 	return DEFAULT_MODEL;
 }
 
+const char *bt_config_get_serial(void)
+{
+	return config_serial;
+}
+
+uint64_t bt_config_get_system_id(void)
+{
+	return config_system_id;
+}
+
+uint16_t bt_config_get_pnp_source(void)
+{
+	return config_pnp_source;
+}
+
+uint16_t bt_config_get_pnp_vendor(void)
+{
+	return config_pnp_vendor;
+}
+
+uint16_t bt_config_get_pnp_product(void)
+{
+	return config_pnp_product;
+}
+
+uint16_t bt_config_get_pnp_version(void)
+{
+	return config_pnp_version;
+}
+
 static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
@@ -284,6 +320,61 @@ static char *get_prop(char *prop, uint16_t len, const uint8_t *val)
 	return prop;
 }
 
+static void parse_pnp_id(uint16_t len, const uint8_t *val)
+{
+	int result;
+	uint16_t vendor, product, version , source;
+	char *pnp;
+
+	/* version is optional */
+	version = config_pnp_version;
+
+	pnp = get_prop(NULL, len, val);
+	if (!pnp)
+		return;
+
+	DBG("pnp_id %s", pnp);
+
+	result = sscanf(pnp, "bluetooth:%4hx:%4hx:%4hx",
+						&vendor, &product, &version);
+	if (result != EOF && result >= 2) {
+		source = 0x0001;
+		goto done;
+	}
+
+	result = sscanf(pnp, "usb:%4hx:%4hx:%4hx", &vendor, &product, &version);
+	if (result != EOF && result >= 2) {
+		source = 0x0002;
+		goto done;
+	}
+
+	free(pnp);
+	return;
+done:
+	free(pnp);
+
+	config_pnp_source = source;
+	config_pnp_vendor = vendor;
+	config_pnp_product = product;
+	config_pnp_version = version;
+}
+
+static void parse_system_id(uint16_t len, const uint8_t *val)
+{
+	uint64_t res;
+	char *id;
+
+	id = get_prop(NULL, len, val);
+	if (!id)
+		return;
+
+	res = strtoull(id, NULL, 16);
+	if (res == ULLONG_MAX && errno == ERANGE)
+		return;
+
+	config_system_id = res;
+}
+
 static void configuration(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_configuration *cmd = buf;
@@ -324,6 +415,21 @@ static void configuration(const void *buf, uint16_t len)
 			DBG("model %s", config_model);
 
 			break;
+		case HAL_CONFIG_SERIAL_NUMBER:
+			config_serial = get_prop(config_serial, prop->len,
+								prop->val);
+
+			DBG("serial %s", config_serial);
+
+			break;
+		case HAL_CONFIG_SYSTEM_ID:
+			parse_system_id(prop->len, prop->val);
+
+			break;
+		case HAL_CONFIG_PNP_ID:
+			parse_pnp_id(prop->len, prop->val);
+
+			break;
 		default:
 			error("Invalid configuration option (%u), terminating",
 								prop->type);
@@ -561,12 +667,24 @@ static bool set_capabilities(void)
 	return true;
 }
 
+static void set_version(void)
+{
+	uint8_t major, minor;
+
+	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
+		return;
+
+	config_pnp_version = major << 8 | minor;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
 	guint signal;
 
+	set_version();
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -651,6 +769,7 @@ int main(int argc, char *argv[])
 	free(config_vendor);
 	free(config_model);
 	free(config_name);
+	free(config_serial);
 
 	return EXIT_SUCCESS;
 }
diff --git a/android/utils.h b/android/utils.h
index c70f8cb..9bf2195 100644
--- a/android/utils.h
+++ b/android/utils.h
@@ -34,3 +34,9 @@ static inline void bdaddr2android(const bdaddr_t *src, void *buf)
 const char *bt_config_get_vendor(void);
 const char *bt_config_get_model(void);
 const char *bt_config_get_name(void);
+const char *bt_config_get_serial(void);
+uint64_t bt_config_get_system_id(void);
+uint16_t bt_config_get_pnp_source(void);
+uint16_t bt_config_get_pnp_vendor(void);
+uint16_t bt_config_get_pnp_product(void);
+uint16_t bt_config_get_pnp_version(void);
-- 
1.9.1

