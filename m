Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881E325495
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990119; cv=none; b=ufBmCNH4rz4YJRxMXRi5iWlzgUAuwzAwc1EH+g1hJ4RzQyRKEmCo/xX+RCIU4JZeMZXXIw8+ac3y6OrfJDXKj2f9vims5+b1pcv1g/gJZaOgAHILKEX7zncfPgpdCobE7bTi8fok/iP5mxVoGZ/cjQ5ZxY3+HSBdCFqWw8DdG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990119; c=relaxed/simple;
	bh=0DgcYQAl6924DL62XuQ0EFFj1Z7qlp2aoZuXTwpP/Mo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy3eU28A0VffAqh8VyzSESsELn1nAWH+YRfbrPObnSLZLNqwThoLEwZKu1nZ4a5spYTLkif6MBuDxRsa80OO8k1qE0/6NT69/vucUbeplTcaoR+rmbCrZokEVdKV6a+/1uzLGglUDcsBdq7X1vrJJnVpyoITidIWHbDdO7UgaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ax0w9cN1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ax0w9cN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765990113;
	bh=0DgcYQAl6924DL62XuQ0EFFj1Z7qlp2aoZuXTwpP/Mo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ax0w9cN1wibr280EC13W0Ecnt7FwFeOHdpV015WbyWDZhaPXYjc2WAAmYPh980KM2
	 bqMmee3fTnk1qKBNyb9ilPyd0G2XnyYx08UEHSYyQiD8QJPe6lJC9Tb8AN1dDxKGwN
	 T+hq+MOElYrcp0D6bCfAFHeGKbBWmGbkZkHIMkshGKHGETolM9j4phHaoUAnvlpjk7
	 GV9lVg1L5ckUQtpp/S8YQME5/GRNEE5U4MpKCjq+SMeG7jUJn3t0yltBv2IYmzDAPC
	 vOCf2qgGjNs1AdIHyw3MJWC5s2w+yG7aD9DCmvtWz0L2/Cvwc/Ta0xp6SyfGi2a2Fm
	 dPSqpvFG6oX0w==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-41cf-E9a9-dE42-A168.rev.sfr.net [IPv6:2a02:8428:af44:1001:41cf:e9a9:de42:a168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D3FBB17E0C87
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 17:48:32 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/hfp-hf: Add simple call support
Date: Wed, 17 Dec 2025 17:48:19 +0100
Message-ID: <20251217164820.277845-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217164820.277845-1-frederic.danis@collabora.com>
References: <20251217164820.277845-1-frederic.danis@collabora.com>
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
 profiles/audio/hfp-hf.c | 184 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 384480c9e..81d5f4437 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -36,6 +36,7 @@
 #include "src/btd.h"
 #include "src/dbus-common.h"
 #include "src/device.h"
+#include "src/error.h"
 #include "src/log.h"
 #include "src/plugin.h"
 #include "src/profile.h"
@@ -52,6 +53,7 @@ struct hfp_device {
 	uint16_t		version;
 	GIOChannel		*io;
 	struct hfp_hf		*hf;
+	GSList			*calls;
 };
 
 static void hfp_hf_debug(const char *str, void *user_data)
@@ -59,6 +61,33 @@ static void hfp_hf_debug(const char *str, void *user_data)
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
+static int call_id_cmp(gconstpointer a, gconstpointer b)
+{
+	struct call *call = (struct call *) a;
+	uint16_t id = GPOINTER_TO_UINT(b);
+
+	return call->idx == id ? 0 : -1;
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	DBG("%s", telephony_get_path(dev->telephony));
@@ -115,6 +144,42 @@ static void hfp_hf_update_operator(const char *operator_name, void *user_data)
 	telephony_set_operator_name(dev->telephony, operator_name);
 }
 
+static void hfp_hf_call_added(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct call *call;
+
+	call = telephony_new_call(dev->telephony, id,
+					hfp_call_status_to_call_state(status),
+					NULL);
+	if (telephony_call_register_interface(call)) {
+		telephony_free_call(call);
+		return;
+	}
+
+	dev->calls = g_slist_append(dev->calls, call);
+}
+
+static void hfp_hf_call_removed(uint id, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	GSList *match;
+	struct call *call;
+
+	match = g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
+							call_id_cmp);
+	if (!match) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+	call = match->data;
+
+	telephony_call_set_state(call, CALL_STATE_DISCONNECTED);
+	dev->calls = g_slist_remove(dev->calls, call);
+	telephony_call_unregister_interface(call);
+}
+
 static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -129,10 +194,51 @@ static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 	telephony_set_state(dev->telephony, CONNECTED);
 }
 
+static void hfp_hf_call_status_updated(uint id, enum hfp_call_status status,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	GSList *match;
+	struct call *call;
+
+	match = g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
+							call_id_cmp);
+	if (!match) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+	call = match->data;
+
+	telephony_call_set_state(call, hfp_call_status_to_call_state(status));
+}
+
+static void hfp_hf_call_line_id_updated(uint id, const char *number,
+							unsigned int type,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+	GSList *match;
+	struct call *call;
+
+	match = g_slist_find_custom(dev->calls, GINT_TO_POINTER(id),
+							call_id_cmp);
+	if (!match) {
+		DBG("Unknown call id: %u", id);
+		return;
+	}
+	call = match->data;
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
@@ -184,7 +290,85 @@ failed:
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

