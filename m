Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09076C38145
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 14:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiIHO4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiIHO4T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 10:56:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71811C167
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662648978; x=1694184978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VpfVlbLRViwzi351CibEnuWXKZLSUBKzJMwwq9x59i8=;
  b=Li9Y1LWmY2Q7Dc7UAXDJEpT5UyoJGOGeatB1x5hzHoBR9U2y+sFYbjUk
   gmbeS0brsLORrwp/9JX0X+P7xN8itgmlS4XWIDQS9vmhTVAcPB+W+ZI+X
   TmYdXr8FFtJDZ9F0GmMZviKAs1Hkv9UiUc0vv0bYM/cAN7Iz0AsdKGMNQ
   ioTsIz9CXXwJGJPZoXfhSt0Mti6PjZ/w/a6/eqIi5laH8gEYcjkfPvbfp
   SynzIzl0lqgOomjHfOJhjmyPduQUAZ5asOzA5n1gqLMFl8wMfhqWqSp0C
   7EDAQrFC1ahwTVGE7xDjp9pM5GFGDSSaeHWVid8mULuesuEcXb13XAw44
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="358930140"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="358930140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 07:56:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="718596088"
Received: from jfisch2-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.78.123])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 07:56:18 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, apusaka@google.com
Subject: [PATCH BlueZ v4 1/2] monitor: Add ADV Monitor events to btmon parser
Date:   Thu,  8 Sep 2022 07:55:54 -0700
Message-Id: <20220908145555.161258-1-brian.gix@intel.com>
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
index 46587e087..4f2172bdf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14914,6 +14914,37 @@ static void mgmt_controller_resume_evt(const void *data, uint16_t size)
 	mgmt_print_address(data, addr_type);
 }
 
+static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
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
+	print_hex_field("AD Data", ad_data, size);
+}
+
+static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
+{
+	uint16_t handle = get_le16(data);
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

