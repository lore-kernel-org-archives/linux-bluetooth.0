Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 21:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiDMVTa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiDMVTP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 17:19:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2048932D
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:16:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so7428815pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kz4HUKOaAygvigeiQWNEkjookJ2NS9oPpAMGyzYqkg=;
        b=q56/o1pbg7LCEo7YRAMlNhsfO1XId2aTIgsfp2vt3Dk7suTZ78VgYT4yb8TLUAM3j7
         QuMvKY2lFnC8DCZlylLrIP4gxz521LW/9QCi2Y6nbX5MjWcFDBkwVAhXdo/CE8HqrFmH
         Efs+dDTpDwP8uijq/mNS3L5tZMwRhAxPytejf5iJEooovBa1R5sqKgu+Of9yZ214cSvz
         EErx6qs6zXOERriBM1aMMdHISFyKJghCmss7cH6GgVYdBmMA0ZAL8wnJy44nYSElWfmj
         OMamMeqU/9OQUV/nI6MAMnEG/YntqXZ8G1lFDcJonTEzQQTIixB5m5wfJNzZnyr3MqRU
         2RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2kz4HUKOaAygvigeiQWNEkjookJ2NS9oPpAMGyzYqkg=;
        b=k332whpQmmfFt2KAxQAWqtlrn1NToBuQEqKYhLyK7WN3oy3g8JKz8Up8qfRn32klX4
         tNxBxgVsXRT3aK/vQuzkw3ldnDGYJb6MOXFYmxryxLdXFHaBlQtFb1Smf4kkwI0AuU5i
         cmFZGNSyUflWsJFWacNZWOHkVzCqdYEaPCN/N6vuNSpggtlt9vPGlMd7OXPA4d848skN
         0LM6q5SyTze6oSIjiHl96QglCxFGCmYF2FNZq7n9ByqNC9UoeTmmRAu9eSNdE27GUb5G
         uSxAH8yZKnJjj4gGVfiiceJgeukHoPgumpqnkMiZmiKEIk9PT0UH42Wt7ykWM2ooCrtk
         Qxpg==
X-Gm-Message-State: AOAM533kxy/GWtGwug69AIvIEbw17LfANOMaSLlhwGG4b91lZnwS3z35
        Owh9CcM3kgxSoU/8ihQxu8unYEZ/i1k=
X-Google-Smtp-Source: ABdhPJwU7FjJspzWgDnuks9LSlGy0zv3cYe/Eb8tTP8PSLu5CTbs+cvmG7/ZjT+JtnWjwkig1NhpXw==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id o2-20020a170902bcc200b0014f23c6c8c5mr43714317pls.131.1649884591999;
        Wed, 13 Apr 2022 14:16:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm7683pfx.81.2022.04.13.14.16.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:16:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/2] client/player: Add endpoint menu
Date:   Wed, 13 Apr 2022 14:16:29 -0700
Message-Id: <20220413211630.171843-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds endpoint menu:

[bluetooth]# menu endpoint
Menu endpoint:
Available commands:
-------------------
list [local]                                      List available endpoints
show <endpoint>                                   Endpoint information
register <UUID> <codec> [capabilities...]         Register Endpoint
unregister <UUID/object>                          Register Endpoint
config <endpoint> <local endpoint> [preset]       Configure Endpoint
presets <UUID> [default]                          List available presets
---
 client/player.c | 1188 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1183 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1095482d4..5db35cfeb 100644
--- a/client/player.c
+++ b/client/player.c
@@ -21,7 +21,9 @@
 #include <stdlib.h>
 #include <fcntl.h>
 #include <string.h>
+#include <sys/ioctl.h>
 #include <sys/uio.h>
+#include <wordexp.h>
 
 #include <glib.h>
 
@@ -30,8 +32,12 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 
+#include "profiles/audio/a2dp-codecs.h"
+
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
+#include "src/shared/io.h"
+#include "src/shared/queue.h"
 #include "player.h"
 
 /* String display constants */
@@ -39,15 +45,51 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
+#define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
 #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
+#define BLUEZ_MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
+#define BLUEZ_MEDIA_ENDPOINT_PATH "/local/endpoint"
+
+#define NSEC_USEC(_t) (_t / 1000L)
+#define SEC_USEC(_t)  (_t  * 1000000L)
+#define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
+
+struct endpoint {
+	char *path;
+	char *uuid;
+	uint8_t codec;
+	struct iovec *caps;
+	bool auto_accept;
+	char *transport;
+	DBusMessage *msg;
+};
 
 static DBusConnection *dbus_conn;
 static GDBusProxy *default_player;
+static GList *medias = NULL;
 static GList *players = NULL;
 static GList *folders = NULL;
 static GList *items = NULL;
+static GList *endpoints = NULL;
+static GList *local_endpoints = NULL;
+
+static void endpoint_unregister(void *data)
+{
+	struct endpoint *ep = data;
+
+	bt_shell_printf("Endpoint %s unregistered\n", ep->path);
+	g_dbus_unregister_interface(dbus_conn, ep->path,
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+}
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	g_list_free_full(local_endpoints, endpoint_unregister);
+	local_endpoints = NULL;
+}
 
 static bool check_default_player(void)
 {
@@ -63,6 +105,9 @@ static char *generic_generator(const char *text, int state, GList *source)
 {
 	static int index = 0;
 
+	if (!source)
+		return NULL;
+
 	if (!state)
 		index = 0;
 
@@ -319,11 +364,10 @@ static void generic_callback(const DBusError *error, void *user_data)
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set %s: %s\n", str, error->name);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
+		bt_shell_printf("Changing %s succeeded\n", str);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
-
-	bt_shell_printf("Changing %s succeeded\n", str);
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_equalizer(int argc, char *argv[])
@@ -450,6 +494,17 @@ static char *proxy_description(GDBusProxy *proxy, const char *title,
 					title, path);
 }
 
+static void print_media(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Media", description);
+
+	bt_shell_printf("%s\n", str);
+
+	g_free(str);
+}
+
 static void print_player(GDBusProxy *proxy, const char *description)
 {
 	char *str;
@@ -481,6 +536,7 @@ static void print_iter(const char *label, const char *name,
 	dbus_uint32_t valu32;
 	dbus_uint16_t valu16;
 	dbus_int16_t vals16;
+	unsigned char byte;
 	const char *valstr;
 	DBusMessageIter subiter;
 
@@ -515,6 +571,10 @@ static void print_iter(const char *label, const char *name,
 		dbus_message_iter_get_basic(iter, &vals16);
 		bt_shell_printf("%s%s: %d\n", label, name, vals16);
 		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_basic(iter, &byte);
+		bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
+		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
 		print_iter(label, name, &subiter);
@@ -948,6 +1008,1081 @@ static const struct bt_shell_menu player_menu = {
 	{} },
 };
 
+static char *endpoint_generator(const char *text, int state)
+{
+	return generic_generator(text, state, endpoints);
+}
+
+static char *local_endpoint_generator(const char *text, int state)
+{
+	int len = strlen(text);
+	GList *l;
+	static int index = 0;
+
+	if (!state)
+		index = 0;
+
+	for (l = g_list_nth(local_endpoints, index); l; l = g_list_next(l)) {
+		struct endpoint *ep = l->data;
+
+		index++;
+
+		if (!strncasecmp(ep->path, text, len))
+			return strdup(ep->path);
+	}
+
+	return NULL;
+}
+
+static void print_endpoint(void *data, void *user_data)
+{
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
+	char *str;
+
+	str = proxy_description(proxy, "Endpoint", description);
+
+	bt_shell_printf("%s\n", str);
+
+	g_free(str);
+}
+
+static void cmd_list_endpoints(int argc, char *argv[])
+{
+	GList *l;
+
+	if (argc > 1) {
+		if (strcmp("local", argv[1])) {
+			bt_shell_printf("Endpoint list %s not available\n",
+					argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		}
+
+		for (l = local_endpoints; l; l = g_list_next(l)) {
+			struct endpoint *ep = l->data;
+
+			bt_shell_printf("%s\n", ep->path);
+		}
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	for (l = endpoints; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		print_endpoint(proxy, NULL);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void confirm_response(const char *input, void *user_data)
+{
+	DBusMessage *msg = user_data;
+
+	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes"))
+		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
+	else if (!strcasecmp(input, "n") || !strcmp(input, "no"))
+		g_dbus_send_error(dbus_conn, msg, "org.bluez.Error.Rejected",
+									NULL);
+	else
+		g_dbus_send_error(dbus_conn, msg, "org.bluez.Error.Canceled",
+									NULL);
+}
+
+static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	DBusMessageIter args, props;
+	const char *path;
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return g_dbus_create_error(msg,
+					 "org.bluez.Error.InvalidArguments",
+					 NULL);
+
+	bt_shell_printf("Endpoint: SetConfiguration\n");
+	bt_shell_printf("\tTransport %s\n", path);
+	print_iter("\t", "Properties", &props);
+
+	free(ep->transport);
+	ep->transport = strdup(path);
+
+	if (ep->auto_accept) {
+		bt_shell_printf("Auto Accepting...\n");
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
+
+	bt_shell_prompt_input("Endpoint", "Accept (yes/no):", confirm_response,
+							dbus_message_ref(msg));
+
+	return NULL;
+}
+
+struct codec_capabilities {
+	uint8_t len;
+	uint8_t type;
+	uint8_t data[UINT8_MAX];
+};
+
+#define data(args...) ((const unsigned char[]) { args })
+
+#define SBC_DATA(args...) \
+	{ \
+		.iov_base = (void *)data(args), \
+		.iov_len = sizeof(data(args)), \
+	}
+
+#define CODEC_CAPABILITIES(_uuid, _codec_id, _data) \
+	{ \
+		.uuid = _uuid, \
+		.codec_id = _codec_id, \
+		.data = _data, \
+	}
+
+static const struct capabilities {
+	const char *uuid;
+	uint8_t codec_id;
+	struct iovec data;
+} caps[] = {
+	/* A2DP SBC Source:
+	 *
+	 * Channel Modes: Mono DualChannel Stereo JointStereo
+	 * Frequencies: 16Khz 32Khz 44.1Khz 48Khz
+	 * Subbands: 4 8
+	 * Blocks: 4 8 12 16
+	 * Bitpool Range: 2-64
+	 */
+	CODEC_CAPABILITIES(A2DP_SOURCE_UUID, A2DP_CODEC_SBC,
+					SBC_DATA(0xff, 0xff, 2, 64)),
+	/* A2DP SBC Sink:
+	 *
+	 * Channel Modes: Mono DualChannel Stereo JointStereo
+	 * Frequencies: 16Khz 32Khz 44.1Khz 48Khz
+	 * Subbands: 4 8
+	 * Blocks: 4 8 12 16
+	 * Bitpool Range: 2-64
+	 */
+	CODEC_CAPABILITIES(A2DP_SINK_UUID, A2DP_CODEC_SBC,
+					SBC_DATA(0xff, 0xff, 2, 64)),
+};
+
+struct codec_preset {
+	const char *name;
+	const struct iovec data;
+	bool is_default;
+};
+
+#define SBC_PRESET(_name, _data) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+	}
+
+#define SBC_DEFAULT_PRESET(_name, _data) \
+	{ \
+		.name = _name, \
+		.data = _data, \
+		.is_default = true, \
+	}
+
+static struct codec_preset sbc_presets[] = {
+	/* Table 4.7: Recommended sets of SBC parameters in the SRC device
+	 * Other settings: Block length = 16, Allocation method = Loudness,
+	 * Subbands = 8.
+	 * A2DP spec sets maximum bitrates as follows:
+	 * This profile limits the available maximum bit rate to 320kb/s for
+	 * mono, and 512kb/s for two-channel modes.
+	 */
+	SBC_PRESET("MQ_MONO_44_1",
+		SBC_DATA(0x28, 0x15, 2, SBC_BITPOOL_MQ_MONO_44100)),
+	SBC_PRESET("MQ_MONO_48",
+		SBC_DATA(0x18, 0x15, 2, SBC_BITPOOL_MQ_MONO_48000)),
+	SBC_PRESET("MQ_STEREO_44_1",
+		SBC_DATA(0x21, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_44100)),
+	SBC_PRESET("MQ_STEREO_48",
+		SBC_DATA(0x11, 0x15, 2, SBC_BITPOOL_MQ_JOINT_STEREO_48000)),
+	SBC_PRESET("HQ_MONO_44_1",
+		SBC_DATA(0x28, 0x15, 2, SBC_BITPOOL_HQ_MONO_44100)),
+	SBC_PRESET("HQ_MONO_48",
+		SBC_DATA(0x18, 0x15, 2, SBC_BITPOOL_HQ_MONO_48000)),
+	SBC_DEFAULT_PRESET("HQ_STEREO_44_1",
+		SBC_DATA(0x21, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_44100)),
+	SBC_PRESET("HQ_STEREO_48",
+		SBC_DATA(0x11, 0x15, 2, SBC_BITPOOL_HQ_JOINT_STEREO_48000)),
+	/* Higher bitrates not recommended by A2DP spec, it dual channel to
+	 * avoid going above 53 bitpool:
+	 *
+	 * https://habr.com/en/post/456476/
+	 * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1092
+	 */
+	SBC_PRESET("XQ_DUAL_44_1", SBC_DATA(0x24, 0x15, 2, 43)),
+	SBC_PRESET("XQ_DUAL_48", SBC_DATA(0x14, 0x15, 2, 39)),
+	/* Ultra high bitpool that fits in 512 kbps mandatory bitrate */
+	SBC_PRESET("UQ_STEREO_44_1", SBC_DATA(0x21, 0x15, 2, 64)),
+	SBC_PRESET("UQ_STEREO_48", SBC_DATA(0x11, 0x15, 2, 58)),
+};
+
+#define PRESET(_uuid, _presets) \
+	{ \
+		.uuid = _uuid, \
+		.presets = _presets, \
+		.num_presets = ARRAY_SIZE(_presets), \
+	}
+
+static const struct preset {
+	const char *uuid;
+	struct codec_preset *presets;
+	size_t num_presets;
+} presets[] = {
+	PRESET(A2DP_SOURCE_UUID, sbc_presets),
+	PRESET(A2DP_SINK_UUID, sbc_presets),
+};
+
+static struct codec_preset *find_preset(const char *uuid, const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(presets); i++) {
+		const struct preset *preset = &presets[i];
+
+		if (!strcasecmp(preset->uuid, uuid)) {
+			size_t j;
+
+			for (j = 0; j < preset->num_presets; j++) {
+				struct codec_preset *p;
+
+				p = &preset->presets[j];
+
+				if (!name) {
+					if (p->is_default)
+						return p;
+				} else if (!strcmp(p->name, name))
+					return p;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static DBusMessage *endpoint_select_config_reply(DBusMessage *msg,
+						 uint8_t *data, size_t len)
+{
+	DBusMessage *reply;
+	DBusMessageIter args, array;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &args);
+
+	dbus_message_iter_open_container(&args, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_BYTE_AS_STRING,
+						&array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &data,
+								len);
+
+	dbus_message_iter_close_container(&args, &array);
+
+	return reply;
+}
+
+static uint8_t *str2bytearray(char *arg, size_t *val_len)
+{
+	uint8_t value[UINT8_MAX];
+	char *entry;
+	unsigned int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= G_N_ELEMENTS(value)) {
+			bt_shell_printf("Too much data\n");
+			return NULL;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			bt_shell_printf("Invalid value at index %d\n", i);
+			return NULL;
+		}
+
+		value[i] = val;
+	}
+
+	*val_len = i;
+
+	return g_memdup(value, i);
+}
+
+static void select_config_response(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct codec_preset *p;
+	DBusMessage *reply;
+	uint8_t *data;
+	size_t len;
+
+	p = find_preset(ep->uuid, input);
+	if (p) {
+		data = p->data.iov_base;
+		len = p->data.iov_len;
+		goto done;
+	}
+
+	data = str2bytearray((void *) input, &len);
+	if (!data) {
+		g_dbus_send_error(dbus_conn, ep->msg,
+				  "org.bluez.Error.Rejected", NULL);
+		ep->msg = NULL;
+		return;
+	}
+
+done:
+	reply = endpoint_select_config_reply(ep->msg, data, len);
+	if (!reply)
+		return;
+
+	if (!p)
+		free(data);
+
+	g_dbus_send_message(dbus_conn, reply);
+	dbus_message_unref(ep->msg);
+	ep->msg = NULL;
+}
+
+static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	struct codec_preset *p;
+	DBusMessageIter args;
+	DBusMessage *reply;
+
+	dbus_message_iter_init(msg, &args);
+
+	bt_shell_printf("Endpoint: SelectConfiguration\n");
+	print_iter("\t", "Capabilities", &args);
+
+	if (!ep->auto_accept) {
+		ep->msg = dbus_message_ref(msg);
+		bt_shell_prompt_input("Endpoint", "Enter preset/configuration:",
+					select_config_response, ep);
+		return NULL;
+	}
+
+	p = find_preset(ep->uuid, NULL);
+	if (!p)
+		NULL;
+
+	reply = endpoint_select_config_reply(msg, p->data.iov_base,
+						p->data.iov_len);
+	if (!reply)
+		return NULL;
+
+	bt_shell_printf("Auto Accepting using %s...\n", p->name);
+
+	return reply;
+}
+
+static DBusMessage *endpoint_clear_configuration(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	free(ep->transport);
+	ep->transport = NULL;
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static struct endpoint *endpoint_find(const char *pattern)
+{
+	GList *l;
+
+	for (l = local_endpoints; l; l = g_list_next(l)) {
+		struct endpoint *ep = l->data;
+
+		/* match object path */
+		if (!strcmp(ep->path, pattern))
+			return ep;
+
+		/* match UUID */
+		if (!strcmp(ep->uuid, pattern))
+			return ep;
+	}
+
+	return NULL;
+}
+
+static void cmd_show_endpoint(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Endpoint %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	bt_shell_printf("Endpoint %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "UUID");
+	print_property(proxy, "Codec");
+	print_property(proxy, "Capabilities");
+	print_property(proxy, "Device");
+	print_property(proxy, "DelayReporting");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const GDBusMethodTable endpoint_methods[] = {
+	{ GDBUS_ASYNC_METHOD("SetConfiguration",
+					GDBUS_ARGS({ "endpoint", "o" },
+						{ "properties", "a{sv}" } ),
+					NULL, endpoint_set_configuration) },
+	{ GDBUS_ASYNC_METHOD("SelectConfiguration",
+					GDBUS_ARGS({ "caps", "ay" } ),
+					NULL, endpoint_select_configuration) },
+	{ GDBUS_ASYNC_METHOD("ClearConfiguration",
+					GDBUS_ARGS({ "transport", "o" } ),
+					NULL, endpoint_clear_configuration) },
+	{ },
+};
+
+static void endpoint_free(void *data)
+{
+	struct endpoint *ep = data;
+
+	if (ep->caps) {
+		g_free(ep->caps->iov_base);
+		g_free(ep->caps);
+	}
+
+	if (ep->msg)
+		dbus_message_unref(ep->msg);
+
+	g_free(ep->path);
+	g_free(ep->uuid);
+	g_free(ep);
+}
+
+static gboolean endpoint_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ep->uuid);
+
+	return TRUE;
+}
+
+static gboolean endpoint_get_codec(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &ep->codec);
+
+	return TRUE;
+}
+
+static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+					     &ep->caps->iov_base,
+					     ep->caps->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable endpoint_properties[] = {
+	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
+	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
+	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ }
+};
+
+static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	DBusMessageIter dict;
+	const char *key = "Capabilities";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	g_dbus_dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &ep->uuid);
+
+	g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_BYTE, &ep->caps->iov_base,
+					ep->caps->iov_len);
+
+	bt_shell_printf("Capabilities:\n");
+	bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void register_endpoint_reply(DBusMessage *message, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to register endpoint: %s\n",
+				error.name);
+		dbus_error_free(&error);
+		local_endpoints = g_list_remove(local_endpoints, ep);
+		g_dbus_unregister_interface(dbus_conn, ep->path,
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Endpoint %s registered\n", ep->path);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void endpoint_register(struct endpoint *ep)
+{
+	GList *l;
+
+	if (!g_dbus_register_interface(dbus_conn, ep->path,
+					BLUEZ_MEDIA_ENDPOINT_INTERFACE,
+					endpoint_methods, NULL,
+					endpoint_properties, ep,
+					endpoint_free)) {
+		goto fail;
+	}
+
+	for (l = medias; l; l = g_list_next(l)) {
+		if (!g_dbus_proxy_method_call(l->data, "RegisterEndpoint",
+						register_endpoint_setup,
+						register_endpoint_reply,
+						ep, NULL)) {
+			g_dbus_unregister_interface(dbus_conn, ep->path,
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+			goto fail;
+		}
+	}
+
+	return;
+
+fail:
+	bt_shell_printf("Failed register endpoint\n");
+	local_endpoints = g_list_remove(local_endpoints, ep);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+}
+
+static void endpoint_auto_accept(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes"))
+		ep->auto_accept = true;
+	else if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		ep->auto_accept = false;
+	else
+		bt_shell_printf("Invalid input for Auto Accept\n");
+
+	endpoint_register(ep);
+}
+
+static void endpoint_set_capabilities(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	if (ep->caps)
+		g_free(ep->caps->iov_base);
+	else
+		ep->caps = g_new0(struct iovec, 1);
+
+	ep->caps->iov_base = str2bytearray((char *) input, &ep->caps->iov_len);
+
+	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+						endpoint_auto_accept, ep);
+}
+
+static char *uuid_generator(const char *text, int state)
+{
+	int len = strlen(text);
+	static int index = 0;
+	size_t i;
+
+	if (!state)
+		index = 0;
+
+	for (i = index; i < ARRAY_SIZE(caps); i++) {
+		const struct capabilities *cap = &caps[i];
+
+		index++;
+
+		if (!strncasecmp(cap->uuid, text, len))
+			return strdup(cap->uuid);
+	}
+
+	return NULL;
+}
+
+static const struct capabilities *find_capabilities(const char *uuid,
+							uint8_t codec_id)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(caps); i++) {
+		const struct capabilities *cap = &caps[i];
+
+		if (strcasecmp(cap->uuid, uuid))
+			continue;
+
+		if (cap->codec_id == codec_id)
+			return cap;
+	}
+
+	return NULL;
+}
+
+static struct iovec *iov_append(struct iovec **iov, const void *data,
+							size_t len)
+{
+	if (!*iov) {
+		*iov = new0(struct iovec, 1);
+		(*iov)->iov_base = new0(uint8_t, UINT8_MAX);
+	}
+
+	if (data && len) {
+		memcpy((*iov)->iov_base + (*iov)->iov_len, data, len);
+		(*iov)->iov_len += len;
+	}
+
+	return *iov;
+}
+
+static void cmd_register_endpoint(int argc, char *argv[])
+{
+	struct endpoint *ep;
+	char *endptr = NULL;
+
+	ep = g_new0(struct endpoint, 1);
+	ep->uuid = g_strdup(argv[1]);
+	ep->codec = strtol(argv[2], &endptr, 0);
+	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
+					g_list_length(local_endpoints));
+	local_endpoints = g_list_append(local_endpoints, ep);
+
+	if (argc > 3)
+		endpoint_set_capabilities(argv[3], ep);
+	else {
+		const struct capabilities *cap;
+
+		cap = find_capabilities(ep->uuid, ep->codec);
+		if (cap) {
+			if (ep->caps)
+				ep->caps->iov_len = 0;
+
+			/* Copy capabilities */
+			iov_append(&ep->caps, cap->data.iov_base,
+							cap->data.iov_len);
+
+			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+						endpoint_auto_accept, ep);
+		} else
+			bt_shell_prompt_input(ep->path, "Enter capabilities:",
+						endpoint_set_capabilities, ep);
+	}
+}
+
+static void unregister_endpoint_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
+}
+
+static void unregister_endpoint_reply(DBusMessage *message, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to unregister endpoint: %s\n",
+				error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Endpoint %s unregistered\n", ep->path);
+
+	local_endpoints = g_list_remove(local_endpoints, ep);
+	g_dbus_unregister_interface(dbus_conn, ep->path,
+					BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_unregister_endpoint(int argc, char *argv[])
+{
+	struct endpoint *ep;
+	GList *l;
+
+	ep = endpoint_find(argv[1]);
+	if (!ep) {
+		bt_shell_printf("Unable to find endpoint object: %s\n",
+								argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	for (l = medias; l; l = g_list_next(l)) {
+		if (!g_dbus_proxy_method_call(l->data, "UnregisterEndpoint",
+						unregister_endpoint_setup,
+						unregister_endpoint_reply,
+						ep, NULL)) {
+			bt_shell_printf("Failed unregister endpoint\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+struct codec_qos {
+	uint32_t interval;
+	uint8_t  framing;
+	char *phy;
+	uint16_t sdu;
+	uint8_t  rtn;
+	uint16_t latency;
+	uint32_t delay;
+};
+
+struct endpoint_config {
+	GDBusProxy *proxy;
+	struct endpoint *ep;
+	struct iovec *caps;
+	struct codec_qos qos;
+};
+
+static void config_endpoint_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	DBusMessageIter dict;
+	const char *key = "Capabilities";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+					&cfg->ep->path);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	bt_shell_printf("Capabilities: ");
+	bt_shell_hexdump(cfg->caps->iov_base, cfg->caps->iov_len);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
+					cfg->caps->iov_len);
+
+	bt_shell_printf("Interval %u\n", cfg->qos.interval);
+
+	g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
+						&cfg->qos.interval);
+
+	bt_shell_printf("Framing %s\n", cfg->qos.framing ? "true" : "false");
+
+	g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
+						&cfg->qos.framing);
+
+	bt_shell_printf("PHY %s\n", cfg->qos.phy);
+
+	g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_STRING, &cfg->qos.phy);
+
+	bt_shell_printf("SDU %u\n", cfg->qos.sdu);
+
+	g_dbus_dict_append_entry(&dict, "SDU", DBUS_TYPE_UINT16,
+						&cfg->qos.sdu);
+
+	bt_shell_printf("Retransmissions %u\n", cfg->qos.rtn);
+
+	g_dbus_dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE,
+						&cfg->qos.rtn);
+
+	bt_shell_printf("Latency %u\n", cfg->qos.latency);
+
+	g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
+						&cfg->qos.latency);
+
+	bt_shell_printf("Delay %u\n", cfg->qos.delay);
+
+	g_dbus_dict_append_entry(&dict, "Delay", DBUS_TYPE_UINT32,
+						&cfg->qos.delay);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void config_endpoint_reply(DBusMessage *message, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	struct endpoint *ep = cfg->ep;
+	DBusError error;
+
+	free(cfg->caps->iov_base);
+	free(cfg->caps);
+	free(cfg);
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to config endpoint: %s\n",
+				error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Endpoint %s configured\n", ep->path);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void endpoint_set_config(struct endpoint_config *cfg)
+{
+	if (!g_dbus_proxy_method_call(cfg->proxy, "SetConfiguration",
+						config_endpoint_setup,
+						config_endpoint_reply,
+						cfg, NULL)) {
+		bt_shell_printf("Failed to config endpoint\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void qos_delay(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.delay = strtol(input, NULL, 0);
+
+	endpoint_set_config(cfg);
+}
+
+static void qos_latency(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.latency = strtol(input, NULL, 0);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter Delay:", qos_delay, cfg);
+}
+
+static void qos_rtn(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.rtn = strtol(input, NULL, 0);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter Latency:",
+							qos_latency, cfg);
+}
+
+static void qos_sdu(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.sdu = strtol(input, NULL, 0);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter Retransmissions:",
+							qos_rtn, cfg);
+}
+
+static void qos_phy(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.phy = strdup(input);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter SDU:", qos_sdu, cfg);
+}
+
+static void qos_framing(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.framing = strtol(input, NULL, 0);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter PHY:", qos_phy, cfg);
+}
+
+static void qos_interval(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	cfg->qos.interval = strtol(input, NULL, 0);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter Framing:", qos_framing,
+									cfg);
+}
+
+static void endpoint_config(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	uint8_t *data;
+	size_t len;
+
+	data = str2bytearray((char *) input, &len);
+
+	iov_append(&cfg->caps, data, len);
+	free(data);
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter Interval:", qos_interval,
+									cfg);
+}
+
+static void cmd_config_endpoint(int argc, char *argv[])
+{
+	struct endpoint_config *cfg;
+	const struct codec_preset *preset;
+
+	cfg = new0(struct endpoint_config, 1);
+
+	cfg->proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	if (!cfg->proxy) {
+		bt_shell_printf("Endpoint %s not found\n", argv[1]);
+		goto fail;
+	}
+
+	cfg->ep = endpoint_find(argv[2]);
+	if (!cfg->ep) {
+		bt_shell_printf("Local Endpoint %s not found\n", argv[2]);
+		goto fail;
+	}
+
+	if (argc > 3) {
+		preset = find_preset(cfg->ep->uuid, argv[3]);
+		if (!preset) {
+			bt_shell_printf("Preset %s not found\n", argv[3]);
+			goto fail;
+		}
+
+		/* Copy capabilities */
+		iov_append(&cfg->caps, preset->data.iov_base,
+						preset->data.iov_len);
+
+		endpoint_set_config(cfg);
+		return;
+	}
+
+	bt_shell_prompt_input(cfg->ep->path, "Enter configuration:",
+					endpoint_config, cfg);
+
+	return;
+
+fail:
+	g_free(cfg);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_presets_endpoint(int argc, char *argv[])
+{
+	size_t i;
+	struct codec_preset *default_preset = NULL;
+
+	if (argc > 2) {
+		default_preset = find_preset(argv[1], argv[2]);
+		if (!default_preset) {
+			bt_shell_printf("Preset %s not found\n", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		default_preset->is_default = true;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(presets); i++) {
+		const struct preset *preset = &presets[i];
+
+		if (!strcasecmp(preset->uuid, argv[1])) {
+			size_t j;
+
+			for (j = 0; j < preset->num_presets; j++) {
+				struct codec_preset *p;
+
+				p = &preset->presets[j];
+
+				if (default_preset && p != default_preset)
+					p->is_default = false;
+
+				if (p->is_default)
+					bt_shell_printf("*%s\n", p->name);
+				else
+					bt_shell_printf("%s\n", p->name);
+			}
+		}
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu endpoint_menu = {
+	.name = "endpoint",
+	.desc = "Media Endpoint Submenu",
+	.entries = {
+	{ "list",         "[local]",    cmd_list_endpoints,
+						"List available endpoints" },
+	{ "show",         "<endpoint>", cmd_show_endpoint,
+						"Endpoint information",
+						endpoint_generator },
+	{ "register",     "<UUID> <codec> [capabilities...]",
+						cmd_register_endpoint,
+						"Register Endpoint",
+						uuid_generator },
+	{ "unregister",   "<UUID/object>", cmd_unregister_endpoint,
+						"Register Endpoint",
+						local_endpoint_generator },
+	{ "config",       "<endpoint> <local endpoint> [preset]",
+						cmd_config_endpoint,
+						"Configure Endpoint",
+						endpoint_generator },
+	{ "presets",      "<UUID> [default]", cmd_presets_endpoint,
+						"List available presets",
+						uuid_generator },
+	{} },
+};
+
+static void media_added(GDBusProxy *proxy)
+{
+	medias = g_list_append(medias, proxy);
+
+	print_media(proxy, COLORED_NEW);
+}
+
 static void player_added(GDBusProxy *proxy)
 {
 	players = g_list_append(players, proxy);
@@ -1002,18 +2137,36 @@ static void item_added(GDBusProxy *proxy)
 	print_item(proxy, COLORED_NEW);
 }
 
+static void endpoint_added(GDBusProxy *proxy)
+{
+	endpoints = g_list_append(endpoints, proxy);
+
+	print_endpoint(proxy, COLORED_NEW);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
-	if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE))
+	if (!strcmp(interface, BLUEZ_MEDIA_INTERFACE))
+		media_added(proxy);
+	else if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE))
 		player_added(proxy);
 	else if (!strcmp(interface, BLUEZ_MEDIA_FOLDER_INTERFACE))
 		folder_added(proxy);
 	else if (!strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE))
 		item_added(proxy);
+	else if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
+		endpoint_added(proxy);
+}
+
+static void media_removed(GDBusProxy *proxy)
+{
+	print_media(proxy, COLORED_DEL);
+
+	medias = g_list_remove(medias, proxy);
 }
 
 static void player_removed(GDBusProxy *proxy)
@@ -1040,18 +2193,29 @@ static void item_removed(GDBusProxy *proxy)
 	print_item(proxy, COLORED_DEL);
 }
 
+static void endpoint_removed(GDBusProxy *proxy)
+{
+	endpoints = g_list_remove(endpoints, proxy);
+
+	print_endpoint(proxy, COLORED_DEL);
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
+	if (!strcmp(interface, BLUEZ_MEDIA_INTERFACE))
+		media_removed(proxy);
 	if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE))
 		player_removed(proxy);
 	if (!strcmp(interface, BLUEZ_MEDIA_FOLDER_INTERFACE))
 		folder_removed(proxy);
 	if (!strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE))
 		item_removed(proxy);
+	if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
+		endpoint_removed(proxy);
 }
 
 static void player_property_changed(GDBusProxy *proxy, const char *name,
@@ -1084,6 +2248,16 @@ static void item_property_changed(GDBusProxy *proxy, const char *name,
 	g_free(str);
 }
 
+static void endpoint_property_changed(GDBusProxy *proxy, const char *name,
+						DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "Endpoint", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -1097,6 +2271,8 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		folder_property_changed(proxy, name, iter);
 	else if (!strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE))
 		item_property_changed(proxy, name, iter);
+	else if (!strcmp(interface, BLUEZ_MEDIA_ENDPOINT_INTERFACE))
+		endpoint_property_changed(proxy, name, iter);
 }
 
 static GDBusClient *client;
@@ -1104,6 +2280,7 @@ static GDBusClient *client;
 void player_add_submenu(void)
 {
 	bt_shell_add_submenu(&player_menu);
+	bt_shell_add_submenu(&endpoint_menu);
 
 	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
 	if (!dbus_conn || client)
@@ -1113,6 +2290,7 @@ void player_add_submenu(void)
 
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
 }
 
 void player_remove_submenu(void)
-- 
2.35.1

