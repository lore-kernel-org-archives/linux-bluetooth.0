Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B674A3F1A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506943; cv=none; b=eqD9WzOvDYk7yTUosO/m16xIDTuniK+YCI2zpr9NER4kyMAzLwaSGtsLGFcXOAYyC+mPgvq3xzXQyB2TyaUU4Nkpz+/mKOQDEBLUEz5GMzEp1OpQvx4PVcaqo3upSgUkozHT1rWjSGDqokCsW3XZb4hGTehBqfyNkxUdWmsTm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506943; c=relaxed/simple;
	bh=zlW+XRl+AYVqvlq0mdcdUWuS1TWT6VyeWpaKiRczB1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCwQ//7wywThAKfO0tqbqPQ2QRRDISKQORDofzrjiNyGHYMgFJJQh8ycrpZA8akJLSl1uDSJ6zywoQ6Lc4Da9xvVE7UG8lcZ3nkHg1z2jqdWywo3EyC/loE85fHwicMdT2rKICS+t08KAkmKAFDg9lW7C2fZGpyN2kKklsvgkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM4S2eQm; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM4S2eQm"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-79028ca9371so70124137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506940; x=1790111740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i5wLl5edHCUxi+Fo+xKoCx9sBanZy8+ppk8KiIZyNCE=;
        b=mM4S2eQmh5HU0MDJtGHNDzMdUBEQ2deFT3Bhb3Y/JeaQuDZqptB/NtCCe/GLmHo0nk
         nYEBxcX9qsG22KRDzKuyPMRN7kOwE6N54H80DzrRXD9IB8sJ3HUQ2z3Y/syj1GXmmm7O
         kuzCL2UkDOjuT/9mDc/EUjFAY+MNfuOdL/vtmjdys3hzapPDRRGcM6SBoasyKIfZEdws
         IZ9vBEq4YtQS7EE2hXWExgbUGT0SpK28j/cbvbkuVPVoSx3yvm2M4ZkNk/WaPQInVB7J
         rVQFRR8ZZVdvR1mHSvaEvfZtXASU8H6HRqMp/k//ajOqDj1228N3Q2cmwIRddF7mzPWg
         D30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506940; x=1790111740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i5wLl5edHCUxi+Fo+xKoCx9sBanZy8+ppk8KiIZyNCE=;
        b=aB8iFNHwILZjH5wm3IT8gIEQvcaSoixLgsq8eF56EPSCgcr5Qe6Vkj01TIJyrVxKL8
         WGCC0yEkwsuUZyV0ZjH0vF2TXtcGM/7aPnwWPu03cBULEu4CtnaRtkZ+6nrerXoRMG1n
         pMt8PlhLvwCXd2KVSsAjShWCQgWT0EQ1vcHyW/i1rDCvY48a3ovZYgks6PfgSc0nHHlp
         P0PT5/+kdmIX/XuxX9V/Nmy9aOwYuf48sw5ivFC7baRXX/E6bPgMChO6DCYbFs1+SAEh
         uDchSkBWAz9+UQhTDEUPqu0XsW+CmudXazNo91JPG0ZFSH9sstX2AH0k2iau0hxvAefM
         CRVA==
X-Gm-Message-State: AFuF++mvn8yaxLFDqeW1NectL0y+2mtYh5z7zGdDq7qtTvop6uAzj4Gv
	ZmXN7+zy+uFLGwm/sguPxe/+ACSb+QoHIdbC1SwEbYWXZzs8/jSVTquDfHxkGa5o
X-Gm-Gg: AYBFou1AB2ern0eKuxgdYvDm3j6uYeb3dPdeYQxiTsGhYoRLHfKcjAU9FpZAchgxVgY
	oTwPGMzptvVFo6SMSfiutix6KK+4xN1NbIjMpJ3gnYzXPDF6wA+EbrIQNN+2GryTsGwj8ISTZ3m
	l/d7FDf71SVFIi1nJjX8KmUJCxpI2s9r0CzqEYU0q6+4l+5P2DbY2gir9jTcfnIOtj0e/2fVJIK
	HFkK3jt2lGcONMCsOcMHFES2rda5rmZDC/sKx2y+x/YG7tyej32gTq7UF3BHiJeHfyrl42IP7yj
	A7tIA6cH4FD0LzEVpNc1kFKZ+UL6Wvx8XummhpF73jYftAr3WrIpK7SST5PeKHsPTKb/RQa2WlG
	zV3kqhmc4PF0wlwjErcylRBZPOFEWA4CWZklj0NWL3mZisfvZkB+hxyZillJL8GMkiiUPtMmYTh
	DDZ8SxqjsHC/sufKpdwcnF6HTLhAVKFmWWjiYz7dm4CColKCoSQnY0CKRE9EvwQxY3Gx2aZ3nJ+
	a39n0FRNfKAWWY29V4SNqoLZMtarud7fuIWq1HR61OG0NwFUrTBu4tVVTsKAR7Dvs64WF19tMJc
X-Received: by 2002:a05:6102:c49:b0:79f:7e2e:c64d with SMTP id ada2fe7eead31-7a027701bf0mr442822137.7.1789506940027;
        Tue, 15 Sep 2026 14:15:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/11] bass: wait for the session to be ready before pushing a source
Date: Tue, 15 Sep 2026 17:15:19 -0400
Message-ID: <20260915211528.1223784-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A Broadcast Assistant could write to the Broadcast Audio Scan Control
Point of a Scan Delegator before its own session had enabled the
Broadcast Receive State notifications, as the connection was completed
as soon as the session was attached.

When that happens the delegator handles the Add Source, sets the state
to request the sync info to be transferred, and notifies it, but the
notification is dropped since the assistant has not subscribed yet. The
assistant never learns it has to transfer the sync info, so PAST never
happens, and the delegator is left waiting for it until the kernel
gives up, which takes 20 seconds, and falls back to creating the sync
itself.

Complete the connection only once the session is ready, and queue any
push received in the meantime, replaying it afterwards, so it is not
rejected just because the user was quick.

With this the sync info is transferred right after the Add Source, and
test_bass_past_transport_acquire consistently takes around 11 seconds
instead of intermittently taking over 40 seconds when the transfer was
missed.

Assisted-by: opencode:claude-opus-5
---
 profiles/audio/bass.c | 124 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 533d45babfeb..c9a9111e010f 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -94,6 +94,14 @@ struct bass_data {
 	unsigned int cp_id;
 	unsigned int bis_id;
 	unsigned int state_id;
+	unsigned int ready_id;
+	bool ready;
+	struct queue *pushes;
+};
+
+struct bass_push {
+	struct bass_assistant *assistant;
+	DBusMessage *msg;
 };
 
 struct bass_assistant {
@@ -1218,10 +1226,31 @@ static DBusMessage *push_add_src(struct bass_assistant *assistant,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *push_src(struct bass_assistant *assistant,
+							DBusMessage *msg)
+{
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
 static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 							  void *user_data)
 {
 	struct bass_assistant *assistant = user_data;
+	struct bass_data *data;
+	struct bass_push *push;
 	DBusMessageIter props, dict;
 
 	DBG("");
@@ -1240,20 +1269,25 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	if (assistant->state == ASSISTANT_STATE_ACTIVE) {
-		return push_mod_src(assistant, msg);
-	} else if (assistant->state == ASSISTANT_STATE_LOCAL) {
-		struct bass_src *src;
+	/* Wait for the session to be ready before writing to the control
+	 * point, otherwise the Broadcast Receive State notifications may not
+	 * be enabled yet and the state changes it triggers, e.g. a request to
+	 * transfer the sync info, would be missed.
+	 */
+	data = queue_find(sessions, match_bass, assistant->data->bass);
+	if (data && !data->ready) {
+		DBG("Session not ready, queueing request");
 
-		src = queue_find(assistant->srcs, match_src_data,
-						assistant->data->bass);
-		if (src) {
-			assistant->src_id = src->src_id;
-			return push_mod_src(assistant, msg);
-		}
+		push = new0(struct bass_push, 1);
+		push->assistant = assistant;
+		push->msg = dbus_message_ref(msg);
+
+		queue_push_tail(data->pushes, push);
+
+		return NULL;
 	}
 
-	return push_add_src(assistant, msg);
+	return push_src(assistant, msg);
 }
 
 static const GDBusMethodTable assistant_methods[] = {
@@ -1754,6 +1788,7 @@ static struct bass_data *bass_data_new(struct btd_adapter *adapter,
 	data = new0(struct bass_data, 1);
 	data->adapter = adapter;
 	data->device = device;
+	data->pushes = queue_new();
 
 	return data;
 }
@@ -1788,6 +1823,19 @@ static void bass_data_add(struct bass_data *data)
 		device_set_past_support(data->device, true);
 }
 
+static void bass_push_free(void *user_data)
+{
+	struct bass_push *push = user_data;
+	DBusMessage *reply;
+
+	reply = btd_error_failed(push->msg, "Session removed");
+	if (reply)
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(push->msg);
+	free(push);
+}
+
 static void bass_data_free(struct bass_data *data)
 {
 	if (data->service) {
@@ -1798,6 +1846,11 @@ static void bass_data_free(struct bass_data *data)
 	bt_bass_src_unregister(data->bass, data->src_id);
 	bt_bass_cp_handler_unregister(data->bass, data->cp_id);
 
+	if (data->ready_id)
+		bt_bass_ready_unregister(data->bass, data->ready_id);
+
+	queue_destroy(data->pushes, bass_push_free);
+
 	bt_bass_unref(data->bass);
 
 	queue_remove_all(assistants, assistant_match_data,
@@ -2365,6 +2418,35 @@ static void bass_remove(struct btd_service *service)
 	bass_data_remove(data);
 }
 
+static void bass_ready(struct bt_bass *bass, void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bass_data *data = btd_service_get_user_data(service);
+	struct bass_push *push;
+
+	DBG("bass %p", bass);
+
+	/* The callback is unregistered with the session, not here, as it is
+	 * called while the ready callbacks are being iterated.
+	 */
+	btd_service_connecting_complete(service, 0);
+
+	if (!data)
+		return;
+
+	data->ready = true;
+
+	while ((push = queue_pop_head(data->pushes))) {
+		DBusMessage *reply = push_src(push->assistant, push->msg);
+
+		if (reply)
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+		dbus_message_unref(push->msg);
+		free(push);
+	}
+}
+
 static int bass_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -2383,10 +2465,22 @@ static int bass_accept(struct btd_service *service)
 	/* Only attach client if initiator of the connection otherwise act as
 	 * delegator.
 	 */
-	if (btd_service_is_initiator(service) &&
-			!bt_bass_attach(data->bass, client)) {
-		error("BASS unable to attach");
-		return -EINVAL;
+	if (btd_service_is_initiator(service)) {
+		/* Complete the connection once the session is ready, so no
+		 * operation is attempted before the Broadcast Receive State
+		 * notifications are enabled, otherwise the state changes they
+		 * trigger, e.g. a request to transfer the sync info, would be
+		 * missed.
+		 */
+		data->ready_id = bt_bass_ready_register(data->bass, bass_ready,
+							service, NULL);
+
+		if (!bt_bass_attach(data->bass, client)) {
+			error("BASS unable to attach");
+			return -EINVAL;
+		}
+
+		return 0;
 	}
 
 	btd_service_connecting_complete(service, 0);
-- 
2.55.0

