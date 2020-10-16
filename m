Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A5B20829
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 22:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="qnsBs4i6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbgJPWJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgJPWJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 18:09:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46FC061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d6so1976220plo.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=grk8HjhASsXnzA5vVkzFWsweZv2u3f+WqEoMPNLzS0Y=;
        b=qnsBs4i6hgIod/eY0l1TrlEUoUXOeMPhrvE9BJ4r6oML7PSoHhRz+u1DkEOgee0mZW
         EOZ/uvrH1UoupQcZYmdMlgE13Tnf1+BYm96a0r6fiONwxsCY5b+4H5+ZAl7Y/YVeHKq1
         bH4Hg2PCaFi4L24f5eJVOGVF+THoaL2V7FwnWEVDHRrCatYcrwv+E5q8hf4eB3x+rlnD
         SLPe2ay9vAeK8oiCNYYPvVzQdIp7RWbJdX1Wo+0EymxQSQ4SdUKbYQ4OQHs+3rbgI7Ko
         12nqqWupKzPoa/laUkDvEqOUIsRItbpkuY9NA8LwWc7cjb+TcHgG3xB5p1HeWbWRrL9Q
         Qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=grk8HjhASsXnzA5vVkzFWsweZv2u3f+WqEoMPNLzS0Y=;
        b=h/HDkDANSaNOJuuwqGaJw9Sz/f0te8rTXjnDtZq8QML8mpCKK9g1gEQth+4z0VbN2i
         GpCDaWGSCbo71gTwU9XN1dHVlYfE8p9YIsD7zIlE3Y9HCQfvFWz8EmaHg0/LNi5DwX+O
         q7cMU/2f1z/Ubk9nWl6v44DwdT/7VIretXASXESZ7xfBgCxDJpzugZYlYfR/8k1q17M1
         MN/JXBOWqVXcbYVvW/uyYI2Ok2KyuQUyGTrM3dDzi3La9MnrmUFld+RpSzEcn6Fhp3OM
         j8XKx64suweKVxDAw0KxkyV51pWbWLM0ZKD+tosdK4OHnO5BG2o7rzDRWC3SPsb0k5aN
         /gGA==
X-Gm-Message-State: AOAM532M/eqoyYR+8JR9EK1Vs650aXVT9/0f+5laaGREQIqZp7Sj19eI
        9Fhup4/57aYGussUez0NdRzmR35Kan1FbHVO
X-Google-Smtp-Source: ABdhPJxpjceVoeu0LXMimQqsCoTdq3Vunc5q2tL/wpC3Hl3h6434e9gnyUxsbmPidBvhup9rO5Y5iA==
X-Received: by 2002:a17:90a:1bc3:: with SMTP id r3mr6252479pjr.196.1602886189318;
        Fri, 16 Oct 2020 15:09:49 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id r8sm4658773pgn.30.2020.10.16.15.09.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 15:09:48 -0700 (PDT)
From:   Peter Mullen <omaolaip@tcd.ie>
Subject: [PATCH BlueZ 3/3] plugins: Add Bose QC35 plugin
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <2ffaa215-fc4b-c38b-e15c-d1286f070acb@tcd.ie>
Date:   Fri, 16 Oct 2020 15:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Bose QC35 headphones use a non-standard interface for handling
battery level reporting. This plugin handles the rfcomm communication
required for accessing extra controls/information from the device,
including the battery level. The battery level is reported over the
same DBus interface as for the standard battery characteristic for
integration with existing systems.
The same rfcomm communication allows control over the device's Active
Noise Cancelling (ANC) level. The plugin registers an additional new
dbus interface, org.bluez.Anc1, to allow external control over the ANC
level.
---
  Makefile.plugins    |   5 +
  configure.ac        |   4 +
  plugins/bose-qc35.c | 623 ++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 632 insertions(+)
  create mode 100644 plugins/bose-qc35.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 3b673bf85..61b9d2275 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -112,3 +112,8 @@ plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module 
-avoid-version \
  plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
  plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
  endif
+
+if BOSE_QC35
+builtin_modules += bose_qc35
+builtin_sources += plugins/bose-qc35.c
+endif
diff --git a/configure.ac b/configure.ac
index d6347c098..09ca43096 100644
--- a/configure.ac
+++ b/configure.ac
@@ -346,6 +346,10 @@ AC_ARG_ENABLE(sixaxis, 
AC_HELP_STRING([--enable-sixaxis],
  AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
  					 test "${enable_udev}" != "no")
  +AC_ARG_ENABLE(bose_qc35, AC_HELP_STRING([--enable-bose-qc35],
+		[enable bose-qc35 plugin]), [enable_bose_qc35=${enableval}])
+AM_CONDITIONAL(BOSE_QC35, test "${enable_bose_qc35}" = "yes" )
+
  AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--enable-hid2hci],
  		[enable hid2hci tool]), [enable_hid2hci=${enableval}])
  AM_CONDITIONAL(HID2HCI, test "${enable_hid2hci}" = "yes" &&
diff --git a/plugins/bose-qc35.c b/plugins/bose-qc35.c
new file mode 100644
index 000000000..4bece875f
--- /dev/null
+++ b/plugins/bose-qc35.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Peter Mullen <omaolaip@tcd.ie>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <unistd.h>
+
+#include "btio/btio.h"
+
+#include "gdbus/gdbus.h"
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/adapter.h"
+#include "src/dbus-common.h"
+#include "src/device.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/log.h"
+#include "src/service.h"
+
+#define IAP_UUID		"00000000-deca-fade-deca-deafdecacaff"
+#define BATTERY_INTERFACE	"org.bluez.Battery1"
+#define ANC_INTERFACE		"org.bluez.Anc1"
+#define BOSE_ANC_RANGE		2
+#define BOSE_RFCOMM_CHANNEL	8
+#define BOSE_VENDOR_ID		158
+#define BOSE_DEVICE_CLASS	2360344
+#define BOSE_QC35_PRODUCT_ID	16396
+
+/*
+ * The following resource was used as a starting reference for this plugin:
+ * 
https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html
+ */
+
+enum bose_command {
+	BOSE_COMMAND_CONNECT = 0,
+	BOSE_COMMAND_QUERY_DEVICE_STATUS,
+	BOSE_COMMAND_QUERY_BATTERY,
+	BOSE_COMMAND_SET_ANC,
+	BOSE_COMMAND_END
+};
+
+#define BOSE_HEADER_LEN 4
+static const guint8 
bose_command_codes[BOSE_COMMAND_END][BOSE_HEADER_LEN] = {
+	{0x00, 0x01, 0x01, 0x00}, /* CONNECT */
+	{0x01, 0x01, 0x05, 0x00}, /* QUERY_DEVICE_STATUS */
+	{0x02, 0x02, 0x01, 0x00}, /* QUERY_BATTERY */
+	{0x01, 0x06, 0x02, 0x01}, /* SET_ANC */
+};
+
+enum bose_message {
+	BOSE_MESSAGE_CONNECT_ACK = 0,
+	BOSE_MESSAGE_ANC_LEVEL,
+	BOSE_MESSAGE_BATTERY_LEVEL,
+	BOSE_MESSAGE_END
+};
+
+#define BOSE_OPCODE_LEN 3
+static const guint8 
bose_message_codes[BOSE_MESSAGE_END][BOSE_OPCODE_LEN] = {
+	{0x00, 0x01, 0x03}, /* CONNECT_ACK */
+	{0x01, 0x06, 0x03}, /* ANC_LEVEL */
+	{0x02, 0x02, 0x03}, /* BATTERY_LEVEL */
+};
+
+struct bose_session {
+	GIOChannel *io;
+	guint io_id;
+	char *path;
+	enum {
+		BOSE_CONNECTION_STATE_DISCONNECTED,
+		BOSE_CONNECTION_STATE_CONNECTING,
+		BOSE_CONNECTION_STATE_CONNECTED
+	} connection_state;
+
+	uint8_t battery_level;
+	uint8_t anc_level;
+	uint8_t anc_level_set;
+};
+
+static int service_cb_id;
+static GSList *bose_services;
+
+static void bose_reset(struct bose_session *session)
+{
+	if (session->io) {
+		g_io_channel_shutdown(session->io, FALSE, NULL);
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
+	if (session->io_id) {
+		g_source_remove(session->io_id);
+		session->io_id = 0;
+	}
+	if (session->path) {
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+					session->path, BATTERY_INTERFACE);
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+					session->path, ANC_INTERFACE);
+		g_free(session->path);
+		session->path = NULL;
+	}
+
+	session->connection_state = BOSE_CONNECTION_STATE_DISCONNECTED;
+}
+
+static void bose_session_destroy(struct btd_service *service, int err)
+{
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	if (!session)
+		return;
+
+	int connection_state = session->connection_state;
+
+	bose_reset(session);
+
+	if (session->connection_state == BOSE_CONNECTION_STATE_CONNECTING)
+		btd_service_connecting_complete(service, err);
+	else if (session->connection_state == BOSE_CONNECTION_STATE_CONNECTED)
+		btd_service_disconnecting_complete(service, 0);
+}
+
+static int bose_disconnect(struct btd_service *service)
+{
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	if (session->connection_state == BOSE_CONNECTION_STATE_DISCONNECTED)
+		return -EAGAIN;
+
+	DBG("Bose profile disconnect");
+
+	bose_session_destroy(service, 0);
+	return 0;
+}
+
+static int bose_free(struct btd_service *service)
+{
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	if (g_slist_find(bose_services, service) != NULL) {
+		bose_services = g_slist_remove(bose_services, service);
+
+		if (g_slist_length(bose_services) == 0 && service_cb_id > 0) {
+			btd_service_remove_state_cb(service_cb_id);
+			service_cb_id = 0;
+		}
+	}
+
+	if (!session)
+		return -ENOTCONN;
+
+	bose_session_destroy(service, 0);
+
+	g_free(session);
+	btd_service_set_user_data(service, NULL);
+
+	return 0;
+}
+
+static bool parse_anc_level(struct bose_session *session)
+{
+	guint8 msg[2];
+	uint8_t new_level;
+	int fd = g_io_channel_unix_get_fd(session->io);
+
+	if (recv(fd, &msg, sizeof(msg), MSG_DONTWAIT) < (ssize_t) sizeof(msg)) {
+		error("Failed to read ANC level payload");
+		return false;
+	}
+
+	new_level = msg[0];
+	if (new_level == 3)
+		new_level = 1;
+	else if (new_level == 1)
+		new_level = 2;
+	else if (new_level != 0) {
+		warn("Received invalid ANC level");
+		goto end;
+	}
+
+	if (new_level != session->anc_level) {
+		session->anc_level = new_level;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						session->path, ANC_INTERFACE,
+						"Level");
+	}
+
+end:
+	session->anc_level_set = session->anc_level;
+	return true;
+}
+
+static bool parse_battery_level(struct bose_session *session)
+{
+	uint8_t battery_level;
+	int fd = g_io_channel_unix_get_fd(session->io);
+
+	if (recv(fd, &battery_level, sizeof(battery_level), MSG_DONTWAIT) !=
+					(ssize_t) sizeof(battery_level)) {
+		error("Failed to read battery level payload");
+		return false;
+	}
+
+	if (battery_level != session->battery_level) {
+		session->battery_level = battery_level;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					session->path, BATTERY_INTERFACE,
+					"Percentage");
+	}
+
+	return true;
+}
+
+static void discard_data(int fd, ssize_t len)
+{
+	uint8_t buffer[64];
+
+	for (; len > 0; len -= sizeof(buffer)) {
+		ssize_t to_read = MIN(len, (ssize_t) sizeof(buffer));
+
+		if (to_read != recv(fd, buffer, to_read, MSG_DONTWAIT))
+			return;
+	}
+}
+
+static void parse_message(int fd, const uint8_t header[BOSE_HEADER_LEN],
+						struct bose_session *session)
+{
+	enum bose_message message;
+	bool payload_consumed = false;
+
+	for (message = 0; message < BOSE_MESSAGE_END; ++message) {
+		if (memcmp(header, bose_message_codes[message],
+							BOSE_OPCODE_LEN) == 0)
+			break;
+	}
+
+	switch (message) {
+	case BOSE_MESSAGE_BATTERY_LEVEL:
+		if (header[3] == 1)
+			payload_consumed = parse_battery_level(session);
+		break;
+	case BOSE_MESSAGE_CONNECT_ACK:
+		session->connection_state = BOSE_CONNECTION_STATE_CONNECTED;
+		break;
+	case BOSE_MESSAGE_ANC_LEVEL:
+		if (header[3] == 2)
+			payload_consumed = parse_anc_level(session);
+		break;
+	case BOSE_MESSAGE_END:
+	default:
+		DBG("Failed to determine packet type (invalid/unimplemented)");
+	}
+
+	if (!payload_consumed && header[3] > 0)
+		discard_data(fd, (ssize_t) header[3]);
+}
+
+gboolean on_data_cb(GIOChannel *source, GIOCondition condition, 
gpointer data)
+{
+	uint8_t message_header[BOSE_HEADER_LEN];
+	ssize_t len;
+	int fd;
+	struct btd_service *service = data;
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	if (condition & (G_IO_HUP | G_IO_ERR)) {
+		DBG("Received HUP/ERR");
+		bose_session_destroy(service, -EIO);
+		return FALSE;
+	}
+
+	if (!(G_IO_IN & condition))
+		return TRUE;
+
+	fd = g_io_channel_unix_get_fd(source);
+	while ((len = recv(fd, message_header, sizeof(message_header),
+							MSG_DONTWAIT)) >= 0) {
+		if (len != (ssize_t) sizeof(message_header)) {
+			error("Received corrupted packet");
+			return TRUE;
+		}
+
+		parse_message(fd, message_header, session);
+	}
+	return TRUE;
+}
+
+static int send_command(GIOChannel *io, enum bose_command command, 
uint8_t data)
+{
+	uint8_t commandMsg[5];
+	ssize_t msgLen;
+	int fd;
+
+	if (command < 0 || command >= BOSE_COMMAND_END) {
+		error("Invalid command");
+		return -EINVAL;
+	}
+
+	memcpy(commandMsg, bose_command_codes[command], BOSE_HEADER_LEN);
+	msgLen = (ssize_t) (commandMsg[3] + BOSE_HEADER_LEN);
+
+	if (msgLen > 5) {
+		error("Cannot handle message payload");
+		return -EINVAL;
+	}
+
+	if (msgLen == 5)
+		commandMsg[4] = data;
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	if (write(fd, commandMsg, msgLen) != msgLen) {
+		error("Failed to send command");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static gboolean property_get_percentage(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_service *service = data;
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	if (send_command(session->io, BOSE_COMMAND_QUERY_BATTERY, 0) >= 0)
+		on_data_cb(session->io, G_IO_IN, service);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&session->battery_level);
+
+	return TRUE;
+}
+
+static gboolean property_get_anc(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_service *service = data;
+	struct bose_session *session = btd_service_get_user_data(service);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&session->anc_level);
+	return TRUE;
+}
+
+static void property_set_anc(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct btd_service *service;
+	struct bose_session *session;
+	uint8_t new_level;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BYTE)
+		return;
+
+	dbus_message_iter_get_basic(value, &new_level);
+
+	service = data;
+	session = btd_service_get_user_data(service);
+
+	if (new_level == session->anc_level_set)
+		return;
+
+	session->anc_level_set = new_level;
+
+	if (new_level == 1)
+		new_level = 3;
+	else if (new_level == 2)
+		new_level = 1;
+	else if (new_level != 0)
+		return;
+
+	if (!send_command(session->io, BOSE_COMMAND_SET_ANC, new_level))
+		on_data_cb(session->io, G_IO_IN, service);
+}
+
+static gboolean property_get_range(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const uint8_t range = BOSE_ANC_RANGE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &range);
+	return TRUE;
+}
+
+static const GDBusPropertyTable battery_properties[] = {
+	{ "Percentage", "y", property_get_percentage },
+	{ }
+};
+
+static const GDBusPropertyTable anc_properties[] = {
+	{ "Level", "y", property_get_anc, property_set_anc },
+	{ "Range", "y", property_get_range },
+	{ }
+};
+
+static void rfcomm_connect_cb(GIOChannel *io, GError *err, gpointer 
user_data)
+{
+	GIOCondition watch_cond;
+	struct btd_service *service;
+	struct bose_session *session;
+	struct btd_device *device;
+
+	if (err) {
+		error("%s", err->message);
+		goto failed;
+	}
+
+	if (send_command(io, BOSE_COMMAND_CONNECT, 0) ||
+			send_command(io, BOSE_COMMAND_QUERY_BATTERY, 0) ||
+			send_command(io, BOSE_COMMAND_QUERY_DEVICE_STATUS, 0))
+		goto failed;
+
+	service = user_data;
+	session = btd_service_get_user_data(service);
+	device = btd_service_get_device(service);
+
+	session->path = g_strdup(device_get_path(device));
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					session->path, BATTERY_INTERFACE,
+					NULL, NULL,
+					battery_properties, service,
+					NULL) == FALSE) {
+		error("Unable to register %s interface for %s",
+			BATTERY_INTERFACE, session->path);
+
+		goto failed;
+	}
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					session->path, ANC_INTERFACE,
+					NULL, NULL,
+					anc_properties, service,
+					NULL) == FALSE) {
+		error("Unable to register %s interface for %s",
+			ANC_INTERFACE, session->path);
+		goto failed;
+	}
+
+	on_data_cb(io, G_IO_IN, service);
+
+	watch_cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN;
+	session->io_id = g_io_add_watch(io, watch_cond, on_data_cb, service);
+
+	session->connection_state = BOSE_CONNECTION_STATE_CONNECTED;
+	btd_service_connecting_complete(service, 0);
+	return;
+
+failed:
+	bose_session_destroy(service, -EIO);
+}
+
+static int bose_connect(struct btd_service *service)
+{
+	struct btd_device *device;
+	struct btd_adapter *adapter;
+	struct bose_session *session = btd_service_get_user_data(service);
+	GError *err = NULL;
+
+	if (session == NULL)
+		return -EINVAL;
+
+	if (session->connection_state != BOSE_CONNECTION_STATE_DISCONNECTED)
+		return -EALREADY;
+
+	device = btd_service_get_device(service);
+	adapter = device_get_adapter(device);
+
+	session->io = bt_io_connect(rfcomm_connect_cb, service,
+					NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR,
+					btd_adapter_get_address(adapter),
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(device),
+					BT_IO_OPT_CHANNEL, BOSE_RFCOMM_CHANNEL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+
+	session->connection_state = BOSE_CONNECTION_STATE_CONNECTING;
+
+	if (!session->io || err) {
+		error("%s", err->message);
+		g_error_free(err);
+		bose_session_destroy(service, -EIO);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void service_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+	struct btd_device *service_device = btd_service_get_device(service);
+	GSList *l;
+
+	if (new_state != BTD_SERVICE_STATE_DISCONNECTED &&
+				new_state != BTD_SERVICE_STATE_CONNECTED)
+		return;
+
+	if (profile->remote_uuid == NULL ||
+			!g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
+		return;
+
+	for (l = bose_services; l != NULL; l = l->next) {
+		struct btd_service *service = l->data;
+
+		if (btd_service_get_device(service) != service_device)
+			continue;
+
+		switch (new_state) {
+		case BTD_SERVICE_STATE_DISCONNECTED:
+			bose_disconnect(service);
+			return;
+		case BTD_SERVICE_STATE_CONNECTED:
+			bose_connect(service);
+			return;
+		case BTD_SERVICE_STATE_CONNECTING:
+		case BTD_SERVICE_STATE_DISCONNECTING:
+		case BTD_SERVICE_STATE_UNAVAILABLE:
+		default:
+			return;
+		}
+	}
+}
+
+static bool is_valid_bose_device(struct btd_device *device)
+{
+	if (btd_device_get_vendor(device) != BOSE_VENDOR_ID ||
+			btd_device_get_class(device) != BOSE_DEVICE_CLASS ||
+			btd_device_get_product(device) != BOSE_QC35_PRODUCT_ID)
+		return false;
+
+	return true;
+}
+
+static int bose_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bose_session *session = btd_service_get_user_data(service);
+	char addr[18];
+
+	if (!is_valid_bose_device(device))
+		return -EINVAL;
+
+	ba2str(device_get_address(device), addr);
+	DBG("Bose profile probe (%s)", addr);
+
+	if (session) {
+		error("Profile probed twice for the same device!");
+		return -EALREADY;
+	}
+
+	session = g_new0(struct bose_session, 1);
+	if (!session)
+		return -ENOMEM;
+
+	btd_service_set_user_data(service, session);
+	session->connection_state = BOSE_CONNECTION_STATE_DISCONNECTED;
+	session->path = NULL;
+	session->io = NULL;
+	session->io_id = 0;
+
+	if (g_slist_length(bose_services) == 0 && service_cb_id == 0)
+		service_cb_id = btd_service_add_state_cb(service_cb, NULL);
+
+	bose_services = g_slist_append(bose_services, service);
+	return 0;
+}
+
+
+static void bose_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bose_session *session = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("Bose profile remove (%s)", addr);
+
+	if (bose_free(service) < 0)
+		error("Bose service not handled by profile");
+}
+
+static struct btd_profile bose_profile = {
+	.name		= "bose-qc35-profile",
+	.vendor_id	= BOSE_VENDOR_ID,
+	.product_id	= BOSE_QC35_PRODUCT_ID,
+	.device_probe	= bose_probe,
+	.device_remove	= bose_remove,
+	.disconnect	= bose_disconnect
+};
+
+static int bose_init(void)
+{
+	return btd_profile_register(&bose_profile);
+}
+
+static void bose_exit(void)
+{
+	btd_profile_unregister(&bose_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(bose_qc35, VERSION, 
BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							bose_init, bose_exit)
-- 
2.28.0

