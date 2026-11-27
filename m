Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769741;
	b=LRH6NZYeLj8huGS366o84cMl27ug7T1nzqWnu7GVuWfWNewEJ4cFptTvy0roYvE1/VHx
	 tIWw0M0w4IvSNVRunoWpr/b6IAjK3QC8J6OfbDVGOEzWqz8Ihtl/38+TVDOFvz3mu7G3L
	 sWy+uWhmSQcBdcwUVf3V2zrQYSLZLQ53aly5QRTGs3M/rbSHqjEFwr6N5bBLvXrFbfoaK
	 FMwiuDudJwOPn01MEvxbb7SHiKu4SqcV9rvqtwg3jkftyE/CuB2yW+LYf91JoKfmIyai1
	 ZcD5JMIvSWW/6xwfDsJ/FRNBrOWhpT7o+mT2GIQOOGW6kySdN2kQcV1lUECfqZ/A0Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3XpJVpJNOjqdPWC8gaK9OgyOya3yC08eihcM/BQj6C8=;
	b=BQCK31n9p7Njf58gwoz0LQiu4OXpyPu27C0MZ0DACt3yaW76eXJvj66h03gvR0fffdcP
	 MGAmSEsPQVNX3d3Kbm9lYe1iuHkL7MrxqMFFabqQhRTwfu5GXQKmhQIvhHs96XsbyTAY1
	 QtAwL1orRUl847e9cgxZfyqCZqdCPo6+UYdobCjNLvEDqNgrhEW9mdralqsmOe18O8X/9
	 qjpwpoAL6Yfypgq3Te8unwiOm50agyZbDR3FutkT6Mz1SkQFuquLd8qhESxgzbDyzXKWi
	 8SGvSA0j1Mz8TCRl0MruYpH5lOIKmrJXPYS2hHYkAl9VdtMPRvKfWHDwqdmC0R+CTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1wMdYEa;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8891606A329
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8891606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1wMdYEa
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb995ade6cso5810165e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769739; x=1796374539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XpJVpJNOjqdPWC8gaK9OgyOya3yC08eihcM/BQj6C8=;
        b=m1wMdYEaTEsNmfy7tl4hvkXkyGO3MVKtFCvbHRolWq+3YC0CwNqYZj/5Fh2Q4AnDW0
         vUe0Y+avRHTiXMtK0g5OxMVlmvlhFtOEg5o1wryYLkVCveXrjftxajvP0NsrWHjlHc8m
         LJ4HqXWCO6+Z0o/KhDFMJPwu5iac0LMQxkzKptDwCRTVcXsDvTci64hcz5oOJvTUoxpn
         mQhab0EuAGKGkoqJREWfp1z5+rt70ys2BChkWkhoQvzl1RRmdzehR3FqnJRYa/Zm0hht
         YOhsZ6TCkzvRJ3NFMOt784B2w9NpEGCcX/shAbq21MWfrRO3X43DFAvQP7XtG9y4H+no
         Sy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769739; x=1796374539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XpJVpJNOjqdPWC8gaK9OgyOya3yC08eihcM/BQj6C8=;
        b=JcA9F8fL6WLwVzvrKtM84LjEspbfW37x5gL+6mp/fx2uScZI64OUwwutfgmTgT03DC
         aOaAToX+xMISrq1187SPtqSbC1IWcDSfOmbaf7ocKcHQA7f1swjje07Hp9jbXxZwgfWP
         DhHi5EqMItsKQ+AvhgHGyXkO9okSg6fWMdxpnwZ+08WotjIjetDBCPnedanupNKzi3xU
         Qfni4TPluovXv6FP7AxJkzIHc1BU1z9OCmv2N6KZNn0EBqniRhZmX37xux62kfqj+1pW
         pnjyDWPiDUyuMUKu09/rVAG+vcHpXbyja7KWypomNZwxNxLcvgbASnPX/VMeiCnvm8FO
         FvRQ==
X-Gm-Message-State: APuU4Z8yNKifp4pzy04BZTGyrhlfrLxnyIvk3Z99PzgpOdLLJ14uI6io
	vasQ/+nB3KgpCaQIua/wDlFIlgvAbheOBDLHTcRUZ02NBpOmQfDxsCAhnK1UKXXl
X-Gm-Gg: AZFdTZcKf7wytgzhqIYtc2uSkKbFLo7C37TiX1GAbT9+KAUWKM0jNDfQfJbu5FSFz4E
	oGOcjokV8l3pP4rBFE4dXJelrh32vp5/PkzGd287VQz9S8sSbXasACvAtI+6SXq2AnO5b0M/GSe
	8KA7TBOndYTG6YFetA9v+JwuQQX+qFo3oUrzD1PeWvWzsAQqB/wWdog1zu0bUjwennNJK53Ycru
	+iNav02n7u1war/2XOXMBVI9WBBkDu9AyQGLtIiar6ZPejt19l6R59XyYk2/rwNiljA3GyqzpG4
	+EEEtqgAKwLT5h69vseFIQulg84GbnACDJmEpHMRrs3U4Z2YH/x8e6MgcLXb0jKi7OzNFFMfGVX
	huVRYueJjvwVacAaQ1DCiS5VrqjDTcFyDi/8amJXDvnk372UcFHezPP5otSFNSzBGKzS/dyIycu
	gJFVy+6NU1UPMAge4HuK+WVidfR8auChSRklyxfLU6t5sLwiKT/WVPW9VGFt4KzH9+CvPE9HJ/P
	PTdlZrA9yDG7FbddwpdSi7GS1A4x9XlzATzSAdt+jq32WdF1u0/VNqU4tKGtbqfhabGI+MpdrQ8
	5aK4sqhOaC/bnO0gYJCsTcu5neOYL2R1qfg=
X-Received: by 2002:a05:600c:2909:b0:4bb:b39d:d447 with SMTP id 5b1f17b1804b1-4bbb39dd4famr23463245e9.1.1795769739009;
        Fri, 27 Nov 2026 00:55:39 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:38 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 5/9] monitor: Add PAwR HCI definitions
Date: Fri, 27 Nov 2026 09:55:21 +0100
Message-ID: <20261127085525.264299-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

Add the commands and events of Periodic Advertising with Responses to
bt.h, for the emulator. They are those of "monitor: Decode Periodic
Advertising with Responses", which adds the decoding.

Assisted-by: Claude:claude-fable-5-2
---
 monitor/bt.h | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 59bc90ccd..1231f3e84 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3032,6 +3032,90 @@ struct bt_hci_rsp_le_read_iso_link_quality {
 	uint32_t duplicated_packets;
 } __packed;
 
+#define BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA	0x2082
+#define BT_HCI_BIT_LE_SET_PA_SUBEVENT_DATA	BT_HCI_CMD_BIT(46, 5)
+struct bt_hci_le_pa_subevent_data {
+	uint8_t  subevent;
+	uint8_t  response_slot_start;
+	uint8_t  response_slot_count;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_cmd_le_set_pa_subevent_data {
+	uint8_t  handle;
+	uint8_t  num_subevents;
+	struct bt_hci_le_pa_subevent_data subevents[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_subevent_data {
+	uint8_t  status;
+	uint8_t  handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_RESPONSE_DATA	0x2083
+#define BT_HCI_BIT_LE_SET_PA_RESPONSE_DATA	BT_HCI_CMD_BIT(46, 6)
+struct bt_hci_cmd_le_set_pa_response_data {
+	uint16_t sync_handle;
+	uint16_t request_event;
+	uint8_t  request_subevent;
+	uint8_t  response_subevent;
+	uint8_t  response_slot;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_response_data {
+	uint8_t  status;
+	uint16_t sync_handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_SYNC_SUBEVENT	0x2084
+#define BT_HCI_BIT_LE_SET_PA_SYNC_SUBEVENT	BT_HCI_CMD_BIT(46, 7)
+struct bt_hci_cmd_le_set_pa_sync_subevent {
+	uint16_t sync_handle;
+	uint16_t properties;
+	uint8_t  num_subevents;
+	uint8_t  subevents[];
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_sync_subevent {
+	uint8_t  status;
+	uint16_t sync_handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_EXT_CREATE_CONN_V2	0x2085
+#define BT_HCI_BIT_LE_EXT_CREATE_CONN_V2	BT_HCI_CMD_BIT(47, 0)
+struct bt_hci_cmd_le_ext_create_conn_v2 {
+	uint8_t  adv_handle;
+	uint8_t  subevent;
+	uint8_t  filter_policy;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  phys;
+	uint8_t  data[];
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_PA_PARAMS_V2		0x2086
+#define BT_HCI_BIT_LE_SET_PA_PARAMS_V2		BT_HCI_CMD_BIT(47, 1)
+struct bt_hci_cmd_le_set_pa_params_v2 {
+	uint8_t  handle;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t properties;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+	uint8_t  num_response_slots;
+} __packed;
+
+struct bt_hci_rsp_le_set_pa_params_v2 {
+	uint8_t  status;
+	uint8_t  handle;
+} __packed;
+
 #define BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES	0x2087
 #define BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES	BT_HCI_CMD_BIT(47, 2)
 struct bt_hci_rsp_le_read_all_local_features {
@@ -4373,6 +4457,96 @@ struct bt_hci_evt_le_big_info_adv_report {
 	uint8_t  encryption;
 } __packed;
 
+#define BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED_V2	0x24
+struct bt_hci_evt_le_per_sync_established_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_REPORT_V2		0x25
+struct bt_hci_le_pa_report_v2 {
+	uint16_t handle;
+	uint8_t  tx_power;
+	int8_t   rssi;
+	uint8_t  cte_type;
+	uint16_t event_counter;
+	uint8_t  subevent;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+#define BT_HCI_EVT_LE_PAST_RECEIVED_V2		0x26
+struct bt_hci_evt_le_past_recv_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint16_t service_data;
+	uint16_t sync_handle;
+	uint8_t  sid;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  phy;
+	uint16_t interval;
+	uint8_t  clock_accuracy;
+	uint8_t  num_subevents;
+	uint8_t  subevent_interval;
+	uint8_t  response_slot_delay;
+	uint8_t  response_slot_spacing;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_SUBEVENT_DATA_REQUEST	0x27
+struct bt_hci_evt_le_pa_subevent_data_request {
+	uint8_t  handle;
+	uint8_t  subevent_start;
+	uint8_t  subevent_data_count;
+} __packed;
+
+#define BT_HCI_EVT_LE_PA_RESPONSE_REPORT		0x28
+struct bt_hci_le_pa_response {
+	int8_t   tx_power;
+	int8_t   rssi;
+	uint8_t  cte_type;
+	uint8_t  response_slot;
+	uint8_t  data_status;
+	uint8_t  data_len;
+	uint8_t  data[];
+} __packed;
+
+struct bt_hci_evt_le_pa_response_report {
+	uint8_t  handle;
+	uint8_t  subevent;
+	uint8_t  tx_status;
+	uint8_t  num_responses;
+	struct bt_hci_le_pa_response responses[];
+} __packed;
+
+#define BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE_V2	0x29
+struct bt_hci_evt_le_enhanced_conn_complete_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  role;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  local_rpa[6];
+	uint8_t  peer_rpa[6];
+	uint16_t interval;
+	uint16_t latency;
+	uint16_t supv_timeout;
+	uint8_t  clock_accuracy;
+	uint8_t  adv_handle;
+	uint16_t sync_handle;
+} __packed;
+
 #define BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE	0x2B
 struct bt_hci_evt_le_read_all_remote_features_complete {
 	uint8_t  status;
-- 
2.47.3

