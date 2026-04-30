Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427D43CEEE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564250; cv=none; b=PfEZsHU+B2f1gs7HEtX2wiICHZ4Kx8IrXELoQe6LGxQJYlTBGd9aw2ir4kchNnsueZouU7K6pc4+BcTRvYjBtWWG8i+puuhv5sV8ILUeNmrSjs9C+TmGhLtXRzGF5thKBjp2COTIbFlPpJPYYP1jUdH4j4owpSqE0i1IbPhz2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564250; c=relaxed/simple;
	bh=pn23PmPfkYa0pCIVyPR8g9x3sa5akLFS3vA9A64lpvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds3O8OrqirUcxpuo472ENazYNBEYHB/pUch8IR/8bXGpIlTqQHlT2avUJNJSSPrJo/2v5EOYYl2hXi3CULIt6enQPJBylJGvrWvxLXOJFH4rpZ5qZrRwv0vE0bSdQ+6XhtlmZu7c86TQTDvhz0p/JhsQ4YlK6jQwvI9WmqevDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUYqZOiB; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUYqZOiB"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5673804da95so404270e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777564248; x=1778169048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WSdSqJUzsIcg5N9jmyjCj22kSF6CuYnwGRuFZc8osU=;
        b=sUYqZOiBLGFnwrqddJsE3veS5UP6vaGL7vV/rMpLgjF0wqWglrTXKUDjnLLKiOU6MM
         k7yP4XqePLAagHMW+aZ9OI/9X+cjBfqIDgHwJtfiX+QR1LYSjNiAaChbemyxOKSwTc1M
         wosP4fM1Wu2sw0lgZMMkAinWO187AlCihxpEq5HmorKLGkz6d23C9o/xVVrQx8RTUOGO
         xDPElIIx422CzHOz1o0h732S9RqE1SEfsbhHQbaQRk+oVJ4Cr4WL0acWHPRgYTFgpxkZ
         J14sKpv77U9Z4xVDK74DG5HanzPiDniNZGia91YSof5KsexBi62hRAlQWtAyEuh2ifxB
         tJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564248; x=1778169048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+WSdSqJUzsIcg5N9jmyjCj22kSF6CuYnwGRuFZc8osU=;
        b=gPQqaLGcyI+CmKUHv7ShVNJce0J4jw28/K9q5LrlySE2XIDap8bOmcKuBWnQJAnp5B
         K7i3WauyVfP9BumL1kNNY/RT+IWemMd8YgV0TNFr81MPB3g1JGFmlWaxSfo5WoQl2esZ
         1ZA3plYSmfQJhaQ9GOFqHRkzCOCHguzgOqo0KgqmTCipJHeTyaC+taFhAgKn7ZZNmrlY
         IAQvgMyXRsb2eOodfE0OcLAS+TP3vPs6zt3At4ZhKsZAduWBPfg1T50JwODkUplWFM6u
         J5nTvxogGQ/Np0KVBEQp/U9p3uENIQxFkby+7k5cRBWhR5G4+uT0RLcu5PKlxUknFhM7
         PrcA==
X-Gm-Message-State: AOJu0YxlkM3C2LRDOWUuf0GwnUOxSUuXcp/rnsh79w9nnjfsQpbwUO+4
	UWJ1QFH9NoBXZvM6rZqsWp3B4lb0XaQz/14Nscul3vSqG+nQZQFzjvwFXnPbXfSw
X-Gm-Gg: AeBDievVFpGAuYhnqjFyIZOlYM+81OxybXHpljhY9DgtR8HAVTgoPCayhk2dlJSdW1U
	HUO+85LfMxcnfjClQ9ORLlVKWZAwhPyr1+rGJuLvpzdYkL1d2DUQsGpKkrT74caQeLo6HYevb8s
	LVZiC2SUbr7mjw0Y0QcorIABPfCgSJptbNeAncsC/ULg3sp0oTz7tfhzQfAzQ596R8SQmCUbsSh
	zJX1/FufEyLHAOjpy5WIEtoq/3xWLhESdoaajRcfuLQ+Bh3RlQMc3g7lmkLGZAKe/m8St7KulDu
	vKgVfbWCY/2yH+7qPP8hA/1gyaJy9DBQZ0xFG9P4cYHO0g/1cuPc7yL6Tg5lPU54LM0P7M2AlL/
	VOUK+qyyBSVaIePRNyUARzPGTfgbXdEZqXgF/8uOVl7IAcEi58sKn9laXkTn83tDwhtioufp9+/
	LOxMtlhAdhIX6QaDAIdsVdzhDKN2PTFZ8fLfK6dj1j9grL4bTzGLD331NFF8kh9X1jj1vNSIqA0
	meHvYv02J3WbHojFg/4VgL02i79
X-Received: by 2002:a05:6122:4889:b0:56f:6d11:b962 with SMTP id 71dfb90a1353d-573c957ed5emr1667151e0c.2.1777564247958;
        Thu, 30 Apr 2026 08:50:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6dfa5b4sm3199545e0c.16.2026.04.30.08.50.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:50:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ 3/3] ranging/rap_hci: Use bt_hci_register_subevent for LE CS events
Date: Thu, 30 Apr 2026 11:50:38 -0400
Message-ID: <20260430155038.426968-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430155038.426968-1-luiz.dentz@gmail.com>
References: <20260430155038.426968-1-luiz.dentz@gmail.com>
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

