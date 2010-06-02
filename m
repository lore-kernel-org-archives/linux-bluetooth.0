Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 02/32] Initial support for HDP
Date: Wed,  2 Jun 2010 15:18:58 +0200
Message-Id: <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Creates the basic structure of the plugin, registering
adapter and device drivers.
---
 Makefile.am        |    8 +
 acinclude.m4       |    8 +-
 health/hdp.c       |  183 +++++++++++++++++++++
 health/hdp.h       |   27 +++
 health/hdp_types.h |   99 ++++++++++++
 health/hdp_util.c  |  447 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 health/hdp_util.h  |   34 ++++
 health/main.c      |   60 +++++++
 health/manager.c   |  101 ++++++++++++
 health/manager.h   |   27 +++
 10 files changed, 993 insertions(+), 1 deletions(-)
 create mode 100644 health/hdp.c
 create mode 100644 health/hdp.h
 create mode 100644 health/hdp_types.h
 create mode 100644 health/hdp_util.c
 create mode 100644 health/hdp_util.h
 create mode 100644 health/main.c
 create mode 100644 health/manager.c
 create mode 100644 health/manager.h

diff --git a/Makefile.am b/Makefile.am
index 9ab5be2..d30850f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -169,6 +169,14 @@ builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
+if HEALTHPLUGIN
+builtin_modules += health
+builtin_sources += health/main.c \
+			health/manager.h health/manager.c \
+			health/hdp.h health/hdp.c \
+			health/hdp_util.h health/hdp_util.c
+endif
+
 if MCAP
 mcap_sources += mcap/mcap_internal.h \
 		mcap/mcap_lib.h	mcap/sync.c \
diff --git a/acinclude.m4 b/acinclude.m4
index b512cfb..23c594a 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,6 +167,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	serial_enable=yes
 	network_enable=yes
 	service_enable=yes
+	health_enable=no
 	mcap_enable=no
 	pnat_enable=no
 	tracer_enable=no
@@ -216,6 +217,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		service_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(health, AC_HELP_STRING([--enable-health], [enable health plugin]), [
+			health_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(mcap, AC_HELP_STRING([--enable-mcap], [enable mcap support]), [
 			mcap_enable=${enableval}
 	])
@@ -330,7 +335,8 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
-	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes")
+	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
+	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes" || test "${health_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
diff --git a/health/hdp.c b/health/hdp.c
new file mode 100644
index 0000000..281be05
--- /dev/null
+++ b/health/hdp.c
@@ -0,0 +1,183 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+#include <gdbus.h>
+
+#include "logging.h"
+#include "error.h"
+
+#include "hdp_types.h"
+#include "hdp_util.h"
+
+#define HEALTH_MANAGER_INTERFACE 	"org.bluez.HealthAdapter"
+
+#include "../src/dbus-common.h"
+
+static GSList *adapters = NULL;
+
+static struct hdp_adapter *find_adapter(GSList *list,
+					struct btd_adapter *btd_adapter)
+{
+	GSList *l;
+	struct hdp_adapter *adapter;
+
+	for (l = list; l; l = l->next) {
+		adapter = l->data;
+		if (adapter->btd_adapter == btd_adapter)
+			return adapter;
+	}
+
+	return NULL;
+}
+
+static void hdp_set_instance_id(struct hdp_instance *hdpi)
+{
+	struct hdp_adapter *adapter = hdpi->adapter;
+
+	hdpi->id = adapter->ic++;
+}
+
+static DBusMessage *hdp_create_instance(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct hdp_adapter *adapter = user_data;
+	const char *path, *name;
+	DBusMessageIter iter;
+	GError *err = NULL;
+	DBusMessage *reply;
+	struct hdp_instance *hdpi;
+	struct hdp_config *config;
+	int ctype;
+
+	dbus_message_iter_init(msg, &iter);
+	ctype = dbus_message_iter_get_arg_type(&iter);
+	if (ctype != DBUS_TYPE_OBJECT_PATH)
+		goto error;
+	dbus_message_iter_get_basic(&iter, &path);
+	dbus_message_iter_next(&iter);
+	config = hdp_get_config(&iter, &err);
+	if (err)
+		goto error;
+	name = dbus_message_get_sender(msg);
+	if (!name) {
+		g_set_error(&err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+						"Can't get sender name");
+		goto error;
+	}
+
+	hdpi = g_new0(struct hdp_instance, 1);
+	hdpi->adapter = adapter;
+	hdpi->aname = g_strdup(name);
+	hdpi->apath = g_strdup(path);
+	hdpi->config = config;
+	if (!config->svc_dsc)
+		config->svc_dsc = g_strdup(HDP_SERVICE_DSC);
+	if (!config->svc_name)
+		config->svc_name = g_strdup(HDP_SERVICE_NAME);
+	if (!config->svc_prov)
+		config->svc_prov = g_strdup(HDP_SERVICE_PROVIDER);
+	hdp_set_instance_id(hdpi);
+
+	/* TODO: Create mcap instance */
+
+	/* TODO: Create SDP record if needed. */
+
+	return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".HealthError",
+					"Incomplete call yet");
+error:
+	if (err) {
+		reply = g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments: %s", err->message);
+		g_error_free(err);
+	} else
+		reply = g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+	return reply;
+}
+
+static GDBusMethodTable hdp_methods[] = {
+	{ "CreateInstance", "oa{sv}", "u", hdp_create_instance },
+	{ NULL }
+};
+
+void hdp_delete_instance_iter(gpointer data, gpointer user_data)
+{
+	/* struct hdp_instance *hdpi = data; */
+
+	/* TODO: Create  a free function */
+}
+
+static void hdp_path_unregister(void *data)
+{
+	struct hdp_adapter *adapter = data;
+
+	g_slist_foreach(adapter->instances, hdp_delete_instance_iter, NULL);
+	g_slist_free(adapter->instances);
+	adapter->instances = NULL;
+	debug("All hdp instance for removed adapter were closed");
+}
+
+int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
+{
+	const char *path = adapter_get_path(btd_adapter);
+
+	struct hdp_adapter *adapter;
+	adapter = g_new0(struct hdp_adapter, 1);
+
+	debug("HDP init");
+	if (!g_dbus_register_interface(conn, path, HEALTH_MANAGER_INTERFACE,
+					hdp_methods, NULL, NULL,
+					adapter, hdp_path_unregister)) {
+		error("Failed to register %s interface to %s",
+						HEALTH_MANAGER_INTERFACE, path);
+		g_free(adapter);
+		return -1;
+	}
+	adapter->conn = dbus_connection_ref(conn);
+	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
+	adapters = g_slist_prepend(adapters, adapter);
+	return 0;
+}
+
+void hdp_adapter_unregister(struct btd_adapter *btd_adapter)
+{
+	struct hdp_adapter *adapter;
+
+	adapter = find_adapter(adapters, btd_adapter);
+	if (!adapter)
+		return;
+
+	g_dbus_unregister_interface(adapter->conn,
+			adapter_get_path(btd_adapter),
+			HEALTH_MANAGER_INTERFACE);
+	dbus_connection_unref(adapter->conn);
+	btd_adapter_unref(adapter->btd_adapter);
+	adapters = g_slist_remove(adapters, adapter);
+	g_free(adapter);
+
+	debug("HDP exit");
+}
diff --git a/health/hdp.h b/health/hdp.h
new file mode 100644
index 0000000..893f745
--- /dev/null
+++ b/health/hdp.h
@@ -0,0 +1,27 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter);
+void hdp_adapter_unregister(struct btd_adapter *btd_adapter);
diff --git a/health/hdp_types.h b/health/hdp_types.h
new file mode 100644
index 0000000..2db9adf
--- /dev/null
+++ b/health/hdp_types.h
@@ -0,0 +1,99 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+
+#ifndef __HDP_TYPES_H__
+#define __HDP_TYPES_H__
+
+#include <glib.h>
+#include "mcap_lib.h"
+
+#define HDP_SERVICE_NAME	"Bluez HDP"
+#define HDP_SERVICE_DSC		"A Bluez health device profile implementation"
+#define HDP_SERVICE_PROVIDER	"Bluez"
+
+#define HDP_VERSION		0x0100
+
+#define HDP_ERROR		g_quark_from_static_string("hdp-error-quark")
+
+typedef enum {
+	HDP_DIC_PARSE_ERROR,
+	HDP_DIC_ENTRY_PARSE_ERROR,
+	HDP_UNSPECIFIED_ERROR,
+	HDP_UNKNOWN_ERROR
+} HdpError;
+
+enum data_specs {
+	DATA_EXCHANGE_SPEC_11073 = 0x01
+};
+
+typedef enum {
+	HDP_SOURCE = 0x00,
+	HDP_SINK = 0x01
+} HdpRole;
+
+struct hdp_feature {
+	guint16		dtype;		/* Data type (see 5.2.9.2) */
+	gboolean	dtype_present;	/* Data type present in config */
+	char		*dscr;		/* Displayable TextName */
+};
+
+struct hdp_supp_fts {
+	guint8		mdepid;		/* (0x01-0x7F) Available for use */
+	HdpRole		role;		/* Role (see table 5.3) */
+	gboolean	role_present;	/* Role present in config */
+	GSList		*features;	/* Feature list */
+};
+
+struct hdp_config {
+	guint8		data_spec;	/* Data exchange specification */
+	GSList		*supp_fts;	/* Supported features list */
+	char		*svc_name;	/* Service name to register in SDP */
+	char		*svc_dsc;	/* Service description */
+	char		*svc_prov;	/* Service provider */
+	gboolean	ds_present;	/* Data spec has been assigned */
+};
+
+struct hdp_adapter {
+	struct btd_adapter	*btd_adapter;
+	DBusConnection		*conn;		/* DBus connection */
+	GSList			*instances;	/* HDP instances list */
+	uint16_t		ic;		/* Instances counter */
+};
+
+struct hdp_instance {
+	struct hdp_adapter	*adapter;	/* HDP adapter */
+	struct mcap_instance	*mi;		/* MCAP instance */
+	uint16_t		ccpsm;		/* Control channel psm */
+	uint16_t		dcpsm;		/* Data channel psm */
+	GSList			*hlink;		/* Health Links */
+	uint32_t		id;		/* HDP instance id */
+	char			*apath;		/* HDP agent path */
+	char			*aname;		/* HDP agent name */
+	struct hdp_config	*config;	/* Configuration */
+	uint32_t		sdp_handler;	/* SDP record handler */
+};
+
+#endif /* __HDP_TYPES_H__ */
diff --git a/health/hdp_util.c b/health/hdp_util.c
new file mode 100644
index 0000000..8f6befc
--- /dev/null
+++ b/health/hdp_util.c
@@ -0,0 +1,447 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <gdbus.h>
+#include "logging.h"
+#include "hdp_types.h"
+
+typedef gboolean (*parse_item_f)(DBusMessageIter *iter, GError **err,
+							gpointer user_data);
+
+struct dict_entry_func {
+	char		*key;
+	parse_item_f	func;
+};
+
+static gboolean check_feature(struct hdp_feature *feature)
+{
+	return feature->dtype_present;
+}
+
+static gboolean check_feature_list(struct hdp_supp_fts *fts)
+{
+	return fts->role_present && (fts->features != NULL);
+}
+
+static gboolean check_config(struct hdp_config *config)
+{
+	if (config->ds_present)
+		return config->supp_fts != NULL;
+	return TRUE;
+}
+
+static gboolean hdp_check_data_spec(guint8 data_spec)
+{
+	/* Future versions may edit this function
+	 * If there are more supported data exchange specifications
+	 */
+	return data_spec == DATA_EXCHANGE_SPEC_11073;
+}
+
+static void free_feature(struct hdp_feature *feature)
+{
+	if (feature->dscr) {
+		g_free(feature->dscr);
+		feature->dscr = NULL;
+	}
+	g_free(feature);
+}
+
+static void free_feature_list(struct hdp_supp_fts *fts)
+{
+	GSList *l;
+
+	for (l = fts->features; l; l = l->next)
+		free_feature(l->data);
+	g_slist_free(fts->features);
+	fts->features = NULL;
+	g_free(fts);
+}
+
+static void free_config(struct hdp_config *config)
+{
+	GSList *l;
+
+	for (l = config->supp_fts; l; l = l->next)
+		free_feature_list(l->data);
+	g_slist_free(config->supp_fts);
+	config->supp_fts = NULL;
+	if (config->svc_dsc) {
+		g_free(config->svc_dsc);
+		config->svc_dsc = NULL;
+	}
+	if (config->svc_name) {
+		g_free(config->svc_name);
+		config->svc_name = NULL;
+	}
+	if (config->svc_prov) {
+		g_free(config->svc_prov);
+		config->svc_prov = NULL;
+	}
+	g_free(config);
+}
+
+static gboolean parse_dict_entry(struct dict_entry_func dict_context[],
+					DBusMessageIter *iter,
+					GError **err,
+					gpointer user_data)
+{
+	DBusMessageIter entry;
+	char *key;
+	int ctype, i;
+	struct dict_entry_func df;
+
+	dbus_message_iter_recurse(iter, &entry);
+	ctype = dbus_message_iter_get_arg_type(&entry);
+	if (ctype != DBUS_TYPE_STRING) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+			"Dictionary entries should have a string as key");
+		return FALSE;
+	}
+	dbus_message_iter_get_basic(&entry, &key);
+	dbus_message_iter_next(&entry);
+	/* Find function and call it */
+	for (i = 0, df = dict_context[0]; df.key; i++, df = dict_context[i]) {
+		if (g_strcmp0(df.key, key) == 0) {
+			return df.func(&entry, err, user_data);
+		}
+	}
+	g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+			"No function found for parsing value for key %s", key);
+	return FALSE;
+}
+
+static gboolean parse_dict(struct dict_entry_func dict_context[],
+					DBusMessageIter *iter,
+					GError **err,
+					gpointer user_data)
+{
+	int ctype;
+	DBusMessageIter dict;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_PARSE_ERROR,
+					"Dictionary should be an array");
+		return FALSE;
+	}
+	dbus_message_iter_recurse(iter, &dict);
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID) {
+		if (ctype != DBUS_TYPE_DICT_ENTRY) {
+			g_set_error(err, HDP_ERROR, HDP_DIC_PARSE_ERROR,
+					"Dictionary array should "
+				        "contain dict entries");
+			return FALSE;
+		}
+		/* Start parsing entry */
+		if (!parse_dict_entry(dict_context, &dict, err,
+							user_data))
+			return FALSE;
+		/* Finish entry parsing */
+		dbus_message_iter_next(&dict);
+	}
+	return TRUE;
+}
+
+static gboolean parse_description(DBusMessageIter *iter, GError **err,
+								gpointer data)
+{
+	struct hdp_feature *feat = data;
+	DBusMessageIter *string, variant;
+	int ctype;
+	const char *desc;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	string = iter;
+	if (ctype == DBUS_TYPE_VARIANT) {
+		/* Get value inside the variable */
+		dbus_message_iter_recurse(iter, &variant);
+		ctype = dbus_message_iter_get_arg_type(&variant);
+		string = &variant;
+	}
+
+	if (ctype != DBUS_TYPE_STRING) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+				"Value data spec should be variable or string");
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(string, &desc);
+	feat->dscr = g_strdup(desc);
+	return TRUE;
+}
+
+static gboolean parse_data_type(DBusMessageIter *iter, GError **err,
+								gpointer data)
+{
+	struct hdp_feature *feat = data;
+	DBusMessageIter *value, variant;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	value = iter;
+	if (ctype == DBUS_TYPE_VARIANT) {
+		/* Get value inside the variable */
+		dbus_message_iter_recurse(iter, &variant);
+		ctype = dbus_message_iter_get_arg_type(&variant);
+		value = &variant;
+	}
+
+	if (ctype != DBUS_TYPE_UINT16) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+			"Final value for data type should be a uint16");
+		return FALSE;
+	}
+	dbus_message_iter_get_basic(value, &feat->dtype);
+
+	/*
+	 * This data should be check by the application layer because it
+	 * depends on the data_spec values and is specific for each value
+	 */
+	feat->dtype_present = TRUE;
+
+	return TRUE;
+}
+
+static struct dict_entry_func specs_context[] = {
+	{"data_type", parse_data_type},
+	{"description", parse_description},
+	{NULL, NULL}
+};
+
+static gboolean parse_specs(DBusMessageIter *iter, GError **err, gpointer data)
+{
+	struct hdp_supp_fts *fts = data;
+	struct hdp_feature *feature = NULL;
+	DBusMessageIter *array, value, dict;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	array = iter;
+	if (ctype == DBUS_TYPE_VARIANT) {
+		/* Get value inside the variable */
+		dbus_message_iter_recurse(iter, &value);
+		ctype = dbus_message_iter_get_arg_type(&value);
+		array = &value;
+	}
+	if (ctype != DBUS_TYPE_ARRAY) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+				"Value specs should be variable or array");
+		return FALSE;
+	}
+	dbus_message_iter_recurse(array, &dict);
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID){
+		feature = g_new0(struct hdp_feature, 1);
+		if (!parse_dict(specs_context, &dict, err, feature))
+			goto error;
+		if (!check_feature(feature)) {
+			g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+					"Field \"data_type\" is mandatory");
+			goto error;
+		}
+		fts->features = g_slist_append(fts->features, feature);
+		dbus_message_iter_next(&dict);
+	}
+
+	return TRUE;
+error:
+	if (feature)
+		free_feature(feature);
+	return FALSE;
+}
+
+static gboolean parse_role(DBusMessageIter *iter, GError **err, gpointer data)
+{
+	struct hdp_supp_fts *fts = data;
+	DBusMessageIter value;
+	DBusMessageIter *string;
+	int ctype;
+	const char *role;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	string = iter;
+	if (ctype == DBUS_TYPE_VARIANT) {
+		/* Get value inside the variable */
+		dbus_message_iter_recurse(iter, &value);
+		ctype = dbus_message_iter_get_arg_type(&value);
+		string = &value;
+	}
+
+	if (ctype != DBUS_TYPE_STRING) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+				"Value data spec should be variable or string");
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(string, &role);
+	if (g_strcmp0(role, "sink") == 0)
+		fts->role = HDP_SINK;
+	else if (g_strcmp0(role, "source") == 0)
+		fts->role = HDP_SOURCE;
+	else {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+			"Role value should be \"source\" or \"sink\"");
+		return FALSE;
+	}
+	fts->role_present = TRUE;
+	return TRUE;
+}
+
+static struct dict_entry_func end_point_context[] = {
+	{"role", parse_role},
+	{"specs", parse_specs},
+	{NULL, NULL}
+};
+
+static gboolean parse_end_points(DBusMessageIter *iter, GError **err,
+								gpointer data)
+{
+	struct hdp_config *config = data;
+	struct hdp_supp_fts *fts = NULL;
+	DBusMessageIter array, dict;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_VARIANT) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+				"Value for end points should be variable");
+		return FALSE;
+	}
+	dbus_message_iter_recurse(iter, &array);
+	ctype = dbus_message_iter_get_arg_type(&array);
+	if (ctype != DBUS_TYPE_ARRAY) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+			"Value end_point should be array inside variable");
+		return FALSE;
+	}
+
+	dbus_message_iter_recurse(&array, &dict);
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID){
+
+		if (ctype != DBUS_TYPE_ARRAY) {
+			g_set_error(err, HDP_ERROR, HDP_DIC_PARSE_ERROR,
+					"Dictionary should be an array");
+			return FALSE;
+		}
+		fts = g_new0(struct hdp_supp_fts, 1);
+		if (!parse_dict(end_point_context, &dict, err, fts))
+			goto error;
+		if (!check_feature_list(fts)) {
+			g_set_error(err, HDP_ERROR, HDP_DIC_PARSE_ERROR,
+					"Role field and specs are mandatory");
+			goto error;
+		}
+		config->supp_fts = g_slist_append(config->supp_fts, fts);
+		dbus_message_iter_next(&dict);
+	}
+	return TRUE;
+error:
+	if (fts)
+		free_feature_list(fts);
+	return FALSE;
+}
+
+static gboolean parse_data_spec(DBusMessageIter *iter, GError **err,
+								gpointer data)
+{
+	struct hdp_config *config = data;
+	DBusMessageIter value;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_VARIANT) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+					"Value data spec should be variable");
+		return FALSE;
+	}
+	dbus_message_iter_recurse(iter, &value);
+	ctype = dbus_message_iter_get_arg_type(&value);
+	if (ctype != DBUS_TYPE_BYTE) {
+		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
+				"Final value data spec should be byte");
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(&value, &config->data_spec);
+
+	if (!hdp_check_data_spec(config->data_spec))
+		return FALSE;
+	config->ds_present = TRUE;
+	return TRUE;
+}
+
+static struct dict_entry_func main_context[] = {
+	{"data_spec", parse_data_spec},
+	{"end_points", parse_end_points},
+	{NULL, NULL}
+};
+
+static void print_feature(gpointer elem, gpointer data)
+{
+	struct hdp_feature *feat = elem;
+
+	debug("   Feature:");
+	debug("      description: %s", feat->dscr);
+	debug("      data type: %u", feat->dtype);
+}
+
+static void print_features(gpointer elem, gpointer data)
+{
+	struct hdp_supp_fts *fts = elem;
+
+	debug("Mdep:");
+	debug("   mdepid %u", fts->mdepid);
+	debug("   role %d", fts->role);
+	g_slist_foreach(fts->features, print_feature, NULL);
+}
+
+struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err)
+{
+	struct hdp_config *config;
+
+	config = g_new0(struct hdp_config, 1);
+
+	if (!parse_dict(main_context, iter, err, config))
+		goto error;
+
+	/* TODO check config */
+	if (!check_config(config)) {
+		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
+			"\"data_spec\" and \"end_point\" should be set or not");
+		goto error;
+	}
+	if (!config->ds_present)
+		goto error;
+	debug("config->data_spec %d", config->data_spec);
+	g_slist_foreach(config->supp_fts, print_features, NULL);
+	return config;
+error:
+	if (config)
+		free_config(config);
+	return NULL;
+}
diff --git a/health/hdp_util.h b/health/hdp_util.h
new file mode 100644
index 0000000..f09e9a6
--- /dev/null
+++ b/health/hdp_util.h
@@ -0,0 +1,34 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __HDP_UTIL_H__
+#define __HDP_UTIL_H__
+
+#include <gdbus.h>
+#include "hdp_types.h"
+
+struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
+
+#endif /* __HDP_UTIL_H__ */
diff --git a/health/main.c b/health/main.c
new file mode 100644
index 0000000..6ece69b
--- /dev/null
+++ b/health/main.c
@@ -0,0 +1,60 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include <gdbus.h>
+
+#include "plugin.h"
+#include "manager.h"
+
+static DBusConnection *connection;
+
+static int hdp_init(void)
+{
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (hdp_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+	return 0;
+}
+
+static void hdp_exit(void)
+{
+	hdp_manager_exit();
+
+	dbus_connection_unref(connection);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(health, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, hdp_init, hdp_exit)
diff --git a/health/manager.c b/health/manager.c
new file mode 100644
index 0000000..b5dec5a
--- /dev/null
+++ b/health/manager.c
@@ -0,0 +1,101 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <bluetooth/sdp.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "adapter.h"
+#include "device.h"
+
+#include "logging.h"
+#include "manager.h"
+#include "hdp.h"
+
+#define HDP_UUID		"00001400-0000-1000-8000-00805F9B34FB"
+#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805F9B34FB"
+#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805F9B34FB"
+
+static DBusConnection *connection = NULL;
+
+static int hdp_adapter_probe(struct btd_adapter *adapter)
+{
+	return hdp_adapter_register(connection, adapter);
+}
+
+static void hdp_adapter_remove(struct btd_adapter *adapter)
+{
+	hdp_adapter_unregister(adapter);
+}
+
+static struct btd_adapter_driver hdp_adapter_driver = {
+	.name	= "hdp-adapter-driver",
+	.probe	= hdp_adapter_probe,
+	.remove	= hdp_adapter_remove,
+};
+
+static int hdp_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	debug("hdp driver probe");
+	return 0;
+}
+
+static void hdp_driver_remove(struct btd_device *device)
+{
+	debug("hdp driver remove");
+}
+
+static struct btd_device_driver hdp_device_driver = {
+	.name	= "hdp_device-driver",
+	.uuids	= BTD_UUIDS(HDP_UUID, HDP_SOURCE_UUID, HDP_SINK_UUID),
+	.probe	= hdp_driver_probe,
+	.remove	= hdp_driver_remove,
+};
+
+int hdp_manager_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+
+	btd_register_adapter_driver(&hdp_adapter_driver);
+	btd_register_device_driver(&hdp_device_driver);
+
+	debug("hdp manager init");
+	return 0;
+}
+
+void hdp_manager_exit(void)
+{
+	btd_unregister_device_driver(&hdp_device_driver);
+	btd_unregister_adapter_driver(&hdp_adapter_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+	debug("hdp manager exit");
+}
diff --git a/health/manager.h b/health/manager.h
new file mode 100644
index 0000000..b91ef75
--- /dev/null
+++ b/health/manager.h
@@ -0,0 +1,27 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int hdp_manager_init(DBusConnection *conn);
+void hdp_manager_exit(void);
-- 
1.6.3.3

