Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C245C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 22:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIGWon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIGWom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 18:44:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15C12769
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662590680; x=1694126680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BL01XrIVVjMpyQG+ZUhKoOWcTgQryr21+syJkw1Ho3A=;
  b=SNBF/88OLaYkspnhZot27rJc9DQskIDjmbGc0UqUznrNEylPtoGUCcMq
   bj1TwwsKtadkZf4o3xkFE+FVhNWBsTqUzIVqDDnrr1sdpBHkZ2p2HFW04
   oXCFWakzPbFdAUKJKJjmWumw4OFOJCRy2np3xtXlx1uakyb6o9WVMVTPS
   X8EE3aNENy3wSek2OO1vl/NLvLKD8xP7to0zuSDRvX/wytGmNDYGpiJWK
   T0Dnx3BN9JhQUUCequ8Q/z4U8/xAE5k2EWskABtRVIAi4RHCEmpc6RlnR
   rw3xuwkvdSFY5/SJUDmnTEhh1M4i1MN8WXsnhN1IVIuzdQpTpy0mwzr3P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323203513"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="323203513"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:44:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943091014"
Received: from jsanch3-desk4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.92.69])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:44:24 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 2/2] monitor: Add mesh MGMT cmds/events to btmon parser
Date:   Wed,  7 Sep 2022 15:44:16 -0700
Message-Id: <20220907224416.62115-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907224416.62115-1-brian.gix@intel.com>
References: <20220907224416.62115-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sample Output:
@ MGMT Command: Read Mesh Features (0x0058) plen 0
@ MGMT Event: Command Complete (0x0001) plen 7
      Read Mesh Features (0x0058) plen 4
        Status: Success (0x00)
        Index: 0
        Max Handles: 3
        Used Handles: 0

@ MGMT Command: Set Mesh Receiver (0x0057) plen 9
        Enable: 1
        Window: 4096
        Period: 4096
        Num AD Types: 3
          AD Type: 42
          AD Type: 43
          AD Type: 41
@ MGMT Event: Command Complete (0x0001) plen 3
      Set Mesh Receiver (0x0057) plen 0
        Status: Success (0x00)

@ MGMT Command: Mesh Send (0x0059) plen 43
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Addr Type: 2
        Instant: 0x0000000000000000
        Delay: 0
        Count: 1
        Data Length: 24
        Data: : 172b01002dda0c2491537ae2000000009de2120a725038b2
@ MGMT Event: Command Complete (0x0001) plen 4
      Mesh Send (0x0059) plen 1
        Status: Success (0x00)
        Handle: 3

@ MGMT Event: Mesh Packet Complete (0x0032) plen 1
        Handle: 3
---
 monitor/packet.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4c4f53dee..7544a7e68 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14191,6 +14191,74 @@ static void mgmt_remove_adv_monitor_patterns_rsp(const void *data,
 	print_field("Handle: %d", handle);
 }
 
+static void mgmt_set_mesh_receiver_cmd(const void *data, uint16_t size)
+{
+	uint8_t enable = get_u8(data);
+	uint16_t window = get_le16(data + 1);
+	uint16_t period = get_le16(data + 3);
+	uint8_t num_ad_types = get_u8(data + 5);
+	const uint8_t *ad_types = data + 6;
+
+	print_field("Enable: %d", enable);
+	print_field("Window: %d", window);
+	print_field("Period: %d", period);
+	print_field("Num AD Types: %d", num_ad_types);
+	size -= 6;
+
+	while (size--)
+		print_field("  AD Type: %d", *ad_types++);
+}
+
+static void mgmt_read_mesh_features_rsp(const void *data, uint16_t size)
+{
+	uint16_t index = get_le16(data);
+	uint8_t max_handles = get_u8(data + 2);
+	uint8_t used_handles = get_u8(data + 3);
+	const uint8_t *handles = data + 4;
+
+	print_field("Index: %d", index);
+	print_field("Max Handles: %d", max_handles);
+	print_field("Used Handles: %d", used_handles);
+	size -= 4;
+
+	while (size--)
+		print_field("  Used Handle: %d", *handles++);
+}
+
+static void mgmt_mesh_send_cmd(const void *data, uint16_t size)
+{
+	const uint8_t *addr = data;
+	uint8_t addr_type = get_u8(data + 6);
+	uint64_t instant = get_le64(data + 7);
+	uint16_t delay = get_le16(data + 15);
+	uint8_t cnt = get_u8(data + 17);
+	uint8_t adv_data_len = get_u8(data + 18);
+
+	data += 19;
+	size -= 19;
+	print_bdaddr(addr);
+	print_field("Addr Type: %d", addr_type);
+	print_field("Instant: 0x%16.16" PRIx64, instant);
+	print_field("Delay: %d", delay);
+	print_field("Count: %d", cnt);
+	print_field("Data Length: %d", adv_data_len);
+	print_hex_field("Data: ", data, size);
+}
+
+static void mgmt_mesh_send_rsp(const void *data, uint16_t size)
+{
+	uint8_t handle = get_u8(data);
+
+	print_field("Handle: %d", handle);
+}
+
+static void mgmt_mesh_send_cancel_cmd(const void *data, uint16_t size)
+{
+	uint8_t handle = get_u8(data);
+
+	print_field("Handle: %d", handle);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -14448,6 +14516,18 @@ static const struct mgmt_data mgmt_command_table[] = {
 				mgmt_add_adv_monitor_patterns_rssi_cmd, 8,
 									false,
 				mgmt_add_adv_monitor_patterns_rsp, 2, true},
+	{ 0x0057, "Set Mesh Receiver",
+				mgmt_set_mesh_receiver_cmd, 6, false,
+				mgmt_null_rsp, 0, true},
+	{ 0x0058, "Read Mesh Features",
+				mgmt_null_cmd, 0, true,
+				mgmt_read_mesh_features_rsp, 4, false},
+	{ 0x0059, "Mesh Send",
+				mgmt_mesh_send_cmd, 19, false,
+				mgmt_mesh_send_rsp, 1, true},
+	{ 0x0056, "Mesh Send Cancel",
+				mgmt_mesh_send_cancel_cmd, 1, true,
+				mgmt_null_rsp, 0, true},
 	{ }
 };
 
@@ -14945,6 +15025,33 @@ static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
 	print_field("Addr Type: %d", addr_type);
 }
 
+static void mgmt_mesh_device_found_evt(const void *data, uint16_t size)
+{
+	const uint8_t *addr = data;
+	uint8_t addr_type = get_u8(data + 6);
+	int8_t rssi = get_s8(data + 7);
+	uint64_t instant = get_le64(data + 8);
+	uint32_t flags = get_le32(data + 16);
+	uint16_t eir_len = get_le16(data + 20);
+	const uint8_t *eir_data = data + 22;
+
+	print_bdaddr(addr);
+	print_field("Addr Type: %d", addr_type);
+	print_field("RSSI: %d", rssi);
+	print_field("Instant: 0x%16.16" PRIx64, instant);
+	mgmt_print_device_flags(flags);
+	print_field("EIR Length: %d", eir_len);
+	size -= 22;
+	print_hex_field("EIR Data: ", eir_data, size);
+}
+
+static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t size)
+{
+	uint8_t handle = get_u8(data);
+
+	print_field("Handle: %d", handle);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -15038,6 +15145,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_adv_monitor_device_found_evt, 16, false },
 	{ 0x0030, "ADV Monitor Device Lost",
 			mgmt_adv_monitor_device_lost_evt, 9, true },
+	{ 0x0031, "Mesh Device Found",
+			mgmt_mesh_device_found_evt, 22, false },
+	{ 0x0032, "Mesh Packet Complete",
+			mgmt_mesh_packet_cmplt_evt, 1, true },
 	{ }
 };
 
-- 
2.37.2

