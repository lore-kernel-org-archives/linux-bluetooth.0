Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 3/3] android: Add completion for adapter to haltest
Date: Fri, 18 Oct 2013 15:16:00 +0200
Message-ID: <1382102160-21532-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds all completion functions for adapter methods.
It also adds short help lines for all methods that require arguments.
---
 android/client/haltest.c  |   11 +-
 android/client/if-bt.c    |  331 ++++++++++++++++++++++++++++++++++++++-------
 android/client/if-main.h  |   16 +++
 android/client/textconv.c |   21 +++
 android/client/textconv.h |    4 +
 5 files changed, 330 insertions(+), 53 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index 6dcabbc..6b37f33 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -103,11 +103,12 @@ static void process_line(char *line_buffer)
 			continue;
 		}
 		if (argc < 2 || strcmp(argv[1], "?") == 0) {
-			j = 0;
-			while (strcmp(interfaces[i]->methods[j].name, "")) {
-				haltest_info("%s %s\n", argv[0],
-						interfaces[i]->methods[j].name);
-				++j;
+			struct method *m = &interfaces[i]->methods[0];
+			while (strcmp(m->name, "")) {
+				haltest_info("%s %s %s\n", argv[0],
+						m->name,
+						(m->help ? m->help : ""));
+				m++;
 			}
 			return;
 		}
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 90ef732..30b41cd 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -19,6 +19,16 @@
 
 const bt_interface_t *if_bluetooth;
 
+#define VERIFY_PROP_TYPE_ARG(n, typ) \
+	do { \
+		if (n < argc) \
+			typ = str2btpropertytype(argv[n]); \
+		else { \
+			haltest_error("No property type specified\n"); \
+			return;\
+		} \
+	} while (0)
+
 static char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 {
 	static char buf[18];
@@ -177,6 +187,84 @@ static void dump_properties(int num_properties, bt_property_t *properties)
 	}
 }
 
+/*
+ * Cache for remote devices, stored in sorted array
+ */
+static bt_bdaddr_t *remote_devices = NULL;
+static int remote_devices_cnt = 0;
+static int remote_devices_capacity = 0;
+
+/* Adds address to remote device set so it can be used in tab completion */
+void add_remote_device(const bt_bdaddr_t *addr)
+{
+	int i;
+
+	if (remote_devices == NULL) {
+		remote_devices = malloc(4 * sizeof(bt_bdaddr_t));
+		remote_devices_cnt = 0;
+		if (remote_devices == NULL) {
+			remote_devices_capacity = 0;
+			return;
+		}
+		remote_devices_capacity = 4;
+	}
+
+	/* Array is sorted, search for right place */
+	for (i = 0; i < remote_devices_cnt; ++i) {
+		int res = memcmp(&remote_devices[i], addr, sizeof(*addr));
+		if (res == 0)
+			return; /* Already added */
+		else if (res > 0)
+			break;
+	}
+
+	/* Realloc space if needed */
+	if (remote_devices_cnt >= remote_devices_capacity) {
+		remote_devices_capacity *= 2;
+		remote_devices = realloc(remote_devices, sizeof(bt_bdaddr_t) *
+						remote_devices_capacity);
+		if (remote_devices == NULL) {
+			remote_devices_capacity = 0;
+			remote_devices_cnt = 0;
+			return;
+		}
+	}
+
+	if (i < remote_devices_cnt)
+		memmove(remote_devices + i + 1, remote_devices + i,
+				(remote_devices_cnt - i) * sizeof(bt_bdaddr_t));
+	remote_devices[i] = *addr;
+	remote_devices_cnt++;
+}
+
+const char *enum_devices(void *v, int i)
+{
+	static char buf[19];
+
+	if (i >= remote_devices_cnt)
+		return NULL;
+
+	bt_bdaddr_t2str(&remote_devices[i], buf);
+	return buf;
+}
+
+static void add_remote_device_from_props(int num_properties,
+						const bt_property_t *properties)
+{
+	int i;
+
+	for (i = 0; i < num_properties; i++) {
+		/*
+		 * properities sometimes come unaligned hence memcp to
+		 * aligned buffer
+		 */
+		bt_property_t property;
+		memcpy(&property, properties + i, sizeof(property));
+		if (property.type == BT_PROPERTY_BDADDR)
+			add_remote_device((bt_bdaddr_t *) property.val);
+	}
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
 	haltest_info("%s: state=%s\n", __func__, bt_state_t2str(state));
@@ -198,6 +286,8 @@ static void remote_device_properties_cb(bt_status_t status,
 	       __func__, bt_status_t2str(status), bdaddr2str(bd_addr),
 	       num_properties);
 
+	add_remote_device(bd_addr);
+
 	dump_properties(num_properties, properties);
 }
 
@@ -205,6 +295,8 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 {
 	haltest_info("%s: num_properties=%d\n", __func__, num_properties);
 
+	add_remote_device_from_props(num_properties, properties);
+
 	dump_properties(num_properties, properties);
 }
 
@@ -214,19 +306,33 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 		bt_discovery_state_t2str(state));
 }
 
+/*
+ * Buffer for remote addres that came from one of bind request.
+ * It's stored for command completion.
+ */
+static char last_remote_addr[18];
+static bt_ssp_variant_t last_ssp_variant = (bt_ssp_variant_t)-1;
+
 static void pin_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 	uint32_t cod)
 {
+	/* Store for command completion */
+	bt_bdaddr_t2str(remote_bd_addr, last_remote_addr);
+
 	haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x\n", __func__,
-			       bdaddr2str(remote_bd_addr), bd_name->name, cod);
+				       last_remote_addr, bd_name->name, cod);
 }
 
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 				uint32_t cod, bt_ssp_variant_t pairing_variant,
 				uint32_t pass_key)
 {
+	/* Store for command completion */
+	bt_bdaddr_t2str(remote_bd_addr, last_remote_addr);
+	last_ssp_variant = pairing_variant;
+
 	haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x pairing_variant=%s pass_key=%d\n",
-		     __func__, bdaddr2str(remote_bd_addr), bd_name->name, cod,
+		     __func__, last_remote_addr, bd_name->name, cod,
 		     bt_ssp_variant_t2str(pairing_variant), pass_key);
 }
 
@@ -338,15 +444,45 @@ static void get_adapter_properties_p(int argc, const char **argv)
 	EXEC(if_bluetooth->get_adapter_properties);
 }
 
+static void get_adapter_property_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = TYPE_ENUM(bt_property_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
 static void get_adapter_property_p(int argc, const char **argv)
 {
-	int type = str2btpropertytype(argv[2]);
+	int type;
 
 	RETURN_IF_NULL(if_bluetooth);
+	VERIFY_PROP_TYPE_ARG(2, type);
 
 	EXEC(if_bluetooth->get_adapter_property, type);
 }
 
+static const char * const names[] = {
+		"BT_PROPERTY_BDNAME",
+		"BT_PROPERTY_ADAPTER_SCAN_MODE",
+		"BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT", NULL
+};
+
+static void set_adapter_property_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = (void *) names;
+		*penum_func = enum_strings;
+	} else if (argc == 4) {
+		if (0 == strcmp(argv[2], "BT_PROPERTY_ADAPTER_SCAN_MODE")) {
+			*puser = TYPE_ENUM(bt_scan_mode_t);
+			*penum_func = enum_defines;
+		}
+	}
+}
+
 static void set_adapter_property_p(int argc, const char **argv)
 {
 	bt_property_t property;
@@ -354,9 +490,12 @@ static void set_adapter_property_p(int argc, const char **argv)
 	int timeout;
 
 	RETURN_IF_NULL(if_bluetooth);
+	VERIFY_PROP_TYPE_ARG(2, property.type);
 
-	property.type = str2btpropertytype(argv[2]);
-
+	if (argc <= 3) {
+		haltest_error("No property value specified\n");
+		return;
+	}
 	switch (property.type) {
 	case BT_PROPERTY_BDNAME:
 		property.len = strlen(argv[3]) + 1;
@@ -383,39 +522,70 @@ static void set_adapter_property_p(int argc, const char **argv)
 	EXEC(if_bluetooth->set_adapter_property, &property);
 }
 
+/*
+ * This function is to be used for completion methods that need only address
+ */
+static void complete_addr_c(int argc, const char **argv,
+					enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = NULL;
+		*penum_func = enum_devices;
+	}
+}
+
+/* Just addres to complete, use complete_addr_c */
+#define get_remote_device_properties_c complete_addr_c
+
 static void get_remote_device_properties_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
+	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_bluetooth->get_remote_device_properties, &addr);
 }
 
+static void get_remote_device_property_c(int argc, const char **argv,
+						enum_func *penum_func,
+								void **puser)
+{
+	if (argc == 3) {
+		*puser = NULL;
+		*penum_func = enum_devices;
+	} else if (argc == 4) {
+		*puser = TYPE_ENUM(bt_property_type_t);
+		*penum_func = enum_defines;
+	}
+}
+
 static void get_remote_device_property_p(int argc, const char **argv)
 {
 	bt_property_type_t type;
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
-	type = str2btpropertytype(argv[3]);
+	VERIFY_ADDR_ARG(2, &addr);
+	VERIFY_PROP_TYPE_ARG(3, type);
 
 	EXEC(if_bluetooth->get_remote_device_property, &addr, type);
 }
 
+/*
+ * Same completion as for get_remote_device_property_c can be used for
+ * set_remote_device_property_c. No need to create separate function.
+ */
+#define set_remote_device_property_c get_remote_device_property_c
+
 static void set_remote_device_property_p(int argc, const char **argv)
 {
 	bt_property_t property;
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
-	property.type = str2btpropertytype(argv[3]);
+	VERIFY_ADDR_ARG(2, &addr);
+	VERIFY_PROP_TYPE_ARG(3, property.type);
 
 	switch (property.type) {
 	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
@@ -430,26 +600,37 @@ static void set_remote_device_property_p(int argc, const char **argv)
 	EXEC(if_bluetooth->set_remote_device_property, &addr, &property);
 }
 
+/*
+ * For now uuid is not autocompleted. Use routine for complete_addr_c
+ */
+#define get_remote_service_record_c complete_addr_c
+
 static void get_remote_service_record_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 	bt_uuid_t uuid;
 
 	RETURN_IF_NULL(if_bluetooth);
+	VERIFY_ADDR_ARG(2, &addr);
 
-	str2bt_bdaddr_t(argv[2], &addr);
+	if (argc <= 3) {
+		haltest_error("No uuid specified\n");
+		return;
+	}
 	str2bt_uuid_t(argv[3], &uuid);
 
 	EXEC(if_bluetooth->get_remote_service_record, &addr, &uuid);
 }
 
+/* Just addres to complete, use complete_addr_c */
+#define get_remote_services_c complete_addr_c
+
 static void get_remote_services_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
+	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_bluetooth->get_remote_services, &addr);
 }
@@ -468,39 +649,55 @@ static void cancel_discovery_p(int argc, const char **argv)
 	EXEC(if_bluetooth->cancel_discovery);
 }
 
+/* Just addres to complete, use complete_addr_c */
+#define create_bond_c complete_addr_c
+
 static void create_bond_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
+	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_bluetooth->create_bond, &addr);
 }
 
+/* Just addres to complete, use complete_addr_c */
+#define remove_bond_c complete_addr_c
+
 static void remove_bond_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
+	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_bluetooth->remove_bond, &addr);
 }
 
+/* Just addres to complete, use complete_addr_c */
+#define cancel_bond_c complete_addr_c
+
 static void cancel_bond_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
 
 	RETURN_IF_NULL(if_bluetooth);
-
-	str2bt_bdaddr_t(argv[2], &addr);
+	VERIFY_ADDR_ARG(2, &addr);
 
 	EXEC(if_bluetooth->cancel_bond, &addr);
 }
 
+static void pin_reply_c(int argc, const char **argv,
+		enum_func *penum_func, void **puser)
+{
+	static const char *const completions[] = { last_remote_addr, NULL };
+	if (argc == 3) {
+		*puser = (void *) completions;
+		*penum_func = enum_strings;
+	}
+}
+
 static void pin_reply_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -509,14 +706,9 @@ static void pin_reply_p(int argc, const char **argv)
 	int accept;
 
 	RETURN_IF_NULL(if_bluetooth);
+	VERIFY_ADDR_ARG(2, &addr);
 
-	if (argc < 3) {
-		haltest_error("No address specified\n");
-		return;
-	}
-	str2bt_bdaddr_t(argv[2], &addr);
-
-	if (argc >= 4) {
+	if (argc > 3) {
 		accept = 1;
 		pin_len = strlen(argv[3]);
 		memcpy(pin.pin, argv[3], pin_len);
@@ -525,6 +717,26 @@ static void pin_reply_p(int argc, const char **argv)
 	EXEC(if_bluetooth->pin_reply, &addr, accept, pin_len, &pin);
 }
 
+static void ssp_reply_c(int argc, const char **argv,
+		enum_func *penum_func, void **puser)
+{
+	if (argc == 3) {
+		*puser = last_remote_addr;
+		*penum_func = enum_one_string;
+	} else if (argc == 5) {
+		*puser = "1";
+		*penum_func = enum_one_string;
+	} else if (argc == 4) {
+		if (-1 != (int) last_ssp_variant) {
+			*puser = (void *) bt_ssp_variant_t2str(last_ssp_variant);
+			*penum_func = enum_one_string;
+		} else {
+			*puser = TYPE_ENUM(bt_ssp_variant_t);
+			*penum_func = enum_defines;
+		}
+	}
+}
+
 static void ssp_reply_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
@@ -533,12 +745,8 @@ static void ssp_reply_p(int argc, const char **argv)
 	int passkey;
 
 	RETURN_IF_NULL(if_bluetooth);
+	VERIFY_ADDR_ARG(2, &addr);
 
-	if (argc < 3) {
-		haltest_error("No address specified\n");
-		return;
-	}
-	str2bt_bdaddr_t(argv[2], &addr);
 	if (argc < 4) {
 		haltest_error("No ssp variant specified\n");
 		return;
@@ -557,6 +765,29 @@ static void ssp_reply_p(int argc, const char **argv)
 	EXEC(if_bluetooth->ssp_reply, &addr, var, accept, passkey);
 }
 
+static void get_profile_interface_c(int argc, const char **argv,
+		enum_func *penum_func, void **puser)
+{
+	static const char *const profile_ids[] = {
+		BT_PROFILE_HANDSFREE_ID,
+		BT_PROFILE_ADVANCED_AUDIO_ID,
+		BT_PROFILE_HEALTH_ID,
+		BT_PROFILE_SOCKETS_ID,
+		BT_PROFILE_HIDHOST_ID,
+		BT_PROFILE_PAN_ID,
+#if PLATFORM_SDK_VERSION >= 18
+		BT_PROFILE_GATT_ID,
+#endif
+		BT_PROFILE_AV_RC_ID,
+		NULL
+	};
+
+	if (argc == 3) {
+		*puser = (void *) profile_ids;
+		*penum_func = enum_strings;
+	}
+}
+
 static void get_profile_interface_p(int argc, const char **argv)
 {
 	const char *id = argv[2];
@@ -595,6 +826,10 @@ static void dut_mode_configure_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_bluetooth);
 
+	if (argc <= 2) {
+		haltest_error("No dut mode specified\n");
+		return;
+	}
 	mode = strtol(argv[2], NULL, 0);
 
 	EXEC(if_bluetooth->dut_mode_configure, mode);
@@ -606,22 +841,22 @@ static struct method methods[] = {
 	STD_METHOD(enable),
 	STD_METHOD(disable),
 	STD_METHOD(get_adapter_properties),
-	STD_METHOD(get_adapter_property),
-	STD_METHOD(set_adapter_property),
-	STD_METHOD(get_remote_device_properties),
-	STD_METHOD(get_remote_device_property),
-	STD_METHOD(set_remote_device_property),
-	STD_METHOD(get_remote_service_record),
-	STD_METHOD(get_remote_services),
+	STD_METHODCH(get_adapter_property, "<prop_type>"),
+	STD_METHODCH(set_adapter_property, "<prop_type> <prop_value>"),
+	STD_METHODCH(get_remote_device_properties, "<addr>"),
+	STD_METHODCH(get_remote_device_property, "<addr> <property_type>"),
+	STD_METHODCH(set_remote_device_property, "<addr> <property_type> <value>"),
+	STD_METHODCH(get_remote_service_record, "<addr> <uuid>"),
+	STD_METHODCH(get_remote_services, "<addr>"),
 	STD_METHOD(start_discovery),
 	STD_METHOD(cancel_discovery),
-	STD_METHOD(create_bond),
-	STD_METHOD(remove_bond),
-	STD_METHOD(cancel_bond),
-	STD_METHOD(pin_reply),
-	STD_METHOD(ssp_reply),
-	STD_METHOD(get_profile_interface),
-	STD_METHOD(dut_mode_configure),
+	STD_METHODCH(create_bond, "<addr>"),
+	STD_METHODCH(remove_bond, "<addr>"),
+	STD_METHODCH(cancel_bond, "<addr>"),
+	STD_METHODCH(pin_reply, "<address> [<pin>]"),
+	STD_METHODCH(ssp_reply, "<address> <ssp_veriant> 1|0 [<passkey>]"),
+	STD_METHODCH(get_profile_interface, "<profile id>"),
+	STD_METHODH(dut_mode_configure, "<dut mode>"),
 	END_METHOD
 };
 
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 3fb3007..b6bbf05 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -103,6 +103,12 @@ int haltest_error(const char *format, ...);
 int haltest_info(const char *format, ...);
 int haltest_warn(const char *format, ...);
 
+/*
+ * Enumerator for discovered devices, to be used as tab completion enum_func
+ */
+const char *enum_devices(void *v, int i);
+void add_remote_device(const bt_bdaddr_t *addr);
+
 /* Helper macro for executing function on interface and printing BT_STATUS */
 #define EXEC(f, ...) \
 	{ \
@@ -119,3 +125,13 @@ int haltest_warn(const char *format, ...);
 
 #define RETURN_IF_NULL(x) \
 	do { if (!x) { haltest_error("%s is NULL\n", #x); return; } } while (0)
+
+#define VERIFY_ADDR_ARG(n, adr) \
+	do { \
+		if (n < argc) \
+			str2bt_bdaddr_t(argv[n], adr); \
+		else { \
+			haltest_error("No address specified\n");\
+			return;\
+		} \
+	} while (0)
diff --git a/android/client/textconv.c b/android/client/textconv.c
index eebad70..3493b1c 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -203,3 +203,24 @@ void str2bt_uuid_t(const char *str, bt_uuid_t *uuid)
 		str += 2;
 	}
 }
+
+const char *enum_defines(void *v, int i)
+{
+	const struct int2str *m = v;
+
+	return m[i].str != NULL ? m[i].str : NULL;
+}
+
+const char *enum_strings(void *v, int i)
+{
+	const char **m = v;
+
+	return m[i] != NULL ? m[i] : NULL;
+}
+
+const char *enum_one_string(void *v, int i)
+{
+	const char *m = v;
+
+	return (i == 0) && (m[0] != 0) ? m : NULL;
+}
diff --git a/android/client/textconv.h b/android/client/textconv.h
index 8fe976c..88da641 100644
--- a/android/client/textconv.h
+++ b/android/client/textconv.h
@@ -54,7 +54,11 @@ struct int2str {
 
 int int2str_findint(int v, const struct int2str m[]);
 int int2str_findstr(const char *str, const struct int2str m[]);
+const char *enum_defines(void *v, int i);
+const char *enum_strings(void *v, int i);
+const char *enum_one_string(void *v, int i);
 
+#define TYPE_ENUM(type) ((void *)&__##type##2str[0])
 #define DECINTMAP(type) \
 extern struct int2str __##type##2str[]; \
 const char *type##2##str(type v); \
-- 
1.7.9.5

