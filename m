Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456302;
	b=xgbHltKSE+KXdcau2HiloKe0boqMWPqXWlABsZzDQIUkhJHjhn1ZlVOAmQyfxVblNRzo
	 tMC7tu7j0nMSDV3W9OXLcDUWTAyiyag+xiYrmrRmBozWnS4/vczVyqXFzHjWzPOJUROyC
	 rmPUL9oicLdxZLT4eSC1ninikixqoF0eTKvTSYwuF5r9cFzQNl0MYgafeF3nvtpiJjvHD
	 KeZYK64JkOPi1xgdLntJkMezRltXGoi1qW8h4gDpEY1Uii5MBmz2mmnmbzLehnM1+SSVW
	 vayRbYCu6bwG00tYOvGpn4wu2t3asl+QfoSQ6f5uo7gnL0d3xlH4hnJZVVYl2a90LEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KlgKVwE9sJywfyAotBltamJc5myw0AP7B24kIoiJXNc=;
	b=yiHrUfPSTSK+XNkd2mmpsniYHm7ICnoJPNd3wd8mw1E1zbagulmM+FHO7c2eSRG9IrfD
	 1SMTIlAZiZ3JNDEvbq11dx0YkUIG2wMe+CI2C9++yu3d0JM6NMa/okyIyaakPyb46rvYw
	 E47+p6iyxJqGHo9KhqQpMzyB7YhUlOHL6oC23jYoFxV80dxM0ZCrM1CibLPb8xIE/jA2Y
	 iXBYdfJB6JTmVAzFxVtGCNJ1ElJ5WNuFxDoCv3tPCaIbfUfnw4rRCWHI5PLfFjB1YsWwV
	 8IwY/ib8yCtPU36MVMEG8kvBXOD8+Y6V3bKz3YZYQiYudzuwyGORqbHDTCFjS0FCybQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnyOAUEB;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402D606A330
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5402D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnyOAUEB
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7a6e560f580so2321239137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456301; x=1796061101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KlgKVwE9sJywfyAotBltamJc5myw0AP7B24kIoiJXNc=;
        b=OnyOAUEBQ9bbVat0tLa9fUAB+AoriCdvjsdIqeaHY/v4DSNLywoHoDJXkvPI4/Qpi5
         UXYC7ujGk1m9btOqRlnzkV4qduiQgSkoCG1ZGv2zxTx1+aMDqEULwuUc3TKj8+ZvE6c9
         9v6HE0PU/OCzNBgjSRSdgTtD6kHWXOHGD4NgtvRyXKypvwszwSbBiwQJPfmhPyIlMWRj
         Tr7h24cCblH7hRBJyuYr3iBI04RQ78EZgyxKSPkKp/TOJWUys4ZlCVFPSK+neXpPgzN8
         2OGyyWzjHohB+q2yxPV2sY9LQlEzMdZK0ZciRuQmaDQTC7hEGF1jgC6EW6wi/6V/RD9O
         Op2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456301; x=1796061101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KlgKVwE9sJywfyAotBltamJc5myw0AP7B24kIoiJXNc=;
        b=apVFNKDCni/ysB1nsA5xEEUkBf87xw8IpWd6PluwPYRUSzZP+UBWbR2yHf/Gzc2zPV
         jze8I5UbCUCdHwTSMPzk2UHg19JbCuTiNrtOBG/KU644YauNF6znVPeOViecocZeMPBW
         A8f0vAVTZqaDGR0gjROSjndW2D6N3r8Ca3cuk5PZxEr6nHfGLrKAXctkmvoYGbzJLxTB
         W5ncaiEJYa4L5oR/H7G+KN1v8BiTuouGNTZlAhZXkWagv+Nx+k9/xkvd7jjovBDTsWyK
         gK3ePNfFCQU/ltABc1V+/zqisCcL1LgLeiUnhmlUbeIjHXtrDaTvEH11dJcd/0YVmQ72
         qy/Q==
X-Gm-Message-State: APuU4Z+dnvbW/ckMvhd+JksTrc7xezwBYJgvr+HLZsGWClEkSd27xMNB
	fapFf5pLYFAIBK1v8TvJFq6lZtdw1dwT0ghJ7iJRl4j4TCRwlUT7kk4EC3H5mg==
X-Gm-Gg: AZFdTZetzzdt/ikeISp8NaqGRz0LGZr6WG5BFNi8NepgG3LniEv93B1i155fnghfpSf
	sCLfqKwv9s9xbvgM36ERWvI73uiGhJTYf9ixsFa0Rlz9vrMQ9VJhmG25vzFasqXclbMnW/CO51W
	qKI9Pmvykph9ZufWA5Ydq+zWIXO3RZUvmIRd7qA3j+GCwtMr/z3e9+SbBjYJYkWt+lWwNwGrVR2
	PnxuxKXBqMGNGWla9Tri0utluWumLlrKZxwayiaOlLeOKtcsH7d8RoAIEBZsp3pT1h8SD2YNJOd
	9EVvm8mI2Ut5LJ03CGxLfUqr+9BmSoBUWIXtu6cENp85pq/452OzegpohlOoBCk5ZpZzeHEE73Y
	gtD/FIt31Imc5lvGg/uGY4AYtTwj+kkYoD7kiLjPqmZIqbcZkux6frUPtuUs1PPKDxybqlXra9j
	7Th0dbAgyK7/Mnil+wtdOEGXnZyCvNiJ+mRWHHrXplpEyOnjPuBgh5CzEb7Bv8oBPUJnOxbuDFs
	k2oMY5zeLrQqe3TuepmC68n9LK4pismeAdj0lB0rogVMmP2d7lR6yuPbdByKGxtlgybYNh9qRaC
	oV9n/U3OPenDt0Zq8AOeiPnfc8QudROQmZwjTv/IelP6ZeeN0/zhiJ6ADta2OnxXQgBQ3lWa9UB
	tCeSSG4p0Zg8vAZXOjFoNBS7Ib8/KjJ2b6e406MYy/h5YhIfMt7m+nDoCcSD2XOQxeryuEHiMiM
	nFn/Y=
X-Received: by 2002:a05:6102:6881:b0:7d2:c786:5a95 with SMTP id ada2fe7eead31-7d73937ce1fmr5619643137.13.1795456301014;
        Mon, 23 Nov 2026 09:51:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 18/18] shared/rap: Defer Ranging Data mode selection until Features is read
Date: Mon, 23 Nov 2026 12:51:21 -0500
Message-ID: <20261123175125.3642617-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

- Wait for the RAS Features read before choosing a mode in
  bt_rap_ensure_ranging_data(), since a zero value also means the read
  has not completed.
- Keep an explicit SetRangingDataMode(Disabled) instead of subscribing
  again on the next start, and subscribe a selected mode again with its
  transport when its subscription ended with the last measurement.
- Forget a notification registration the peer rejected and drop its
  handler, so that a later start retries it.
- Arm the first Real-time data timeout when Real-time is enabled while a
  procedure is already running.

Assisted-by: Claude:claude-sonnet-5-5
---
 src/shared/rap.c | 120 ++++++++++++++++++++++++++++++++++++++++++++--
 unit/test-rap.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+), 5 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index d4ce1751f052..c4489e2cfde4 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -480,6 +480,11 @@ struct bt_rap {
 	unsigned int ready_notify_id;
 	unsigned int overwritten_notify_id;
 	uint32_t ras_features;
+	bool features_read;	/* RAS Features read completed */
+	bool ensure_pending;	/* ensure_ranging_data() waits for it */
+	bool mode_selected;	/* SetRangingDataMode() called, even Disabled */
+	enum bt_rap_ranging_data_mode selected_mode;
+	bool proc_enabled;	/* a CS procedure is running */
 
 	/* Responder role: Ranging Counters read back through Ranging Data
 	 * Ready and Overwritten, scoped to this connection (RAS v1.0, 3.4
@@ -999,6 +1004,10 @@ void bt_rap_detach(struct bt_rap *rap)
 	rap->cp_notify_id = 0;
 	rap->ready_notify_id = 0;
 	rap->overwritten_notify_id = 0;
+	rap->features_read = false;
+	rap->ensure_pending = false;
+	rap->mode_selected = false;
+	rap->proc_enabled = false;
 
 	bt_att_unregister_disconnect(rap->att, rap->disconn_id);
 	rap->att = NULL;
@@ -3357,7 +3366,9 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 	/* RAP v1.0 4.4.1.1: the first Real-time Ranging Data is due within
 	 * 5 seconds after the CS procedure starts.
 	 */
-	if (data->state == 0x01 && rap->realtime_notify_id)
+	rap->proc_enabled = data->state == 0x01;
+
+	if (rap->proc_enabled && rap->realtime_notify_id)
 		ras_realtime_arm_timeout(rap,
 					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 }
@@ -3530,14 +3541,68 @@ static void rap_read_value(struct bt_rap *rap, uint16_t value_handle,
 	queue_push_tail(rap->pending, pending);
 }
 
+static void rap_forget_notify(struct bt_rap *rap, unsigned int id)
+{
+	if (rap->realtime_notify_id == id)
+		rap->realtime_notify_id = 0;
+	if (rap->ondemand_notify_id == id)
+		rap->ondemand_notify_id = 0;
+	if (rap->cp_notify_id == id)
+		rap->cp_notify_id = 0;
+	if (rap->ready_notify_id == id)
+		rap->ready_notify_id = 0;
+	if (rap->overwritten_notify_id == id)
+		rap->overwritten_notify_id = 0;
+}
+
+struct rap_failed_notify {
+	struct bt_rap *rap;
+	unsigned int id;
+};
+
+static bool rap_failed_notify_cb(void *user_data)
+{
+	struct rap_failed_notify *failed = user_data;
+
+	if (failed->rap->client)
+		bt_gatt_client_unregister_notify(failed->rap->client,
+							failed->id);
+
+	return false;
+}
+
+static void rap_failed_notify_free(void *user_data)
+{
+	struct rap_failed_notify *failed = user_data;
+
+	bt_rap_unref(failed->rap);
+	free(failed);
+}
+
 static void ras_register(uint16_t att_ecode, void *user_data)
 {
 	struct bt_rap_notify *notify = user_data;
+	struct rap_failed_notify *failed;
 
-	if (att_ecode)
-		DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
+	if (!att_ecode)
+		return;
 
-	(void)notify;
+	DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
+
+	/* The ID only says the CCC write was queued. Forget it so a later
+	 * subscription retries, and drop the handler the client still holds;
+	 * that is done from the mainloop as the client is iterating its
+	 * registrations right now.
+	 */
+	rap_forget_notify(notify->rap, notify->id);
+
+	failed = new0(struct rap_failed_notify, 1);
+	failed->rap = bt_rap_ref(notify->rap);
+	failed->id = notify->id;
+
+	if (!timeout_add(0, rap_failed_notify_cb, failed,
+					rap_failed_notify_free))
+		rap_failed_notify_free(failed);
 }
 
 static void rap_notify(uint16_t value_handle, const uint8_t *value,
@@ -4651,6 +4716,14 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		rap->realtime_notify_id = bt_rap_register_notify(rap,
 				value_handle, rap->realtime_ccc_value,
 				ras_segment_notify_cb, "real-time");
+
+		/* Enabled while a procedure is already running: its start,
+		 * which arms the first data timeout, has been missed.
+		 */
+		if (rap->realtime_notify_id && rap->proc_enabled)
+			ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
+
 		return rap->realtime_notify_id != 0;
 	}
 
@@ -4695,7 +4768,7 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport)
 {
-	if (!rap || !rap->client || !rap->ras_features)
+	if (!rap || !rap->client || !rap->features_read)
 		return false;
 
 	if (mode == BT_RAP_RANGING_DATA_REALTIME &&
@@ -4713,6 +4786,8 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 
 	rap->realtime_ccc_value = transport;
 	rap->ondemand_ccc_value = transport;
+	rap->mode_selected = true;
+	rap->selected_mode = mode;
 
 	return rap_subscribe_ranging_data(rap, mode);
 }
@@ -4724,9 +4799,37 @@ bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
 	if (!rap || !rap->client)
 		return false;
 
+	/* An explicit selection stands, Disabled included. A selected mode
+	 * whose subscription ended with the last measurement (stop or
+	 * timeout) or was rejected is subscribed again with its transport.
+	 */
+	if (rap->mode_selected) {
+		if (rap->selected_mode == BT_RAP_RANGING_DATA_DISABLED ||
+				(rap->selected_mode ==
+				BT_RAP_RANGING_DATA_REALTIME &&
+				rap->realtime_notify_id) ||
+				(rap->selected_mode ==
+				BT_RAP_RANGING_DATA_ONDEMAND &&
+				rap->ondemand_notify_id))
+			return true;
+
+		if (!rap->features_read) {
+			rap->ensure_pending = true;
+			return true;
+		}
+
+		return rap_subscribe_ranging_data(rap, rap->selected_mode);
+	}
+
 	if (rap->realtime_notify_id || rap->ondemand_notify_id)
 		return true;
 
+	/* Which mode the peer supports is only known once Features is read */
+	if (!rap->features_read) {
+		rap->ensure_pending = true;
+		return true;
+	}
+
 	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
 	 * Ranging Data is optional for the RRSP, so fall back to On-demand
 	 * when it is not supported (RAP v1.0 4.4.2).
@@ -4785,6 +4888,7 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	if (ras)
 		ras->client.abort_operation = abort_operation;
 	rap->ras_features = features;
+	rap->features_read = true;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
@@ -4802,6 +4906,12 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 			!rap_subscribe_ranging_data(rap,
 					BT_RAP_RANGING_DATA_ONDEMAND))
 		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
+
+	/* StartMeasurement() arrived before the peer's features were known */
+	if (rap->ensure_pending) {
+		rap->ensure_pending = false;
+		bt_rap_ensure_ranging_data(rap);
+	}
 }
 
 static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
diff --git a/unit/test-rap.c b/unit/test-rap.c
index a1655640d41c..2077cbec6713 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -49,6 +49,8 @@ struct test_data_ras {
 struct test_config_rap {
 	const struct iovec *setup_data;
 	const size_t setup_data_len;
+	/* Run right after attaching, before RAS Features is read */
+	void (*early)(struct bt_rap *rap);
 	/* Run once the Requester is ready; when NULL the test passes there */
 	void (*action)(struct bt_rap *rap);
 	/* Called when the ATT script is exhausted; NULL leaves it to action */
@@ -467,6 +469,9 @@ static void test_client_rap(const void *user_data)
 	bt_rap_ready_register(data->rap, rap_client_ready_cb, data, NULL);
 
 	bt_rap_attach(data->rap, data->client);
+
+	if (data->cfg->early)
+		data->cfg->early(data->rap);
 }
 
 /*
@@ -1121,12 +1126,84 @@ static void action_ondemand_indicate(struct bt_rap *rap)
 	WRITE_CCCD(0x0f, 0x02), \
 	WRITE_CCCD(0x12, 0x02)
 
+/* StartMeasurement() before RAS Features was read waits for it, so the mode
+ * follows what the peer supports (Real-time here).
+ */
+static void early_ensure(struct bt_rap *rap)
+{
+	g_assert(bt_rap_ensure_ranging_data(rap));
+}
+
+/* An explicit Disabled selection is not overridden by StartMeasurement() */
+static void action_disabled_then_ensure(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_DISABLED,
+				BT_RAP_RANGING_NOTIFY));
+	g_assert(bt_rap_ensure_ranging_data(rap));
+	g_timeout_add(300, idle_pass_cb, NULL);
+}
+
+static gboolean retry_ensure_cb(gpointer user_data);
+
+/* A selected mode whose subscription ended with the last measurement is
+ * subscribed again, with the selected transport, by the next start.
+ */
+static void action_selected_resubscribe(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_INDICATE));
+	g_timeout_add(200, realtime_disable_cb, rap);
+	g_timeout_add(400, retry_ensure_cb, rap);
+}
+
+static gboolean retry_ensure_cb(gpointer user_data)
+{
+	g_assert(bt_rap_ensure_ranging_data(user_data));
+	return FALSE;
+}
+
+/* The peer rejects the CCCD write: the next start has to retry it */
+static void action_ensure_retry(struct bt_rap *rap)
+{
+	g_assert(bt_rap_ensure_ranging_data(rap));
+	g_timeout_add(300, retry_ensure_cb, rap);
+}
+
 const struct test_config_rap cfg_rap_idle = {
 	.setup_data = cggit_setup_data,
 	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
 	.action = action_idle,
 };
 
+const struct test_config_rap cfg_rap_early_ensure = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.early = early_ensure,
+	.action = action_idle,
+};
+
+const struct test_config_rap cfg_rap_disabled = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_disabled_then_ensure,
+};
+
+const struct test_config_rap cfg_rap_resubscribe = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_selected_resubscribe,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_retry = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_ensure_retry,
+	.complete = test_complete_cb,
+};
+
 const struct test_config_rap cfg_rap_rt_notify = {
 	.setup_data = cggit_setup_data,
 	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
@@ -1204,6 +1281,27 @@ const struct test_config_rap cfg_rap_rt_timeout = {
 	.complete = realtime_timeout_complete,
 };
 
+/*
+ * Real-time Ranging Data enabled while a procedure is already running arms
+ * the first data timeout as well.
+ */
+static void action_realtime_midproc(struct bt_rap *rap)
+{
+	proc_enable_time = g_get_monotonic_time();
+	inject_proc_enable(rap);
+
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_NOTIFY));
+}
+
+const struct test_config_rap cfg_rap_rt_midproc = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_realtime_midproc,
+	.complete = realtime_timeout_complete,
+};
+
 /*
  * RAS Ranging Data Ready/Overwritten reads report the counters of the
  * connection they are read on (RAS v1.0, 3.4 and 3.5).
@@ -1497,6 +1595,30 @@ int main(int argc, char *argv[])
 			test_setup_rap, test_client_rap, &cfg_rap_ensure,
 			RAP_REQ_ORD_ROUND(0x01));
 
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Subscribe on start before "
+				"Features read]",
+			test_setup_rap, test_client_rap, &cfg_rap_early_ensure,
+			ATTACH_FEATURES_REALTIME, WRITE_CCCD(0x06, 0x01));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Disabled mode kept on start]",
+			test_setup_rap, test_client_rap, &cfg_rap_disabled,
+			ATTACH_FEATURES_REALTIME);
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Selected mode resubscribed]",
+			test_setup_rap, test_client_rap, &cfg_rap_resubscribe,
+			ATTACH_FEATURES_REALTIME, WRITE_CCCD(0x06, 0x02),
+			WRITE_CCCD(0x06, 0x00), WRITE_CCCD(0x06, 0x02));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Retry after rejected CCCD]",
+			test_setup_rap, test_client_rap, &cfg_rap_retry,
+			ATTACH_FEATURES_REALTIME,
+			IOV_DATA(0x12, 0x06, 0x00, 0x01, 0x00),
+			IOV_DATA(0x01, 0x12, 0x06, 0x00, 0x03),
+			WRITE_CCCD(0x06, 0x00),
+			WRITE_CCCD(0x06, 0x01));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Real-time timeout when enabled "
+				"mid-procedure]",
+			test_setup_rap, test_client_rap, &cfg_rap_rt_midproc,
+			ATTACH_FEATURES_REALTIME, WRITE_CCCD(0x06, 0x01),
+			WRITE_CCCD(0x06, 0x00));
+
 	/* RAS Ranging Counters are per connection */
 	tester_add("RAS/SR/RCO/Ranging Counters per connection", &cnt_data,
 			NULL, test_counters, cnt_teardown);
-- 
2.56.0

