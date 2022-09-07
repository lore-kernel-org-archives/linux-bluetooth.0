Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE1C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIGWol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIGWok (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 18:44:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB21705E
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662590678; x=1694126678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G6OdsRHP+3kOTxVVdUG3dUj23mWDAiTMUTG/hynC+5Y=;
  b=lABpSXSuvjxokMws3GfdnWDkJ9RcnL4tiRwoVyQ0OBerr2R3OkM3Qlam
   RX2fwT+MMwutOqgvtI4ryjsdTUn1LpTMH5qtx8VVy3M06Da1rIJApp5dH
   /LR/1ZMQcRgOm700LYQ1CSMktZPthuy0bPDasjgadwSHzsnPWhpR3v26/
   wIIyJBr63KL3qjJmG/oHQPezf5dQGg9Svk/1XGom62Fj2igEJuki25YXd
   XbRjOhef1ZHhrxUH4PyYK1mrNV6vMwdpn4p6FGs0V1X+KmV3/l2aCJQL7
   RbVCqCJxbRWDJsI+RF3exi/3hnyu06BXr/3F40g41woQX5pQFzgOq3TQf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323203512"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="323203512"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:44:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943091011"
Received: from jsanch3-desk4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.92.69])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:44:24 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 1/2] monitor: Add ADV Monitor events to btmon parser
Date:   Wed,  7 Sep 2022 15:44:15 -0700
Message-Id: <20220907224416.62115-1-brian.gix@intel.com>
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

