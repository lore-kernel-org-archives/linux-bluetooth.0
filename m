Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiKVKLI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiKVKLC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:11:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955053EEA
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111859; x=1700647859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4HQ33z5nrOXbGGIMeRdMYcJ7Biv0C4WPe9UtFDl0cs=;
  b=O9audZpc/R8TQq0Jx5B7Y2gs2Y12MuYhNlaIBSQPDWP0fDC04o13Xdfi
   vdI6fP4QzuRgem8lry0Zg5FWoGb3B8XDNbbJyz6zf4prlVYWES8yhB02w
   U6GD8wyKVGPcY1CJ2nEAsWSC9hxo+3MD1/EeUturFuDyg4VoMdFRSfViu
   QqUSx64kSEKUV442MGTeZCnCnnDxyLjAjdpy7r9YSGSAQZzYkWrDPNg3l
   9yjhqRGB0pIh5f13QH5vfvY4ewro4sdsE55CloQfc7zh/nEt+sXZOIysx
   pthdms7HKJw3R+fKvAC6GSXWEBnSycWSYP8Z5npVwnJ8VPFENExHSafAQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378039375"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378039375"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672431947"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672431947"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 02:10:58 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 6/7] monitor/att: Add decoding support for CSIP
Date:   Tue, 22 Nov 2022 15:42:31 +0530
Message-Id: <20221122101232.45320-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122101232.45320-1-sathish.narasimman@intel.com>
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds decoding support for CSIS attributes
> ACL Data RX: Handle 3585 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017 Type: Set Identity Resolving Key (0x2b84)
< ACL Data TX: Handle 3585 flags 0x00 dlen 22
      ATT: Read Response (0x0b) len 17
        Value: 01761fae703ed681f0c50b34155b6434fb
        Handle: 0x0017 Type: Set Identity Resolving Key (0x2b84)
          SIRK: 01761fae703ed681f0c50b34155b6434fb
> ACL Data RX: Handle 3585 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x001b Type: Csis Lock (0x2b86)
< ACL Data TX: Handle 3585 flags 0x00 dlen 6
      ATT: Read Response (0x0b) len 1
        Value: 01
        Handle: 0x001b Type: Csis Lock (0x2b86)
            CSIP LOCK: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x001e Type: Csis Rank (0x2b87)
< ACL Data TX: Handle 3585 flags 0x00 dlen 6
      ATT: Read Response (0x0b) len 1
        Value: 01
        Handle: 0x001e Type: Csis Rank (0x2b87)
            CSIP Rank: 1
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

