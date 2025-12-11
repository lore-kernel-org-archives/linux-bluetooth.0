Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328023F439
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478083; cv=none; b=TGd2+Q15rgTOE4FsRj4bcYqpotWj4+wdRcaH2JSpubKRudy6uY/1FcqTSyNPFkum50NDab0nASk48a1QvDEEWIpGN0KI55FLDsepKQCXOCQgtlcky5GCVGo0qyW6wD26alxAW1HZ+B6lgZHAXAI/2ehz5ZagagvF5LvZnnDEcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478083; c=relaxed/simple;
	bh=yqts7sZk9/3vyK+1DYkOzV7+pnQs5W6JY10zl9x6J9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsmvJ2Zb2rWNWaNifwPeAe98uv7lnvzWsh0QXvsrMbnnbf8LjXKXLZOPipKUmmkisEpIsVmsTQ0ucfCvyX0J1ufKrpjMiQD5zANUgSJaFszmRqIhfkSW2IrZRV3AcM0+doy5/tLqjaIvlIsodTFeFCeFI0wC0BVg9c+R5DZtw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OuCQ8/Tr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OuCQ8/Tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765478078;
	bh=yqts7sZk9/3vyK+1DYkOzV7+pnQs5W6JY10zl9x6J9U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OuCQ8/Tr3AZPU7LteKPpTCnuDg5MA1AAzdV6/bkhVxw31L+dy3Jjl7+xxokEUMO04
	 Ut2ttfO+ChSZuq12nDZpEk+pkH7A+NUe0Lzy+1AAk8m+ZaCu4DF2nY42xqfB30WFNq
	 hlZQ1oMcsuq5Gg6AY0p21NmYwY0OzOqUiTmjSzGNaMVUxFY/rQKPL8zIK6IUMW5gve
	 GmoM2Zy3SxgAwhGB3TC0v+0rJBX4jpE1Hcn8T34v3bXZ7AfH4CUgh7qYswn49FMtrS
	 ipGKki/QqoGDq8UGBtBz1NG/lQsj87ZW8zL/q84yVaJjFQT4eZiE/ForkzMwoiUu0D
	 7hXYzl/wSj+Wg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-F1a6-5002-c5C6-5e5c.rev.sfr.net [IPv6:2a02:8428:af44:1001:f1a6:5002:c5c6:5e5c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B49C517E110C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:34:38 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] audio/telephony: Add shared interfaces implementation
Date: Thu, 11 Dec 2025 19:34:26 +0100
Message-ID: <20251211183429.419619-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211183429.419619-1-frederic.danis@collabora.com>
References: <20251211183429.419619-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This implements the Telephony and Call DBus interfaces which will be
shared by telephony related "headset" profiles.
---
v1->v2: Improve commit message

 profiles/audio/telephony.c | 885 +++++++++++++++++++++++++++++++++++++
 profiles/audio/telephony.h | 115 +++++
 2 files changed, 1000 insertions(+)
 create mode 100644 profiles/audio/telephony.c
 create mode 100644 profiles/audio/telephony.h

diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
new file mode 100644
index 000000000..454b6882c
--- /dev/null
+++ b/profiles/audio/telephony.c
@@ -0,0 +1,885 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <limits.h>
+
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
+#include "bluetooth/uuid.h"
+
+#include "gdbus/gdbus.h"
+
+#include "btio/btio.h"
+#include "src/adapter.h"
+#include "src/btd.h"
+#include "src/dbus-common.h"
+#include "src/device.h"
+#include "src/error.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/hfp.h"
+
+#include "telephony.h"
+
+#define TELEPHONY_INTERFACE "org.bluez.Telephony1"
+#define TELEPHONY_CALL_INTERFACE "org.bluez.Call1"
+
+struct telephony {
+	struct btd_service		*service;
+	struct btd_device		*device;
+	char				*path;
+	bdaddr_t			src;
+	bdaddr_t			dst;
+	void				*profile_data;
+	struct telephony_callbacks	*cbs;
+	GSList				*uri_schemes;
+	enum connection_state		state;
+	bool				network_service;
+	uint8_t				signal;
+	bool				roaming;
+	uint8_t				battchg;
+	char				*operator_name;
+	bool				inband_ringtone;
+};
+
+static const char *state_to_string(enum connection_state state)
+{
+	switch (state) {
+	case CONNECTING:
+		return "connecting";
+	case SESSION_CONNECTING:
+		return "session_connecting";
+	case CONNECTED:
+		return "connected";
+	case DISCONNECTING:
+		return "disconnecting";
+	}
+
+	return NULL;
+}
+
+static const char *call_state_to_string(enum call_state state)
+{
+	switch (state) {
+	case CALL_STATE_ACTIVE:
+		return "active";
+	case CALL_STATE_HELD:
+		return "held";
+	case CALL_STATE_DIALING:
+		return "dialing";
+	case CALL_STATE_ALERTING:
+		return "alerting";
+	case CALL_STATE_INCOMING:
+		return "incoming";
+	case CALL_STATE_WAITING:
+		return "waiting";
+	case CALL_STATE_RESPONSE_AND_HOLD:
+		return "response_and_hold";
+	case CALL_STATE_DISCONNECTED:
+		return "disconnected";
+	}
+
+	return NULL;
+}
+
+struct telephony *telephony_new(struct btd_service *service,
+				void *profile_data,
+				struct telephony_callbacks *cbs)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct telephony *ag;
+	static int id;
+
+	ag = g_new0(struct telephony, 1);
+	bacpy(&ag->src, btd_adapter_get_address(adapter));
+	bacpy(&ag->dst, device_get_address(device));
+	ag->service = btd_service_ref(service);
+	ag->device = btd_device_ref(device);
+	ag->path = g_strdup_printf("%s/telephony%u", path, id++);
+	ag->profile_data = profile_data;
+	ag->cbs = cbs;
+
+	return ag;
+}
+
+void telephony_free(struct telephony *telephony)
+{
+	btd_service_unref(telephony->service);
+	btd_device_unref(telephony->device);
+	g_free(telephony->operator_name);
+	g_slist_free_full(telephony->uri_schemes, g_free);
+	g_free(telephony->path);
+	g_free(telephony);
+}
+
+static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->dial)
+		return telephony->cbs->dial(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *swap_calls(DBusConnection *conn, DBusMessage *msg,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->swap_calls)
+		return telephony->cbs->swap_calls(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *release_and_answer(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->release_and_answer)
+		return telephony->cbs->release_and_answer(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *release_and_swap(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->release_and_swap)
+		return telephony->cbs->release_and_swap(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *hold_and_answer(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->hold_and_answer)
+		return telephony->cbs->hold_and_answer(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->hangup_all)
+		return telephony->cbs->hangup_all(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *create_multiparty(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->create_multiparty)
+		return telephony->cbs->create_multiparty(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static DBusMessage *send_tones(DBusConnection *conn, DBusMessage *msg,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->cbs && telephony->cbs->send_tones)
+		return telephony->cbs->send_tones(conn, msg,
+					telephony->profile_data);
+
+	return btd_error_not_supported(msg);
+}
+
+static gboolean property_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	struct btd_profile *p = btd_service_get_profile(telephony->service);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &p->remote_uuid);
+
+	return TRUE;
+}
+
+static gboolean property_get_uri_schemes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	DBusMessageIter entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (l = telephony->uri_schemes; l != NULL; l = l->next)
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&l->data);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
+static gboolean property_get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	const char *string;
+
+	string = state_to_string(telephony->state);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
+
+	return TRUE;
+}
+
+static gboolean property_get_service(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	dbus_bool_t value;
+
+	value = telephony->network_service;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean property_get_signal(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&telephony->signal);
+
+	return TRUE;
+}
+
+static gboolean property_get_roaming(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	dbus_bool_t value;
+
+	value = telephony->roaming;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean property_get_battchg(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&telephony->battchg);
+
+	return TRUE;
+}
+
+static gboolean property_operator_name_exists(
+	const GDBusPropertyTable *property,
+	void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	return telephony->operator_name != NULL;
+}
+
+static gboolean property_get_operator_name(const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *user_data)
+{
+	struct telephony *telephony = user_data;
+
+	if (telephony->operator_name == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+					&telephony->operator_name);
+
+	return TRUE;
+}
+
+static gboolean property_get_inband_ringtone(const GDBusPropertyTable *property,
+					DBusMessageIter *iter,
+					void *user_data)
+{
+	struct telephony *telephony = user_data;
+	dbus_bool_t value;
+
+	value = telephony->inband_ringtone;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable telephony_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Dial", GDBUS_ARGS({"uri", "s"}), NULL,
+						dial) },
+	{ GDBUS_ASYNC_METHOD("SwapCalls", NULL, NULL, swap_calls) },
+	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
+						release_and_answer) },
+	{ GDBUS_ASYNC_METHOD("ReleaseAndSwap", NULL, NULL,
+						release_and_swap) },
+	{ GDBUS_ASYNC_METHOD("HoldAndAnswer", NULL, NULL,
+						hold_and_answer) },
+	{ GDBUS_ASYNC_METHOD("HangupAll", NULL, NULL, hangup_all) },
+	{ GDBUS_ASYNC_METHOD("CreateMultiparty", NULL,
+						GDBUS_ARGS({ "calls", "ao" }),
+						create_multiparty) },
+	{ GDBUS_ASYNC_METHOD("SendTones", GDBUS_ARGS({"number", "s"}), NULL,
+						send_tones) },
+	{ }
+};
+
+static const GDBusPropertyTable telephony_properties[] = {
+	{ "UUID", "s", property_get_uuid },
+	{ "SupportedURISchemes", "as", property_get_uri_schemes },
+	{ "State", "s", property_get_state },
+	{ "Service", "b", property_get_service },
+	{ "Signal", "y", property_get_signal },
+	{ "Roaming", "b", property_get_roaming },
+	{ "BattChg", "y", property_get_battchg },
+	{ "OperatorName", "s", property_get_operator_name, NULL,
+			property_operator_name_exists },
+	{ "InbandRingtone", "b", property_get_inband_ringtone },
+	{ }
+};
+
+static void path_unregister(void *data)
+{
+	struct telephony *telephony = data;
+
+	DBG("Unregistered interface %s on path %s",  TELEPHONY_INTERFACE,
+						telephony->path);
+}
+
+int telephony_register_interface(struct telephony *telephony)
+{
+	if (telephony->cbs == NULL)
+		return -EINVAL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+			telephony->path,
+			TELEPHONY_INTERFACE,
+			telephony_methods, NULL,
+			telephony_properties, telephony,
+			path_unregister)) {
+		return -EINVAL;
+	}
+
+	DBG("Registered interface %s on path %s", TELEPHONY_INTERFACE,
+						telephony->path);
+
+	return 0;
+}
+
+void telephony_unregister_interface(struct telephony *telephony)
+{
+	g_dbus_unregister_interface(btd_get_dbus_connection(), telephony->path,
+					TELEPHONY_INTERFACE);
+}
+
+struct btd_service *telephony_get_service(struct telephony *telephony)
+{
+	return telephony->service;
+}
+
+struct btd_device *telephony_get_device(struct telephony *telephony)
+{
+	return telephony->device;
+}
+
+const char *telephony_get_path(struct telephony *telephony)
+{
+	return telephony->path;
+}
+
+bdaddr_t telephony_get_src(struct telephony *telephony)
+{
+	return telephony->src;
+}
+
+bdaddr_t telephony_get_dst(struct telephony *telephony)
+{
+	return telephony->dst;
+}
+
+void *telephony_get_profile_data(struct telephony *telephony)
+{
+	return telephony->profile_data;
+}
+
+void telephony_add_uri_scheme(struct telephony *telephony, const char *scheme)
+{
+	telephony->uri_schemes = g_slist_append(telephony->uri_schemes,
+						g_strdup(scheme));
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					telephony->path, TELEPHONY_INTERFACE,
+					"SupportedURISchemes");
+}
+
+void telephony_remove_uri_scheme(struct telephony *telephony,
+				const char *scheme)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(telephony->uri_schemes, scheme,
+				(GCompareFunc)strcasecmp);
+	if (!l)
+		return;
+
+	telephony->uri_schemes = g_slist_delete_link(telephony->uri_schemes,
+							l);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					telephony->path, TELEPHONY_INTERFACE,
+					"SupportedURISchemes");
+}
+
+void telephony_set_state(struct telephony *telephony,
+				enum connection_state state)
+{
+	char address[18];
+
+	if (telephony->state == state)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s state %s -> %s", address,
+				state_to_string(telephony->state),
+				state_to_string(state));
+
+	telephony->state = state;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					telephony->path, TELEPHONY_INTERFACE,
+					"State");
+}
+
+enum connection_state telephony_get_state(struct telephony *telephony)
+{
+	return telephony->state;
+}
+
+void telephony_set_network_service(struct telephony *telephony, bool service)
+{
+	char address[18];
+
+	if (telephony->network_service == service)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s network service %u -> %u", address,
+					telephony->network_service,
+					service);
+
+	telephony->network_service = service;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"Service");
+}
+
+bool telephony_get_network_service(struct telephony *telephony)
+{
+	return telephony->network_service;
+}
+
+void telephony_set_signal(struct telephony *telephony, uint8_t signal)
+{
+	char address[18];
+
+	if (telephony->signal == signal)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s signal %u -> %u", address, telephony->signal, signal);
+
+	telephony->signal = signal;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"Signal");
+}
+
+uint8_t telephony_get_signal(struct telephony *telephony)
+{
+	return telephony->signal;
+}
+
+void telephony_set_roaming(struct telephony *telephony, bool roaming)
+{
+	char address[18];
+
+	if (telephony->roaming == roaming)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s roaming %u -> %u", address,
+					telephony->roaming,
+					roaming);
+
+	telephony->roaming = roaming;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"Roaming");
+}
+
+bool telephony_get_roaming(struct telephony *telephony)
+{
+	return telephony->roaming;
+}
+
+void telephony_set_battchg(struct telephony *telephony, uint8_t battchg)
+{
+	char address[18];
+
+	if (telephony->battchg == battchg)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s battchg %u -> %u", address, telephony->battchg, battchg);
+
+	telephony->battchg = battchg;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"BattChg");
+}
+
+uint8_t telephony_get_battchg(struct telephony *telephony)
+{
+	return telephony->battchg;
+}
+
+void telephony_set_operator_name(struct telephony *telephony,
+					const char *name)
+{
+	char address[18];
+
+	if (telephony->operator_name &&
+			g_str_equal(telephony->operator_name, name))
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s operator name %s -> %s", address,
+			telephony->operator_name, name);
+
+	if (telephony->operator_name)
+		g_free(telephony->operator_name);
+	telephony->operator_name = g_strdup(name);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"OperatorName");
+}
+
+const char *telephony_get_operator_name(struct telephony *telephony)
+{
+	return telephony->operator_name;
+}
+
+void telephony_set_inband_ringtone(struct telephony *telephony, bool enabled)
+{
+	char address[18];
+
+	if (telephony->inband_ringtone == enabled)
+		return;
+
+	ba2str(&telephony->dst, address);
+	DBG("device %s inband ringtone %u -> %u", address,
+					telephony->inband_ringtone,
+					enabled);
+
+	telephony->inband_ringtone = enabled;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			telephony->path, TELEPHONY_INTERFACE,
+			"InbandRingtone");
+}
+
+bool telephony_get_inband_ringtone(struct telephony *telephony)
+{
+	return telephony->inband_ringtone;
+}
+
+struct call *telephony_new_call(struct telephony *telephony,
+				uint8_t idx,
+				enum call_state state,
+				void *user_data)
+{
+	struct call *call;
+
+	call = g_new0(struct call, 1);
+	call->device = telephony;
+	call->state = state;
+	call->idx = idx;
+	call->path = g_strdup_printf("%s/call%u", telephony->path, call->idx);
+
+	return call;
+}
+
+void telephony_free_call(struct call *call)
+{
+	if (call->pending_msg)
+		dbus_message_unref(call->pending_msg);
+
+	g_free(call->name);
+	g_free(call->incoming_line);
+	g_free(call->line_id);
+	g_free(call->path);
+	g_free(call);
+}
+
+static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
+	void *call_data)
+{
+	struct call *call = call_data;
+	struct telephony *telephony = call->device;
+
+	return telephony->cbs->call_answer(conn, msg, call_data);
+}
+
+static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
+	void *call_data)
+{
+	struct call *call = call_data;
+	struct telephony *telephony = call->device;
+
+	return telephony->cbs->call_hangup(conn, msg, call_data);
+}
+
+static gboolean call_line_id_exists(const GDBusPropertyTable *property,
+	void *data)
+{
+	struct call *call = data;
+
+	return call->line_id != NULL;
+}
+
+static gboolean call_property_get_line_id(
+	const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct call *call = data;
+
+	if (call->line_id == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &call->line_id);
+
+	return TRUE;
+}
+
+static gboolean call_incoming_line_exists(const GDBusPropertyTable *property,
+	void *data)
+{
+	struct call *call = data;
+
+	return call->incoming_line != NULL;
+}
+
+static gboolean call_property_get_incoming_line(
+	const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct call *call = data;
+
+	if (call->incoming_line == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+		&call->incoming_line);
+
+	return TRUE;
+}
+
+static gboolean call_name_exists(const GDBusPropertyTable *property,
+	void *data)
+{
+	struct call *call = data;
+
+	return call->name != NULL;
+}
+
+static gboolean call_property_get_name(const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct call *call = data;
+
+	if (call->name == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &call->name);
+
+	return TRUE;
+}
+
+static gboolean call_property_get_multiparty(
+	const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct call *call = data;
+	dbus_bool_t value;
+
+	value = call->multiparty;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean call_property_get_state(const GDBusPropertyTable *property,
+	DBusMessageIter *iter, void *data)
+{
+	struct call *call = data;
+	const char *string;
+
+	string = call_state_to_string(call->state);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable telephony_call_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Answer", NULL, NULL, call_answer) },
+	{ GDBUS_ASYNC_METHOD("Hangup", NULL, NULL, call_hangup) },
+	{ }
+};
+
+static const GDBusPropertyTable telephony_call_properties[] = {
+	{ "LineIdentification", "s", call_property_get_line_id, NULL,
+			call_line_id_exists },
+	{ "IncomingLine", "s", call_property_get_incoming_line, NULL,
+			call_incoming_line_exists },
+	{ "Name", "s", call_property_get_name, NULL, call_name_exists },
+	{ "Multiparty", "b", call_property_get_multiparty },
+	{ "State", "s", call_property_get_state },
+	{ }
+};
+
+static void call_path_unregister(void *user_data)
+{
+	struct call *call = user_data;
+
+	DBG("Unregistered interface %s on path %s",  TELEPHONY_CALL_INTERFACE,
+			call->path);
+
+	telephony_free_call(call);
+}
+
+int telephony_call_register_interface(struct call *call)
+{
+	if (call->device->cbs == NULL)
+		return -EINVAL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+			call->path,
+			TELEPHONY_CALL_INTERFACE,
+			telephony_call_methods, NULL,
+			telephony_call_properties, call,
+			call_path_unregister)) {
+		return -EINVAL;
+	}
+
+	DBG("Registered interface %s on path %s", TELEPHONY_CALL_INTERFACE,
+						call->path);
+
+	return 0;
+}
+
+void telephony_call_unregister_interface(struct call *call)
+{
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					call->path,
+					TELEPHONY_CALL_INTERFACE);
+}
+
+void telephony_call_set_state(struct call *call, enum call_state state)
+{
+	if (call->state == state)
+		return;
+
+	DBG("%s state %s -> %s", call->path, call_state_to_string(call->state),
+					call_state_to_string(state));
+
+	call->state = state;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			call->path, TELEPHONY_CALL_INTERFACE,
+			"State");
+}
+
+void telephony_call_set_line_id(struct call *call, const char *line_id)
+{
+	if (call->line_id && g_str_equal(call->line_id, line_id))
+		return;
+
+	g_free(call->line_id);
+	call->line_id = g_strdup(line_id);
+
+	DBG("%s line_id: %s", call->path, call->line_id);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			call->path, TELEPHONY_CALL_INTERFACE,
+			"LineIdentification");
+}
diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
new file mode 100644
index 000000000..aefda9307
--- /dev/null
+++ b/profiles/audio/telephony.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+enum connection_state {
+	CONNECTING = 0,
+	SESSION_CONNECTING,
+	CONNECTED,
+	DISCONNECTING
+};
+
+enum call_state {
+	CALL_STATE_ACTIVE = 0,
+	CALL_STATE_HELD,
+	CALL_STATE_DIALING,
+	CALL_STATE_ALERTING,
+	CALL_STATE_INCOMING,
+	CALL_STATE_WAITING,
+	CALL_STATE_RESPONSE_AND_HOLD,
+	CALL_STATE_DISCONNECTED,
+};
+
+struct telephony;
+
+struct telephony_callbacks {
+	DBusMessage *(*dial)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*swap_calls)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*release_and_answer)(DBusConnection *conn,
+					DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*release_and_swap)(DBusConnection *conn,
+					DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*hold_and_answer)(DBusConnection *conn,
+					DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*hangup_all)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*create_multiparty)(DBusConnection *conn,
+					DBusMessage *msg,
+					void *profile_data);
+	DBusMessage *(*send_tones)(DBusConnection *conn, DBusMessage *msg,
+					void *profile_data);
+
+	DBusMessage *(*call_answer)(DBusConnection *conn, DBusMessage *msg,
+					void *call_data);
+	DBusMessage *(*call_hangup)(DBusConnection *conn, DBusMessage *msg,
+					void *call_data);
+};
+
+struct call {
+	struct telephony	*device;
+	char			*path;
+	uint8_t			idx;
+
+	char			*line_id;
+	char			*incoming_line;
+	char			*name;
+	bool			multiparty;
+	enum call_state		state;
+
+	DBusMessage		*pending_msg;
+};
+
+struct telephony *telephony_new(struct btd_service *service,
+				void *profile_data,
+				struct telephony_callbacks *cbs);
+void telephony_free(struct telephony *telephony);
+int telephony_register_interface(struct telephony *telephony);
+void telephony_unregister_interface(struct telephony *telephony);
+
+struct btd_service *telephony_get_service(struct telephony *telephony);
+struct btd_device *telephony_get_device(struct telephony *telephony);
+const char *telephony_get_path(struct telephony *telephony);
+bdaddr_t telephony_get_src(struct telephony *telephony);
+bdaddr_t telephony_get_dst(struct telephony *telephony);
+void *telephony_get_profile_data(struct telephony *telephony);
+void telephony_add_uri_scheme(struct telephony *telephony, const char *scheme);
+void telephony_remove_uri_scheme(struct telephony *telephony,
+				const char *scheme);
+void telephony_set_state(struct telephony *telephony,
+				enum connection_state state);
+enum connection_state telephony_get_state(struct telephony *telephony);
+void telephony_set_network_service(struct telephony *telephony, bool service);
+bool telephony_get_network_service(struct telephony *telephony);
+void telephony_set_signal(struct telephony *telephony, uint8_t signal);
+uint8_t telephony_get_signal(struct telephony *telephony);
+void telephony_set_roaming(struct telephony *telephony, bool roaming);
+bool telephony_get_roaming(struct telephony *telephony);
+void telephony_set_battchg(struct telephony *telephony, uint8_t battchg);
+uint8_t telephony_get_battchg(struct telephony *telephony);
+void telephony_set_operator_name(struct telephony *telephony,
+				const char *name);
+const char *telephony_get_operator_name(struct telephony *telephony);
+void telephony_set_inband_ringtone(struct telephony *telephony, bool enabled);
+bool telephony_get_inband_ringtone(struct telephony *telephony);
+
+struct call *telephony_new_call(struct telephony *telephony,
+	uint8_t idx,
+	enum call_state state,
+	void *user_data);
+void telephony_free_call(struct call *call);
+int telephony_call_register_interface(struct call *call);
+void telephony_call_unregister_interface(struct call *call);
+
+void telephony_call_set_state(struct call *call, enum call_state state);
+void telephony_call_set_line_id(struct call *call, const char *line_id);
-- 
2.43.0

