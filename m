Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05944BCAE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564250; cv=none; b=mk5lS9I/7v0iTYOo0AefgDJfoyLPI/MK2U2k46bdh+UNnXdyYgh6dz6DOInwW4XzwI1A7LqunitbiyzAdD2vfiJssyjxPJSnZLdjyzt3uayyGgIpWStHrQREhQzuxLtNlkAcmJGYwAEeIVJyMFvgOPaTDb5QCJHiT2Mp5r8xc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564250; c=relaxed/simple;
	bh=9RQBiT0dHIhd3gtPCnDRxLRsn7TLmsX0NVBdBShd+KY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vhp0dX1l3QNYn2mPUGTRAVhgqWadcQmWAKApdPqaCl934F5iuR6ZbWSyDfCu2d2u+8g4bzxCCLHcXscHSogFCyEzIhjYaSROUsHaOBwwTqj4FH4KrkybMMCU4hmFiwfHfQmRWtj2AjFP4K3URnCcsHLnE5Ws4xEkdfaswnkdPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjCni5Gj; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjCni5Gj"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56f75445470so660221e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777564247; x=1778169047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSkwXm+65XpCMRBcqk/hBL7jJ6/rrC/YeMwkqhG4gXs=;
        b=bjCni5GjN9AwbEdhMjXIiwBvOZA4yRiPSkpbDzpttk0eUjVJnHa+F352j1bFkVInj+
         O1Y+r5kaCvnw9sBt37lyyTrh2JyxOXdAb7ZNdQ4H8u7v2UuS4xGprvdhs484fslyY0r1
         BFHhRgaG3gYLKMgHxCOAtqQvjLFRmRlmXWenA7GHWrEF9OYjWL/DDflsIs095Z6UPlt8
         a5iM8ebGhdbr7HqXTzVM6e1lucmS1dob0tLo1WMqNLz81CHJuyZprLYLrVibRnAqoD6n
         8yqrfbk4oTaoZclJ4QTcvAJbUqjrLukt1icMNXQ/SHDpEbjYxJ/ySD24NnmobUnXh7zJ
         eLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564247; x=1778169047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VSkwXm+65XpCMRBcqk/hBL7jJ6/rrC/YeMwkqhG4gXs=;
        b=EKcRUC8atp7qea8UYHgE11yInZQ0dCP/elakB8q1lQyFxybRbViRblSUNLk1R7BOQv
         hFfuypYRlGZd6/vy0gwBt4m5qqhtvIjJ9amXi7Rk3+cFGW/HU2S0gk14zYRgk7OVvK+Q
         waFIdXQ8cck/0IqtIEBBTSSQThR0CQViYdRaoDGkFOXr1kfg6W9yM+x7WSHqAC+4G5Aa
         LPW2k3+L6Rk4OMH+sKj2fZx7rINxqRA4X6Bv61oYEFsluAaYP/O0/8igWbVmaihAQCfz
         R4l4ETe8R8FHchmVSwa/hRoIphVq7vYvj4e6g9LqosTRy7fApGoubr0Sy8rknTLQ4WeH
         zr1w==
X-Gm-Message-State: AOJu0YxFv2NIZz+WI1el0mSF3Hwh0Lh5de9k573Q0GfO+bGJ63nnW0eh
	FBfluHLmZbPv2k2f0WpSbRDpphSJSB/DPhalC22hHgUZWLD8cQT9l9tgkh/ip2q1
X-Gm-Gg: AeBDiesnhjkBC5Y7Fb/I+0T9S5WRkBcS6GqRGkvZ/XhJCbUARZHA+nY19Yn03AzSzRg
	2HG4b8vAPym4jsefTG5G5C6akF5wMwYWQRRXVoUe1OTZTIfB6bjoaI68zK5oXJ7rcvk3SnAlKyx
	6gZq1WLxH7L5VG94Z1szRoUExN6TRS2RUu8Q+51t20OaJR0tSuXxKgH6cfPinABkGwB2I4O61JH
	j+eXHhNZTxf253DQmVrj7fwmM4bR8zGa7Pk9oF3GLxkaOXSxA0/hC+vP/C64WocGFoei6ImZ8yH
	RacXj+1rKykGMY80GzQvgcceuN9dcaOg+Lk1Tz2P7tfrHxybLMnD7zO6AuliXOuQyYGTe9tCMPS
	+ze2ICsdg/v2x0V8Nafv77reRAJpTSYZpQMCydZANCRY12inRohPTacPjloL/Uo79rxGNbo+JQw
	7A922Jc15JtOElvWGcelVAbwPxCGa7//KSlwsECSO3WIc1kdfX5JIuCa5lXM5w3q/CavwvSmO7J
	fLkd9flp33Uu34PjrXvsrok97NZ
X-Received: by 2002:a05:6122:660e:b0:56a:ef51:4cae with SMTP id 71dfb90a1353d-573c959946bmr1945855e0c.4.1777564247302;
        Thu, 30 Apr 2026 08:50:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6dfa5b4sm3199545e0c.16.2026.04.30.08.50.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:50:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ 2/3] shared/hci: Add bt_hci_register_subevent for LE Meta events
Date: Thu, 30 Apr 2026 11:50:37 -0400
Message-ID: <20260430155038.426968-2-luiz.dentz@gmail.com>
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

Add bt_hci_register_subevent/bt_hci_unregister_subevent API that allows
registering for specific LE Meta Event subevents. The BPF filter is
extended to accept BT_HCI_EVT_LE_META_EVENT packets and then check the
subevent byte (offset 4) against registered subevents.

Since bt_hci_register_subevent is only used with BT_HCI_EVT_LE_META_EVENT,
the event parameter is omitted. The subevent list reuses struct evt where
evt->event stores the subevent code.

Assisted-by: Claude:claude-opus-4.6
---
 src/shared/hci.c | 239 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/hci.h |   6 ++
 2 files changed, 211 insertions(+), 34 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 5105b0b2f320..24b2c813e888 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -45,6 +45,7 @@ struct bt_hci {
 	struct queue *cmd_queue;
 	struct queue *rsp_queue;
 	struct queue *evt_list;
+	struct queue *subevt_list;
 	struct queue *data_queue;
 };
 
@@ -239,6 +240,21 @@ static void process_notify(void *data, void *user_data)
 						hdr->plen, evt->user_data);
 }
 
+struct subevt_data {
+	uint8_t subevent;
+	const void *data;
+	uint8_t size;
+};
+
+static void process_subevt_notify(void *data, void *user_data)
+{
+	struct subevt_data *sd = user_data;
+	struct evt *evt = data;
+
+	if (evt->event == sd->subevent)
+		evt->callback(sd->data, sd->size, evt->user_data);
+}
+
 static void process_event(struct bt_hci *hci, const void *data, size_t size)
 {
 	const struct bt_hci_evt_hdr *hdr = data;
@@ -275,6 +291,16 @@ static void process_event(struct bt_hci *hci, const void *data, size_t size)
 
 	default:
 		queue_foreach(hci->evt_list, process_notify, (void *) hdr);
+		if (hdr->evt == BT_HCI_EVT_LE_META_EVENT && size > 0) {
+			const uint8_t *params = data;
+			struct subevt_data sd;
+
+			sd.subevent = params[0];
+			sd.data = data + 1;
+			sd.size = size - 1;
+			queue_foreach(hci->subevt_list,
+					process_subevt_notify, &sd);
+		}
 		break;
 	}
 }
@@ -332,10 +358,12 @@ static struct bt_hci *create_hci(int fd)
 	hci->cmd_queue = queue_new();
 	hci->rsp_queue = queue_new();
 	hci->evt_list = queue_new();
+	hci->subevt_list = queue_new();
 	hci->data_queue = queue_new();
 
 	if (!io_set_read_handler(hci->io, io_read_callback, hci, NULL)) {
 		queue_destroy(hci->evt_list, NULL);
+		queue_destroy(hci->subevt_list, NULL);
 		queue_destroy(hci->rsp_queue, NULL);
 		queue_destroy(hci->cmd_queue, NULL);
 		queue_destroy(hci->data_queue, NULL);
@@ -458,6 +486,7 @@ void bt_hci_unref(struct bt_hci *hci)
 		return;
 
 	queue_destroy(hci->evt_list, evt_free);
+	queue_destroy(hci->subevt_list, evt_free);
 	queue_destroy(hci->cmd_queue, cmd_free);
 	queue_destroy(hci->rsp_queue, cmd_free);
 	queue_destroy(hci->data_queue, data_free);
@@ -571,7 +600,7 @@ static void update_evt_filter(struct bt_hci *hci)
 	const struct queue_entry *entry;
 	struct sock_filter *filters;
 	struct sock_fprog fprog;
-	unsigned int count, i;
+	unsigned int evt_count, subevt_count, count, i;
 	int fd;
 
 	fd = io_get_fd(hci->io);
@@ -582,21 +611,37 @@ static void update_evt_filter(struct bt_hci *hci)
 	if (hci->is_stream)
 		return;
 
-	count = queue_length(hci->evt_list);
+	evt_count = queue_length(hci->evt_list);
+	subevt_count = queue_length(hci->subevt_list);
 
-	/* Build filter: load event code, check defaults + registered events.
-	 * Packet layout for HCI_CHANNEL_RAW: [H4 type (1 byte)][evt code (1)]
-	 * So event code is at offset 1.
+	/* Filter structure:
+	 * Packet layout: [H4 type(1)][evt code(1)][plen(1)][params...]
+	 * For LE Meta: params[0] is the subevent code (offset 4 from start)
 	 *
-	 * Filter structure:
 	 *   [0] Load byte at offset 1 (event code)
-	 *   [1] JEQ BT_HCI_EVT_CMD_COMPLETE -> accept
-	 *   [2] JEQ BT_HCI_EVT_CMD_STATUS -> accept
-	 *   [3..3+count-1] JEQ registered_event -> accept
-	 *   [3+count] reject
-	 *   [4+count] accept
+	 *   [1] JEQ CMD_COMPLETE -> accept
+	 *   [2] JEQ CMD_STATUS -> accept
+	 *   [3] JEQ LE_META -> subevent_check (if subevts registered)
+	 *   [4..4+evt_count-1] JEQ registered_event -> accept
+	 *   [4+evt_count] reject
+	 *   -- subevent section (if subevt_count > 0) --
+	 *   [5+evt_count] Load byte at offset 4 (subevent code)
+	 *   [6+evt_count..6+evt_count+subevt_count-1] JEQ subevent -> accept
+	 *   [6+evt_count+subevt_count] reject
+	 *   -- shared accept --
+	 *   [last] accept
 	 */
-	filters = malloc(sizeof(*filters) * (count + 5));
+
+	/* Without subevents: 3 (defaults) + evt_count + reject + accept = evt_count + 5
+	 * With subevents: 4 (defaults+LE_META) + evt_count + reject +
+	 *                 1 (load subevent) + subevt_count + reject + accept
+	 */
+	if (subevt_count)
+		count = 4 + evt_count + 1 + 1 + subevt_count + 1 + 1;
+	else
+		count = 3 + evt_count + 1 + 1;
+
+	filters = malloc(sizeof(*filters) * count);
 	if (!filters)
 		return;
 
@@ -606,32 +651,106 @@ static void update_evt_filter(struct bt_hci *hci)
 	filters[i++] = (struct sock_filter)
 		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 1);
 
-	/* Check BT_HCI_EVT_CMD_COMPLETE (0x0e) */
-	filters[i++] = (struct sock_filter)
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_COMPLETE,
-			 count + 2, 0);
-
-	/* Check BT_HCI_EVT_CMD_STATUS (0x0f) */
-	filters[i++] = (struct sock_filter)
-		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_STATUS,
-			 count + 1, 0);
-
-	/* Check each registered event */
-	entry = queue_get_entries(hci->evt_list);
-	while (entry) {
-		const struct evt *evt = entry->data;
-		unsigned int jump = count - (i - 3);
+	if (subevt_count) {
+		/* accept is at index: count - 1
+		 * From instruction at index i, jump_true = (count-1) - (i+1)
+		 */
 
+		/* Check BT_HCI_EVT_CMD_COMPLETE -> accept */
 		filters[i] = (struct sock_filter)
-			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, evt->event,
-				 jump, 0);
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+				 BT_HCI_EVT_CMD_COMPLETE,
+				 count - 1 - (i + 1), 0);
 		i++;
-		entry = entry->next;
-	}
 
-	/* Reject */
-	filters[i++] = (struct sock_filter)
-		BPF_STMT(BPF_RET | BPF_K, 0);
+		/* Check BT_HCI_EVT_CMD_STATUS -> accept */
+		filters[i] = (struct sock_filter)
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+				 BT_HCI_EVT_CMD_STATUS,
+				 count - 1 - (i + 1), 0);
+		i++;
+
+		/* Check LE_META -> subevent section
+		 * subevent section starts at: 4 + evt_count + 1
+		 * (after the evt reject instruction)
+		 */
+		filters[i] = (struct sock_filter)
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+				 BT_HCI_EVT_LE_META_EVENT,
+				 4 + evt_count + 1 - (i + 1), 0);
+		i++;
+
+		/* Check each registered event -> accept */
+		entry = queue_get_entries(hci->evt_list);
+		while (entry) {
+			const struct evt *evt = entry->data;
+
+			filters[i] = (struct sock_filter)
+				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+					 evt->event,
+					 count - 1 - (i + 1), 0);
+			i++;
+			entry = entry->next;
+		}
+
+		/* Reject (for non-matching events) */
+		filters[i++] = (struct sock_filter)
+			BPF_STMT(BPF_RET | BPF_K, 0);
+
+		/* Subevent section: load subevent byte at offset 4 */
+		filters[i++] = (struct sock_filter)
+			BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 4);
+
+		/* Check each registered subevent -> accept */
+		entry = queue_get_entries(hci->subevt_list);
+		while (entry) {
+			const struct evt *evt = entry->data;
+
+			filters[i] = (struct sock_filter)
+				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+					 evt->event,
+					 count - 1 - (i + 1), 0);
+			i++;
+			entry = entry->next;
+		}
+
+		/* Reject (for non-matching subevents) */
+		filters[i++] = (struct sock_filter)
+			BPF_STMT(BPF_RET | BPF_K, 0);
+	} else {
+		/* No subevents - simple filter */
+
+		/* Check BT_HCI_EVT_CMD_COMPLETE -> accept */
+		filters[i] = (struct sock_filter)
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+				 BT_HCI_EVT_CMD_COMPLETE,
+				 count - 1 - (i + 1), 0);
+		i++;
+
+		/* Check BT_HCI_EVT_CMD_STATUS -> accept */
+		filters[i] = (struct sock_filter)
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+				 BT_HCI_EVT_CMD_STATUS,
+				 count - 1 - (i + 1), 0);
+		i++;
+
+		/* Check each registered event -> accept */
+		entry = queue_get_entries(hci->evt_list);
+		while (entry) {
+			const struct evt *evt = entry->data;
+
+			filters[i] = (struct sock_filter)
+				BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K,
+					 evt->event,
+					 count - 1 - (i + 1), 0);
+			i++;
+			entry = entry->next;
+		}
+
+		/* Reject */
+		filters[i++] = (struct sock_filter)
+			BPF_STMT(BPF_RET | BPF_K, 0);
+	}
 
 	/* Accept */
 	filters[i++] = (struct sock_filter)
@@ -744,6 +863,58 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 	return true;
 }
 
+
+unsigned int bt_hci_register_subevent(struct bt_hci *hci,
+				uint8_t subevent,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy)
+{
+	struct evt *evt;
+
+	if (!hci)
+		return 0;
+
+	evt = new0(struct evt, 1);
+	evt->event = subevent;
+
+	if (hci->next_evt_id < 1)
+		hci->next_evt_id = 1;
+
+	evt->id = hci->next_evt_id++;
+
+	evt->callback = callback;
+	evt->destroy = destroy;
+	evt->user_data = user_data;
+
+	if (!queue_push_tail(hci->subevt_list, evt)) {
+		free(evt);
+		return 0;
+	}
+
+	update_evt_filter(hci);
+
+	return evt->id;
+}
+
+bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id)
+{
+	struct evt *evt;
+
+	if (!hci || !id)
+		return false;
+
+	evt = queue_remove_if(hci->subevt_list, match_evt_id,
+							UINT_TO_PTR(id));
+	if (!evt)
+		return false;
+
+	evt_free(evt);
+
+	update_evt_filter(hci);
+
+	return true;
+}
+
 bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
 				uint16_t *handle)
 {
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 800dc4946b97..5be48577f9db 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -42,5 +42,11 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				void *user_data, bt_hci_destroy_func_t destroy);
 bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
 
+unsigned int bt_hci_register_subevent(struct bt_hci *hci,
+				uint8_t subevent,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy);
+bool bt_hci_unregister_subevent(struct bt_hci *hci, unsigned int id);
+
 bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
 				uint16_t *handle);
-- 
2.53.0

