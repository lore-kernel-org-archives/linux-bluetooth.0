Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DF31C57B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154551; cv=none; b=hfHT1FoGIvYUAv1gahG2I7MDD2jaDZJiTRp9Fh6Jd80BnKpz77j2jRdZuaebrKkrUZBzNnWE8gd8t2yfpzI0J6W6OIHVqIDtlRpzSLxu3NhNgVqErU0LVSLaGuFNeccF9VjMW8xm1ZKbNO+YYJIfJEtk6DZsf8QsZneoNP4Pau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154551; c=relaxed/simple;
	bh=toGDpuKnrh8+4KTRvqRbeXk3ogToXomlkPG8eDr4qCA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnjffbrYODJ9T+ppJyBgJQw0JmbTCPlLU+isntGzgpX/Z3H/C/vUUF/LX2oK6QShlqCKVUxZaOx4hKjgGOez4rQCWO/fBmhv12bE3z1Qr/+/ZPiGmIUWRUk9CmC8H2DTSxFxnh+tCn4NSwt6g4KmqA7WzME1LTANHT5jWBLo/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aja0UySS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aja0UySS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766154547;
	bh=toGDpuKnrh8+4KTRvqRbeXk3ogToXomlkPG8eDr4qCA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aja0UySSt57VG+f8F8vsdR/kEO983clism/9UnEjjukgChR7y+YL427rWQ0RMP8YS
	 V225XF/bs59d23LcE6H5cBgLiclDkBAG/lPXflQqUZfi08UTzXhVSP9rpd77h5waEm
	 OfIutPkNbgSdHQRg4rvujuvUmQexOaf0kZzM0d+axHHW/XU1i4rLdzzpPXFS1m4UIG
	 XZO6zJSeEkJXX5hI9EGolV+K5rBW4l+x7a8L1bWOPdwjz/sR9JfWv/EZPhrGdzYcVX
	 UoUAl0jhP6hoDt4OZ9/K7Cs7AMyKn/We+V0+qZQB/0x3XAbDS95iJK5NIvtrVXsCGp
	 eaTIRB9i04EVQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-2e1C-31AC-4A84-8c5a.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e1c:31ac:4a84:8c5a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2FFBB17E0464
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 15:29:07 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] audio/hfp-hf: Add simple call support
Date: Fri, 19 Dec 2025 15:29:01 +0100
Message-ID: <20251219142902.559714-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219142902.559714-1-frederic.danis@collabora.com>
References: <20251219142902.559714-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows to dial, hang-up, answer or reject a call.
---
v1->v2:
 - Replace GSList by struct queue
 - Set remote number property if available on call interface creation

 profiles/audio/hfp-hf.c | 186 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 384480c9e..a3263c018 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -36,11 +36,13 @@
 #include "src/btd.h"
 #include "src/dbus-common.h"
 #include "src/device.h"
+#include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/shared/hfp.h"
+#include "src/shared/queue.h"
 
 #include "telephony.h"
 
@@ -52,6 +54,7 @@ struct hfp_device {
 	uint16_t		version;
 	GIOChannel		*io;
 	struct hfp_hf		*hf;
+	struct queue		*calls;
 };
 
 static void hfp_hf_debug(const char *str, void *user_data)
@@ -59,6 +62,33 @@ static void hfp_hf_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static enum call_state hfp_call_status_to_call_state(
+						enum hfp_call_status status)
+{
+	switch (status) {
+	case CALL_STATUS_ACTIVE: return CALL_STATE_ACTIVE; break;
+	case CALL_STATUS_HELD: return CALL_STATE_HELD; break;
+	case CALL_STATUS_DIALING: return CALL_STATE_DIALING; break;
+	case CALL_STATUS_ALERTING: return CALL_STATE_ALERTING; break;
+	case CALL_STATUS_INCOMING: return CALL_STATE_INCOMING; break;
+	case CALL_STATUS_WAITING: return CALL_STATE_WAITING; break;
+	case CALL_STATUS_RESPONSE_AND_HOLD:
+		return CALL_STATE_RESPONSE_AND_HOLD; break;
+	default:
+		DBG("Unknown hfp_call_status: %u", status);
+	}
+
+	return CALL_STATE_DISCONNECTED;
+}
+
+static bool call_id_cmp(const void *data, const void *match_data)
+{
+	struct call *call = (struct call *) data;
+	uint16_t id = GPOINTER_TO_UINT(match_data);
+
+	return call->idx == id;
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	DBG("%s", telephony_get_path(dev->telephony));
@@ -115,6 +145,42 @@ static void hfp_hf_update_operator(const char *operator_name, void *user_data)
 	telephony_set_operator_name(dev->telephony, operator_name);
 }
 
+static void hfp_hf_call_added(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct call *call;
+	const char *number;
+
+	call = telephony_new_call(dev->telephony, id,
+					hfp_call_status_to_call_state(status),
+					NULL);
+	if ((number = hfp_hf_call_get_number(dev->hf, id)) != NULL)
+		call->line_id = g_strdup(number);
+	if (telephony_call_register_interface(call)) {
+		telephony_free_call(call);
+		return;
+	}
+
+	queue_push_tail(dev->calls, call);
+}
+
+static void hfp_hf_call_removed(uint id, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct call *call;
+
+	call = queue_find(dev->calls, call_id_cmp, GUINT_TO_POINTER(id));
+	if (!call) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+
+	telephony_call_set_state(call, CALL_STATE_DISCONNECTED);
+	queue_remove(dev->calls, call);
+	telephony_call_unregister_interface(call);
+}
+
 static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -129,16 +195,56 @@ static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 	telephony_set_state(dev->telephony, CONNECTED);
 }
 
+static void hfp_hf_call_status_updated(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct call *call;
+
+	call = queue_find(dev->calls, call_id_cmp, GUINT_TO_POINTER(id));
+	if (!call) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+
+	telephony_call_set_state(call, hfp_call_status_to_call_state(status));
+}
+
+static void hfp_hf_call_line_id_updated(uint id, const char *number,
+							unsigned int type,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct call *call;
+
+	call = queue_find(dev->calls, call_id_cmp, GUINT_TO_POINTER(id));
+	if (!call) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+
+	telephony_call_set_line_id(call, number);
+}
+
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
 	.update_operator = hfp_hf_update_operator,
+	.call_added = hfp_hf_call_added,
+	.call_removed = hfp_hf_call_removed,
+	.call_status_updated = hfp_hf_call_status_updated,
+	.call_line_id_updated = hfp_hf_call_line_id_updated,
 };
 
 static void hfp_disconnect_watch(void *user_data)
 {
+	struct hfp_device *dev = user_data;
+
 	DBG("");
 
+	queue_destroy(dev->calls, NULL);
+	dev->calls = NULL;
+
 	device_destroy(user_data);
 }
 
@@ -168,6 +274,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 					dev, NULL);
 	hfp_hf_session_register(dev->hf, &hf_session_callbacks, dev);
 
+	dev->calls = queue_new();
+
 	if (!hfp_hf_session(dev->hf)) {
 		error("Could not start SLC creation");
 		hfp_hf_disconnect(dev->hf);
@@ -184,7 +292,85 @@ failed:
 	device_destroy(dev);
 }
 
+static void cmd_complete(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	DBusMessage *msg = user_data;
+
+	if (res != HFP_RESULT_OK) {
+		DBusMessage *reply;
+		const char *name = dbus_message_get_member(msg);
+
+		error("Command %s error: %d", name, res);
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE
+					".Failed",
+					"Command %s failed: %d", name, res);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(msg);
+		return;
+	}
+
+	g_dbus_send_reply(btd_get_dbus_connection(), msg, DBUS_TYPE_INVALID);
+	dbus_message_unref(msg);
+}
+
+static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	const char *number;
+	bool ret;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID)) {
+		return btd_error_invalid_args(msg);
+	}
+
+	if (strncmp(number, URI_PREFIX, strlen(URI_PREFIX)) != 0)
+		return btd_error_invalid_args(msg);
+
+	ret = hfp_hf_dial(dev->hf, number + strlen(URI_PREFIX), cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Dial command failed");
+
+	return NULL;
+}
+
+static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
+				void *call_data)
+{
+	struct call *call = call_data;
+	struct hfp_device *dev = telephony_get_profile_data(call->device);
+	bool ret;
+
+	ret = hfp_hf_call_answer(dev->hf, call->idx, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Answer call command failed");
+
+	return NULL;
+}
+
+static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
+				void *call_data)
+{
+	struct call *call = call_data;
+	struct hfp_device *dev = telephony_get_profile_data(call->device);
+	bool ret;
+
+	ret = hfp_hf_call_hangup(dev->hf, call->idx, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Hangup call command failed");
+
+	return NULL;
+}
+
 struct telephony_callbacks hfp_callbacks = {
+	.dial = dial,
+	.call_answer = call_answer,
+	.call_hangup = call_hangup,
 };
 
 static int hfp_connect(struct btd_service *service)
-- 
2.43.0

