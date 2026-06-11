Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05A3126D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198574; cv=none; b=pAqZ1cj2/+tL+F2xDYWs6to6MgBtRflzHjHGBBpjmCpe8n6803adn4FYWLhKZYXZryrhZ7CzrY7/pO5wkp+mOEbIjWBRBKliIJH78p9qGGDyo+AueW+FEgBAkLj2eMYpswUJTwpjGyjeU+EjvRaZADepI5jzRX74tf68FqkhPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198574; c=relaxed/simple;
	bh=PqDIdaaZc8UafpHGMD+reh70UOQFUpKQ27LZohEWEqg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rFekmg2mV+c6KpkCbehDS364BgrXH8ZxR+qGP7pAh2O34eW5B9bUdzEGlO0lYyo8DllvVAgF4LKlAyoe/0GvhFggDOTQOwV80aE8GA9wLqu7eajlvKgR1fFBKg4WLBOS590glENyOFC7OSSokdVdKnjH9FmWScv6u8UDms2dfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynsr0JBa; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynsr0JBa"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96392241154so33739241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198565; x=1781803365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dzSDoPVuAz9gPAU+yPJ2gHXE6Gv8zhX+IRndkTDJCk=;
        b=Ynsr0JBabGHuN0/Gh9lHFmMPCUREMISfM4olImr56DmCN0WAyxiyfieOmGHTFFdCFr
         X7c3PFyCFt42mjty3YlvdNijqAkmc7Ec+CRIm8aMJYyUWgWF45fmFeUiSaw72+aAEoGi
         LaE32hBu3z6BWJsUqG3iBiqwxbWIn62j04+hCHYVg4DfZBKP/8NShIPDjnxT8l3ceS93
         mw6LJJ7TqvSBBg5Tu/grYNLUznEHh48gnXp5cm/KhtxBw3EfDjluqHo4MWqqoU8BJrqQ
         MTxOoO3Snq+KjMIJNpzg1N/nYlLTiXu9NjuZAEHB3KgDY0GBt43XCqntTfgBFPGOoHo9
         Zggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198565; x=1781803365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dzSDoPVuAz9gPAU+yPJ2gHXE6Gv8zhX+IRndkTDJCk=;
        b=GCfyD/ysDDKdEJ3HfXfYDMNvKkJZkM9qcLcP9Eakpe1Rsn5lCcRzryj1QKHulye1Mf
         ZeSdjiJpz8QEtSEY8NGZ1//4JRRZU1t2bbmPUEUWe84ZC+GDEk9Bu8oKwj3pXyRDMUMm
         QMdpLPlyeAS0X56GmaqKIvPFoxBsIL+WoYZmaNUEFAVddW9GFCQIyCbmfBpVsQnF88rP
         bNf/it/tiurJUw3CnozLeG9JrK5kHgeOJHCb+Ejs3U6egxzi5+3KBB+eht+G/JULx2+T
         tNwJLGoqEr+NJUFtarBAKbnMf9TpUHyp1OzEw6ANn0yNHl0GB0wD6KXEjAVQVM7C67dZ
         fvGQ==
X-Gm-Message-State: AOJu0Yx/6Esu66z7I9mbrj57/lrHRKqdztsWJvoB1jat8VZF5mf7HmG0
	y4nweYxQmBvQZZUix5+bV0/4kem19sJxo0JL9xvst0IKRWF01ldYYFvhbJ1pjwRK
X-Gm-Gg: Acq92OFgOk3wTsM8AslLH1fI/w0pGqqEnXGILHqROjxJrccYEuEuHMCm//9i7OCFxA7
	ki85YJbelC5UI3JAo85xiYkA6ApDwphNERmmJvWPpuhFbiFHsnw0MfPNiObmVbPE0GMmk09VTz7
	Tbnum0SE8C1iQq+hNGUA7Yt1mGE//btPpkL/H5LoXEXXNJBu4MEtj1bPFrA5iH2To5Md9XNQ6pM
	2Z3qE3VGNceshjoy5a2XFFcwi08Mqr/QLM+QX/EQQEB4gN4n7JzclVRxLwcZulQyu/wRYUgoYuL
	//S/W2QW4BFVDnIirQVoVCyzmc3p9hQIGh6aDGa34igB1H39QRvizlJcanMjonLdGj1CjrJ/4w0
	JYUie23TbgSa+FQjTKt5rm2DahW8hWZuUwTOoSdNIiQ4pdmyWxOD/VEIglMn7ZBh8H94axa7SRf
	9dvlTXBK4a+UD0kEuj9fheYtcALSYJ81hxFZQ+lYtsGCm10XoLwEBCwrG3h2GeuxYuzTo4qjy8B
	Cfptbfi6ZUl+j/jaQ==
X-Received: by 2002:a05:6102:26d6:b0:650:967f:fb32 with SMTP id ada2fe7eead31-71d5d49bb76mr2536565137.3.1781198563551;
        Thu, 11 Jun 2026 10:22:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71d9267bb61sm1689828137.9.2026.06.11.10.22.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:22:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active
Date: Thu, 11 Jun 2026 13:22:32 -0400
Message-ID: <20260611172235.92930-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When a MediaAssistant is already active (streaming), a subsequent Push
should send Modify Source with PA_SYNC_NO_SYNC and bis_sync=0 to
remove the broadcast source, rather than adding a duplicate source.

Split push() into push_add_src() and push_mod_src() helpers. The push
dispatcher checks the assistant state: ACTIVE non-local assistants and
LOCAL assistants with a tracked source entry both route to
push_mod_src, while all others proceed with push_add_src.

Add per-device source tracking for LOCAL assistants via a bass_src
struct (keyed by bt_bass pointer) stored in a per-assistant srcs
queue. This is needed because LOCAL assistants never change state, so
we cannot rely on the state machine alone to detect active sources.

Also fix the bass_src_changed BID filter: the previous check rejected
non-local assistants when BID was zero, but this incorrectly excluded
LOCAL assistants in REQUESTING state whose BID happens to be non-zero.
Change to reject assistants whose own BID is non-zero when the
notification BID is zero, which correctly matches local streams.
---
 profiles/audio/bass.c | 176 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 1fd7704a77a2..f018f8b3ad7f 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -108,9 +108,16 @@ struct bass_assistant {
 	struct iovec *meta;
 	struct iovec *caps;
 	enum assistant_state state;
+	uint8_t src_id;
+	struct queue *srcs;		/* Per-device source tracking */
 	char *path;
 };
 
+struct bass_src {
+	struct bt_bass *bass;
+	uint8_t src_id;
+};
+
 struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
 	struct btd_service *service;
@@ -158,6 +165,17 @@ static void bass_data_remove(struct bass_data *data);
 static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
 			struct iovec *caps, struct iovec *meta,
 			struct bt_bap_qos *qos, void *user_data);
+
+static bool match_src_data(const void *data, const void *match_data)
+{
+	const struct bass_src *src = data;
+	const struct bt_bass *bass = match_data;
+
+	return src->bass == bass;
+}
+
+static struct bass_src *assistant_add_src(struct bass_assistant *assistant,
+					struct bt_bass *bass, uint8_t id);
 static void bis_remove(struct bt_bap *bap, void *user_data);
 
 
@@ -1010,35 +1028,62 @@ static void assistant_past(struct bass_assistant *assistant)
 	free(addr);
 }
 
-static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
-							  void *user_data)
+static DBusMessage *push_mod_src(struct bass_assistant *assistant,
+					DBusMessage *msg)
+{
+	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
+	struct bt_bass_mod_src_params params = {0};
+	struct iovec iov = {0};
+	uint32_t bis_sync = 0;
+	uint8_t meta_len = 0;
+	int err;
+
+	hdr.op = BT_BASS_MOD_SRC;
+
+	params.id = assistant->src_id;
+	params.pa_sync = PA_SYNC_NO_SYNC;
+	params.pa_interval = PA_INTERVAL_UNKNOWN;
+	params.num_subgroups = assistant->sgrp + 1;
+
+	util_iov_append(&iov, &params, sizeof(params));
+
+	for (uint8_t sgrp = 0; sgrp < params.num_subgroups; sgrp++) {
+		util_iov_append(&iov, &bis_sync, sizeof(bis_sync));
+		util_iov_append(&iov, &meta_len, sizeof(meta_len));
+	}
+
+	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	if (err) {
+		DBG("Unable to send BASS Write Command");
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	free(iov.iov_base);
+
+	if (assistant->device) {
+		assistant_set_state(assistant, ASSISTANT_STATE_IDLE);
+	} else {
+		struct bass_src *src;
+
+		src = queue_remove_if(assistant->srcs, match_src_data,
+						assistant->data->bass);
+		free(src);
+	}
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *push_add_src(struct bass_assistant *assistant,
+					DBusMessage *msg)
 {
-	struct bass_assistant *assistant = user_data;
 	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
 	struct bt_bass_add_src_params params = {0};
 	struct iovec iov = {0};
 	uint32_t bis_sync = 0;
 	uint8_t meta_len = 0;
 	int err;
-	DBusMessageIter props, dict;
 	struct io *io;
 
-	DBG("");
-
-	dbus_message_iter_init(msg, &props);
-
-	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_ARRAY) {
-		DBG("Unable to parse properties");
-		return btd_error_invalid_args(msg);
-	}
-
-	dbus_message_iter_recurse(&props, &dict);
-
-	if (assistant_parse_props(assistant, &dict)) {
-		DBG("Unable to parse properties");
-		return btd_error_invalid_args(msg);
-	}
-
 	hdr.op = BT_BASS_ADD_SRC;
 
 	if (assistant->device) {
@@ -1130,11 +1175,52 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 
 	free(iov.iov_base);
 
-	assistant_set_state(assistant, ASSISTANT_STATE_PENDING);
+	if (assistant->state == ASSISTANT_STATE_LOCAL)
+		assistant_add_src(assistant, assistant->data->bass, 0);
+	else
+		assistant_set_state(assistant, ASSISTANT_STATE_PENDING);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
+							  void *user_data)
+{
+	struct bass_assistant *assistant = user_data;
+	DBusMessageIter props, dict;
+
+	DBG("");
+
+	dbus_message_iter_init(msg, &props);
+
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_ARRAY) {
+		DBG("Unable to parse properties");
+		return btd_error_invalid_args(msg);
+	}
+
+	dbus_message_iter_recurse(&props, &dict);
+
+	if (assistant_parse_props(assistant, &dict)) {
+		DBG("Unable to parse properties");
+		return btd_error_invalid_args(msg);
+	}
+
+	if (assistant->state == ASSISTANT_STATE_ACTIVE) {
+		return push_mod_src(assistant, msg);
+	} else if (assistant->state == ASSISTANT_STATE_LOCAL) {
+		struct bass_src *src;
+
+		src = queue_find(assistant->srcs, match_src_data,
+						assistant->data->bass);
+		if (src) {
+			assistant->src_id = src->src_id;
+			return push_mod_src(assistant, msg);
+		}
+	}
+
+	return push_add_src(assistant, msg);
+}
+
 static const GDBusMethodTable assistant_methods[] = {
 	{GDBUS_EXPERIMENTAL_ASYNC_METHOD("Push",
 					GDBUS_ARGS({ "Props", "a{sv}" }),
@@ -1235,6 +1321,7 @@ static void assistant_free(void *data)
 	g_free(assistant->path);
 	util_iov_free(assistant->meta, 1);
 	util_iov_free(assistant->caps, 1);
+	queue_destroy(assistant->srcs, free);
 
 	free(assistant);
 }
@@ -2015,9 +2102,33 @@ static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 	free(iov.iov_base);
 }
 
+static struct bass_src *assistant_add_src(struct bass_assistant *assistant,
+					struct bt_bass *bass, uint8_t id)
+{
+	struct bass_src *src;
+
+	if (!assistant->srcs)
+		assistant->srcs = queue_new();
+
+	src = queue_find(assistant->srcs, match_src_data, bass);
+	if (src) {
+		src->src_id = id;
+		return src;
+	}
+
+	src = new0(struct bass_src, 1);
+	src->bass = bass;
+	src->src_id = id;
+
+	queue_push_tail(assistant->srcs, src);
+
+	return src;
+}
+
 static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
 				uint8_t enc, uint32_t bis_sync, void *user_data)
 {
+	struct bass_data *data = user_data;
 	const struct queue_entry *entry;
 
 	for (entry = queue_get_entries(assistants); entry;
@@ -2032,9 +2143,9 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
 			continue;
 
 		/* If BID is not set it may happen to be local stream so ignore
-		 * non-local assistants.
+		 * non-local assistants unless their BID is also not set.
 		 */
-		if (!bid && assistant->state != ASSISTANT_STATE_LOCAL)
+		if (!bid && assistant->bid)
 			continue;
 
 		if (state == BT_BASS_SYNC_INFO_RE) {
@@ -2066,21 +2177,34 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
 				break;
 
 			/* Match BIS index */
-			if (bis & bis_sync)
+			if (bis & bis_sync) {
+				assistant->src_id = id;
 				assistant_set_state(assistant,
 						ASSISTANT_STATE_ACTIVE);
+			}
 			break;
 		case BT_BASS_BIG_ENC_STATE_DEC:
 			/* Only handle assistant objects that
 			 * have requested a Broadcast Code
 			 */
-			if (assistant->state != ASSISTANT_STATE_REQUESTING)
+			if (assistant->state != ASSISTANT_STATE_REQUESTING &&
+				assistant->state != ASSISTANT_STATE_LOCAL)
 				break;
 
 			/* Match BIS index */
-			if (bis & bis_sync)
+			if (bis & bis_sync) {
+				assistant->src_id = id;
+
+				if (assistant->state ==
+						ASSISTANT_STATE_LOCAL) {
+					assistant_add_src(assistant, data->bass,
+								id);
+					break;
+				}
+
 				assistant_set_state(assistant,
 						ASSISTANT_STATE_ACTIVE);
+			}
 			break;
 		default:
 			continue;
-- 
2.54.0

