Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193728;
	b=kjftKR7fIxI5BaamMWXZ3nneSQMUcPgSt/Y3N5i3XhthXSi68UGegQ7rDDzO5G6AEjMZ
	 vbZqzjyl1GwBB+h/BRd2oDl30I32kH4p3yhiRlZhPEvEvSgP+Rm8mDEmD41E3NQDTgeZa
	 ABAhZPSGjO+hdQ8WBiDemgn2XgJGV7x6R+ednAKoPV35fhdW7W/RifUZwz/IvaidrDvAr
	 opJ51puy2BbhbL7812mQ04yGZ/knb2JKrjpq3j22A7lwvaP7JW/ZKL9SMeAquszAtqKH6
	 CECBl98B8DEIFy2kfWQ8VUX9UFaftYstEjexltEcbbiuor2bZNGt1SHBGBqsTOX+0mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ocT/ALRl7jR61+X7ccIOVm/vDx+W362kKFs63Eufw8k=;
	b=ElpSjzdrDGo+mkHdCYbMblzqui8X3QJ4weFLPThzWkL7ynmet6IBE8c77ub3GG7K48lx
	 LtVrfkutVb7LOPSUliz449cBl2WKJSdOqvs62KaXoTnfKGHXvWOjJz1Ww52JZ+stRLlhS
	 qTZ+O31ASGKxN8GyqaSptIHVrOlE8/uk1D5/BSN1/v7FBZN2KbmLS5SHwmdjpOpZzcGva
	 iZTjYApomfilLVmuvD9HHOJnCIaX09de00Jr9fNhp2hUkJW/XLBl24XpUbbRpSwWqPBGV
	 HDtm1qJrgLabP9wT0is3yx76hOxR59qc/ShzBdgFAn2LzS/nLCGRUGK7JLWVMJb+VCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8VNZA8F;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDE60A2606
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2EDE60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8VNZA8F
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso380324e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193727; x=1795798527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ocT/ALRl7jR61+X7ccIOVm/vDx+W362kKFs63Eufw8k=;
        b=F8VNZA8FWJP1VzE1w4mAwQJMUwTiayn3zgTzYUEUVKNAzIaeJqvKaLRxwkBR/J+qwW
         29U3uvCcVTzR9hSywIkjTdfnwsqV3AbVp56nripqA+2uSCcQo5YjOrOFoIsOjBm2nBUO
         V/9wPW2xX3F0rvSc0akZQa2DJ/9XdQuh2PwdISrms73c8M+jTtYy6N95FooLlRqwtKcX
         YRr5rjkVI+5QQfB6t5PxX35mdZDQXO6XisbTgqQJVcJmX6Y2HKDMOiDTA45d/jATHA6p
         uTD8UWHZRBECHL0Li7LCmW0Fno2b2kGG2GyzhyTt4Bx1GcSd8mmzJFL/ZU5Tjm3BvTwQ
         m3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193727; x=1795798527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ocT/ALRl7jR61+X7ccIOVm/vDx+W362kKFs63Eufw8k=;
        b=AM6KdNsOjr5miQYcCH3pxopbp0UxV5Yi4BvTo4+rUbbJVSSBvK7E7NRee4e1sTFBSL
         pURtgYawIszVPGs3b+tGtapeTlblBX6Uq8HsZSQ3bcfiKk2Hb3PUfGTBEO8jESsEip8z
         CvitDyOoNVNrkIpfdXYx+AqwSaPO5MzTZKunzW6Cqy+mIS55y/GiUZJmdMZgkARNIffC
         YS3uipJGLo6+khQmNNkW3n00nWFubVy/I/OqBdJGnrRt7TCbORvUd4a8MSrpuSOUsH2b
         9nbut1pw9qhq46QR6QyPSLuEnHbjn+Ksl/TLvkiD3/sakRlhWG+q8mI9ZzdB1dN/1Pnc
         Uyew==
X-Gm-Message-State: APuU4Z8KfWCIFkh/5ceZ1dthu4R7qOTX9WAi+FEPDWKGtyGXo2CCGhWv
	5zEGC/VRg2sHAsLee4/GRPUV8TXgCn1KSlidWCcIYtwuTm4Mj0qTN0qg4rs30L0c
X-Gm-Gg: AZFdTZch6XbSh5jb7MEZDvlHkumOKhZUaOxwdhwnFHP6tWnlde3fSfKRtq5l+qOfAtb
	+4Nfi5Zdb7ZNhZWjFI1YTosSV8hkrU+tvrfFzjjL/qNXzroyiSCDmEPBV/z2gHW5DXQ74ugBlsI
	vgWOb/4Crj2STAf7tctQdVzwH3b7XHj20Bdlf9yOr5PN4x6Ft3M44nRkRmfZmVamrtR8ONnRQG7
	UnRyebEed74lLq6B3xm7g4fOJn5ULAb2clOduy4WExE95bEbyzWnSGbn/o+rTGiYk09Rdaurg/o
	GtvHJu7MsLsbQjInuL3bjjUlvq9DzNRQcCR1MUrLS4HDPbwisscF4IGouG3pRAKjn+QjgAvmvw0
	W7rRf06q/ep46+jHYr7vhAUD2YEIdw/QxET7oHkdmrCfpK0uEkRAXrtlu3dWZWxq2ofOKtf+BpF
	hw6Wzu4Bt370gnm2D9NFvs9FNubqlLFVpqzeE5eEpMVZSjGbXT1Mq4fT3Kq9yP0NxoDQX0Xcyjs
	23A8FVDipZDdZ17SyKFwt/IOAy1Y3wzJWLHRz/bvZRz8DqnzjAPiQj08w1u10WqIcAUKixiglLR
	6MZUHphHYOViAPF7ac2Nj87GrUxoVISwGywBM0ZW9NYovcXintlMQGFtmVvHuPRIldW8+YdsDB5
	jFEd6EYh91FeoTRAELS2UJb6gcqQo1Z56qbv+2QMu03Zs/NFq/gj04OSaR1IcZuDvid55hhJq9F
	xoIMM=
X-Received: by 2002:a67:e713:0:b0:7cc:1192:563c with SMTP id ada2fe7eead31-7d7395edf5emr1531146137.25.1795193726598;
        Fri, 20 Nov 2026 08:55:26 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 18/18] shared/rap: Defer Ranging Data mode selection until Features is read
Date: Fri, 20 Nov 2026 11:55:08 -0500
Message-ID: <20261120165510.1858959-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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
  again on the next start.
- Forget a notification registration the peer rejected and drop its
  handler, so that a later start retries it.
- Arm the first Real-time data timeout when Real-time is enabled while a
  procedure is already running.

Assisted-by: Claude:claude-sonnet-5-5
---
 src/shared/rap.c | 100 ++++++++++++++++++++++++++++++++++++++++++++---
 unit/test-rap.c  |  97 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 6 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index d4ce1751f052..3aecd4d40231 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -480,6 +480,10 @@ struct bt_rap {
 	unsigned int ready_notify_id;
 	unsigned int overwritten_notify_id;
 	uint32_t ras_features;
+	bool features_read;	/* RAS Features read completed */
+	bool ensure_pending;	/* ensure_ranging_data() waits for it */
+	bool mode_selected;	/* SetRangingDataMode() called, even Disabled */
+	bool proc_enabled;	/* a CS procedure is running */
 
 	/* Responder role: Ranging Counters read back through Ranging Data
 	 * Ready and Overwritten, scoped to this connection (RAS v1.0, 3.4
@@ -999,6 +1003,10 @@ void bt_rap_detach(struct bt_rap *rap)
 	rap->cp_notify_id = 0;
 	rap->ready_notify_id = 0;
 	rap->overwritten_notify_id = 0;
+	rap->features_read = false;
+	rap->ensure_pending = false;
+	rap->mode_selected = false;
+	rap->proc_enabled = false;
 
 	bt_att_unregister_disconnect(rap->att, rap->disconn_id);
 	rap->att = NULL;
@@ -3357,7 +3365,9 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
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
@@ -3530,14 +3540,68 @@ static void rap_read_value(struct bt_rap *rap, uint16_t value_handle,
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
+
+	if (!att_ecode)
+		return;
 
-	if (att_ecode)
-		DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
+	DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
 
-	(void)notify;
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
@@ -4651,6 +4715,14 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
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
 
@@ -4695,7 +4767,7 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport)
 {
-	if (!rap || !rap->client || !rap->ras_features)
+	if (!rap || !rap->client || !rap->features_read)
 		return false;
 
 	if (mode == BT_RAP_RANGING_DATA_REALTIME &&
@@ -4713,6 +4785,7 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 
 	rap->realtime_ccc_value = transport;
 	rap->ondemand_ccc_value = transport;
+	rap->mode_selected = true;
 
 	return rap_subscribe_ranging_data(rap, mode);
 }
@@ -4724,8 +4797,16 @@ bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
 	if (!rap || !rap->client)
 		return false;
 
-	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+	/* An explicit selection stands, Disabled included */
+	if (rap->mode_selected || rap->realtime_notify_id ||
+					rap->ondemand_notify_id)
+		return true;
+
+	/* Which mode the peer supports is only known once Features is read */
+	if (!rap->features_read) {
+		rap->ensure_pending = true;
 		return true;
+	}
 
 	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
 	 * Ranging Data is optional for the RRSP, so fall back to On-demand
@@ -4785,6 +4866,7 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	if (ras)
 		ras->client.abort_operation = abort_operation;
 	rap->ras_features = features;
+	rap->features_read = true;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
@@ -4802,6 +4884,12 @@ static void read_ras_features(struct bt_rap *rap, bool success,
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
index a1655640d41c..725aec7eee50 100644
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
@@ -1121,12 +1126,63 @@ static void action_ondemand_indicate(struct bt_rap *rap)
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
@@ -1204,6 +1260,27 @@ const struct test_config_rap cfg_rap_rt_timeout = {
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
@@ -1497,6 +1574,26 @@ int main(int argc, char *argv[])
 			test_setup_rap, test_client_rap, &cfg_rap_ensure,
 			RAP_REQ_ORD_ROUND(0x01));
 
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Subscribe on start before "
+				"Features read]",
+			test_setup_rap, test_client_rap, &cfg_rap_early_ensure,
+			ATTACH_FEATURES_REALTIME, WRITE_CCCD(0x06, 0x01));
+	define_test_rap("RAP/REQ/RRD/BV-01-C [Disabled mode kept on start]",
+			test_setup_rap, test_client_rap, &cfg_rap_disabled,
+			ATTACH_FEATURES_REALTIME);
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

