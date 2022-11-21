Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD07C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKUXqz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiKUXqU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00276C6947
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074288; x=1700610288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HjTXE6yASm4fnculIMu637JkLzu9jsyaoxsbFGWhJY=;
  b=nQGoNp1qtsgIo1BFxaR32SH2eH+DrxmGG188syaHIV3mrN7cFOwLd7FQ
   8j9P7+7GYB1i8KQCAWsmYVppH8km+0ashqjLM6ikjDNexiAKdFt/SamXE
   NSjL2XU7h7wuB6NCfuY7OlvTEtP5fVu3emM2xQRinAcHY+HZORF1OHisS
   18pRzd2bzONqBjwJqpX9eRR7KQrKMQlr47TYz/8MZ1YFtvrg0IDdlI3tQ
   HD+jRYLQaQFm4a4UCuzxr2X8BysO23Oj1RoOBqR7b1YSAFWYw+QTNn6IH
   YxypcJXvVTV1Or7p8tTID9n1TRkmas8VvggoRTVCo5yr+/G63qpufSkkN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377946609"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377946609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783633470"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783633470"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2022 15:44:46 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 5/6] monitor/att: Add decoding support for CSIP
Date:   Tue, 22 Nov 2022 05:16:23 +0530
Message-Id: <20221121234624.2961-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121234624.2961-1-sathish.narasimman@intel.com>
References: <20221121234624.2961-1-sathish.narasimman@intel.com>
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

