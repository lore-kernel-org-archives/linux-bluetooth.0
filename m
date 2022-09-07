Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B2FC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIGTPM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIGTPG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 15:15:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC65A3CA
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578104; x=1694114104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3/Is8Ta2Wze6VCsK5CfSxbJAZUh8B1jwDalKJy2A2zQ=;
  b=cOwSxWqbB5JbwYC3PKLLIl+Km/cBXJkR2vOxBA1OhEVCpyR01+FGY33E
   5161cl0HgAi5IfHmVhL9QehQsVYQDSao8lLHd9htLHbLZlMd1LwHfhnB9
   vh6kR475DtFqGQH60oUMqK30LZOX6X379vT2kM0P7FPubk1nf7YAiJ4H5
   /PAQz9NW+6AdiJLEoZTryOfo8X3vmTc6eUsGFfTIK3/Gy+ogutdSy8q7l
   EctC/NM64Eip8g3XV36UrUyWnzr1JMoEvEgpymhOPggG3NvRy//wmzr9z
   XoPhyg9NppcakEqJjXfOku5LE69YDZSh6Y4V/BgR8+6O0MTa73sGw+eV/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360938874"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360938874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:15:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="644755639"
Received: from jsanch3-desk4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.92.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:15:02 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/2] Bluetooth: Add ADV Monitor events to btmon parser
Date:   Wed,  7 Sep 2022 12:14:49 -0700
Message-Id: <20220907191450.38262-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 monitor/packet.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 46587e087..7447e1565 100644
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
+	{ 0x0030, "Controller Resumed",
+			mgmt_adv_monitor_device_lost_evt, 9, true },
 	{ }
 };
 
-- 
2.37.2

