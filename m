Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5ABC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AC5610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhHMMVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHMMVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E5C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p7-20020a170902b087b029012c2879a885so6021093plr.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CmkMF2BsBS7wId7P5QUnYFG9FV3+VKC82WTwJjcGAxc=;
        b=a0uLJpM9cpRsJsfBJ/Ysvb7L7kvRP0VLBXKs0m8WYG1lZ5ZYojd6HgMmeRwPbmw3gq
         gERdsLqP+usfNuaaaPAWT9EB7t/ZEskE3h8/Nh5SkZCf9FU5o+GnjgRlhck5WPH/wXoD
         /dtKeQjHakcAx1rsPFpQWkhTjA7+Ywe5QTHq6oi4KOWOm74sZd1r5EJLoAaRb2dFBlPb
         dRPGxLaqXLrPuTuUUJTGsmhwKs09hL063NFPhSBW/mmYl3CX3/VXLYK6J9V3m9rKLKoO
         PA8DoYv7tomv/pWqCAmVepbF7+1A1Ap45ciPhPxxfhrv/j69M81II63z9dTrmjyXxv0u
         HCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CmkMF2BsBS7wId7P5QUnYFG9FV3+VKC82WTwJjcGAxc=;
        b=n0K6HRHS4PVKxpDgYOCOYiKjEEOCd/OgEqC+hSjHKDr8X2Skq/2Bck/yAeYOIGVMC3
         Z4sBa/zjeGn+h9rOal5gYWzo1M5g7mfJyidCdY7iY1qdDcJL7CMM+pZ4hyivcy6+yP/S
         HNj9Kp737hi3oetjlkL4clkAZ3bsbAGHF0LDPyD7fxorKnCcTnGM/lt0vZbbjZ77a67A
         P0iMq7C1a7FYuZIRyWNsq6RJ4mACCbmyuhwk4fq3yNVYOU9dGBFvjnL08d4VIQWrSwKz
         c73LCq9Iruk/hJzhD17pcOKI8T3RrO41esvwDbVLnet6JNMA2MI96bjGKmF+wKWyEK8n
         /9Eg==
X-Gm-Message-State: AOAM531CzkmWnMzXoFwUMfldxDZo/0zvj7Kb0taVxIv27M7tRFu793U5
        IPEq2kY8mouzjWVNLsEA2heOpOs0mJ7tPuq2MmyvtyMvSAUKSx18lboXvApbr4aX7+hGyA+Xw0S
        97Hlh7UaNIVYkXeC/toKCJSGdGn1R67EjtBOQuhcA81FEyGXNvaJQIxDOPphR8tHy2HpfUiyeBD
        ZK
X-Google-Smtp-Source: ABdhPJwTkKGgLCCsHmKAGDFCHd2E1+8N1ztm2AL2RK0leM2kztXwAMswnc5/aeuAI+Bq3Q7+SdgU6tL+aRvQ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a62:6042:0:b029:3e0:86b4:51b with SMTP id
 u63-20020a6260420000b02903e086b4051bmr2202382pfb.62.1628857238068; Fri, 13
 Aug 2021 05:20:38 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:02 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.17.I91ffb170f72b7d0a9d054ec97046a54ab06cc8d2@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 17/62] monitor: Inclusive language in peripheral broadcast
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec 5.3.
---

 monitor/bt.h     | 30 +++++++--------
 monitor/packet.c | 95 ++++++++++++++++++++++++------------------------
 tools/3dsp.c     | 31 ++++++++--------
 3 files changed, 79 insertions(+), 77 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 70e18cc171..4aa11e53a5 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -898,8 +898,8 @@ struct bt_hci_cmd_truncated_page_cancel {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST		0x0441
-struct bt_hci_cmd_set_slave_broadcast {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST	0x0441
+struct bt_hci_cmd_set_peripheral_broadcast {
 	uint8_t  enable;
 	uint8_t  lt_addr;
 	uint8_t  lpo_allowed;
@@ -908,14 +908,14 @@ struct bt_hci_cmd_set_slave_broadcast {
 	uint16_t max_interval;
 	uint16_t timeout;
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast {
+struct bt_hci_rsp_set_peripheral_broadcast {
 	uint8_t  status;
 	uint8_t  lt_addr;
 	uint16_t interval;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE	0x0442
-struct bt_hci_cmd_set_slave_broadcast_receive {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE	0x0442
+struct bt_hci_cmd_set_peripheral_broadcast_receive {
 	uint8_t  enable;
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
@@ -928,7 +928,7 @@ struct bt_hci_cmd_set_slave_broadcast_receive {
 	uint16_t pkt_type;
 	uint8_t  map[10];
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast_receive {
+struct bt_hci_rsp_set_peripheral_broadcast_receive {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
@@ -1599,13 +1599,13 @@ struct bt_hci_rsp_delete_reserved_lt_addr {
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_SET_SLAVE_BROADCAST_DATA	0x0c76
-struct bt_hci_cmd_set_slave_broadcast_data {
+#define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_DATA	0x0c76
+struct bt_hci_cmd_set_peripheral_broadcast_data {
 	uint8_t  lt_addr;
 	uint8_t  fragment;
 	uint8_t  length;
 } __attribute__ ((packed));
-struct bt_hci_rsp_set_slave_broadcast_data {
+struct bt_hci_rsp_set_peripheral_broadcast_data {
 	uint8_t  status;
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
@@ -3325,8 +3325,8 @@ struct bt_hci_evt_sync_train_received {
 	uint8_t  service_data;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_RECEIVE	0x51
-struct bt_hci_evt_slave_broadcast_receive {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE	0x51
+struct bt_hci_evt_peripheral_broadcast_receive {
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
 	uint32_t clock;
@@ -3336,8 +3336,8 @@ struct bt_hci_evt_slave_broadcast_receive {
 	uint8_t  length;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_TIMEOUT	0x52
-struct bt_hci_evt_slave_broadcast_timeout {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT	0x52
+struct bt_hci_evt_peripheral_broadcast_timeout {
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
 } __attribute__ ((packed));
@@ -3350,8 +3350,8 @@ struct bt_hci_evt_truncated_page_complete {
 
 #define BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT	0x54
 
-#define BT_HCI_EVT_SLAVE_BROADCAST_CHANNEL_MAP_CHANGE	0x55
-struct bt_hci_evt_slave_broadcast_channel_map_change {
+#define BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE	0x55
+struct bt_hci_evt_peripheral_broadcast_channel_map_change {
 	uint8_t  map[10];
 } __attribute__ ((packed));
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 5c0fe400da..a787cb2854 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2584,17 +2584,17 @@ static const struct bitfield_data features_page1[] = {
 };
 
 static const struct bitfield_data features_page2[] = {
-	{  0, "Connectionless Slave Broadcast - Master"	},
-	{  1, "Connectionless Slave Broadcast - Slave"	},
-	{  2, "Synchronization Train"			},
-	{  3, "Synchronization Scan"			},
-	{  4, "Inquiry Response Notification Event"	},
-	{  5, "Generalized interlaced scan"		},
-	{  6, "Coarse Clock Adjustment"			},
-	{  8, "Secure Connections (Controller Support)"	},
-	{  9, "Ping"					},
-	{ 10, "Slot Availability Mask"			},
-	{ 11, "Train nudging"				},
+	{  0, "Connectionless Peripheral Broadcast - Central"	},
+	{  1, "Connectionless Peripheral Broadcast - Peripheral"},
+	{  2, "Synchronization Train"				},
+	{  3, "Synchronization Scan"				},
+	{  4, "Inquiry Response Notification Event"		},
+	{  5, "Generalized interlaced scan"			},
+	{  6, "Coarse Clock Adjustment"				},
+	{  8, "Secure Connections (Controller Support)"		},
+	{  9, "Ping"						},
+	{ 10, "Slot Availability Mask"				},
+	{ 11, "Train nudging"					},
 	{ }
 };
 
@@ -2982,11 +2982,11 @@ static const struct bitfield_data events_page2_table[] = {
 	{ 14, "Triggered Clock Capture"					},
 	{ 15, "Synchronization Train Complete"				},
 	{ 16, "Synchronization Train Received"				},
-	{ 17, "Connectionless Slave Broadcast Receive"			},
-	{ 18, "Connectionless Slave Broadcast Timeout"			},
+	{ 17, "Connectionless Peripheral Broadcast Receive"		},
+	{ 18, "Connectionless Peripheral Broadcast Timeout"		},
 	{ 19, "Truncated Page Complete"					},
 	{ 20, "Slave Page Response Timeout"				},
-	{ 21, "Connectionless Slave Broadcast Channel Map Change"	},
+	{ 21, "Connectionless Peripheral Broadcast Channel Map Change"	},
 	{ 22, "Inquiry Response Notification"				},
 	{ 23, "Authenticated Payload Timeout Expired"			},
 	{ 24, "SAM Status Change"					},
@@ -4547,9 +4547,9 @@ static void truncated_page_cancel_cmd(const void *data, uint8_t size)
 	print_bdaddr(cmd->bdaddr);
 }
 
-static void set_slave_broadcast_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast *cmd = data;
 
 	print_field("Enable: 0x%2.2x", cmd->enable);
 	print_lt_addr(cmd->lt_addr);
@@ -4560,18 +4560,18 @@ static void set_slave_broadcast_cmd(const void *data, uint8_t size)
 	print_slot_625("Supervision timeout", cmd->timeout);
 }
 
-static void set_slave_broadcast_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 
 	print_status(rsp->status);
 	print_lt_addr(rsp->lt_addr);
 	print_interval(rsp->interval);
 }
 
-static void set_slave_broadcast_receive_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast_receive *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast_receive *cmd = data;
 
 	print_field("Enable: 0x%2.2x", cmd->enable);
 	print_bdaddr(cmd->bdaddr);
@@ -4587,9 +4587,9 @@ static void set_slave_broadcast_receive_cmd(const void *data, uint8_t size)
 	print_channel_map(cmd->map);
 }
 
-static void set_slave_broadcast_receive_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_receive_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast_receive *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast_receive *rsp = data;
 
 	print_status(rsp->status);
 	print_bdaddr(rsp->bdaddr);
@@ -5658,9 +5658,9 @@ static void delete_reserved_lt_addr_rsp(const void *data, uint8_t size)
 	print_lt_addr(rsp->lt_addr);
 }
 
-static void set_slave_broadcast_data_cmd(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_cmd(const void *data, uint8_t size)
 {
-	const struct bt_hci_cmd_set_slave_broadcast_data *cmd = data;
+	const struct bt_hci_cmd_set_peripheral_broadcast_data *cmd = data;
 
 	print_lt_addr(cmd->lt_addr);
 	print_broadcast_fragment(cmd->fragment);
@@ -5673,9 +5673,9 @@ static void set_slave_broadcast_data_cmd(const void *data, uint8_t size)
 	packet_hexdump(data + 3, size - 3);
 }
 
-static void set_slave_broadcast_data_rsp(const void *data, uint8_t size)
+static void set_peripheral_broadcast_data_rsp(const void *data, uint8_t size)
 {
-	const struct bt_hci_rsp_set_slave_broadcast_data *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast_data *rsp = data;
 
 	print_status(rsp->status);
 	print_lt_addr(rsp->lt_addr);
@@ -8490,12 +8490,12 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x0440, 247, "Truncated Page Cancel",
 				truncated_page_cancel_cmd, 6, true,
 				status_bdaddr_rsp, 7, true },
-	{ 0x0441, 248, "Set Connectionless Slave Broadcast",
-				set_slave_broadcast_cmd, 11, true,
-				set_slave_broadcast_rsp, 4, true },
-	{ 0x0442, 249, "Set Connectionless Slave Broadcast Receive",
-				set_slave_broadcast_receive_cmd, 34, true,
-				set_slave_broadcast_receive_rsp, 8, true },
+	{ 0x0441, 248, "Set Connectionless Peripheral Broadcast",
+				set_peripheral_broadcast_cmd, 11, true,
+				set_peripheral_broadcast_rsp, 4, true },
+	{ 0x0442, 249, "Set Connectionless Peripheral Broadcast Receive",
+				set_peripheral_broadcast_receive_cmd, 34, true,
+				set_peripheral_broadcast_receive_rsp, 8, true },
 	{ 0x0443, 250, "Start Synchronization Train",
 				null_cmd, 0, true },
 	{ 0x0444, 251, "Receive Synchronization Train",
@@ -8796,9 +8796,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x0c75, 253, "Delete Reserved LT_ADDR",
 				delete_reserved_lt_addr_cmd, 1, true,
 				delete_reserved_lt_addr_rsp, 2, true },
-	{ 0x0c76, 254, "Set Connectionless Slave Broadcast Data",
-				set_slave_broadcast_data_cmd, 3, false,
-				set_slave_broadcast_data_rsp, 2, true },
+	{ 0x0c76, 254, "Set Connectionless Peripheral Broadcast Data",
+				set_peripheral_broadcast_data_cmd, 3, false,
+				set_peripheral_broadcast_data_rsp, 2, true },
 	{ 0x0c77, 255, "Read Synchronization Train Parameters",
 				null_cmd, 0, true,
 				read_sync_train_params_rsp, 8, true },
@@ -10200,9 +10200,9 @@ static void sync_train_received_evt(const void *data, uint8_t size)
 	print_field("Service Data: 0x%2.2x", evt->service_data);
 }
 
-static void slave_broadcast_receive_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_receive_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_receive *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 	print_lt_addr(evt->lt_addr);
@@ -10222,9 +10222,9 @@ static void slave_broadcast_receive_evt(const void *data, uint8_t size)
 		packet_hexdump(data + 18, size - 18);
 }
 
-static void slave_broadcast_timeout_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_timeout_evt(const void *data, uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_timeout *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 
 	print_bdaddr(evt->bdaddr);
 	print_lt_addr(evt->lt_addr);
@@ -10242,9 +10242,10 @@ static void slave_page_response_timeout_evt(const void *data, uint8_t size)
 {
 }
 
-static void slave_broadcast_channel_map_change_evt(const void *data, uint8_t size)
+static void peripheral_broadcast_channel_map_change_evt(const void *data,
+								uint8_t size)
 {
-	const struct bt_hci_evt_slave_broadcast_channel_map_change *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_channel_map_change *evt = data;
 
 	print_channel_map(evt->map);
 }
@@ -11190,16 +11191,16 @@ static const struct event_data event_table[] = {
 				sync_train_complete_evt, 1, true },
 	{ 0x50, "Synchronization Train Received",
 				sync_train_received_evt, 29, true },
-	{ 0x51, "Connectionless Slave Broadcast Receive",
-				slave_broadcast_receive_evt, 18, false },
-	{ 0x52, "Connectionless Slave Broadcast Timeout",
-				slave_broadcast_timeout_evt, 7, true },
+	{ 0x51, "Connectionless Peripheral Broadcast Receive",
+				peripheral_broadcast_receive_evt, 18, false },
+	{ 0x52, "Connectionless Peripheral Broadcast Timeout",
+				peripheral_broadcast_timeout_evt, 7, true },
 	{ 0x53, "Truncated Page Complete",
 				truncated_page_complete_evt, 7, true },
 	{ 0x54, "Slave Page Response Timeout",
 				slave_page_response_timeout_evt, 0, true },
-	{ 0x55, "Connectionless Slave Broadcast Channel Map Change",
-				slave_broadcast_channel_map_change_evt, 10, true },
+	{ 0x55, "Connectionless Peripheral Broadcast Channel Map Change",
+			peripheral_broadcast_channel_map_change_evt, 10, true },
 	{ 0x56, "Inquiry Response Notification",
 				inquiry_response_notify_evt, 4, true },
 	{ 0x57, "Authenticated Payload Timeout Expired",
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 99c1ac82bc..4dd53478e1 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -122,7 +122,7 @@ static void sync_train_received(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct bt_hci_evt_sync_train_received *evt = data;
-	struct bt_hci_cmd_set_slave_broadcast_receive cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
 	if (evt->status) {
 		printf("Failed to synchronize with 3D display\n");
@@ -147,7 +147,7 @@ static void sync_train_received(const void *data, uint8_t size,
 	cmd.pkt_type = cpu_to_le16(PKT_TYPE);
 	memcpy(cmd.map, evt->map, 10);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
 				set_slave_broadcast_receive, NULL, NULL);
 }
@@ -156,7 +156,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 							void *user_data)
 {
 	const struct brcm_evt_sync_train_received *evt = data;
-	struct bt_hci_cmd_set_slave_broadcast_receive cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
 	if (evt->status) {
 		printf("Failed to synchronize with 3D display\n");
@@ -181,7 +181,7 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 	cmd.pkt_type = cpu_to_le16(PKT_TYPE);
 	memcpy(cmd.map, evt->map, 10);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE,
 				&cmd, sizeof(cmd),
 				set_slave_broadcast_receive, NULL, NULL);
 }
@@ -212,7 +212,7 @@ static void truncated_page_complete(const void *data, uint8_t size,
 static void slave_broadcast_timeout(const void *data, uint8_t size,
 							void *user_data)
 {
-	const struct bt_hci_evt_slave_broadcast_timeout *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
 	struct bt_hci_cmd_receive_sync_train cmd;
 
 	printf("Re-synchronizing with 3D display\n");
@@ -229,7 +229,7 @@ static void slave_broadcast_timeout(const void *data, uint8_t size,
 static void slave_broadcast_receive(const void *data, uint8_t size,
 							void *user_data)
 {
-	const struct bt_hci_evt_slave_broadcast_receive *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (evt->status != 0x00)
@@ -326,9 +326,9 @@ static void start_glasses(void)
 
 	bt_hci_register(hci_dev, BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE,
 					truncated_page_complete, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_TIMEOUT,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT,
 					slave_broadcast_timeout, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_RECEIVE,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE,
 					slave_broadcast_receive, NULL, NULL);
 
 	start_inquiry();
@@ -443,13 +443,13 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
 	msg.frame_sync_period_fraction = 0;
 	memcpy(bcastdata + 3, &msg, sizeof(msg));
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST_DATA,
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_DATA,
 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
 }
 
 static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
 {
-	const struct bt_hci_rsp_set_slave_broadcast *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
 	struct bt_hci_cmd_read_clock cmd;
 
 	if (rsp->status) {
@@ -467,7 +467,7 @@ static void set_slave_broadcast(const void *data, uint8_t size, void *user_data)
 
 static void start_display(void)
 {
-	struct bt_hci_cmd_set_slave_broadcast cmd;
+	struct bt_hci_cmd_set_peripheral_broadcast cmd;
 	uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };
 	uint8_t sspmode = 0x01;
@@ -494,8 +494,9 @@ static void start_display(void)
 
 	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT,
 				slave_page_response_timeout, NULL, NULL);
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_BROADCAST_CHANNEL_MAP_CHANGE,
-				slave_broadcast_channel_map_change, NULL, NULL);
+	bt_hci_register(hci_dev,
+			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
+			slave_broadcast_channel_map_change, NULL, NULL);
 	bt_hci_register(hci_dev, BT_HCI_EVT_SYNC_TRAIN_COMPLETE,
 					sync_train_complete, NULL, NULL);
 
@@ -510,8 +511,8 @@ static void start_display(void)
 	cmd.max_interval = cpu_to_le16(0x00a0);		/* 100 ms */
 	cmd.timeout = cpu_to_le16(0xfffe);
 
-	bt_hci_send(hci_dev, BT_HCI_CMD_SET_SLAVE_BROADCAST, &cmd, sizeof(cmd),
-					set_slave_broadcast, NULL, NULL);
+	bt_hci_send(hci_dev, BT_HCI_CMD_SET_PERIPHERAL_BROADCAST, &cmd,
+			sizeof(cmd), set_slave_broadcast, NULL, NULL);
 }
 
 static void signal_callback(int signum, void *user_data)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

