Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBDC38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIGUwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIGUwO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 16:52:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094E3F331
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662583934; x=1694119934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G6OdsRHP+3kOTxVVdUG3dUj23mWDAiTMUTG/hynC+5Y=;
  b=Ot5bqUr+26bMNDEbc2GD9AqIlxyr41Qwx/vOmQ2gd09Uq368pvF7w04I
   PkoLuBZH8HL7ZWdJyEu/IaSud9ojnqLunF60TpdgBrhlcHIX217zwhtrB
   +QldHRKaD2/Q163s5MbBrTMsnegsuEnjUsdDZYbejJbxYnt6/Hhd6cwoM
   dXioJbg72wrMPHrMaq2jPO09CCgcORBFjxR09SqNlB8s/skY/o44kjhsx
   dHAiL0fp8veeK6EMlJ4DsMtLQ+pwLTGG7AJr9c9cCECpgFzWLtiZHlrBO
   D0pfTwrcuuUKgo0fyfPakMBEK/ly4rx5lrmp52tsGe8ErMCG5K54i2YA9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360957737"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360957737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 13:52:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="644781752"
Received: from jsanch3-desk4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.92.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 13:52:13 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 1/2] monitor: Add ADV Monitor events to btmon parser
Date:   Wed,  7 Sep 2022 13:52:04 -0700
Message-Id: <20220907205205.49729-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add missing ADV Monitor MGMT events
---
 monitor/packet.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 46587e087..4c4f53dee 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14914,6 +14914,37 @@ static void mgmt_controller_resume_evt(const void *data, uint16_t size)
 	mgmt_print_address(data, addr_type);
 }
 
+static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
+{
+	uint8_t handle = get_le16(data);
+	const uint8_t *addr = data + 2;
+	uint8_t addr_type = get_u8(data + 8);
+	int8_t rssi = get_s8(data + 9);
+	uint32_t flags = get_le32(data + 10);
+	uint16_t ad_data_len = get_le16(data + 14);
+	const uint8_t *ad_data = data + 16;
+
+	print_field("Handle: %d", handle);
+	print_bdaddr(addr);
+	print_field("Addr Type: %d", addr_type);
+	print_field("RSSI: %d", rssi);
+	mgmt_print_device_flags(flags);
+	print_field("AD Data Len: %d", ad_data_len);
+	size -= 16;
+	print_hex_field("AD Data: ", ad_data, size);
+}
+
+static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
+{
+	uint8_t handle = get_le16(data);
+	const uint8_t *addr = data + 2;
+	uint8_t addr_type = get_u8(data + 8);
+
+	print_field("Handle: %d", handle);
+	print_bdaddr(addr);
+	print_field("Addr Type: %d", addr_type);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -15003,6 +15034,10 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_controller_suspend_evt, 1, true },
 	{ 0x002e, "Controller Resumed",
 			mgmt_controller_resume_evt, 8, true },
+	{ 0x002f, "ADV Monitor Device Found",
+			mgmt_adv_monitor_device_found_evt, 16, false },
+	{ 0x0030, "ADV Monitor Device Lost",
+			mgmt_adv_monitor_device_lost_evt, 9, true },
 	{ }
 };
 
-- 
2.37.2

