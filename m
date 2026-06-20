Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CD237180
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983076; cv=none; b=moG1oCJiKVwsj8726luary1Se3m7iqu7m/psu94NzfXmTqrlTvFxecH/aJtoYVB7yH5/fo6C0z4MxZppo7+bcBzLXktHFI0eBVFsc25QHMdp0gAEFvSzRgaYOJtAAWGzacAGXoKsIe+p0Y5uf9aQB6zdCL0Vucn01tG3vEZXtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983076; c=relaxed/simple;
	bh=KpVU6KES/Er12xLY9I52vkTk5TPikvQ5PWlbA5C63+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHKdTxPM2u4QFPdfofAQqQYOIhJwNOKxbiMMrE2sF9sfuylSpr8Sxq1J1wPceMsWTSXHTvIshzzTnJcq1kSoHwkPG28SPHJKBAz5T0bYWJMwF2KSReQo0q1HBMhkfJgGOYOaBC1z8KQbNHlIyA2vc25voc/O2brY0n7gwTa5s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQN1Cwug; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQN1Cwug"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso20793385e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781983073; x=1782587873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WW8WLVimuSTrOsok7Fq0ZgquxN9qOkQEeLrelmBJ0g=;
        b=eQN1Cwug8sNnGwAsy+x48E7gXtn4EW+LyiA/qiLrD3tVnQsisPXHAQV2an2KQZc3D5
         d9NXyXYcv/yeiUdW10k75KWz0IIKdTDBvjYHqPQpLknT6GBfEM1rxHRAWtFqv0Z1Ryac
         yeYp6uE5Xu6LjGNChQiHR2OPdva/ETRfWWZ0zm+fAeoysPaPs8BPU+gI0ji7UJ2oO3Ij
         vzl+WshIiVORzzDFOkHo84opz9nD9BVckY84nzTbk68UXCYvZbNeRUhEDQ2A55DUiE4e
         eIvy4gmdh5ekm9evKdickRs/JvkmbUjnR11OJwAvHfzN0Idqb0+ZktToSsh8gCPFVDxS
         piuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781983073; x=1782587873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WW8WLVimuSTrOsok7Fq0ZgquxN9qOkQEeLrelmBJ0g=;
        b=p9wuqjWwe2IslMO/QqFV2Jcy5ba7/03ih5gCpplgpa69Ouyrgu4wn8ZRPy1JIf5cj9
         HixuvjklaQxKG3JSYYJ/RfP1oY9j6R1fwEa5WZNmR7jHoAnXs08xHuWLgFHETrNE5Cdx
         oHcl6jf4GnEdDmPzx44hPTEX0/IN/KmX5AXxEFyV7cj8j92fGvho3WJ7qY8qIRq3pqk9
         CDzfnribRmAlxqK9+5TKuWhKuAdc+A2ZI2E/Bke32RNdF80/lF8x4exHaTlDywuzthPP
         +A4t1kEtct6N3AGzXlGAnFhC37fww9YY/b6NlRbo/XGFb/Rlxy8V9zaz0vg2xUX1SFQu
         exgA==
X-Gm-Message-State: AOJu0YxT5x5XbhFsp/Jqf3d7g53TBc/FvIZQm/buz9xlAlR06tuj6Yju
	tuazxVa1OZVMu1VaH+PcdXWX+x/pVnRliLPC79u/X2Cnc0vYb23CyYU7P5UMoQ==
X-Gm-Gg: AfdE7cmsJlAMdbyk7EKIKvvl8jZBFn1sT5ee7WQ53MRH/T5P/6RtI+Al+coQ6WUR3c/
	acnmEpo9uJLG8pM5O1eMhKUncQSfKWMjeLF3nJTk+b3tp8TnMNnyqAkDZSUXs3zLovoJSFRu91U
	Z6FJRwTAJKKu0EIBqOlo8nMeEhnopcPALAV/a77cRVbKuFaHV06xFn8HdCJo+A5D8aUX3BRdOd+
	U37uwiHKInd40D19BqgwuZzEM9jpiDQf5/n/qpXYqW6fZoVsvdo0No5x8nJLaAkaEkdek7aLDcy
	0I/+HwGGrjO4uz9Izk3/HVi+J5YyZsdsrRjStFx6ynsv8neGK0IevBHO4EjuXQwFh40A7X6Psb9
	8Cr/BDaosX8hYBp9p/U8Asd2QYM08426HHj/J7q5Cr5ES24yLjDIbMRHqC4zFO6QQH25kk2L7tl
	73pv2sE14eSvHaPQFGXBWRGfn8z3vX9SeR8zwvUG9kFAl5SL8PC3WQzeHEGJJGTRwbPPafURCes
	QpcJambb82GYZdFcw==
X-Received: by 2002:a05:600c:4346:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-49240e20cc6mr86811835e9.6.1781983072341;
        Sat, 20 Jun 2026 12:17:52 -0700 (PDT)
Received: from morpheus01.lan (93-38-64-42.ip69.fastwebnet.it. [93.38.64.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923c862sm77000665e9.7.2026.06.20.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:17:50 -0700 (PDT)
From: Geraldo Netto <geraldonetto@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Geraldo Netto <geraldonetto@gmail.com>
Subject: [PATCH BlueZ 1/2] audio: harden a2dp parsers
Date: Sat, 20 Jun 2026 21:17:34 +0200
Message-ID: <20260620191735.2675946-2-geraldonetto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620191735.2675946-1-geraldonetto@gmail.com>
References: <20260620191735.2675946-1-geraldonetto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am                   |   7 +
 Makefile.plugins              |   1 +
 profiles/audio/a2dp-helpers.c | 136 ++++++++++++++++
 profiles/audio/a2dp-helpers.h |  20 +++
 profiles/audio/a2dp.c         |  86 +++++-----
 unit/test-a2dp.c              | 288 ++++++++++++++++++++++++++++++++++
 6 files changed, 489 insertions(+), 49 deletions(-)
 create mode 100644 profiles/audio/a2dp-helpers.c
 create mode 100644 profiles/audio/a2dp-helpers.h
 create mode 100644 unit/test-a2dp.c

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..35871cc57 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -642,6 +642,13 @@ unit_test_avdtp_SOURCES = unit/test-avdtp.c \
 				unit/avdtp.c unit/avdtp.h
 unit_test_avdtp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
+unit_tests += unit/test-a2dp
+
+unit_test_a2dp_SOURCES = unit/test-a2dp.c \
+				profiles/audio/a2dp-helpers.c \
+				profiles/audio/a2dp-helpers.h
+unit_test_a2dp_LDADD = src/libshared-glib.la $(GLIB_LIBS) $(DBUS_LIBS)
+
 unit_tests += unit/test-avctp
 
 unit_test_avctp_SOURCES = unit/test-avctp.c \
diff --git a/Makefile.plugins b/Makefile.plugins
index ac667beda..57400d877 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -27,6 +27,7 @@ builtin_modules += a2dp
 builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
 			profiles/audio/a2dp.h profiles/audio/a2dp.c \
+			profiles/audio/a2dp-helpers.h profiles/audio/a2dp-helpers.c \
 			profiles/audio/avdtp.h profiles/audio/avdtp.c \
 			profiles/audio/a2dp-codecs.h
 endif
diff --git a/profiles/audio/a2dp-helpers.c b/profiles/audio/a2dp-helpers.c
new file mode 100644
index 000000000..035236df6
--- /dev/null
+++ b/profiles/audio/a2dp-helpers.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+#include "a2dp-helpers.h"
+
+static bool parse_hex_byte(const char **value, uint8_t *byte)
+{
+	int high;
+	int low;
+
+	if ((*value)[0] == '\0' || (*value)[1] == '\0')
+		return false;
+
+	high = g_ascii_xdigit_value((*value)[0]);
+	low = g_ascii_xdigit_value((*value)[1]);
+	if (high < 0 || low < 0)
+		return false;
+
+	*byte = high << 4 | low;
+	*value += 2;
+
+	return true;
+}
+
+static bool parse_colon(const char **value)
+{
+	if (**value != ':')
+		return false;
+
+	(*value)++;
+
+	return true;
+}
+
+static bool parse_caps(const char *value, uint8_t *caps, size_t caps_len,
+								size_t *size)
+{
+	size_t len;
+	size_t i;
+
+	if (!value || !caps || !size)
+		return false;
+
+	*size = 0;
+
+	len = strlen(value);
+	if (!len || len % 2 || len / 2 > caps_len)
+		return false;
+
+	for (i = 0; i < len; i++) {
+		if (!g_ascii_isxdigit(value[i]))
+			return false;
+	}
+
+	for (i = 0; i < len; i += 2) {
+		const char *pos = value + i;
+
+		parse_hex_byte(&pos, &caps[i / 2]);
+	}
+
+	*size = len / 2;
+
+	return true;
+}
+
+bool a2dp_parse_capabilities_array(DBusMessageIter *value,
+					uint8_t **caps, int *size)
+{
+	DBusMessageIter array;
+
+	if (!value || !caps || !size)
+		return false;
+
+	*caps = NULL;
+	*size = 0;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
+		return false;
+
+	if (dbus_message_iter_get_element_type(value) != DBUS_TYPE_BYTE)
+		return false;
+
+	dbus_message_iter_recurse(value, &array);
+	dbus_message_iter_get_fixed_array(&array, caps, size);
+
+	return *caps && *size > 0;
+}
+
+bool a2dp_parse_persisted_endpoint(const char *value, uint8_t *type,
+					uint8_t *codec,
+					bool *delay_reporting,
+					uint8_t *caps, size_t caps_len,
+					size_t *size)
+{
+	const char *pos;
+	uint8_t delay = 0;
+
+	if (!value || !type || !codec || !delay_reporting || !size)
+		return false;
+
+	*size = 0;
+
+	pos = value;
+	if (!parse_hex_byte(&pos, type) || !parse_colon(&pos))
+		return false;
+
+	if (!parse_hex_byte(&pos, codec) || !parse_colon(&pos))
+		return false;
+
+	if (pos[0] != '\0' && pos[1] != '\0' &&
+			g_ascii_isxdigit(pos[0]) && g_ascii_isxdigit(pos[1]) &&
+			pos[2] == ':') {
+		parse_hex_byte(&pos, &delay);
+		parse_colon(&pos);
+		if (delay > 1)
+			return false;
+	}
+
+	if (!parse_caps(pos, caps, caps_len, size))
+		return false;
+
+	*delay_reporting = delay;
+
+	return true;
+}
diff --git a/profiles/audio/a2dp-helpers.h b/profiles/audio/a2dp-helpers.h
new file mode 100644
index 000000000..a5c90c516
--- /dev/null
+++ b/profiles/audio/a2dp-helpers.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef BLUEZ_A2DP_HELPERS_H
+#define BLUEZ_A2DP_HELPERS_H
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include <dbus/dbus.h>
+
+bool a2dp_parse_capabilities_array(DBusMessageIter *value,
+					uint8_t **caps, int *size);
+bool a2dp_parse_persisted_endpoint(const char *value, uint8_t *type,
+					uint8_t *codec,
+					bool *delay_reporting,
+					uint8_t *caps, size_t caps_len,
+					size_t *size);
+
+#endif /* BLUEZ_A2DP_HELPERS_H */
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a5e002784..0999436c5 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -52,6 +52,7 @@
 #include "sink.h"
 #include "source.h"
 #include "a2dp.h"
+#include "a2dp-helpers.h"
 #include "a2dp-codecs.h"
 #include "media.h"
 
@@ -689,7 +690,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		if (err < 0 && err != -EINPROGRESS) {
 			error("avdtp_start: %s (%d)", strerror(-err), -err);
 			finalize_setup_errno(setup, err, finalize_resume,
-									NULL);
+							(GSourceFunc) NULL);
 			return;
 		}
 
@@ -942,7 +943,8 @@ static void endpoint_open_cb(struct a2dp_setup *setup, uint8_t error_code)
 
 	if (error_code != 0) {
 		setup->stream = NULL;
-		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
+		finalize_setup_errno(setup, -EPERM, finalize_config,
+							(GSourceFunc) NULL);
 		goto done;
 	}
 
@@ -954,7 +956,7 @@ static void endpoint_open_cb(struct a2dp_setup *setup, uint8_t error_code)
 
 	error("avdtp_open %s (%d)", strerror(-err), -err);
 	setup->stream = NULL;
-	finalize_setup_errno(setup, err, finalize_config, NULL);
+	finalize_setup_errno(setup, err, finalize_config, (GSourceFunc) NULL);
 done:
 	setup_unref(setup);
 }
@@ -974,6 +976,7 @@ static void store_remote_sep(void *data, void *user_data)
 	char seid[4], value[256];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec;
+	uint8_t delay_reporting;
 	unsigned int i;
 	ssize_t offset;
 
@@ -981,12 +984,13 @@ static void store_remote_sep(void *data, void *user_data)
 		return;
 
 	codec = (void *) service->data;
+	delay_reporting = avdtp_get_delay_reporting(sep->sep);
 
 	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
 
 	offset = sprintf(value, "%02hhx:%02hhx:%02hhx:",
 			avdtp_get_type(sep->sep), codec->media_codec_type,
-			avdtp_get_delay_reporting(sep->sep));
+			delay_reporting);
 
 	for (i = 0; i < service->length - sizeof(*codec); i++)
 		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
@@ -1139,7 +1143,8 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			return;
 
 		setup->stream = NULL;
-		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
+		finalize_setup_errno(setup, -EPERM, finalize_config,
+							(GSourceFunc) NULL);
 		setup_unref(setup);
 		return;
 	}
@@ -1148,7 +1153,8 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (ret < 0) {
 		error("avdtp_open %s (%d)", strerror(-ret), -ret);
 		setup->stream = NULL;
-		finalize_setup_errno(setup, ret, finalize_config, NULL);
+		finalize_setup_errno(setup, ret, finalize_config,
+							(GSourceFunc) NULL);
 	}
 }
 
@@ -1431,7 +1437,8 @@ static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err),
 								-start_err);
-		finalize_setup_errno(setup, start_err, finalize_resume, NULL);
+		finalize_setup_errno(setup, start_err, finalize_resume,
+							(GSourceFunc) NULL);
 	}
 
 	return TRUE;
@@ -1483,7 +1490,8 @@ static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	start_err = avdtp_start(session, a2dp_stream->stream);
 	if (start_err < 0 && start_err != -EINPROGRESS) {
 		error("avdtp_start: %s (%d)", strerror(-start_err), -start_err);
-		finalize_setup_errno(setup, start_err, finalize_suspend, NULL);
+		finalize_setup_errno(setup, start_err, finalize_suspend,
+							(GSourceFunc) NULL);
 	}
 }
 
@@ -1504,7 +1512,7 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		return TRUE;
 
 	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
-							finalize_resume, NULL);
+					finalize_resume, (GSourceFunc) NULL);
 
 	return TRUE;
 }
@@ -1572,7 +1580,8 @@ static gboolean a2dp_reconfigure(gpointer data)
 	return FALSE;
 
 failed:
-	finalize_setup_errno(setup, posix_err, finalize_config, NULL);
+	finalize_setup_errno(setup, posix_err, finalize_config,
+							(GSourceFunc) NULL);
 	return FALSE;
 }
 
@@ -1648,8 +1657,8 @@ static void abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 		return;
 
 	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
-							finalize_resume,
-							finalize_config, NULL);
+					finalize_resume, finalize_config,
+					(GSourceFunc) NULL);
 
 	return;
 }
@@ -1901,7 +1910,8 @@ static void channel_free(void *data)
 		setup->chan = NULL;
 		setup_ref(setup);
 		/* Finalize pending commands before we NULL setup->session */
-		finalize_setup_errno(setup, -ENOTCONN, finalize_all, NULL);
+		finalize_setup_errno(setup, -ENOTCONN, finalize_all,
+							(GSourceFunc) NULL);
 		avdtp_unref(setup->session);
 		setup->session = NULL;
 		setup_unref(setup);
@@ -1991,10 +2001,12 @@ static struct a2dp_sep *find_sep(struct a2dp_server *server, uint8_t type,
 
 static int parse_properties(DBusMessageIter *props, uint8_t **caps, int *size)
 {
+	*caps = NULL;
+	*size = 0;
+
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		const char *key;
 		DBusMessageIter value, entry;
-		int var;
 
 		dbus_message_iter_recurse(props, &entry);
 		dbus_message_iter_get_basic(&entry, &key);
@@ -2002,15 +2014,10 @@ static int parse_properties(DBusMessageIter *props, uint8_t **caps, int *size)
 		dbus_message_iter_next(&entry);
 		dbus_message_iter_recurse(&entry, &value);
 
-		var = dbus_message_iter_get_arg_type(&value);
 		if (strcasecmp(key, "Capabilities") == 0) {
-			DBusMessageIter array;
-
-			if (var != DBUS_TYPE_ARRAY)
+			if (!a2dp_parse_capabilities_array(&value, caps, size))
 				return -EINVAL;
 
-			dbus_message_iter_recurse(&value, &array);
-			dbus_message_iter_get_fixed_array(&array, caps, size);
 			return 0;
 		}
 
@@ -2130,7 +2137,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	struct avdtp_media_codec_capability *codec;
 	DBusMessageIter args, props;
 	const char *sender, *path;
-	uint8_t *caps;
+	uint8_t *caps = NULL;
 	int err, size = 0;
 
 	sender = dbus_message_get_sender(msg);
@@ -2371,11 +2378,10 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	for (; *seids; seids++) {
 		uint8_t type;
 		uint8_t codec;
-		uint8_t delay_reporting;
+		bool delay_reporting;
 		GSList *l = NULL;
-		char caps[256];
 		uint8_t data[128];
-		int i, size;
+		size_t size;
 
 		if (sscanf(*seids, "%02hhx", &rseid) != 1)
 			continue;
@@ -2385,34 +2391,16 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		if (!value)
 			continue;
 
-		/* Try loading with delay_reporting first */
-		if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type, &codec,
-					&delay_reporting, caps) != 4) {
-			/* Try old format */
-			if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
-								caps) != 3) {
-				warn("Unable to load Endpoint: seid %u", rseid);
-				g_free(value);
-				continue;
-			}
-			delay_reporting = false;
-		}
-
-		for (i = 0, size = strlen(caps); i < size; i += 2) {
-			uint8_t *tmp = data + i / 2;
-
-			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
-				warn("Unable to load Endpoint: seid %u", rseid);
-				break;
-			}
+		if (!a2dp_parse_persisted_endpoint(value, &type, &codec,
+						&delay_reporting, data,
+						sizeof(data), &size)) {
+			warn("Unable to load Endpoint: seid %u", rseid);
+			g_free(value);
+			continue;
 		}
-
 		g_free(value);
 
-		if (i != size)
-			continue;
-
-		caps_add_codec(&l, codec, data, size / 2);
+		caps_add_codec(&l, codec, data, size);
 
 		rsep = avdtp_register_remote_sep(chan->session, rseid, type, l,
 							delay_reporting);
diff --git a/unit/test-a2dp.c b/unit/test-a2dp.c
new file mode 100644
index 000000000..2f7bd7bbc
--- /dev/null
+++ b/unit/test-a2dp.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+#include "profiles/audio/a2dp-helpers.h"
+
+static DBusMessage *new_method_call(void)
+{
+	return dbus_message_new_method_call("org.bluez.test",
+						"/org/bluez/test",
+						"org.bluez.test",
+						"Test");
+}
+
+static void append_byte_array(DBusMessage *msg, const uint8_t *data, int size)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_BYTE_AS_STRING,
+						&array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&data, size);
+	dbus_message_iter_close_container(&iter, &array);
+}
+
+static void append_string_array(DBusMessage *msg)
+{
+	DBusMessageIter iter;
+	DBusMessageIter array;
+	const char *value = "not-bytes";
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING,
+						&array);
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &value);
+	dbus_message_iter_close_container(&iter, &array);
+}
+
+static void test_capabilities_array_accepts_byte_array(void)
+{
+	DBusMessage *msg = new_method_call();
+	DBusMessageIter iter;
+	const uint8_t bytes[] = { 0x11, 0x22, 0x33 };
+	uint8_t *caps = NULL;
+	int size = 0;
+
+	g_assert_nonnull(msg);
+
+	append_byte_array(msg, bytes, sizeof(bytes));
+	g_assert_true(dbus_message_iter_init(msg, &iter));
+	g_assert_true(a2dp_parse_capabilities_array(&iter, &caps, &size));
+	g_assert_cmpint(size, ==, 3);
+	g_assert_nonnull(caps);
+	g_assert_cmpint(memcmp(caps, bytes, sizeof(bytes)), ==, 0);
+
+	dbus_message_unref(msg);
+}
+
+static void test_capabilities_array_rejects_wrong_element_type(void)
+{
+	DBusMessage *msg = new_method_call();
+	DBusMessageIter iter;
+	uint8_t *caps = (void *) 0x01;
+	int size = 1;
+
+	g_assert_nonnull(msg);
+
+	append_string_array(msg);
+	g_assert_true(dbus_message_iter_init(msg, &iter));
+	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
+	g_assert_null(caps);
+	g_assert_cmpint(size, ==, 0);
+
+	dbus_message_unref(msg);
+}
+
+static void test_capabilities_array_rejects_empty_array(void)
+{
+	DBusMessage *msg = new_method_call();
+	DBusMessageIter iter;
+	uint8_t *caps = (void *) 0x01;
+	int size = 1;
+
+	g_assert_nonnull(msg);
+
+	append_byte_array(msg, NULL, 0);
+	g_assert_true(dbus_message_iter_init(msg, &iter));
+	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
+	g_assert_cmpint(size, ==, 0);
+
+	dbus_message_unref(msg);
+}
+
+static void test_capabilities_array_rejects_missing_iter(void)
+{
+	uint8_t *caps = (void *) 0x01;
+	int size = 1;
+
+	g_assert_false(a2dp_parse_capabilities_array(NULL, &caps, &size));
+}
+
+static void test_capabilities_array_rejects_non_array(void)
+{
+	DBusMessage *msg = new_method_call();
+	DBusMessageIter iter;
+	const char *value = "not-array";
+	uint8_t *caps = (void *) 0x01;
+	int size = 1;
+
+	g_assert_nonnull(msg);
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &value);
+	g_assert_true(dbus_message_iter_init(msg, &iter));
+	g_assert_false(a2dp_parse_capabilities_array(&iter, &caps, &size));
+	g_assert_null(caps);
+	g_assert_cmpint(size, ==, 0);
+
+	dbus_message_unref(msg);
+}
+
+static void assert_endpoint(const char *value, uint8_t expected_type,
+				uint8_t expected_codec,
+				bool expected_delay,
+				const uint8_t *expected_caps,
+				size_t expected_size)
+{
+	uint8_t type = 0xff;
+	uint8_t codec = 0xff;
+	bool delay_reporting = true;
+	uint8_t caps[128];
+	size_t size = 0;
+
+	memset(caps, 0xa5, sizeof(caps));
+
+	g_assert_true(a2dp_parse_persisted_endpoint(value, &type, &codec,
+							&delay_reporting,
+							caps, sizeof(caps),
+							&size));
+	g_assert_cmpint(type, ==, expected_type);
+	g_assert_cmpint(codec, ==, expected_codec);
+	g_assert_cmpint(delay_reporting, ==, expected_delay);
+	g_assert_cmpuint(size, ==, expected_size);
+	g_assert_cmpint(memcmp(caps, expected_caps, expected_size), ==, 0);
+}
+
+static void test_endpoint_parser_accepts_current_format(void)
+{
+	const uint8_t caps[] = { 0x11, 0x22, 0x33 };
+
+	assert_endpoint("00:40:01:112233", 0x00, 0x40, true, caps,
+							sizeof(caps));
+}
+
+static void test_endpoint_parser_accepts_old_format(void)
+{
+	const uint8_t caps[] = { 0xaa, 0xbb };
+
+	assert_endpoint("01:02:aabb", 0x01, 0x02, false, caps, sizeof(caps));
+}
+
+static void assert_endpoint_rejected(const char *value)
+{
+	uint8_t type = 0xff;
+	uint8_t codec = 0xff;
+	bool delay_reporting = true;
+	uint8_t caps[4] = { 0xa5, 0xa5, 0xa5, 0xa5 };
+	size_t size = 7;
+
+	g_assert_false(a2dp_parse_persisted_endpoint(value, &type, &codec,
+							&delay_reporting,
+							caps, sizeof(caps),
+							&size));
+	g_assert_cmpint(caps[0], ==, 0xa5);
+	g_assert_cmpint(caps[1], ==, 0xa5);
+	g_assert_cmpint(caps[2], ==, 0xa5);
+	g_assert_cmpint(caps[3], ==, 0xa5);
+}
+
+static void test_endpoint_parser_rejects_invalid_fields(void)
+{
+	assert_endpoint_rejected(NULL);
+	assert_endpoint_rejected("");
+	assert_endpoint_rejected("00:40");
+	assert_endpoint_rejected("00:40:");
+	assert_endpoint_rejected("00:40:01:");
+	assert_endpoint_rejected("00:40:02:aabb");
+	assert_endpoint_rejected("00:40:01:aab");
+	assert_endpoint_rejected("00:40:01:aazz");
+	assert_endpoint_rejected("00:40:01:aa:bb");
+	assert_endpoint_rejected("00:40:aabb:");
+	assert_endpoint_rejected("xx:40:01:aabb");
+}
+
+static void test_endpoint_parser_rejects_missing_output_buffer(void)
+{
+	uint8_t type;
+	uint8_t codec;
+	bool delay_reporting;
+	size_t size;
+
+	g_assert_false(a2dp_parse_persisted_endpoint("00:40:01:aabb",
+							&type, &codec,
+							&delay_reporting,
+							NULL, 0, &size));
+}
+
+static void test_endpoint_parser_rejects_oversized_caps(void)
+{
+	char value[sizeof("00:40:01:") + 16];
+
+	memset(value, 'a', sizeof(value));
+	memcpy(value, "00:40:01:", strlen("00:40:01:"));
+	value[sizeof(value) - 1] = '\0';
+
+	assert_endpoint_rejected(value);
+}
+
+static void test_endpoint_parser_fuzz_cases_keep_bounds(void)
+{
+	static const char alphabet[] = "0123456789abcdefABCDEF:gZ";
+	unsigned int i;
+
+	for (i = 0; i < 4096; i++) {
+		char value[16];
+		uint8_t type;
+		uint8_t codec;
+		bool delay_reporting;
+		uint8_t caps[6] = { 0, 0, 0, 0, 0xcc, 0xdd };
+		size_t size;
+		size_t len = i % (sizeof(value) - 1);
+		size_t j;
+
+		for (j = 0; j < len; j++)
+			value[j] = alphabet[(i + j * 7) %
+						(sizeof(alphabet) - 1)];
+		value[len] = '\0';
+
+		a2dp_parse_persisted_endpoint(value, &type, &codec,
+						&delay_reporting, caps, 4,
+						&size);
+		g_assert_cmpint(caps[4], ==, 0xcc);
+		g_assert_cmpint(caps[5], ==, 0xdd);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_func("/a2dp/capabilities/byte-array",
+			test_capabilities_array_accepts_byte_array);
+	g_test_add_func("/a2dp/capabilities/wrong-element-type",
+			test_capabilities_array_rejects_wrong_element_type);
+	g_test_add_func("/a2dp/capabilities/empty-array",
+			test_capabilities_array_rejects_empty_array);
+	g_test_add_func("/a2dp/capabilities/missing-iter",
+			test_capabilities_array_rejects_missing_iter);
+	g_test_add_func("/a2dp/capabilities/non-array",
+			test_capabilities_array_rejects_non_array);
+	g_test_add_func("/a2dp/endpoint/current-format",
+			test_endpoint_parser_accepts_current_format);
+	g_test_add_func("/a2dp/endpoint/old-format",
+			test_endpoint_parser_accepts_old_format);
+	g_test_add_func("/a2dp/endpoint/invalid-fields",
+			test_endpoint_parser_rejects_invalid_fields);
+	g_test_add_func("/a2dp/endpoint/missing-output-buffer",
+			test_endpoint_parser_rejects_missing_output_buffer);
+	g_test_add_func("/a2dp/endpoint/oversized-caps",
+			test_endpoint_parser_rejects_oversized_caps);
+	g_test_add_func("/a2dp/endpoint/fuzz-bounds",
+			test_endpoint_parser_fuzz_cases_keep_bounds);
+
+	return g_test_run();
+}
-- 
2.43.0

