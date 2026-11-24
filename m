Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534755;
	b=e5ElJM8F834ebBiV2IVkjISfRpSTjIZ2fXaNVT+D2TY/A1MK9QEbvgvo1RhxDcnYpEQk
	 qaoF2xx/KCcuE7LyZcoAr5mqeqCnEkt8Rqx3L6r0eppbGse0iHMngqPAPk2N2uVbZm1PT
	 RQ+3D7VxtmH1lXzUGhojV8BpTs4K93s3BK0EoenU/t70UV0bmvzu96wOa+h94Tcym2C6r
	 1d1rTKyReqcCyRHchZZ7Lz9wImMExcVWlcOrIgBAviLMELy356VuAd5pQOhwsY1zKliPh
	 1kP9mfvqk2OX/pZ3sA5QnCYxKGGZPaihmVyr+KskcGJeWYR9chbkNpPMkl3fLN4ROkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3wiPbdugB1ArzJIouetPDfuhoOHHCe64/hIyko5cCF8=;
	b=Wxofl6rN3RN9Z0cf1e7aEd1ANUQ/fNR/gWgFv99Y1x1RAiTlEI0vKbz+8LOT4MMcxuqw
	 tHo42ySgN9go5EQmnA7RRehomLlWIFw6RmZ+Mv8wnSO/McXE60mRR7XTyGUiCHquItfSJ
	 PjqAKm/EpTS9Veo7DTU772AA5tHJtrc8dofU+xjuySiFzlODgNKQ8OeTmMjUJkTFkRgtv
	 o8KCIhAkgASyBCkkMq/+IGazFGLHz8O4LAuaJMOtNX8/RAjAcJAdTX3puE3pQdw+T2yVm
	 N5anLUT3hrwQgTqtXo3Rgjrj1LdzETsFB1yfugA3yu9+y8aTxSRRZbrfjmEd/wI6Bcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iaeXOdzN;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED5606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3ED5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iaeXOdzN
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ec6f271883so2841128e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534754; x=1796139554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3wiPbdugB1ArzJIouetPDfuhoOHHCe64/hIyko5cCF8=;
        b=iaeXOdzNTX0Uktmf7Q3gYuAuxAPaF/B4i8cnSKkQI8v4Es+tSqQSeSWfa+vwMbAqOF
         FhsRkmXh4eO0nBaAgpn2nwjiPuiMxB5Ny1W5TEqzlb5ucX2iiUnlueJ30jcw8JRytPSC
         WfQqOawyX00JX9FSmzgEh/90OBXEXvgEvOJgWGX8OIatpboZnAAD1mxKq49mKmI+XHGH
         q/FN/9FkjJLNofuElccLVAP+uVL/gbeDDStNhrfd4kRDIWQlR1vKhQGaZKnk6whEyo9r
         28wVgrMpSyXyXjfU2u8B3WHIOUBBCcv1Y+XvAzNCxI56gCCifEwhkPq8bjBjTiYrZkEE
         fxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534754; x=1796139554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3wiPbdugB1ArzJIouetPDfuhoOHHCe64/hIyko5cCF8=;
        b=ZpJyVTS96SBhjPVaPp38apFKCACc6ztGf48v40RpPq9IyGo2DPW1b/8xplWjzeJyK3
         lgannLHSAaq1JhX1c32UN/Pf2lDMt6vVVZMfixA8AN+bNUaVZrnDxJQ+sqlaukip5Gyh
         Cg3TXLJ0pEA7NXMU5OMdv5c9S2D7jns+PmyqCc9S04UCWhxvHD3DgthQ61LyR/PhOm38
         lNV6FGJGUXTE4OhcuielyP99ZohCqEHs+3cT43ysfGp/MTotQifRRwGMDgbXW8pIUqQJ
         eHaqcIaVKqyschPWlghvQTwXH8C7RaPoPBca2WkrhDpZ7ud87RXBRNBF5jCNBzTZ1P/j
         kFkw==
X-Gm-Message-State: APuU4Z98lBXgJKPVl1rBu1s6MMhlS/zDr+ABnB9jO89QUk2wpc+zF5oQ
	Kl9hSKSQfkdJyEkpB0nuTeC6g9OAZfO20cUyAkmueSjTYzrAtAyBDtX4S4JtBg==
X-Gm-Gg: AZFdTZdP4S8dOE7wa9VSeI8ArAltxqlteOO8Nx3sqVv62jWPJHv/rW7ps1Hwwl93LuO
	OzGzIIjHkc/7OdAAU4/fJO4eFdCthgBq35nLW/OphjMi3TJ33PYJgY9E8lNDyAKW3+MPV5V9j/y
	46iC6ogDUaxwCj7qpX7Sw5q2crnIO7VS0L7N+GXhqmwmlwv8nLH1VF8yRO0YRRhXcrqqKjB6ZFJ
	rVpe2mTOR4TsKOIe2TFUkeI/BlgL7ecsfRAiJ0EbYy2GDH/SVv0Y7oAyOqYWCD9LzV4fpoT1JbJ
	8Nn3vOAzanPS/BFUT/QcZh/GaeFQ6BbVowwEPV4Evpz+H/KRQTGvvPoMvl88iCU4MEwwMqyTaj2
	tSuFdiitZWvrd7h8w7r0Qsy3DVZc5+/J/lP171NKz69h7fSfPeI4MEcoQTDBNlDryBVXxtRTqTR
	7nnsvwoXLwNoUu/XRvvPpto1T8ddW3i8HsqSva0PV6KwxiU2uElHeLswB9zHKpa0jkjMKokpNtm
	/0WjIqOHD+F/gqKSe4zzYLUeeHp/Yth6ch4TsEfThsclZDv5Fnm/c7BzrdL/4JYCSuYo8gyTgwi
	3FnZslkL01kc1I78D3tPYIUjWXPQePKb31HyWs3rUBt6oAr/SoP8SN7E55D5UlT9vtGKn/+St2k
	Yt7nftlqAgXyOgn/PFm7oIL+inSCYR5ETFxy5LXMxpt0BgUijLCDPGsgyA2C7so0HEL1/9+plfP
	lutYE=
X-Received: by 2002:a05:6122:7cc:b0:5ea:b712:8281 with SMTP id 71dfb90a1353d-5ee8af2df64mr9269163e0c.18.1795534753510;
        Tue, 24 Nov 2026 07:39:13 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 17/18] unit/test-rap: Add tests for Ranging Data subscription and counters
Date: Tue, 24 Nov 2026 10:38:54 -0500
Message-ID: <20261124153856.216054-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

Add Requester tests for the Ranging Data subscriptions: nothing is
written when RAS Features is read, Real-time and On-demand CCCD values
for both transports, subscribing on start, and the 5 s Real-time timeout
running from CS Procedure Enable Complete rather than from the CCCD write.

Add a two-connection test that the Ranging Data Ready and Overwritten
counters are per connection.

Assisted-by: Claude:claude-sonnet-5-5
---
 unit/test-rap.c | 507 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 464 insertions(+), 43 deletions(-)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index 338f0babf2a4..a1655640d41c 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -49,6 +49,10 @@ struct test_data_ras {
 struct test_config_rap {
 	const struct iovec *setup_data;
 	const size_t setup_data_len;
+	/* Run once the Requester is ready; when NULL the test passes there */
+	void (*action)(struct bt_rap *rap);
+	/* Called when the ATT script is exhausted; NULL leaves it to action */
+	void (*complete)(const void *user_data);
 };
 
 struct test_data_rap {
@@ -180,6 +184,57 @@ static void gatt_notify_cb(struct gatt_db_attribute *attrib,
 		printf("%s: Failed to send notification\n", __func__);
 }
 
+static void inject_proc_enable(struct bt_rap *rap)
+{
+	struct rap_ev_cs_proc_enable_cmplt ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.conn_hdl = 0x0001;
+	ev.config_id = 0x01;
+	ev.state = 0x01;
+
+	bt_rap_hci_cs_procedure_enable_complete_callback(sizeof(ev), &ev, rap);
+}
+
+static void inject_cs_result(struct bt_rap *rap, uint16_t proc_counter)
+{
+	size_t event_size = sizeof(struct rap_ev_cs_subevent_result) +
+			    sizeof(struct cs_step_data);
+	struct rap_ev_cs_subevent_result *fake_event;
+	struct cs_mode_zero_data *mode_zero;
+
+	if (tester_use_debug())
+		tester_debug("Injecting fake CS data...");
+
+	fake_event = g_malloc0(event_size);
+
+	fake_event->conn_hdl = 0x0001;
+	fake_event->config_id = 0x01;
+	fake_event->start_acl_conn_evt_counter = 0x0000;
+	fake_event->proc_counter = proc_counter;
+	fake_event->freq_comp = 0x0000;
+	fake_event->ref_pwr_lvl = 0x00;
+	fake_event->proc_done_status = 0x00;
+	fake_event->subevt_done_status = 0x00;
+	fake_event->abort_reason = 0x00;
+	fake_event->num_ant_paths = 0x01;
+	fake_event->num_steps_reported = 0x01;
+
+	fake_event->step_data[0].step_mode = CS_MODE_ZERO;
+	fake_event->step_data[0].step_chnl = 0x00;
+	/* Mode 0: 1+1+1+4 bytes */
+	fake_event->step_data[0].step_data_length = 4;
+	mode_zero = &fake_event->step_data[0].step_mode_data.mode_zero_data;
+	mode_zero->packet_quality = 0x01;
+	mode_zero->packet_rssi_dbm = 0x02;
+	mode_zero->packet_ant = 0x03;
+	mode_zero->init_measured_freq_offset = 0x04;
+
+	bt_rap_hci_cs_subevent_result_callback(event_size, fake_event, rap);
+
+	g_free(fake_event);
+}
+
 static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
@@ -220,48 +275,8 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 	/* If notifications/indications enabled on Real-time Ranging Data CCCD,
 	 * inject fake HCI CS subevent data to trigger notifications
 	 */
-	if (handle == 0x0006 && ccc_value != 0x0000 && data->rap) {
-		size_t event_size = sizeof(struct rap_ev_cs_subevent_result) +
-				    sizeof(struct cs_step_data);
-		struct rap_ev_cs_subevent_result *fake_event;
-		struct cs_mode_zero_data *mode_zero;
-
-		if (tester_use_debug())
-			tester_debug("Injecting fake CS data...");
-
-		fake_event = g_malloc0(event_size);
-		if (!fake_event)
-			return;  /* Already sent write response */
-
-		/* Fill in the header fields */
-		fake_event->conn_hdl = 0x0001;
-		fake_event->config_id = 0x01;
-		fake_event->start_acl_conn_evt_counter = 0x0000;
-		fake_event->proc_counter = 0x0001;
-		fake_event->freq_comp = 0x0000;
-		fake_event->ref_pwr_lvl = 0x00;
-		fake_event->proc_done_status = 0x00;
-		fake_event->subevt_done_status = 0x00;
-		fake_event->abort_reason = 0x00;
-		fake_event->num_ant_paths = 0x01;
-		fake_event->num_steps_reported = 0x01;
-
-		fake_event->step_data[0].step_mode = CS_MODE_ZERO;
-		fake_event->step_data[0].step_chnl = 0x00;
-		/* Mode 0: 1+1+1+4 bytes */
-		fake_event->step_data[0].step_data_length = 4;
-mode_zero = &fake_event->step_data[0].step_mode_data.mode_zero_data;
-		mode_zero->packet_quality = 0x01;
-		mode_zero->packet_rssi_dbm = 0x02;
-		mode_zero->packet_ant = 0x03;
-		mode_zero->init_measured_freq_offset = 0x04;
-
-		/* Inject the fake event to trigger notification */
-		bt_rap_hci_cs_subevent_result_callback(event_size, fake_event,
-						       data->rap);
-
-		g_free(fake_event);
-	}
+	if (handle == 0x0006 && ccc_value != 0x0000 && data->rap)
+		inject_cs_result(data->rap, 0x0001);
 	return;
 
 done:
@@ -413,6 +428,13 @@ static void test_setup_rap(const void *user_data)
 
 static void rap_client_ready_cb(struct bt_rap *rap, void *user_data)
 {
+	struct test_data_rap *data = user_data;
+
+	if (data->cfg->action) {
+		data->cfg->action(rap);
+		return;
+	}
+
 	tester_test_passed();
 }
 
@@ -432,7 +454,7 @@ static void test_client_rap(const void *user_data)
 	io = tester_setup_io(data->iov, data->iovcnt);
 	g_assert(io);
 
-	tester_io_set_complete_func(NULL);
+	tester_io_set_complete_func(data->cfg->complete);
 
 	data->db = gatt_db_new();
 	g_assert(data->db);
@@ -1001,6 +1023,372 @@ const struct test_config_rap cfg_cggit_discovery = {
 	IOV_DATA(0x0a, 0x09, 0x00), \
 	IOV_DATA(0x0b, 0x01, 0x00)
 
+/*
+ * Requester subscription behavior (RAP v1.0 4.4)
+ *
+ * Remote handles: Real-time CCCD 0x0006, On-demand CCCD 0x0009, RAS Control
+ * Point CCCD 0x000c, Ranging Data Ready CCCD 0x000f, Ranging Data Overwritten
+ * CCCD 0x0012.
+ */
+#define ATTACH_FEATURES_REALTIME \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x00, 0x00, 0x00)
+
+/* Abort supported, Real-time not */
+#define ATTACH_FEATURES_ONDEMAND \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x04, 0x00, 0x00, 0x00)
+
+#define WRITE_CCCD(handle, value) \
+	IOV_DATA(0x12, handle, 0x00, value, 0x00), \
+	IOV_DATA(0x13)
+
+static gboolean idle_pass_cb(gpointer user_data)
+{
+	tester_test_passed();
+	return FALSE;
+}
+
+static gboolean realtime_disable_cb(gpointer user_data)
+{
+	bt_rap_disable_realtime_ranging(user_data);
+	return FALSE;
+}
+
+/* Reading RAS Features must not subscribe by itself: nothing is written
+ * until the Upper Tester asks for Ranging Data (RAP/REQ/RRD/BV-01-C).
+ */
+static void action_idle(struct bt_rap *rap)
+{
+	g_timeout_add(300, idle_pass_cb, NULL);
+}
+
+static void action_realtime_notify(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_NOTIFY));
+	g_timeout_add(200, realtime_disable_cb, rap);
+}
+
+static void action_realtime_indicate(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_INDICATE));
+	g_timeout_add(200, realtime_disable_cb, rap);
+}
+
+/* StartMeasurement() with the peer supporting Real-time subscribes to it */
+static void action_ensure(struct bt_rap *rap)
+{
+	g_assert(bt_rap_ensure_ranging_data(rap));
+}
+
+static void action_ondemand_notify(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_ONDEMAND,
+				BT_RAP_RANGING_NOTIFY));
+}
+
+static void action_ondemand_indicate(struct bt_rap *rap)
+{
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_ONDEMAND,
+				BT_RAP_RANGING_INDICATE));
+}
+
+#define RAP_REQ_RRD_NO_SUBSCRIBE \
+	ATTACH_FEATURES_REALTIME
+
+#define RAP_REQ_RRD_ROUND(value) \
+	ATTACH_FEATURES_REALTIME, \
+	WRITE_CCCD(0x06, value), \
+	WRITE_CCCD(0x06, 0x00)
+
+#define RAP_REQ_RRD_ENSURE \
+	ATTACH_FEATURES_REALTIME, \
+	WRITE_CCCD(0x06, 0x01)
+
+/* On-demand: the data characteristic follows the requested transport, the
+ * Control Point, Ranging Data Ready and Overwritten are indicated.
+ */
+#define RAP_REQ_ORD_ROUND(value) \
+	ATTACH_FEATURES_ONDEMAND, \
+	WRITE_CCCD(0x09, value), \
+	WRITE_CCCD(0x0c, 0x02), \
+	WRITE_CCCD(0x0f, 0x02), \
+	WRITE_CCCD(0x12, 0x02)
+
+const struct test_config_rap cfg_rap_idle = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_idle,
+};
+
+const struct test_config_rap cfg_rap_rt_notify = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_realtime_notify,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_rt_indicate = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_realtime_indicate,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_ensure = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_ensure,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_od_notify = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_ondemand_notify,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_od_indicate = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_ondemand_indicate,
+	.complete = test_complete_cb,
+};
+
+/*
+ * The 5 s wait for the first Real-time Ranging Data starts with the CS
+ * procedure (RAP v1.0 4.4.1.1), not with the CCCD write: the CCCD is disabled
+ * 5 s after Procedure Enable Complete, which is injected after the write.
+ */
+
+static gint64 proc_enable_time;
+
+static gboolean inject_proc_enable_cb(gpointer user_data)
+{
+	proc_enable_time = g_get_monotonic_time();
+	inject_proc_enable(user_data);
+	return FALSE;
+}
+
+static void action_realtime_timeout(struct bt_rap *rap)
+{
+	proc_enable_time = 0;
+
+	g_assert(bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_NOTIFY));
+	g_timeout_add(300, inject_proc_enable_cb, rap);
+}
+
+static void realtime_timeout_complete(const void *user_data)
+{
+	/* Disabled no earlier than 5 s after Procedure Enable Complete */
+	if (!proc_enable_time ||
+	    g_get_monotonic_time() - proc_enable_time < 4900 * 1000)
+		tester_test_failed();
+	else
+		tester_test_passed();
+}
+
+const struct test_config_rap cfg_rap_rt_timeout = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_realtime_timeout,
+	.complete = realtime_timeout_complete,
+};
+
+/*
+ * RAS Ranging Data Ready/Overwritten reads report the counters of the
+ * connection they are read on (RAS v1.0, 3.4 and 3.5).
+ */
+#define RAS_CONNS	2
+
+struct cnt_op {
+	int conn;
+	enum { CNT_READ, CNT_WRITE, CNT_INJECT } type;
+	uint16_t handle;
+	uint16_t value;
+};
+
+struct test_data_cnt {
+	struct test_data_ras ras;
+	struct bt_att *satt[RAS_CONNS];
+	struct bt_att *catt[RAS_CONNS];
+	struct bt_gatt_server *server[RAS_CONNS];
+	struct bt_gatt_client *client[RAS_CONNS];
+	struct gatt_db *cdb[RAS_CONNS];
+	unsigned int ready;
+	unsigned int step;
+};
+
+static struct test_data_cnt cnt_data;
+
+static const struct cnt_op cnt_ops[] = {
+	/* Fresh connections report no counter */
+	{ 0, CNT_READ, 0x000e, 0 },
+	{ 1, CNT_READ, 0x000e, 0 },
+	{ 0, CNT_READ, 0x0011, 0 },
+	{ 1, CNT_READ, 0x0011, 0 },
+	/* Connection 0 selects On-demand and two procedures complete on it,
+	 * the second one overwriting the first.
+	 */
+	{ 0, CNT_WRITE, 0x0009, 0x0001 },
+	{ 0, CNT_INJECT },
+	/* Only connection 0 sees the counters */
+	{ 0, CNT_READ, 0x000e, 2 },
+	{ 1, CNT_READ, 0x000e, 0 },
+	{ 0, CNT_READ, 0x0011, 1 },
+	{ 1, CNT_READ, 0x0011, 0 },
+};
+
+static void cnt_teardown(const void *user_data)
+{
+	struct test_data_cnt *data = (void *)user_data;
+	int i;
+
+	for (i = 0; i < RAS_CONNS; i++) {
+		bt_gatt_client_unref(data->client[i]);
+		bt_gatt_server_unref(data->server[i]);
+		bt_att_unref(data->satt[i]);
+		bt_att_unref(data->catt[i]);
+		gatt_db_unref(data->cdb[i]);
+	}
+
+	gatt_db_unref(data->ras.db);
+	bt_rap_unregister(data->ras.ras_id);
+	queue_destroy(data->ras.ccc_states, free);
+
+	tester_teardown_complete();
+}
+
+static void cnt_next(struct test_data_cnt *data);
+
+static void cnt_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct test_data_cnt *data = user_data;
+	const struct cnt_op *op = &cnt_ops[data->step];
+
+	g_assert(success);
+	g_assert_cmpuint(length, ==, 2);
+	g_assert_cmpuint(get_le16(value), ==, op->value);
+
+	data->step++;
+	cnt_next(data);
+}
+
+static void cnt_write_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	struct test_data_cnt *data = user_data;
+
+	g_assert(success);
+
+	data->step++;
+	cnt_next(data);
+}
+
+static void cnt_next(struct test_data_cnt *data)
+{
+	const struct cnt_op *op;
+	uint8_t value[2];
+	struct bt_rap *rap;
+
+	if (data->step == ARRAY_SIZE(cnt_ops)) {
+		tester_test_passed();
+		return;
+	}
+
+	op = &cnt_ops[data->step];
+
+	switch (op->type) {
+	case CNT_READ:
+		g_assert(bt_gatt_client_read_value(data->client[op->conn],
+					op->handle, cnt_read_cb, data, NULL));
+		break;
+	case CNT_WRITE:
+		put_le16(op->value, value);
+		g_assert(bt_gatt_client_write_value(data->client[op->conn],
+					op->handle, value, sizeof(value),
+					cnt_write_cb, data, NULL));
+		break;
+	case CNT_INJECT:
+		rap = bt_rap_get_session(data->satt[op->conn], data->ras.db);
+		g_assert(rap);
+		inject_proc_enable(rap);
+		inject_cs_result(rap, 0x0001);
+		inject_cs_result(rap, 0x0002);
+		data->step++;
+		cnt_next(data);
+		break;
+	}
+}
+
+static void cnt_client_ready_cb(bool success, uint8_t att_ecode,
+							void *user_data)
+{
+	struct test_data_cnt *data = user_data;
+
+	g_assert(success);
+
+	if (++data->ready == RAS_CONNS)
+		cnt_next(data);
+}
+
+static void test_counters(const void *user_data)
+{
+	struct test_data_cnt *data = (void *)user_data;
+	int i;
+
+	data->ras.db = gatt_db_new();
+	g_assert(data->ras.db);
+
+	gatt_db_ccc_register(data->ras.db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+					gatt_notify_cb, &data->ras);
+
+	bt_rap_add_db(data->ras.db);
+
+	data->ras.ras_id = bt_rap_register(ras_attached, ras_detached,
+								&data->ras);
+	data->ras.ccc_states = queue_new();
+
+	for (i = 0; i < RAS_CONNS; i++) {
+		int sv[2];
+
+		g_assert(socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0,
+								sv) == 0);
+
+		data->satt[i] = bt_att_new(sv[0], false);
+		data->catt[i] = bt_att_new(sv[1], false);
+		g_assert(data->satt[i] && data->catt[i]);
+
+		bt_att_set_close_on_unref(data->satt[i], true);
+		bt_att_set_close_on_unref(data->catt[i], true);
+		bt_att_set_security(data->satt[i], BT_ATT_SECURITY_MEDIUM);
+
+		data->server[i] = bt_gatt_server_new(data->ras.db,
+						data->satt[i], 64, 0);
+		g_assert(data->server[i]);
+
+		data->cdb[i] = gatt_db_new();
+		data->client[i] = bt_gatt_client_new(data->cdb[i],
+						data->catt[i], 64, 0);
+		g_assert(data->client[i]);
+
+		bt_gatt_client_ready_register(data->client[i],
+				cnt_client_ready_cb, data, NULL);
+	}
+
+	/* Notifications go out through the first connection */
+	data->ras.server = data->server[0];
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -1080,5 +1468,38 @@ int main(int argc, char *argv[])
 			test_setup_rap, test_client_rap,
 			&cfg_cggit_discovery, RAP_CL_CGGIT_CHA_BV_06_C);
 
+	/* RAP Requester Ranging Data subscriptions */
+	define_test_rap("RAP/REQ/RRD/BV-01-C [No subscription at attach]",
+			test_setup_rap, test_client_rap, &cfg_rap_idle,
+			RAP_REQ_RRD_NO_SUBSCRIBE);
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Real-time Notification]",
+			test_setup_rap, test_client_rap, &cfg_rap_rt_notify,
+			RAP_REQ_RRD_ROUND(0x01));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Real-time Indication]",
+			test_setup_rap, test_client_rap, &cfg_rap_rt_indicate,
+			RAP_REQ_RRD_ROUND(0x02));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Subscribe on start]",
+			test_setup_rap, test_client_rap, &cfg_rap_ensure,
+			RAP_REQ_RRD_ENSURE);
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Real-time timeout from "
+				"Procedure Enable]",
+			test_setup_rap, test_client_rap, &cfg_rap_rt_timeout,
+			ATTACH_FEATURES_REALTIME, WRITE_CCCD(0x06, 0x01),
+			WRITE_CCCD(0x06, 0x00));
+	define_test_rap("RAP/REQ/ORD/BV-01-C [On-demand Notification]",
+			test_setup_rap, test_client_rap, &cfg_rap_od_notify,
+			RAP_REQ_ORD_ROUND(0x01));
+	define_test_rap("RAP/REQ/ORD/BV-01-C [On-demand Indication]",
+			test_setup_rap, test_client_rap, &cfg_rap_od_indicate,
+			RAP_REQ_ORD_ROUND(0x02));
+	define_test_rap("RAP/REQ/ORD/BV-01-C [Subscribe on start without "
+				"Real-time support]",
+			test_setup_rap, test_client_rap, &cfg_rap_ensure,
+			RAP_REQ_ORD_ROUND(0x01));
+
+	/* RAS Ranging Counters are per connection */
+	tester_add("RAS/SR/RCO/Ranging Counters per connection", &cnt_data,
+			NULL, test_counters, cnt_teardown);
+
 	return tester_run();
 }
-- 
2.56.0

