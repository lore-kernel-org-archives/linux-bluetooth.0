Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB03C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJFOfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiJFOfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:35:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870A83F19
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665066938; x=1696602938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c436BQecQNI2dks+MDUs/y6/usuVOpiOxHqKGGFJWYI=;
  b=dxPpHVxFWCD2kaivoZxJhFUTznC8IRQ2dddHa8uoJCFN6MGNZbXkqrrE
   qrFFCfVySvInp4Jg32rOTk738xic9M8clHC+n91fOR/vfmvykcuw2XL1G
   RJqdiBvikIVD9g6+eYQ13PWV5O9nyshrOonkWtTCVxEp1xaiYHow2ktX+
   Mwma0o+Q0uEW14bUiOa8CRORBCPIUPfkywXRBJIKHpMSZDtogp1EOVALu
   643Vsu06PAP5GT/ZqTYv4uM0vmcoeIqLYmHy04A8g6KPqV7T8PK2e7lEA
   qB/merPg86Xx+5bMh8a/QjNlEZKOdGYAB9UpuYO0lrRoOMrcbXC96tBIy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301059148"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="301059148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693373601"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="693373601"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2022 07:35:32 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 4/4] monitor/att: Add decoding support for GMCS
Date:   Thu,  6 Oct 2022 20:03:43 +0530
Message-Id: <20221006143343.199055-5-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
References: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds decoding support for GMCS attributes.

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0056 Type: Media Control Point Opcodes Supported (0x2ba5)
> ACL Data RX: Handle 3585 flags 0x02 dlen 9
      ATT: Read Response (0x0b) len 4
        Value: 33180000
        Handle: 0x0056 Type: Media Control Point Opcodes Supported (0x2ba5)
              Supported Opcodes: 0x00001833
                Play (0x00000001)
                Pause (0x00000002)
                Stop (0x00000010)
                Move Relative (0x00000020)
                Previous Track (0x00000800)
                Next Track (0x00001000)
---
 monitor/att.c | 511 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 511 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index f5fc32cb0..1bb9f58f6 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -14,6 +14,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -22,6 +23,8 @@
 #include <errno.h>
 #include <linux/limits.h>
 
+#include <glib.h>
+
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 #include "lib/hci.h"
@@ -1746,6 +1749,497 @@ static void vol_flag_notify(const struct l2cap_frame *frame)
 	print_vcs_flag(frame);
 }
 
+static char *name2utf8(const uint8_t *name, uint16_t len)
+{
+    char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+    int i;
+
+    if (g_utf8_validate((const char *) name, len, NULL))
+        return g_strndup((char *) name, len);
+
+    len = MIN(len, sizeof(utf8_name) - 1);
+
+    memset(utf8_name, 0, sizeof(utf8_name));
+    strncpy(utf8_name, (char *) name, len);
+
+    /* Assume ASCII, and replace all non-ASCII with spaces */
+    for (i = 0; utf8_name[i] != '\0'; i++) {
+        if (!isascii(utf8_name[i]))
+            utf8_name[i] = ' ';
+    }
+
+    /* Remove leading and trailing whitespace characters */
+    g_strstrip(utf8_name);
+
+    return g_strdup(utf8_name);
+}
+
+static void print_mp_name(const struct l2cap_frame *frame)
+{
+	char *name;
+
+	name = name2utf8((uint8_t *)frame->data, frame->size);
+
+	print_field("  Media Player Name: %s", name);
+}
+
+static void mp_name_read(const struct l2cap_frame *frame)
+{
+	print_mp_name(frame);
+}
+
+static void mp_name_notify(const struct l2cap_frame *frame)
+{
+	print_mp_name(frame);
+}
+
+static void print_track_changed(const struct l2cap_frame *frame)
+{
+	print_field("  Track Changed");
+}
+
+static void track_changed_notify(const struct l2cap_frame *frame)
+{
+	print_track_changed(frame);
+}
+
+static void print_track_title(const struct l2cap_frame *frame)
+{
+	char *name;
+
+	name = name2utf8((uint8_t *)frame->data, frame->size);
+
+	print_field("  Track Title: %s", name);
+}
+
+static void track_title_read(const struct l2cap_frame *frame)
+{
+	print_track_title(frame);
+}
+
+static void track_title_notify(const struct l2cap_frame *frame)
+{
+	print_track_title(frame);
+}
+
+static void print_track_duration(const struct l2cap_frame *frame)
+{
+	int32_t duration;
+
+	if (!l2cap_frame_get_le32((void *)frame, (uint32_t *)&duration)) {
+		print_text(COLOR_ERROR, "  Track Duration: invalid size");
+		goto done;
+	}
+
+	print_field("  Track Duration: %u", duration);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void track_duration_read(const struct l2cap_frame *frame)
+{
+	print_track_duration(frame);
+}
+
+static void track_duration_notify(const struct l2cap_frame *frame)
+{
+	print_track_duration(frame);
+}
+
+static void print_track_position(const struct l2cap_frame *frame)
+{
+	int32_t position;
+
+	if (!l2cap_frame_get_le32((void *)frame, (uint32_t *)&position)) {
+		print_text(COLOR_ERROR, "  Track Position: invalid size");
+		goto done;
+	}
+
+	print_field("  Track Position: %u", position);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void track_position_read(const struct l2cap_frame *frame)
+{
+	print_track_position(frame);
+}
+
+static void track_position_write(const struct l2cap_frame *frame)
+{
+	print_track_position(frame);
+}
+
+static void track_position_notify(const struct l2cap_frame *frame)
+{
+	print_track_position(frame);
+}
+
+static void print_playback_speed(const struct l2cap_frame *frame)
+{
+	int8_t playback_speed;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&playback_speed)) {
+		print_text(COLOR_ERROR, "  Playback Speed: invalid size");
+		goto done;
+	}
+
+	print_field("  Playback Speed: %u", playback_speed);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void playback_speed_read(const struct l2cap_frame *frame)
+{
+	print_playback_speed(frame);
+}
+
+static void playback_speed_write(const struct l2cap_frame *frame)
+{
+	print_playback_speed(frame);
+}
+
+static void playback_speed_notify(const struct l2cap_frame *frame)
+{
+	print_playback_speed(frame);
+}
+
+static void print_seeking_speed(const struct l2cap_frame *frame)
+{
+	int8_t seeking_speed;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&seeking_speed)) {
+		print_text(COLOR_ERROR, "  Seeking Speed: invalid size");
+		goto done;
+	}
+
+	print_field("  Seeking Speed: %u", seeking_speed);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void seeking_speed_read(const struct l2cap_frame *frame)
+{
+	print_seeking_speed(frame);
+}
+
+static void seeking_speed_notify(const struct l2cap_frame *frame)
+{
+	print_seeking_speed(frame);
+}
+
+const char *play_order_str(uint8_t order)
+{
+	switch (order) {
+	case 0x01:
+		return "Single once";
+	case 0x02:
+		return "Single repeat";
+	case 0x03:
+		return "In order once";
+	case 0x04:
+		return "In order repeat";
+	case 0x05:
+		return "Oldest once";
+	case 0x06:
+		return "Oldest repeat";
+	case 0x07:
+		return "Newest once";
+	case 0x08:
+		return "Newest repeat";
+	case 0x09:
+		return "Shuffle once";
+	case 0x0A:
+		return "Shuffle repeat";
+	default:
+		return "RFU";
+	}
+}
+
+static void print_playing_order(const struct l2cap_frame *frame)
+{
+	int8_t playing_order;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&playing_order)) {
+		print_text(COLOR_ERROR, "  Playing Order: invalid size");
+		goto done;
+	}
+
+	print_field("  Playing Order: %s", play_order_str(playing_order));
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void playing_order_read(const struct l2cap_frame *frame)
+{
+	print_playing_order(frame);
+}
+
+static void playing_order_write(const struct l2cap_frame *frame)
+{
+	print_playing_order(frame);
+}
+
+static void playing_order_notify(const struct l2cap_frame *frame)
+{
+	print_playing_order(frame);
+}
+
+static const struct bitfield_data playing_orders_table[] = {
+	{  0, "Single once (0x0001)"	    },
+	{  1, "Single repeat (0x0002)"		},
+	{  2, "In order once (0x0004)"		},
+	{  3, "In Order Repeat (0x0008)"	},
+	{  4, "Oldest once (0x0010)"		},
+	{  5, "Oldest repeat (0x0020)"		},
+	{  6, "Newest once (0x0040)"		},
+	{  7, "Newest repeat (0x0080)"	    },
+	{  8, "Shuffle once (0x0100)"		},
+	{  9, "Shuffle repeat (0x0200)"		},
+	{  10, "RFU (0x0400)"			    },
+	{  11, "RFU (0x0800)"		        },
+	{  12, "RFU (0x1000)"				},
+	{  13, "RFU (0x2000)"				},
+	{  14, "RFU (0x4000)"				},
+	{  15, "RFU (0x8000)"				},
+	{ }
+};
+
+static void print_playing_orders_supported(const struct l2cap_frame *frame)
+{
+	uint16_t supported_orders;
+	uint16_t mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &supported_orders)) {
+		print_text(COLOR_ERROR, "    Supported Playing Orders: invalid size");
+		goto done;
+	}
+
+	print_field("      Supported Playing Orders: 0x%4.4x", supported_orders);
+
+	mask = print_bitfield(8, supported_orders, playing_orders_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("    Data", frame->data, frame->size);
+}
+
+static void playing_orders_supported_read(const struct l2cap_frame *frame)
+{
+	print_playing_orders_supported(frame);
+}
+
+const char *media_state_str(uint8_t state)
+{
+	switch (state) {
+	case 0x00:
+		return "Inactive";
+	case 0x01:
+		return "Playing";
+	case 0x02:
+		return "Paused";
+	case 0x03:
+		return "Seeking";
+	default:
+		return "RFU";
+	}
+}
+
+static void print_media_state(const struct l2cap_frame *frame)
+{
+	int8_t state;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&state)) {
+		print_text(COLOR_ERROR, "  Media State: invalid size");
+		goto done;
+	}
+
+	print_field("  Media State: %s", media_state_str(state));
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void media_state_read(const struct l2cap_frame *frame)
+{
+	print_media_state(frame);
+}
+
+static void media_state_notify(const struct l2cap_frame *frame)
+{
+	print_media_state(frame);
+}
+
+struct media_cp_opcode {
+	uint8_t opcode;
+	const char *opcode_str;
+} media_cp_opcode_table[] = {
+	{0x01, "Play"},
+	{0x02 ,	"Pause"},
+	{0x03 ,	"Fast Rewind"},
+	{0x04 ,	"Fast Forward"},
+	{0x05 ,	"Stop"},
+	{0x10 ,	"Move Relative"},
+	{0x20 ,	"Previous Segment"},
+	{0x21 ,	"Next Segment"},
+	{0x22 ,	"First Segment"},
+	{0x23 ,	"Last Segment"},
+	{0x24 ,	"Goto Segment"},
+	{0x30 ,	"Previous Track"},
+	{0x31 ,	"Next Track"},
+	{0x32 ,	"First Track"},
+	{0x33 ,	"Last Track"},
+	{0x34 ,	"Goto Track"},
+	{0x40 ,	"Previous Group"},
+	{0x41 ,	"Next Group"},
+	{0x42 ,	"First Group"},
+	{0x43 ,	"Last Group"},
+	{0x44 ,	"Goto Group"},
+};
+
+const char *cp_opcode_str(uint8_t opcode)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(media_cp_opcode_table); i++) {
+		const char *str = media_cp_opcode_table[i].opcode_str;
+
+		if (opcode == media_cp_opcode_table[i].opcode)
+			return str;
+	}
+
+	return "RFU";
+}
+
+static void print_media_cp(const struct l2cap_frame *frame)
+{
+	int8_t opcode;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&opcode)) {
+		print_text(COLOR_ERROR, "  Media Control Point: invalid size");
+		goto done;
+	}
+
+	print_field("  Media Control Point: %s", cp_opcode_str(opcode));
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void media_cp_write(const struct l2cap_frame *frame)
+{
+	print_media_cp(frame);
+}
+
+static void media_cp_notify(const struct l2cap_frame *frame)
+{
+	print_media_cp(frame);
+}
+
+static const struct bitfield_data supported_opcodes_table[] = {
+    {0	, "Play (0x00000001)"				},
+    {1	, "Pause (0x00000002)"				},
+    {2	, "Fast Rewind	(0x00000004)"		},
+    {3	, "Fast Forward (0x00000008)"		},
+    {4	, "Stop (0x00000010)"				},
+    {5	, "Move Relative (0x00000020)"		},
+    {6	, "Previous Segment (0x00000040)"	},
+    {7	, "Next Segment (0x00000080)"		},
+    {8	, "First Segment (0x00000100)"		},
+    {9	, "Last Segment (0x00000200)"		},
+    {10	, "Goto Segment (0x00000400)"		},
+    {11	, "Previous Track (0x00000800)"     },
+    {12	, "Next Track (0x00001000)"		    },
+    {13	, "First Track (0x00002000)"		},
+    {14	, "Last Track (0x00004000)"		    },
+    {15	, "Goto Track (0x00008000)"		    },
+    {16	, "Previous Group (0x00010000)"	    },
+    {17	, "Next Group (0x00020000)"		    },
+    {18	, "First Group (0x00040000)"		},
+    {19	, "Last Group (0x00080000)"		    },
+    {20 , "Goto Group (0x00100000)"		    },
+    {21	, "RFU (0x00200000)"				},
+    {22	, "RFU (0x00400000)"				},
+    {23	, "RFU (0x00800000)"				},
+    {24	, "RFU (0x01000000)"				},
+    {25	, "RFU (0x02000000)"				},
+    {26	, "RFU (0x04000000)"				},
+    {27	, "RFU (0x08000000)"				},
+    {28	, "RFU (0x10000000)"				},
+    {29	, "RFU (0x20000000)"				},
+    {30	, "RFU (0x40000000)"				},
+    {31	, "RFU (0x80000000)"				},
+    { }
+};
+
+static void print_media_cp_op_supported(const struct l2cap_frame *frame)
+{
+	uint32_t supported_opcodes;
+	uint32_t mask;
+
+	if (!l2cap_frame_get_le32((void *)frame, &supported_opcodes)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("      Supported Opcodes: 0x%8.8x", supported_opcodes);
+
+	mask = print_bitfield(8, supported_opcodes, supported_opcodes_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%4.4x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("    Data", frame->data, frame->size);
+}
+
+static void media_cp_op_supported_read(const struct l2cap_frame *frame)
+{
+	print_media_cp_op_supported(frame);
+}
+
+static void media_cp_op_supported_notify(const struct l2cap_frame *frame)
+{
+	print_media_cp_op_supported(frame);
+}
+
+static void print_content_control_id(const struct l2cap_frame *frame)
+{
+	int8_t ccid;
+
+	if (!l2cap_frame_get_u8((void *)frame, (uint8_t *)&ccid)) {
+		print_text(COLOR_ERROR, "  Content Control ID: invalid size");
+		goto done;
+	}
+
+	print_field("  Content Control ID: 0x%2.2x", ccid);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void content_control_id_read(const struct l2cap_frame *frame)
+{
+	print_content_control_id(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -1776,6 +2270,23 @@ struct gatt_handler {
 	GATT_HANDLER(0x2b7d, vol_state_read, NULL, vol_state_notify),
 	GATT_HANDLER(0x2b7e, NULL, vol_cp_write, NULL),
 	GATT_HANDLER(0x2b7f, vol_flag_read, NULL, vol_flag_notify),
+	GATT_HANDLER(0x2b93, mp_name_read, NULL, mp_name_notify),
+	GATT_HANDLER(0x2b96, NULL, NULL, track_changed_notify),
+	GATT_HANDLER(0x2b97, track_title_read, NULL, track_title_notify),
+	GATT_HANDLER(0x2b98, track_duration_read, NULL, track_duration_notify),
+	GATT_HANDLER(0x2b99, track_position_read, track_position_write,
+					track_position_notify),
+	GATT_HANDLER(0x2b9a, playback_speed_read, playback_speed_write,
+					playback_speed_notify),
+	GATT_HANDLER(0x2b9b, seeking_speed_read, NULL, seeking_speed_notify),
+	GATT_HANDLER(0x2ba1, playing_order_read, playing_order_write,
+					playing_order_notify),
+	GATT_HANDLER(0x2ba2, playing_orders_supported_read, NULL, NULL),
+	GATT_HANDLER(0x2ba3, media_state_read, NULL, media_state_notify),
+	GATT_HANDLER(0x2ba4, NULL, media_cp_write, media_cp_notify),
+	GATT_HANDLER(0x2ba5, media_cp_op_supported_read, NULL,
+					media_cp_op_supported_notify),
+	GATT_HANDLER(0x2bba, content_control_id_read, NULL, NULL),
 };
 
 static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
-- 
2.25.1

