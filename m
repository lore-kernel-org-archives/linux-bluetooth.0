Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2D3B19AE
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646344; cv=none; b=jlY7N2Am6r+9nxLHD5hXAERvYqzWQykj6UjdjGhFhe789VNDM/Zc+dxBVrb4VhVQAgTPlD/5ODcEdyRwhjAVUq4wyl+yqsjMEAzJ9gjOOnwXIlRZ2M/XU9NdjmMihCfRLTo1iRuE0/DIwi5n1ezzPcsVl1wEye6RNwlAf5aTO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646344; c=relaxed/simple;
	bh=f/BiqhsigHLnR/e1CU5ZfPg9DX2KioqXvninFtnILf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZQxFSU/o4UI7wld2p1Zu/1R4qw4IiPETNB9QONCwwlA8XoHzEEWVUaJbM9jwPxZFkfyRw9EwoWIb+oDQvl3yJrwjTPAvxgOOWpKe4lYL64onZu9apidka6kBI19oFo7Z/ZowqqC2RXabMTwkcuG/d9m2syuRM2ne+q2UPE3+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4MmTrrB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4MmTrrB"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so1121020e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646339; x=1778251139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1UOI/qdLIHaKvWkmNAm9sACo31fjgp8gOmcDp4MRPE=;
        b=o4MmTrrBhveMGHpKVSGp3Q6uV2pbFQedNpsyvrAWJun9bRU4Qpsd5GPAu8kHy+Gx11
         BWbZf6OifFM9pjSVpoKNIuH61WusBa6smPB2ipUjSY8oWR28PKRRgldjCkH3m1GvHV+B
         Xr9Fb2scxkSflko2BhxzUbv8PyA/Q3sz0XqV1LWULiwPraxarLLommFlHKCJcch4lnbc
         UxnRAjyp0s+gfHmJCcPcG7iHPsC5v/m+FaSGv7YIHeJ3IVrMvVBbjuMbyQ0+ZV/pccAz
         D4yZMmB5uEDYjxgTAy1P3JXoNd+3MM3lf7MPIKYVTADflL4BYBvYHxBUm8EnFW+8wMBt
         67Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646339; x=1778251139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1UOI/qdLIHaKvWkmNAm9sACo31fjgp8gOmcDp4MRPE=;
        b=Vo6dI2XLM6mlHBHZEp/VVyFNDXfXaaczrMYZaoQO1V10+W7mEa8WEAam+4cwSXM2mm
         zAZ6DDY6cHKntdO+jBbMnF3gDTJjsualmLEMZsGeAkEJFA9poXAYNVrawEB6haqyeMMZ
         WPjoh10gGp2XZ/+yAiZ4yNNy46YcOQHoOnb/98Ag1a+ILmb9vxWyUizbYOliwElPlj8F
         iqv/QeeptBOPqRHmkP+EBabOMPdgkW+QKd21gOAS9znqbfYM8lPhzVxftcM88JjX2/hP
         LwOXqC1mNKQFyFMexhW6bEnIvXUlOdA3zDQNsY3wSG5cdtJnVt4mreVoGInDHEzJSqZm
         oPBA==
X-Gm-Message-State: AOJu0YwgJ34M2hDs3sw2OxPYgi8GlYeetY6WYlvtiL2peR7f6x78fs6f
	1S5bpJHNeHaiuL4tKs9vv0CNXUK/eBFoim8SYiyHBD/bGgXTxjk4ayn0MrdhWBSH
X-Gm-Gg: AeBDieu5PeuYf2jfMnWEbo3c6M48tYeutx3ZpCTdk/+ws/Ar/ywoNCS84kOGBMljyXj
	9FHr98sMZ+iSRfYyxcXCCxw5nPUvR0j9PLobwsWUn0CHzvxf0kkI1TaD2zFLQcF0Co6Wc6ShBiV
	b8L6N/daielCws1/XNLx1rWY+ZZQQbcRPGjXdhDDb1NQiN9z4x9uTHEscYwXAl6MDblVby4g2aA
	ZSm1KueWIUhbDHnneNnI/E0tNKv2yYXSoLDrvLHv5oadMdSHu3cYRTmzNkArap8nXmhyNdX6itf
	BtSGLY//fskNBBOwydhGhvcAUEn8E+uTDFjcQw7+XHBGdQg43Mh3Ew7eaYXtJg5pfBk/uWHv8bX
	GDduPg0m/Qd1rBhl3F83QOMF8xLsIVXMkET/rIEyq/RxdXP/3599R2o11WdkqLABExpfLujHiLV
	S2O3ZpUA0UKu2mE0guaqtHWdzd0xQBb97TG8aQW1zff0gBDdxt7AsB5/PPoEEsLaMUNlQZbDpRW
	Uas66hu7jxMrgYt3amqligNWEJd
X-Received: by 2002:a05:6122:3c46:b0:56d:aa1f:e48a with SMTP id 71dfb90a1353d-573c96f74edmr3819257e0c.12.1777646339336;
        Fri, 01 May 2026 07:38:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm1531895e0c.14.2026.05.01.07.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:38:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] shared/hci: Add bt_hci_register_subevent for LE Meta events
Date: Fri,  1 May 2026 10:38:45 -0400
Message-ID: <20260501143847.724150-2-luiz.dentz@gmail.com>
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

Add bt_hci_register_subevent/bt_hci_unregister_subevent API that allows
registering for specific LE Meta Event subevents. The BPF filter is
extended to accept BT_HCI_EVT_LE_META_EVENT packets and then check the
subevent byte (offset 4) against registered subevents.

Since bt_hci_register_subevent is only used with BT_HCI_EVT_LE_META_EVENT,
the event parameter is omitted. The subevent list reuses struct evt where
evt->event stores the subevent code.

Assisted-by: Claude:claude-opus-4.6
---
 src/shared/hci.c | 240 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/hci.h |   6 ++
 2 files changed, 212 insertions(+), 34 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 5105b0b2f320..40326fc810e6 100644
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
@@ -582,21 +611,38 @@ static void update_evt_filter(struct bt_hci *hci)
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
+	 * For LE Meta: params[0] is the subevent code (offset 3 from start)
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
+	 *   [5+evt_count] Load byte at offset 3 (subevent code)
+	 *   [6+evt_count..6+evt_count+subevt_count-1] JEQ subevent -> accept
+	 *   [6+evt_count+subevt_count] reject
+	 *   -- shared accept --
+	 *   [last] accept
 	 */
-	filters = malloc(sizeof(*filters) * (count + 5));
+
+	/* Without subevents: 3 (defaults) + evt_count + reject + accept =
+	 *                    evt_count + 5
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
 
@@ -606,32 +652,106 @@ static void update_evt_filter(struct bt_hci *hci)
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
+		/* Subevent section: load subevent byte at offset 3 */
+		filters[i++] = (struct sock_filter)
+			BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 3);
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
@@ -744,6 +864,58 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
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

