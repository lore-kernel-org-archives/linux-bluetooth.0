Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456301;
	b=s5Me4W2tTTjg8J+zUp1GEfgMuCvIIM/3+fYwkGjCHrOpcqE0XGmbM1v7iyAaLLlIs048
	 FoajfIXGMD2+QjzKwOhIEsNY8m2rqpo3RJbVHge62BCbKaeg//a3pKXHHDx88mzhzpExF
	 k5QpTg2IWP7QAKAme4wdYinws01EVv7KZdo1UwzeLfp8ffFl8/PxDyj8vp9eOn450Nroc
	 lRidp2iYvwSji4mmxKjmWYFrPVvzNDR59G6B7WaOKWpQ95VXD16NtUD9iTIwKFyZeyeJ+
	 1vcPYFvxxyBCnxvfpQR+6wOPWl7sl/OME7r3OcjN7JSqrow/lnLnVAmr3+Y2a92bD3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/dQi6NHOzIa1HSfoj1sL7q5WIGNsIYW3mYBwwv6a2bw=;
	b=d3oVUJBUv7UMw9gWSFLWx0i86m96jdEtwu2GMIKX/8Pf5zdi7Ey9wqozbEmvwYMeOWgk
	 BNLXUUITG023jqSpUjtVBeglNNcq5AMvqEf8POfqsDSxF0f4eUlUO6e9kMgjHjB/zk5wp
	 AYVxv18b7HpgEIShye5p/Jk3Pk3+1BKVNwzA/L6erRbnLhG5R9kzCBEkaBC+cJ/QCm2ip
	 DVGxPd8wpi7jCT9O0ajDZudAghiG/+ucrDBSxfKi1HE/ypHn/ySt1GIqAoqWMW0/nkJV4
	 YTergX5M3cBnTU2dNz0nQU+gmXY0QkEX6XVcg6XHkCJoD4RECm7eJ0rR0KPHftRGDrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+1jFqv8;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61188606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61188606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+1jFqv8
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so1319696241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456299; x=1796061099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dQi6NHOzIa1HSfoj1sL7q5WIGNsIYW3mYBwwv6a2bw=;
        b=z+1jFqv8zd8p6Fe9tWUy4z1IjLzZVAHdzoP2IXd8B8cYYwmewGdUa774gDEgmf0CPP
         nRZo7ZV+BPD534vcgWTjdB4wvwxgjdDhV12svWMCKZ7mrmfNZiQlvJNZHHURUOkmLgrW
         CAuc1XpJMcAp2inI8EofQTxdykp2/OE6fWFjzAq/YpMiUWkCXSgpWUKaadVg1C2Fc3ur
         90ZnqJH+C6f045kdDLgkvDCvnp/aJ20ocp9O/9QFlrTgqIuCVq603+X7OH5ahp6RKo4J
         /HVH2raa/OB8GTkkxc4mFVBFjlmkRxTq9RBHiD4ZK1lzEHwi4BBv33+DjMtHGLJVih48
         EvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456299; x=1796061099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/dQi6NHOzIa1HSfoj1sL7q5WIGNsIYW3mYBwwv6a2bw=;
        b=fxx/RtiWRLoyD+QjXC5WjkQ3R4Pa5I9SkEHeWURaU0K386xM4DCIn7ndL3OKc96qUY
         LGcrYd5la3aYZIRDzIsnHbrTkz+rPeCoqscqS986vnyjgb2YiI3+JC4HadMYoB6RI+in
         6Tj7ZzKUqggSHqrt42Rc+8IKNsTuqSHGCEOK/sXJalLlwWbaGnf4hwY0A/OKorMewQp+
         tPHBkYhVUE3uDYshiDhAU0hvhVHioqhO3Yr5S9KaUNsEk+rVUxWShDdHj7QYywJT7Qjg
         CjgEAgh2vmnooLf41pNCjoRDRnVAEUsPKJj3B02Thuz3JNGJXKqr8FpdMf+FfXE5RNzt
         lhgQ==
X-Gm-Message-State: APuU4Z/SVo5O2U9x3fWl5Uqs1vYCgax+K28knY6j2ZfA+awzZV6vSlb8
	C2dYt8/aymVAYSJKt9nlgrhUFpRpJcJkWbaU9ud7JcuZhbawoaqpPt/DQTbTxQ==
X-Gm-Gg: AZFdTZdri1bZ55HCrm1dQMbnxjrIFkAmTXxa7u48KzMSe8MIsMFZTHBaurugHiIP0zH
	OasUYRgwxAP9BRYhdaUf/g+g9hLq3koHBaxrdnjrvlnovee6PlF0fTc7z99ULCGN312YMUlZiNp
	9C+6C2e6p/rzfVbSRFFl7JoidvvjPEGFExLPJcYm1DDW10Q0koKO6Hpji2565t2vHSlmkJ2ctFE
	KH1KmMpsC+gmxJupXw6TwZkGnIYdOYrQqn1CDjxjrIr4h+TZoFRBJAE2UnLNmHsXxQNfhxDulRE
	mh4u9eLXaNobe/eHnABCE98VUMPcKUI5S/+weK7vh9s4PHIpXlWK/rdWv23b8litUMKUxS8zX11
	zsal4t9i7OP7NYGq8QIPeDWncs43OkIxPWmtsDVfNZPWLHb1F+0pfdogDST01QKVW98FW2Mh01O
	vtYl6S9FFJdHFCASnZCEwlsYPTGFIvcp6wctQ/Yx/+9k9ATc75+9660R2j90bELjw1E4KPGnuQB
	dWkm3aoe6k11nC2/CBIRZwwkVBbfWrtwlPK71DxCiLRqwI1gKx1i06B/84imUjrmu0awVCDP1d+
	LASy5aV7W9ELRK52W9ehVvGvkLe1ZWLvFtH5RD8k7n1XbKbKjr9Rn6G3bqUPay9/kD18/puF04t
	GklKM0b7KDNztPKxW7rupg1OHxfjlg8blgO3ttjtoYDIpYO5CPXOGXGkiE8fCPWRRuJDuiDGDgQ
	XrXF0=
X-Received: by 2002:a05:6102:54a2:b0:7d6:2c4a:469 with SMTP id ada2fe7eead31-7d7396849camr6299286137.33.1795456298833;
        Mon, 23 Nov 2026 09:51:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 15/18] profiles/ranging: Keep CS sessions apart from stale and unrelated events
Date: Mon, 23 Nov 2026 12:51:18 -0500
Message-ID: <20261123175125.3642617-16-luiz.dentz@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

- Filter Procedure Enable Complete, Remote Capabilities, Remote FAE
  and Config Complete by the connection of the state machine, and decode
  the little-endian event handle before the lookup.
- Use the configuration ID chosen by the peer in the commands that follow
  its Config Complete, and clear the role, the pending Security Enable
  and the running procedure when the configuration is removed.
- Tie Read Local Capabilities and Set Default Settings responses to the
  session that sent them, and do not let the Procedure Enable Complete
  of a disable sent before a restart move the new session to STOPPED.
- Ignore Config Complete and Procedure Enable Complete of a stopped
  session until StartMeasurement() is called again.
- Defer Set Procedure Parameters until both capability reads are in when
  a peer-created configuration finishes Security Enable first.
- Stop a running Reflector procedure by removing the configuration and
  report failure if that cannot be done.
- Decide the Reflector session from the negotiated role, ignore the
  duration for a Reflector-only request, and run the same cleanup when a
  session ends by timeout or by the end of the remote procedure.

Assisted-by: Claude:claude-sonnet-5-5
---
 profiles/ranging/rap.c     |  61 +++++---
 profiles/ranging/rap_hci.c | 285 ++++++++++++++++++++++++++++++-------
 src/shared/rap.h           |   5 +
 3 files changed, 282 insertions(+), 69 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 8f99572574c0..c4fac3cb1926 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -55,6 +55,8 @@ struct cs_session {
 	struct bt_rap_le_cs_frequency freq;
 };
 
+#define CS_ROLE_REFLECTOR	0x02  /* Role_Enable: Reflector only */
+
 struct rap_data {
 	struct btd_device *device;
 	struct btd_service *service;
@@ -847,6 +849,12 @@ bad_type:
 	 * acts on the remote Initiator's events; rap_def_settings_done_cb()
 	 * leaves Create Config to the Initiator.
 	 */
+	/* A Reflector only waits for the remote Initiator, so its duration
+	 * is ignored rather than ending the wait.
+	 */
+	if (settings.role == CS_ROLE_REFLECTOR)
+		duration_secs = 0;
+
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
@@ -864,6 +872,24 @@ bad_type:
 	return dbus_message_new_method_return(msg);
 }
 
+/* Common end of a session, however it ends: explicit stop, duration expiry or
+ * the end of the remote procedure a Reflector was armed for.
+ */
+static void rap_end_session(struct rap_data *data)
+{
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
+
+	/* The Requester owns the Real-time CCCD subscription. Unregister it
+	 * when the procedure ends so the peer receives the required CCCD
+	 * disable. The local procedure has already been stopped, so a failure
+	 * here (e.g. no remote RAS client) must not fail the caller.
+	 */
+	if (!bt_rap_disable_realtime_ranging(data->rap))
+		DBG("Unable to disable Real-time Ranging Data");
+
+	memset(&data->active_session, 0, sizeof(data->active_session));
+}
+
 static DBusMessage *stop_measurement(DBusConnection *conn,
 				DBusMessage *msg, void *user_data)
 {
@@ -878,17 +904,7 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
 					"Stop measurement failed");
 
-	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
-
-	/* The Requester owns the Real-time CCCD subscription. Unregister it
-	 * when the procedure ends so the peer receives the required CCCD
-	 * disable. The local procedure has already been stopped, so a failure
-	 * here (e.g. no remote RAS client) must not fail the method.
-	 */
-	if (!bt_rap_disable_realtime_ranging(data->rap))
-		DBG("Unable to disable Real-time Ranging Data");
-
-	memset(&data->active_session, 0, sizeof(data->active_session));
+	rap_end_session(data);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device_get_path(data->device),
@@ -937,7 +953,19 @@ static const GDBusMethodTable cs_dbus_methods[] = {
 	{ }
 };
 
-#define CS_ROLE_INITIATOR	0x01
+/* The role negotiated for the current configuration decides, since the
+ * allowed-role setting can permit both. Until a configuration exists, only a
+ * Reflector-only setting makes this a Reflector session.
+ */
+static bool rap_is_reflector_session(struct rap_data *data)
+{
+	uint8_t role;
+
+	if (bt_rap_get_cs_role(data->hci_sm, &role))
+		return role == CS_REFLECTOR;
+
+	return data->active_session.settings.role == CS_ROLE_REFLECTOR;
+}
 
 static gboolean cs_property_get_active(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
@@ -948,8 +976,7 @@ static gboolean cs_property_get_active(const GDBusPropertyTable *property,
 	/* A Reflector session is only armed while waiting for the peer, so
 	 * only report the procedure state for it.
 	 */
-	if (data->active_session.active &&
-	    (data->active_session.settings.role & CS_ROLE_INITIATOR))
+	if (data->active_session.active && !rap_is_reflector_session(data))
 		active = true;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &active);
@@ -970,7 +997,7 @@ static void rap_measurement_timeout_cb(void *user_data)
 {
 	struct rap_data *data = user_data;
 
-	memset(&data->active_session, 0, sizeof(data->active_session));
+	rap_end_session(data);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device_get_path(data->device),
@@ -987,9 +1014,9 @@ static void rap_proc_active_changed(bool active, void *user_data)
 	 * refuse to replace and StopMeasurement() could not be reached for.
 	 */
 	if (!active && data->active_session.active &&
-	    !(data->active_session.settings.role & CS_ROLE_INITIATOR)) {
+	    rap_is_reflector_session(data)) {
 		bt_rap_stop_measurement(data->hci_sm);
-		memset(&data->active_session, 0, sizeof(data->active_session));
+		rap_end_session(data);
 	}
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8dbb6b847c11..d8109669e947 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -74,6 +74,10 @@ struct cs_state_machine {
 	bool initiator;
 	bool procedure_active;
 	bool stop_requested;  /* StopMeasurement() since StartMeasurement() */
+	unsigned int session_gen;  /* Bumped by every Start/StopMeasurement() */
+	bool disable_pending;  /* Procedure Enable (disable) not yet reported */
+	bool stale_disable;  /* ... and a new session started meanwhile */
+	bool proc_setup_pending;  /* Procedure setup waits for capabilities */
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
@@ -390,6 +394,33 @@ static bool cs_local_is_initiator(const struct cs_state_machine *sm)
 	return sm->role_enable & CS_ROLE_ENABLE_INITIATOR;
 }
 
+struct cs_cmd_ctx {
+	struct cs_state_machine *sm;
+	unsigned int gen;
+};
+
+static void rap_resume_proc_setup(struct cs_state_machine *sm);
+
+/* Tie a command response to the session that sent it, so the response of a
+ * session that was stopped and restarted meanwhile cannot act on the new one.
+ */
+static struct cs_cmd_ctx *cs_cmd_ctx_new(struct cs_state_machine *sm)
+{
+	struct cs_cmd_ctx *ctx = new0(struct cs_cmd_ctx, 1);
+
+	ctx->sm = sm;
+	ctx->gen = sm->session_gen;
+
+	return ctx;
+}
+
+static void cs_set_procedure_active(struct cs_state_machine *sm, bool active)
+{
+	sm->procedure_active = active;
+	if (sm->proc_active_func)
+		sm->proc_active_func(active, sm->proc_active_data);
+}
+
 /* Helper function to send read remote capabilities for all connections */
 static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
 		uint16_t handle)
@@ -426,12 +457,18 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 					void *user_data)
 {
 	const struct bt_hci_rsp_le_cs_rd_loc_supp_cap *rsp;
-	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
+	struct cs_cmd_ctx *ctx = user_data;
+	struct cs_state_machine *sm = ctx ? ctx->sm : NULL;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_rsp_le_cs_rd_loc_supp_cap))
 		return;
 
+	if (ctx->gen != sm->session_gen) {
+		DBG("Local capabilities of a previous session, ignoring");
+		return;
+	}
+
 	DBG("size=0x%02X", size);
 
 	rsp = (const struct bt_hci_rsp_le_cs_rd_loc_supp_cap *) data;
@@ -478,6 +515,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 	DBG("Sending read remote capabilities for handle 0x%04X",
 		sm->active_conn_handle);
 	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
+
+	rap_resume_proc_setup(sm);
 }
 
 static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
@@ -535,11 +574,17 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 					void *user_data)
 {
 	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
-	struct cs_state_machine *sm = user_data;
+	struct cs_cmd_ctx *ctx = user_data;
+	struct cs_state_machine *sm = ctx ? ctx->sm : NULL;
 
 	if (!sm || !data || size < sizeof(*rp))
 		return;
 
+	if (ctx->gen != sm->session_gen) {
+		DBG("Def settings response of a previous session, ignoring");
+		return;
+	}
+
 	DBG("size=0x%02X", size);
 
 	rp = (const struct bt_hci_rsp_le_cs_set_def_settings *) data;
@@ -580,7 +625,7 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 }
 
-static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
+static bool rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 						uint16_t handle)
 {
 	struct bt_hci_cmd_le_cs_remove_config cmd;
@@ -588,7 +633,7 @@ static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 
 	if (!sm || !sm->hci) {
 		error("CS Remove Config: sm or hci is null");
-		return;
+		return false;
 	}
 
 	DBG("Sending CS Remove Config command for handle 0x%04X", handle);
@@ -603,10 +648,11 @@ static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 	if (!status) {
 		error("Failed to send CS Remove Config command");
 		cs_set_state(sm, CS_STATE_HOLD);
-		return;
+		return false;
 	}
 
 	DBG("CS Remove Config command sent successfully");
+	return true;
 }
 
 static void rap_send_hci_cs_security_enable_command(
@@ -838,7 +884,7 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS,
 				&cp, sizeof(cp), rap_def_settings_done_cb,
-				sm, NULL);
+				cs_cmd_ctx_new(sm), free);
 
 	DBG("sending set default settings case, status : %d", status);
 
@@ -869,12 +915,13 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
+	DBG("status=0x%02X, handle=0x%04X", evt->status,
+		le16_to_cpu(evt->handle));
 
 	/* Every state machine on this adapter sees every CS event, so ignore
 	 * the ones for other links before acting on the status.
 	 */
-	if (!find_mapping_by_handle(sm, evt->handle)) {
+	if (!find_mapping_by_handle(sm, le16_to_cpu(evt->handle))) {
 		DBG("Not for this link, ignoring");
 		return;
 	}
@@ -964,12 +1011,13 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
+	DBG("status=0x%02X, handle=0x%04X", evt->status,
+		le16_to_cpu(evt->handle));
 
 	/* Every state machine on this adapter sees every CS event, so do not
 	 * let another link's capabilities overwrite this one's.
 	 */
-	if (!find_mapping_by_handle(sm, evt->handle)) {
+	if (!find_mapping_by_handle(sm, le16_to_cpu(evt->handle))) {
 		DBG("Not for this link, ignoring");
 		return;
 	}
@@ -1006,14 +1054,21 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 
 	bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
 
+	rap_resume_proc_setup(sm);
+
+	if (sm->stop_requested) {
+		DBG("Measurement stopped, not continuing setup");
+		return;
+	}
+
 	/* Check Bit 1 of subfeatures_supported (0x0002) */
 	if (!(subfeatures_supported & 0x0002)) {
 		DBG("Bit 1 not set, sending Read Remote FAE Table");
-		bt_rap_read_remote_fae_table(sm, evt->handle);
+		bt_rap_read_remote_fae_table(sm, le16_to_cpu(evt->handle));
 		return;
 	}
 
-	DBG("send def settings for 0x%04X", evt->handle);
+	DBG("send def settings for 0x%04X", le16_to_cpu(evt->handle));
 	rap_send_hci_def_settings_command(sm, evt);
 }
 
@@ -1042,13 +1097,14 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
+	DBG("status=0x%02X, handle=0x%04X", evt->status,
+		le16_to_cpu(evt->handle));
 
 	/* Every state machine on this adapter sees every CS event, so ignore
 	 * the ones for other links: acting on them would overwrite this
 	 * link's negotiated role and advance its state.
 	 */
-	mapping = find_mapping_by_handle(sm, evt->handle);
+	mapping = find_mapping_by_handle(sm, le16_to_cpu(evt->handle));
 	if (!mapping) {
 		DBG("Not for this link, ignoring");
 		return;
@@ -1060,6 +1116,24 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 */
 	if (evt->status == 0 && evt->action == 0x00) {
 		DBG("Config %u removed", evt->config_id);
+
+		if (!sm->cs_role_known ||
+				evt->config_id == sm->cs_config.config_id) {
+			cs_set_state(sm, CS_STATE_UNSPECIFIED);
+			sm->sec_enable_pending = false;
+			sm->proc_setup_pending = false;
+			if (sm->procedure_active)
+				cs_set_procedure_active(sm, false);
+			sm->cs_role_known = false;
+		}
+		return;
+	}
+
+	/* StartMeasurement() has to be called again after a stop before a
+	 * configuration of the peer is acted on.
+	 */
+	if (sm->stop_requested) {
+		DBG("Measurement stopped, ignoring Config Complete");
 		return;
 	}
 
@@ -1092,7 +1166,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 			/* Create/update failed — try to remove the config */
 			error("Configuration failed with status 0x%02X",
 				evt->status);
-			rap_send_hci_cs_remove_config_command(sm, evt->handle);
+			rap_send_hci_cs_remove_config_command(sm,
+						le16_to_cpu(evt->handle));
 		} else {
 			error("CS Config Remove failed with status 0x%02X",
 				evt->status);
@@ -1103,7 +1178,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	/* Copy fields to rap_ev structure */
 	rap_ev.status = evt->status;
-	rap_ev.conn_hdl = cpu_to_le16(evt->handle);
+	rap_ev.conn_hdl = evt->handle;
 	rap_ev.config_id = evt->config_id;
 	rap_ev.action = evt->action;
 	rap_ev.main_mode_type = evt->main_mode_type;
@@ -1138,6 +1213,10 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
+	/* The peer picks the configuration ID of the ones it creates, and the
+	 * commands that follow have to address that one.
+	 */
+	sm->cs_config.config_id = rap_ev.config_id;
 	sm->cs_role = rap_ev.role;
 	sm->cs_role_known = true;
 	sm->cs_opt.rtt_type = rap_ev.rtt_type;
@@ -1176,7 +1255,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 			(mapping->att && bt_att_get_security(mapping->att,
 					NULL) >= BT_ATT_SECURITY_MEDIUM)) {
 		DBG("Central,encrypted: Sending CS Security Enable command");
-		rap_send_hci_cs_security_enable_command(sm, evt->handle);
+		rap_send_hci_cs_security_enable_command(sm,
+						le16_to_cpu(evt->handle));
 	} else {
 		DBG("Central, not yet encrypted: deferring CS Security Enable");
 		sm->sec_enable_pending = true;
@@ -1219,6 +1299,40 @@ static const uint8_t encrypt_evts[] = {
 	BT_HCI_EVT_ENCRYPT_CHANGE_V3,
 };
 
+static bool rap_start_procedure(struct cs_state_machine *sm, uint16_t handle)
+{
+	DBG("Initiator role: Sending CS Set Procedure Params");
+	if (!rap_send_hci_cs_set_procedure_parameters(sm, handle)) {
+		error("Failed to send CS Set Procedure Params");
+		return false;
+	}
+
+	DBG("Initiator role: Sending CS Procedure Enable");
+	if (!rap_send_hci_cs_procedure_enable(sm, handle, true)) {
+		error("Failed to send CS Procedure Enable");
+		return false;
+	}
+
+	return true;
+}
+
+static void rap_resume_proc_setup(struct cs_state_machine *sm)
+{
+	if (!sm->proc_setup_pending || !sm->local_caps_known ||
+						!sm->remote_caps_known)
+		return;
+
+	sm->proc_setup_pending = false;
+
+	if (sm->stop_requested || !sm->cs_role_known ||
+			sm->cs_role != CS_INITIATOR ||
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT)
+		return;
+
+	if (!rap_start_procedure(sm, sm->active_conn_handle))
+		cs_set_state(sm, CS_STATE_HOLD);
+}
+
 static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 					 void *user_data)
 {
@@ -1283,18 +1397,14 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 				return;
 			}
 
-			DBG("Initiator role: Sending CS Set Procedure Params");
-			if (!rap_send_hci_cs_set_procedure_parameters(
-							sm, handle)) {
-				error("Failed to send CS Set Procedure Params");
-				cs_set_state(sm, CS_STATE_HOLD);
-				return;
-			}
-
-			DBG("Initiator role: Sending CS Procedure Enable");
-			if (!rap_send_hci_cs_procedure_enable(sm, handle,
-								      true)) {
-				error("Failed to send CS Procedure Enable");
+			/* A peer-created configuration can get here while the
+			 * capability reads of StartMeasurement() are still in
+			 * flight. They resume the setup when they complete.
+			 */
+			if (!sm->local_caps_known || !sm->remote_caps_known) {
+				DBG("Capabilities pending, deferring setup");
+				sm->proc_setup_pending = true;
+			} else if (!rap_start_procedure(sm, handle)) {
 				cs_set_state(sm, CS_STATE_HOLD);
 				return;
 			}
@@ -1346,22 +1456,50 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
+	DBG("status=0x%02X, handle=0x%04X", evt->status,
+		le16_to_cpu(evt->handle));
+
+	/* Every state machine on this adapter sees every CS event, so ignore
+	 * the ones for other links.
+	 */
+	if (!find_mapping_by_handle(sm, le16_to_cpu(evt->handle))) {
+		DBG("Not for this link, ignoring");
+		return;
+	}
+
+	/* The report of a disable sent by a session that has been restarted
+	 * since belongs to that session: it ends the procedure, but must not
+	 * move the new session's setup to STOPPED.
+	 */
+	if (sm->stale_disable && (evt->status != 0 || evt->state == 0x00)) {
+		DBG("Procedure disabled for a previous session");
+		sm->stale_disable = false;
+		if (sm->procedure_active)
+			cs_set_procedure_active(sm, false);
+		return;
+	}
+
+	if (evt->status != 0 || evt->state == 0x00)
+		sm->disable_pending = false;
+
+	/* A stopped session does not start a procedure again by itself */
+	if (evt->status == 0 && evt->state == 0x01 && sm->stop_requested) {
+		DBG("Measurement stopped, ignoring Procedure Enable Complete");
+		return;
+	}
 
 	/* Check status */
 	if (evt->status != 0) {
 		error("Procedure enable failed with status 0x%02X",
 			evt->status);
 		cs_set_state(sm, CS_STATE_HOLD);
-		sm->procedure_active = false;
-		if (sm->proc_active_func)
-			sm->proc_active_func(false, sm->proc_active_data);
+		cs_set_procedure_active(sm, false);
 		return;
 	}
 
 	/* Copy fields to rap_ev structure */
 	rap_ev.status = evt->status;
-	rap_ev.conn_hdl = cpu_to_le16(evt->handle);
+	rap_ev.conn_hdl = evt->handle;
 	rap_ev.config_id = evt->config_id;
 	rap_ev.state = evt->state;
 	rap_ev.tone_ant_config_sel = evt->tone_antenna_config_selection;
@@ -1383,14 +1521,10 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 	/* Success - procedure started */
 	if (rap_ev.state == 0x01) {
 		cs_set_state(sm, CS_STATE_STARTED);
-		sm->procedure_active = true;
-		if (sm->proc_active_func)
-			sm->proc_active_func(true, sm->proc_active_data);
+		cs_set_procedure_active(sm, true);
 	} else if (rap_ev.state == 0x00) {
 		cs_set_state(sm, CS_STATE_STOPPED);
-		sm->procedure_active = false;
-		if (sm->proc_active_func)
-			sm->proc_active_func(false, sm->proc_active_data);
+		cs_set_procedure_active(sm, false);
 	}
 
 	/* Send callback to RAP Profile */
@@ -1426,12 +1560,14 @@ static void rap_le_conn_update_complete_evt(const void *data, uint8_t size,
 	if (evt->status != 0)
 		return;
 
-	mapping = find_mapping_by_handle(sm, evt->handle);
+	mapping = find_mapping_by_handle(sm, le16_to_cpu(evt->handle));
 	if (mapping && mapping->rap) {
-		DBG("Found handle 0x%04X in mapping cache", evt->handle);
+		DBG("Found handle 0x%04X in mapping cache",
+			le16_to_cpu(evt->handle));
 		rap = mapping->rap;
 	} else {
-		DBG("No RAP mapping for handle 0x%04X, ignoring", evt->handle);
+		DBG("No RAP mapping for handle 0x%04X, ignoring",
+			le16_to_cpu(evt->handle));
 		return;
 	}
 
@@ -1910,7 +2046,7 @@ static bool bt_rap_read_local_supported_capabilities(
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP,
 				NULL, 0, rap_rd_loc_supp_cap_done_cb,
-				sm, NULL);
+				cs_cmd_ctx_new(sm), free);
 
 	if (!status) {
 		error("Failed to send Read Local Supported Capabilities");
@@ -2037,6 +2173,7 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 {
 	struct cs_state_machine *sm = hci_sm;
 	enum cs_state state;
+	bool stale;
 
 	if (!sm || !sm->hci)
 		return false;
@@ -2046,8 +2183,21 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 		return false;
 	}
 
+	/* The disable of the previous session is still in flight: let its
+	 * report be recognized instead of applying it to this session.
+	 */
+	stale = sm->disable_pending;
+	if (stale) {
+		sm->stale_disable = true;
+		sm->disable_pending = false;
+	}
+
+	sm->session_gen++;
 	sm->active_conn_handle = conn_handle;
 	sm->stop_requested = false;
+	sm->proc_setup_pending = false;
+	sm->local_caps_known = false;
+	sm->remote_caps_known = false;
 
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
@@ -2059,12 +2209,13 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 	 * rewound by their completion. A configuration the peer already
 	 * created before this call (Config Complete does not wait for the
 	 * local setup phase) has moved the state past INIT: keep it, or the
-	 * events that follow would fail their state checks.
+	 * events that follow would fail their state checks. The state left by
+	 * a session whose disable is still outstanding is not one of those.
 	 */
 	state = cs_get_current_state(sm);
-	if (state == CS_STATE_WAIT_SEC_CMPLT ||
+	if (!stale && (state == CS_STATE_WAIT_SEC_CMPLT ||
 			state == CS_STATE_WAIT_PROC_CMPLT ||
-			state == CS_STATE_STARTED)
+			state == CS_STATE_STARTED))
 		DBG("Keeping %s from a peer-created configuration",
 			state_names[state]);
 	else
@@ -2091,6 +2242,8 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	 * keep it from creating a config or enabling a procedure.
 	 */
 	sm->stop_requested = true;
+	sm->proc_setup_pending = false;
+	sm->session_gen++;
 
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
@@ -2111,15 +2264,29 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	 * Only the Initiator enables a procedure, so the same holds for a
 	 * Reflector once the Initiator's procedure is running.
 	 */
-	if ((!sm->procedure_active &&
-			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) ||
-			!sm->cs_role_known || sm->cs_role != CS_INITIATOR) {
+	if (!sm->procedure_active &&
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
 		DBG("No local CS procedure active, nothing to disable");
 		return true;
 	}
 
-	return rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
-						false);
+	if (!sm->cs_role_known)
+		return true;
+
+	/* Only the Initiator enables and disables a procedure. A Reflector
+	 * can only end the remote one by removing the configuration.
+	 */
+	if (sm->cs_role != CS_INITIATOR)
+		return rap_send_hci_cs_remove_config_command(sm,
+						sm->active_conn_handle);
+
+	if (!rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
+						false))
+		return false;
+
+	sm->disable_pending = true;
+
+	return true;
 }
 
 bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
@@ -2174,9 +2341,23 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->sec_enable_pending = false;
 	sm->remote_caps_known = false;
 	sm->stop_requested = false;
+	sm->proc_setup_pending = false;
+	sm->disable_pending = false;
+	sm->stale_disable = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
+bool bt_rap_get_cs_role(void *hci_sm, uint8_t *role)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !sm->cs_role_known)
+		return false;
+
+	*role = sm->cs_role;
+	return true;
+}
+
 bool bt_rap_is_procedure_active(void *hci_sm)
 {
 	struct cs_state_machine *sm = hci_sm;
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7ff5de227d70..e7f616c74797 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -284,6 +284,11 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
 
 bool bt_rap_is_procedure_active(void *hci_sm);
 
+/* Negotiated CS role of the current configuration, once Config Complete has
+ * reported it. Returns false until then.
+ */
+bool bt_rap_get_cs_role(void *hci_sm, uint8_t *role);
+
 void bt_rap_set_timeout_cb(void *hci_sm, void (*func)(void *),
 				void *user_data);
 
-- 
2.56.0

