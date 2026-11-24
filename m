Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534756;
	b=YcE8G2yv5ahRoFlQtKFRIIKwXFJukYA4rwoXGGvaLZipVxbAGtn2lxLCknBELZIz1cLv
	 E9iB5570YP8C/bP9r4bNWPs9w9fZol1UAAsyY9PaGDRU78wgOH+GQMWc89Ee+rznqWbOX
	 ogxa0lQhhYtjYsEsWArfZY2SJ8T3VpbsdLrWwrgg3RBoKGats4i+3zbaGWejZ3RxCPGp3
	 JQl3oS49YlsH/xaZvo+JD5MFMO0N51mU0o4lh7+7BRdSgHryLsRzyxk1oE9BtF3Mifqmj
	 bE8Lg7YPblK6c5CWFNAtaYa7Vufc83q31yQWSZin4Qxs6IISwg5wCyK+ziiQO1QVA/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kfl/Tnr/Uk5fxS/oQCHEqAcUD7xHq0sIA+symXG51Tk=;
	b=JarVAM+NsPVgKgnE0v77FSJjrAVpYWh0dLB2/0M2tcks7VHulvldvolntvSO1rjbph1m
	 Jm+PpayKGGvVOH8zPLq4vUDhqzE4828r6vFUFnMFQH14DQxt7Zt5ka4w/bltn1OxO42Am
	 w4vCD/NoZCrXkmWANg8sOzVfQ2+O3BOKNwJj4TPJ7TfzTvjqMWVw8n+6NknWXHE11Me4j
	 7AOplLu7LqWla/tbjRP+EGFCQK2pDF92p9h+tiCz0HvRcs6fL2eT48u2LK19FPyqVDjk1
	 L6klTtDgEX1M1VqB9Bs/hfuch4ulFLQqfZpjGCxiNCXYj+pDgeMgBNHUZ0+FU99YpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJmjOcT1;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F7606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC2F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJmjOcT1
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99071945aa7so2613664241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534755; x=1796139555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kfl/Tnr/Uk5fxS/oQCHEqAcUD7xHq0sIA+symXG51Tk=;
        b=cJmjOcT1g/jRZj2NGTN10f8jtMoJortEjfwNmG0rR3dsxSVx9YCdvFA10cxupGpbq/
         D8IzNqZVGLcq2ne6WophWSQVlWxPmywDm2OK9/YN7tZ7Yu7MAY55hhJI201rM2Rvbn0m
         qz9tbMDXi/DsoDHs8glD6RhVd4XlGSCI4HM+gyGs4zbnujo92lEG2cDZYnydcO3h3tvv
         tu5fAAzqaA/0Bsq+SthXR0ddufEKZzrlnWHXkzkbDBbY8jue8SVOpHovgVa53kVxkTOU
         yLpLHI+lz+3/PxdWg8Hlh5lpgkAl+AeYQLabYJMyOvIIGHm5E+O/41Xgdk9+DlT5HRRk
         MdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534755; x=1796139555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kfl/Tnr/Uk5fxS/oQCHEqAcUD7xHq0sIA+symXG51Tk=;
        b=HyCUhPhRRi4B+rg3Lnu/fv8pXv8emBDn52KbiSodzZTcMBYeuFzj41HIGvRBJ8Aifq
         NnAqMiE9IQgDkSZAbE51Jl40FQ8KG7g+2RCgH2xNCy80l2ga0feEERN04CFpitYDx02F
         g8+jGywDjqY6rSPGtmimVla5oZUDIPA1vtyP/OGXyJsZbTZiu2qCl8PqlLLQEX62Lh2c
         C21zTHGxTAF47eLaWl6qvnxJKXlETGt2r8k1kVC4NLsEcOJ/gvLpw328XduVQE9V694M
         qy8G7ITbFfwxl3+guwbWPr3X5CQC4Abqo/H2Svqm/bsmwLlrdj+HIcOmcYmbfpG39O60
         cC6g==
X-Gm-Message-State: APuU4Z8Y29B8NdldfihyZeGjdOjSBtWfli1OhbHglD9KaY0BSjG2bk3L
	iRhPv5rifwuLievnHsLUnqs7IlbaES9HuMYJaTZvzlKPC1aNhwS0xhg2ukf63Q==
X-Gm-Gg: AZFdTZexJV4YyW6tLnGylT1fLhA24iaUzuEZ7UxdfLJm7GAxYE43LjkGnsDuA+A4xqn
	qFUnOL1Ur3qvj3UEhIg8ROD+2w/IF3caqTT8cVIb0+Shu673BeKOENG917SOkkIf+FS+mupl+i5
	v2Rv33+sRSs/30o53sDAaAbp1Qsk2Zpm/xqB/lB56385oKA7G+j2wg8NY904FyCuIWa9/+8fXX0
	TaD/VpQAl7gNzUyxZ3sp/XtXVZE06mPADX/sE7JburaL/9ffW/HYJnfT94mxa2SYtBwlkyk0d5x
	b6CbzqMYToIFejzE3xDdLWm8sj6JfA/TGaqKVdg6AkndkizilXxJ69auTKl53HyghdoMo3xMfyh
	QjnupF/mzizgdtkf9TYI3lByZoiCNGmivkOmLqdGUCIBtwtrHB2yfzNP6Ska0f4sS+b0l5YN0hk
	1saOH+NGvY153ZlfnP9lG6/2yJe1AVf+E90iw3NNRbPAfvtsbwmri0i21T/wnRcNhC28byCkrOX
	xP+fpVxCnUFPUncpK+FZ4Ovo8JfSyNC3nU5mgzj+qExGTq5jOwFL9WteEySI+S/czB11XlXzbr6
	Wnau39/5YlKlHiaXJlgLC9EpUAp4JY9kxsBvywsgUTjv89jHq2MlyvC9KCIDF6GIns6cdWbcpi4
	5vgnVlwDDN4SpGBNndNPxDWv17r6MvxIXB3XePL+nlSfJzW9oF6TInQoXJUkDp6c+5ldcS5cbYJ
	mrPOE=
X-Received: by 2002:a05:6122:e1aa:b0:5ea:e052:2ef0 with SMTP id 71dfb90a1353d-5ee8af38c92mr7985193e0c.9.1795534754477;
        Tue, 24 Nov 2026 07:39:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 18/18] shared/rap: Defer Ranging Data mode selection until Features is read
Date: Tue, 24 Nov 2026 10:38:55 -0500
Message-ID: <20261124153856.216054-19-luiz.dentz@gmail.com>
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

- Wait for the RAS Features read before choosing a mode in
  bt_rap_ensure_ranging_data(), since a zero value also means the read
  has not completed.
- Keep an explicit SetRangingDataMode(Disabled) instead of subscribing
  again on the next start, and subscribe a selected mode again with its
  transport when its subscription ended with the last measurement. A
  selection is only remembered once it took effect.
- Make only the On-demand registrations that are missing, so a repeated
  subscription retries the failed ones without registering the others
  twice.
- Forget a notification registration the peer rejected and drop its
  handler, so that a later start retries it.
- Arm the first Real-time data timeout when Real-time is enabled while a
  procedure is already running.

Assisted-by: Claude:claude-sonnet-5-5
---
 src/shared/rap.c | 177 +++++++++++++++++++++++++++++++++++++++--------
 unit/test-rap.c  | 169 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+), 29 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index d4ce1751f052..c0466e5cd827 100644
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
+
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
 
-	(void)notify;
+	if (!timeout_add(0, rap_failed_notify_cb, failed,
+					rap_failed_notify_free))
+		rap_failed_notify_free(failed);
 }
 
 static void rap_notify(uint16_t value_handle, const uint8_t *value,
@@ -4651,11 +4716,20 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
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
 
 	if (mode == BT_RAP_RANGING_DATA_ONDEMAND) {
 		uint16_t value_handle;
+		bool ready_new = false;
 
 		/* Only the data characteristic follows the requested
 		 * transport (RAS v1.0 Table 3.1). The RAS Control Point can
@@ -4663,22 +4737,33 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		 * Overwritten are indicated whenever the server supports it,
 		 * since a server may send them only as indications.
 		 */
-		rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
-			rap->ondemand_ccc_value, ras_segment_notify_cb,
-			"on-demand", &rap->ondemand_notify_id);
-		rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
-			BT_RAP_RANGING_INDICATE, ras_cp_response_notify_cb,
-			"RAS Control Point", &rap->cp_notify_id);
-		rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
-			rap_status_ccc(ras->ready_chrc),
-			ras_data_ready_notify_cb,
-			"Ranging Data Ready", &rap->ready_notify_id);
-		rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
-			rap_status_ccc(ras->overwritten_chrc),
-			ras_data_overwritten_notify_cb,
-			"Ranging Data Overwritten",
-			&rap->overwritten_notify_id);
-		if (ras->ready_chrc &&
+		/* Only the registrations still missing are made, so this can
+		 * be repeated to retry the ones that failed or were rejected
+		 * without registering the others twice.
+		 */
+		if (!rap->ondemand_notify_id)
+			rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
+				rap->ondemand_ccc_value, ras_segment_notify_cb,
+				"on-demand", &rap->ondemand_notify_id);
+		if (!rap->cp_notify_id)
+			rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
+				BT_RAP_RANGING_INDICATE,
+				ras_cp_response_notify_cb,
+				"RAS Control Point", &rap->cp_notify_id);
+		if (!rap->ready_notify_id) {
+			ready_new = true;
+			rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
+				rap_status_ccc(ras->ready_chrc),
+				ras_data_ready_notify_cb,
+				"Ranging Data Ready", &rap->ready_notify_id);
+		}
+		if (!rap->overwritten_notify_id)
+			rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
+				rap_status_ccc(ras->overwritten_chrc),
+				ras_data_overwritten_notify_cb,
+				"Ranging Data Overwritten",
+				&rap->overwritten_notify_id);
+		if (ready_new && ras->ready_chrc &&
 			gatt_db_attribute_get_char_data(ras->ready_chrc, NULL,
 						&value_handle, NULL, NULL,
 						NULL))
@@ -4695,7 +4780,7 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport)
 {
-	if (!rap || !rap->client || !rap->ras_features)
+	if (!rap || !rap->client || !rap->features_read)
 		return false;
 
 	if (mode == BT_RAP_RANGING_DATA_REALTIME &&
@@ -4714,7 +4799,14 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 	rap->realtime_ccc_value = transport;
 	rap->ondemand_ccc_value = transport;
 
-	return rap_subscribe_ranging_data(rap, mode);
+	/* Only a selection that took effect is kept for later starts */
+	if (!rap_subscribe_ranging_data(rap, mode))
+		return false;
+
+	rap->mode_selected = true;
+	rap->selected_mode = mode;
+
+	return true;
 }
 
 bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
@@ -4724,17 +4816,37 @@ bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
 	if (!rap || !rap->client)
 		return false;
 
-	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+	/* An explicit selection stands, Disabled included. */
+	if (rap->mode_selected &&
+			rap->selected_mode == BT_RAP_RANGING_DATA_DISABLED)
 		return true;
 
-	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
-	 * Ranging Data is optional for the RRSP, so fall back to On-demand
-	 * when it is not supported (RAP v1.0 4.4.2).
-	 */
-	if (rap->ondemand_mode || !(rap->ras_features & 0x01))
+	/* Which mode the peer supports is only known once Features is read */
+	if (!rap->features_read) {
+		rap->ensure_pending = true;
+		return true;
+	}
+
+	if (rap->mode_selected) {
+		mode = rap->selected_mode;
+	} else if (rap->realtime_notify_id) {
+		return true;
+	} else if (rap->ondemand_mode || !(rap->ras_features & 0x01)) {
+		/* The RREQ has to enable one of the two (RAP v1.0 4.4).
+		 * Real-time Ranging Data is optional for the RRSP, so fall
+		 * back to On-demand when it is not supported (RAP v1.0 4.4.2).
+		 */
 		mode = BT_RAP_RANGING_DATA_ONDEMAND;
-	else
+	} else {
 		mode = BT_RAP_RANGING_DATA_REALTIME;
+	}
+
+	/* A mode whose subscription ended with the last measurement (stop or
+	 * timeout) or was rejected is subscribed again with its transport;
+	 * the On-demand subscription only makes the registrations missing.
+	 */
+	if (mode == BT_RAP_RANGING_DATA_REALTIME && rap->realtime_notify_id)
+		return true;
 
 	return rap_subscribe_ranging_data(rap, mode);
 }
@@ -4785,6 +4897,7 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 	if (ras)
 		ras->client.abort_operation = abort_operation;
 	rap->ras_features = features;
+	rap->features_read = true;
 
 	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
 	    supports_realtime ? "Yes" : "No",
@@ -4802,6 +4915,12 @@ static void read_ras_features(struct bt_rap *rap, bool success,
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
index a1655640d41c..a14536a665ea 100644
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
@@ -1121,12 +1126,118 @@ static void action_ondemand_indicate(struct bt_rap *rap)
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
+/* A selection that could not be made is not remembered: Real-time is not
+ * supported here, so the next start falls back to On-demand.
+ */
+static void action_failed_selection(struct bt_rap *rap)
+{
+	g_assert(!bt_rap_set_ranging_data_mode(rap,
+				BT_RAP_RANGING_DATA_REALTIME,
+				BT_RAP_RANGING_NOTIFY));
+	g_assert(bt_rap_ensure_ranging_data(rap));
+}
+
+/* One of the On-demand registrations is rejected: the next start retries
+ * that one only, without registering the others again.
+ */
+static void action_ondemand_retry(struct bt_rap *rap)
+{
+	g_assert(bt_rap_ensure_ranging_data(rap));
+	g_timeout_add(300, retry_ensure_cb, rap);
+}
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
+const struct test_config_rap cfg_rap_failed_sel = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_failed_selection,
+	.complete = test_complete_cb,
+};
+
+const struct test_config_rap cfg_rap_od_retry = {
+	.setup_data = cggit_setup_data,
+	.setup_data_len = ARRAY_SIZE(cggit_setup_data),
+	.action = action_ondemand_retry,
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
@@ -1204,6 +1315,27 @@ const struct test_config_rap cfg_rap_rt_timeout = {
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
@@ -1497,6 +1629,43 @@ int main(int argc, char *argv[])
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
+	define_test_rap("RAP/REQ/ORD/BV-01-C [Failed selection not kept]",
+			test_setup_rap, test_client_rap, &cfg_rap_failed_sel,
+			RAP_REQ_ORD_ROUND(0x01));
+	define_test_rap("RAP/REQ/ORD/BV-01-C [Retry rejected registration]",
+			test_setup_rap, test_client_rap, &cfg_rap_od_retry,
+			ATTACH_FEATURES_ONDEMAND,
+			WRITE_CCCD(0x09, 0x01),
+			IOV_DATA(0x12, 0x0c, 0x00, 0x02, 0x00),
+			IOV_DATA(0x01, 0x12, 0x0c, 0x00, 0x03),
+			WRITE_CCCD(0x0f, 0x02), WRITE_CCCD(0x12, 0x02),
+			IOV_DATA(0x0a, 0x0e, 0x00),
+			IOV_DATA(0x0b, 0x00, 0x00),
+			WRITE_CCCD(0x0c, 0x00), WRITE_CCCD(0x0c, 0x02));
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

