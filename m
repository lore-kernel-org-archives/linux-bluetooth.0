Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A70C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKVDX7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiKVDXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:23:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA54248CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669087433; x=1700623433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HjTXE6yASm4fnculIMu637JkLzu9jsyaoxsbFGWhJY=;
  b=lmxFa2upHW4LZJ7v7CfDw8xIrvpTNT1PC0hlUMjbA6l8+oJhVxd0+fM4
   afJgIat6JQ7YwqQgBRmHzOyXyJN4RfJRaolLLYreL1OzLQnig14zdcjlo
   DSe/g8B1SKc6G6+ppfbtE3JQQ97DiQ6AvqWniUm5aIO9Q4Q6RpDh2f73e
   9EdHvENZOx+DjqLdUc12IoDjm8ooBAdWx1ItxvUJALfp8Vi+rzhGLEI0V
   l2GrepTx4cKSBp3qaG4GRUZhFeUSXD98Y4WHifzAGU8f3zqe5QJ1SAvID
   3w5O9XiQ4jx5rIAEBlVeEa6VYljptLQTiBLtU6Yzj/7qL6rosEHHURn3D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340583286"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="340583286"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672331739"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672331739"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 19:23:52 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ V2 5/6] monitor/att: Add decoding support for CSIP
Date:   Tue, 22 Nov 2022 08:55:29 +0530
Message-Id: <20221122032530.3842-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122032530.3842-1-sathish.narasimman@intel.com>
References: <20221122032530.3842-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds decoding support for CSIS attributes
---
 monitor/att.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index d14cbd165697..6fd740aa4cd4 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1733,6 +1733,73 @@ static void pac_context_notify(const struct l2cap_frame *frame)
 	print_pac_context(frame);
 }
 
+static void csip_rank_read(const struct l2cap_frame *frame)
+{
+	uint8_t rank;
+
+	if (!l2cap_frame_get_u8((void *)frame, &rank)) {
+		print_text(COLOR_ERROR, "CSIP Rank: invalid size");
+		goto done;
+	}
+	print_field("    CSIP Rank: %u", rank);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void csip_lock_read(const struct l2cap_frame *frame)
+{
+	uint8_t lock;
+
+	if (!l2cap_frame_get_u8((void *)frame, &lock)) {
+		print_text(COLOR_ERROR, "CSIP LOCK: invalid size");
+		goto done;
+	}
+	print_field("    CSIP LOCK: %u", lock);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void print_csip_size(const struct l2cap_frame *frame)
+{
+	uint8_t size;
+
+	if (!l2cap_frame_get_u8((void *)frame, &size)) {
+		print_text(COLOR_ERROR, "CSIP SIZE: invalid size");
+		goto done;
+	}
+	print_field("    CSIP SIZE: %u", size);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void csip_size_read(const struct l2cap_frame *frame)
+{
+	print_csip_size(frame);
+}
+
+static void csip_size_notify(const struct l2cap_frame *frame)
+{
+	print_csip_size(frame);
+}
+
+static void csip_sirk_read(const struct l2cap_frame *frame)
+{
+	if (frame->size)
+		print_hex_field("  SIRK", frame->data, frame->size);
+}
+
+static void csip_sirk_notify(const struct l2cap_frame *frame)
+{
+	if (frame->size)
+		print_hex_field("  SIRK", frame->data, frame->size);
+}
+
 static void print_vcs_state(const struct l2cap_frame *frame)
 {
 	uint8_t vol_set, mute, chng_ctr;
@@ -2413,6 +2480,12 @@ struct gatt_handler {
 	GATT_HANDLER(0x2b7d, vol_state_read, NULL, vol_state_notify),
 	GATT_HANDLER(0x2b7e, NULL, vol_cp_write, NULL),
 	GATT_HANDLER(0x2b7f, vol_flag_read, NULL, vol_flag_notify),
+
+	GATT_HANDLER(0x2b84, csip_sirk_read, NULL, csip_sirk_notify),
+	GATT_HANDLER(0x2b85, csip_size_read, NULL, csip_size_notify),
+	GATT_HANDLER(0x2b86, csip_lock_read, NULL, NULL),
+	GATT_HANDLER(0x2b87, csip_rank_read, NULL, NULL),
+
 	GATT_HANDLER(0x2b93, mp_name_read, NULL, mp_name_notify),
 	GATT_HANDLER(0x2b96, NULL, NULL, track_changed_notify),
 	GATT_HANDLER(0x2b97, track_title_read, NULL, track_title_notify),
-- 
2.25.1

