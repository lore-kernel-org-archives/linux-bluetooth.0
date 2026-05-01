Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D473CE4B5
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646346; cv=none; b=eCPrkPc7ae0yctGwDTrISlrASgwA5YYmHUS84TU7/JVL7uhqTQ34gJcKSwlFPbMOmfPjw7D9QFSgAZ4Sd5jfrvETzVxgC2+c7ob0PXnQhVqMZ+KOxuG230vJ9SWJBItz8TFO0ij8h4lI5t1MfHwX4BzvCNIC3IZEHe8hn5oMzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646346; c=relaxed/simple;
	bh=pn23PmPfkYa0pCIVyPR8g9x3sa5akLFS3vA9A64lpvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3qIoD/aK8XCzznegINdYAGTNKari8N9Xu/jz0RR9AFgXk2LUFzPR4fk/enhf+BdUn30VqH8E8eMyVaY3+HchuCL7e2z3qEDbM2CLbE0XMQE0zoQtXCWyA6yNp1eXc3u4aRQRRoBIkRfLP540bljK2BKy+sPDy+4GritpFJdNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hae0UA5f; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hae0UA5f"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-573a81abef0so1254376e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646340; x=1778251140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WSdSqJUzsIcg5N9jmyjCj22kSF6CuYnwGRuFZc8osU=;
        b=Hae0UA5fXjoY23dorFt0cD1lPEeEQ49biD9FSPw4csZtbv+1tUSz+U0n3jsVmShp/x
         WkcAespi4E9hIdjdi+rXVQAXP4CTAlTQZOwI9UqkOYIZKlcEZrBvBCpnYxjiNdMWKQ6T
         DUSHL25t+TxoNznxmc0l6nF9m0u4ls2MGOvvZESCgH/hHJv+JXlAB3OK8yP8vDLC8u7N
         wyesRqE/eOZ/eMVaXmi8NX0Fntiri3fHq04ZfmUHUrAV64BpfcZ9+uclxLdQquFgt6Oy
         i/1oiGyKUUnbJrG56Kn3ZyL6/lpBUBiEdmwevVqLNuQHF5D2aFsRYdL9jIAwqA7DRvI7
         fzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646340; x=1778251140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+WSdSqJUzsIcg5N9jmyjCj22kSF6CuYnwGRuFZc8osU=;
        b=AFo6vh2VbSRa4f1887WjQE633FHIJ20bnYRfImQ3Zz8l0BDHqnhQh7UDLoY/aUTEU/
         ZlpaMJJb/h/uOWGLK6NnIZKmngovJHgRBIDXAfTNGg6yEiaxD0cemTXvfisco+v+9cHe
         Wc6pDEYVGOnBSxqs54Vf6nnazl5mIQjJKOKyQbQ7RfVE1JVSphafpZrppVbt3qGPQSx/
         WheOlfsWyVD1dqKs9KQVviFaNWCVgMYleYg0UmFWjx3wwe8SjyT0ssYwRDZuzOTsLPsE
         MypNd3zlErlH0HrwapIlJ3KVNSRYYe28C5S1CekQY4b/MP1YDgf8GcGDq+j4u2z8787i
         WqdA==
X-Gm-Message-State: AOJu0YwmNYp9MGEjcXNC4R2S3bS4+jFArGz8QL1KwidSNv0FYZKnkepB
	nWOcaWQSi2FXsL7dEONTay6CSUCM6Ux3zdCNeoKtTpHB01BNdRPWsbAnl/rJChK5
X-Gm-Gg: AeBDiev/rjVIeRtRAYZkfBn4qWnENrSRAcjLChZMhRg6/vFM2kj3HD75PZZYtwRNo2J
	sYA7qQExr8mHDgm/zyGf/Ddc93VJuGqSYzh8nRLL1Wxyv+hJKEsOyDLsFYsmXIf8fUBmwh+5l3o
	QGuZmc+kljTFOqNccELwIDP6MqJST5uKjf+pANFQwFInJsgsAhz/hA/m/temW7AWtJvA6+ShgKS
	fv+CFO3CGLErOt2FISeLVsK58xI710YZbvPOV2uO/t7ePNTXIvPdd92mYg8lFKuk1YOxfd+HGnT
	xgfhbdeX91344ekQsDo/h+lszW4+qtZRa/KGYC7C9NW3nT4Xwb3xze3NoSlnTFBE68Wv0MFpUCz
	8xDN2/h6/pYdbjf4IrI6D6doA3cLe0zbmKt9bZv69Us2LTSPKvfLF66RDAHGVd7lyjhaOyF6Twz
	x/ne6gysNcQKuGXt7OTqasyPh+pQCeyMqk+ccnCVEynkXFrODZjkCD76rAFk4bQWT+f5+nP3WRR
	ib6r3/D64zsU5imzo34TMiHBQXF
X-Received: by 2002:a05:6122:a04:b0:567:44ba:bd8a with SMTP id 71dfb90a1353d-573c966ac03mr4341623e0c.9.1777646339938;
        Fri, 01 May 2026 07:38:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm1531895e0c.14.2026.05.01.07.38.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:38:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] ranging/rap_hci: Use bt_hci_register_subevent for LE CS events
Date: Fri,  1 May 2026 10:38:46 -0400
Message-ID: <20260501143847.724150-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501143847.724150-1-luiz.dentz@gmail.com>
References: <20260501143847.724150-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Replace the single BT_HCI_EVT_LE_META_EVENT registration and subevent
dispatch table with individual bt_hci_register_subevent calls for each
CS subevent. This enables BPF filtering at the socket level for each
specific subevent and removes the manual subevent dispatch logic.

Event IDs are stored in a struct queue for flexible management.

Assisted-by: Claude:claude-opus-4.6
---
 profiles/ranging/rap_hci.c | 193 ++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 122 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 08ddc077ce94..8e65e5ef87bd 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -61,7 +61,7 @@ struct cs_state_machine {
 	enum cs_state old_state;
 	struct bt_hci *hci;
 	struct bt_rap *rap;
-	unsigned int event_id;
+	struct queue *event_ids;
 	bool initiator;
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
@@ -302,7 +302,7 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 		error("Failed to send default settings cmd");
 }
 
-static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t size,
+static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 					   void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
@@ -348,7 +348,7 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t size,
 	cs_set_state(sm, CS_STATE_INIT);
 }
 
-static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
+static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 				    void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
@@ -439,7 +439,7 @@ static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
 	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
 }
 
-static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t size,
+static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 					 void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
@@ -500,7 +500,7 @@ static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t size,
 	bt_rap_hci_cs_sec_enable_complete_callback(size, &rap_ev, sm->rap);
 }
 
-static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t size,
+static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 					  void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
@@ -800,7 +800,7 @@ static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
 	}
 }
 
-static void rap_cs_subevt_result_evt(const uint8_t *data, uint8_t size,
+static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 				void *user_data)
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
@@ -910,7 +910,7 @@ send_event:
 	free(rap_ev);
 }
 
-static void rap_cs_subevt_result_cont_evt(const uint8_t *data, uint8_t size,
+static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 					void *user_data)
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
@@ -1009,113 +1009,12 @@ send_event:
 }
 
 /* Subevent handler function type */
-typedef void (*subevent_handler_t)(const uint8_t *data, uint8_t size,
-				   void *user_data);
 
-/* Subevent table entry */
-struct subevent_entry {
-	uint8_t opcode;
-	uint8_t min_len;
-	uint8_t max_len;
-	subevent_handler_t handler;
-	const char *name;
-};
-
-/* Macro to define HCI event entries
- * Note: min_len excludes the subevent byte since it's stripped before dispatch
- */
-#define HCI_EVT(_opcode, _struct, _handler, _name) \
-	{ \
-		.opcode = _opcode, \
-		.min_len = sizeof(_struct), \
-		.max_len = 0xFF, \
-		.handler = _handler, \
-		.name = _name \
-	}
-
-/* Subevent dispatch table */
-static const struct subevent_entry subevent_table[] = {
-	HCI_EVT(BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
-		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete,
-		rap_rd_rmt_supp_cap_cmplt_evt,
-		"CS Read Remote Supported Capabilities Complete"),
-	HCI_EVT(BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
-		struct bt_hci_evt_le_cs_config_complete,
-		rap_cs_config_cmplt_evt,
-		"CS Config Complete"),
-	HCI_EVT(BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
-		struct bt_hci_evt_le_cs_sec_enable_complete,
-		rap_cs_sec_enable_cmplt_evt,
-		"CS Security Enable Complete"),
-	HCI_EVT(BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
-		struct bt_hci_evt_le_cs_proc_enable_complete,
-		rap_cs_proc_enable_cmplt_evt,
-		"CS Procedure Enable Complete"),
-	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
-		struct bt_hci_evt_le_cs_subevent_result,
-		rap_cs_subevt_result_evt,
-		"CS Subevent Result"),
-	HCI_EVT(BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
-		struct bt_hci_evt_le_cs_subevent_result_continue,
-		rap_cs_subevt_result_cont_evt,
-		"CS Subevent Result Continue")
-};
-
-#undef HCI_EVT
-
-#define SUBEVENT_TABLE_SIZE ARRAY_SIZE(subevent_table)
-
-/* HCI Event Registration */
-static void rap_handle_hci_events(const void *data, uint8_t size,
-				void *user_data)
+static void unregister_event_id(void *data, void *user_data)
 {
-	struct iovec iov;
-	uint8_t subevent;
-	const struct subevent_entry *entry = NULL;
-	size_t i;
+	struct bt_hci *hci = user_data;
 
-	/* Initialize iovec with the event data */
-	iov.iov_base = (void *) data;
-	iov.iov_len = size;
-
-	/* Pull the subevent code */
-	if (!util_iov_pull_u8(&iov, &subevent)) {
-		DBG("Failed to parse subevent code");
-		return;
-	}
-
-	/* Find the subevent in the table */
-	for (i = 0; i < SUBEVENT_TABLE_SIZE; i++) {
-		if (subevent_table[i].opcode == subevent) {
-			entry = &subevent_table[i];
-			break;
-		}
-	}
-
-	/* Check if subevent is supported */
-	if (!entry) {
-		DBG("Unknown subevent: 0x%02X", subevent);
-		return;
-	}
-
-	/* Validate payload length */
-	if (iov.iov_len < entry->min_len) {
-		DBG("%s: payload too short (%zu < %u)",
-		    entry->name, iov.iov_len, entry->min_len);
-		return;
-	}
-
-	if (entry->max_len != 0xFF && iov.iov_len > entry->max_len) {
-		DBG("%s: payload too long (%zu > %u)",
-		    entry->name, iov.iov_len, entry->max_len);
-		return;
-	}
-
-	/* Call the handler */
-	DBG("Handling %s (opcode=0x%02X, len=%zu)",
-	    entry->name, subevent, iov.iov_len);
-
-	entry->handler(iov.iov_base, iov.iov_len, user_data);
+	bt_hci_unregister_subevent(hci, PTR_TO_UINT(data));
 }
 
 void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
@@ -1123,6 +1022,7 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 			int8_t max_tx_power)
 {
 	struct cs_state_machine *sm;
+	unsigned int id;
 
 	if (!rap || !hci) {
 		error("rap or hci null");
@@ -1140,22 +1040,68 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 	cs_state_machine_init(sm, rap, hci, role, cs_sync_ant_sel,
 				max_tx_power);
 
-	sm->event_id = bt_hci_register(hci, BT_HCI_EVT_LE_META_EVENT,
-					rap_handle_hci_events, sm, NULL);
+	sm->event_ids = queue_new();
 
-	DBG("bt_hci_register done, event_id : %d", sm->event_id);
+	/* Register each LE Meta subevent individually */
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
+			rap_rd_rmt_supp_cap_cmplt_evt, sm, NULL);
+	if (!id)
+		goto fail;
 
-	if (!sm->event_id) {
-		error("Failed to register hci le meta events");
-		error("event_id=0x%02X", sm->event_id);
-		free(sm);
-		return NULL;
-	}
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
+			rap_cs_config_cmplt_evt, sm, NULL);
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
+			rap_cs_sec_enable_cmplt_evt, sm, NULL);
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
+			rap_cs_proc_enable_cmplt_evt, sm, NULL);
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
+			rap_cs_subevt_result_evt, sm, NULL);
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
+	id = bt_hci_register_subevent(hci,
+			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
+			rap_cs_subevt_result_cont_evt, sm, NULL);
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 
 	DBG("CS options: role=%u, cs_sync_ant_sel=%u, max_tx_power=%d",
 		role, cs_sync_ant_sel, max_tx_power);
 
 	return sm;
+
+fail:
+	error("Failed to register hci le meta subevents");
+	queue_foreach(sm->event_ids, unregister_event_id, hci);
+	queue_destroy(sm->event_ids, NULL);
+	free(sm);
+	return NULL;
 }
 
 bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
@@ -1204,8 +1150,11 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 	/* Cleanup the per-instance state machine */
 	if (sm) {
 		/* Unregister HCI events */
-		if (sm->event_id && sm->hci)
-			bt_hci_unregister(sm->hci, sm->event_id);
+		if (sm->hci)
+			queue_foreach(sm->event_ids, unregister_event_id,
+								sm->hci);
+
+		queue_destroy(sm->event_ids, NULL);
 
 		/* Clean up per-instance connection mappings */
 		remove_rap_mappings(sm);
-- 
2.53.0

