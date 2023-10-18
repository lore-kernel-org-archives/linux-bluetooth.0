Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6550CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjJRT5J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjJRT5F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 15:57:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37520B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:57:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca6809fb8aso26785285ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659020; x=1698263820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIOVb60mzA5Y5iiuFP/Lw8PVJQKXtDU/mQ8HCsyRNXc=;
        b=K2yoOCWsKnt64D6xL5F8+5rdjzT2B5jdoUnslCJUQb/nrla04yhqEyUvu6Dphm0cQL
         wZUD6ThC3ayYpHQlILACHmaJABRUDrU2RY3tE8vSpbBHfXw23SpIeitsPZ26nNrTNLe4
         qnFXH9ZlaE++00cWxpp3Ea8w4RtUUF489QwzEidhPRGWOHYz/1XX6QmLawvjhSkrdy0G
         uh/m7hxNMtryn3jsHn+gkkbrv0LeLROmwOEBh4cX0bv2oP+OtQgXOnOZAmLa4goKi8uO
         JTXoIIuC2Kv5Vuk5f4Qumakzcz22N7OHnc93yXHMqxATI1JfTeYQbMNlhKCF9SeZYOGh
         4LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659020; x=1698263820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIOVb60mzA5Y5iiuFP/Lw8PVJQKXtDU/mQ8HCsyRNXc=;
        b=VLjx108c3ErRt/OvugNt4JCYwWq/q4Xf/WESPgJmlzzLKo3fXL8MMTpu6Y/wB66pwi
         Me1+dryDxOff4MDM1WpMenRrri/RCL5DyoD8vh5oRF1ZnfSKSBnz78mJkJs4tuXHrlYx
         WVIF/4CB4QgH/93kAeBgc4FtXtNHlpVHJ6XIzqX98dHTuAFam64PVBo4qqT+nAQSrgLw
         XOPKX0EQHS4bd6ovrLzgiGFGym5210jrESakHW0Z9xxZbVMtLGoHL8pqO32fanZ7ex2r
         /GQVxHeG2E1kdue6peJQ41+Ds9pfL+KB4ogVXEuR4wKNGml6Isuebq7E9rnIpEL41WLN
         csTQ==
X-Gm-Message-State: AOJu0Yzzm2Ul4ZKpkwDId3BNSQS86sfLxvkdvsQ1W4Co801rMB30nMLC
        1Q/fGD21Bp6CWkpidy/CYCI7S6Ej8rRZ2qrvlaU=
X-Google-Smtp-Source: AGHT+IHCTLMl8jSqNm8gHrRr4pf5OEJbowSaO0Qx6EpbmSnHQBSW3d2HiVI7k07qfHRdxTdB6LNopQ==
X-Received: by 2002:a17:902:9a4b:b0:1c9:bca1:d70c with SMTP id x11-20020a1709029a4b00b001c9bca1d70cmr340833plv.30.1697659019578;
        Wed, 18 Oct 2023 12:56:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001b3bf8001a9sm329739plb.48.2023.10.18.12.56.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:56:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/bap: Add debug helpers
Date:   Wed, 18 Oct 2023 12:56:52 -0700
Message-ID: <20231018195653.2532882-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018195653.2532882-1-luiz.dentz@gmail.com>
References: <20231018195653.2532882-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bap-debug.{c.h} that implements function helpers that can be
used to print BAP/ASCS/PACS TLV entries.
---
 Makefile.am            |   1 +
 profiles/audio/media.c |   7 +-
 src/shared/bap-debug.c | 539 +++++++++++++++++++++++++++++++++++++++++
 src/shared/bap-debug.h |  14 ++
 src/shared/bap.c       |  60 +----
 src/shared/bap.h       |   3 -
 6 files changed, 564 insertions(+), 60 deletions(-)
 create mode 100644 src/shared/bap-debug.c
 create mode 100644 src/shared/bap-debug.h

diff --git a/Makefile.am b/Makefile.am
index 6187f298e81a..e9a952e72d69 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,6 +231,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gap.h src/shared/gap.c \
 			src/shared/log.h src/shared/log.c \
 			src/shared/bap.h src/shared/bap.c src/shared/ascs.h \
+			src/shared/bap-debug.h src/shared/bap-debug.c \
 			src/shared/mcs.h src/shared/mcp.h src/shared/mcp.c \
 			src/shared/vcp.c src/shared/vcp.h \
 			src/shared/micp.c src/shared/micp.h \
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 1d98ac5a1a70..825f3cf97f5f 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -42,6 +42,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/bap.h"
+#include "src/shared/bap-debug.h"
 
 #include "avdtp.h"
 #include "media.h"
@@ -1217,13 +1218,13 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	if (!bap_print_cc(endpoint->capabilities, endpoint->size, bap_debug,
-								NULL)) {
+	if (!bt_bap_debug_caps(endpoint->capabilities, endpoint->size,
+				bap_debug, NULL)) {
 		error("Unable to parse endpoint capabilities");
 		return false;
 	}
 
-	if (!bap_print_cc(endpoint->metadata, endpoint->metadata_size,
+	if (!bt_bap_debug_metadata(endpoint->metadata, endpoint->metadata_size,
 					bap_debug, NULL)) {
 		error("Unable to parse endpoint metadata");
 		return false;
diff --git a/src/shared/bap-debug.c b/src/shared/bap-debug.c
new file mode 100644
index 000000000000..20dc3a1419c0
--- /dev/null
+++ b/src/shared/bap-debug.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation.
+ */
+
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "src/shared/util.h"
+#include "src/shared/bap-debug.h"
+
+static const struct util_bit_debugger pac_freq_table[] = {
+	UTIL_BIT_DEBUG(0, "\t8 Khz (0x0001)"),
+	UTIL_BIT_DEBUG(1, "\t11.25 Khz (0x0002)"),
+	UTIL_BIT_DEBUG(2, "\t16 Khz (0x0004)"),
+	UTIL_BIT_DEBUG(3, "\t22.05 Khz (0x0008)"),
+	UTIL_BIT_DEBUG(4, "\t24 Khz (0x0010)"),
+	UTIL_BIT_DEBUG(5, "\t32 Khz (0x0020)"),
+	UTIL_BIT_DEBUG(6, "\t44.1 Khz (0x0040)"),
+	UTIL_BIT_DEBUG(7, "\t48 Khz (0x0080)"),
+	UTIL_BIT_DEBUG(8, "\t88.2 Khz (0x0100)"),
+	UTIL_BIT_DEBUG(9, "\t96 Khz (0x0200)"),
+	UTIL_BIT_DEBUG(10, "\t176.4 Khz (0x0400)"),
+	UTIL_BIT_DEBUG(11, "\t192 Khz (0x0800)"),
+	UTIL_BIT_DEBUG(12, "\t384 Khz (0x1000)"),
+	UTIL_BIT_DEBUG(13, "\tRFU (0x2000)"),
+	UTIL_BIT_DEBUG(14, "\tRFU (0x4000)"),
+	UTIL_BIT_DEBUG(15, "\tRFU (0x8000)"),
+	{ }
+};
+
+static void pac_debug_freq(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint16_t value;
+	uint16_t mask;
+
+	if (!util_iov_pull_le16(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Sampling Frequencies: 0x%4.4x", value);
+
+	mask = util_debug_bit(value, pac_freq_table, func, user_data);
+	if (mask)
+		util_debug(func, user_data, "Unknown fields (0x%4.4x)",
+						mask);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+					user_data);
+}
+
+static const struct util_bit_debugger pac_duration_table[] = {
+	UTIL_BIT_DEBUG(0, "\t7.5 ms (0x01)"),
+	UTIL_BIT_DEBUG(1, "\t10 ms (0x02)"),
+	UTIL_BIT_DEBUG(2, "\tRFU (0x04)"),
+	UTIL_BIT_DEBUG(3, "\tRFU (0x08)"),
+	UTIL_BIT_DEBUG(4, "\t7.5 ms preferred (0x10)"),
+	UTIL_BIT_DEBUG(5, "\t10 ms preferred (0x20)"),
+	UTIL_BIT_DEBUG(6, "\tRFU (0x40)"),
+	UTIL_BIT_DEBUG(7, "\tRFU (0x80)"),
+	{ }
+};
+
+static void pac_debug_duration(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+	uint8_t mask;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Frame Duration: 0x%2.2x", value);
+
+	mask = util_debug_bit(value, pac_duration_table, func, user_data);
+	if (mask)
+		util_debug(func, user_data, "Unknown fields (0x%2.2x)",
+					mask);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+					user_data);
+}
+
+static const struct util_bit_debugger pac_channel_table[] = {
+	UTIL_BIT_DEBUG(0, "\t1 channel (0x01)"),
+	UTIL_BIT_DEBUG(1, "\t2 channel (0x02)"),
+	UTIL_BIT_DEBUG(2, "\t3 channel (0x04)"),
+	UTIL_BIT_DEBUG(3, "\t4 channel (0x08)"),
+	UTIL_BIT_DEBUG(4, "\t5 channel (0x10)"),
+	UTIL_BIT_DEBUG(5, "\t6 channel (0x20)"),
+	UTIL_BIT_DEBUG(6, "\t7 channel (0x40)"),
+	UTIL_BIT_DEBUG(7, "\t8 channel (0x80)"),
+	{ }
+};
+
+static void pac_debug_channels(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+	uint8_t mask;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Audio Channel Count: 0x%2.2x", value);
+
+	mask = util_debug_bit(value, pac_channel_table, func, user_data);
+	if (mask)
+		util_debug(func, user_data, "Unknown fields (0x%2.2x)",
+					mask);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+					user_data);
+}
+
+static void pac_debug_frame_length(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint16_t min, max;
+
+	if (!util_iov_pull_le16(&frame, &min)) {
+		util_debug(func, user_data, "min: invalid size");
+		goto done;
+	}
+
+	if (!util_iov_pull_le16(&frame, &max)) {
+		util_debug(func, user_data, "max: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data,
+			"Frame Length: %u (0x%4.4x) - %u (0x%4.4x)",
+			min, min, max, max);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+					user_data);
+}
+
+static void pac_debug_sdu(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Max SDU: %u (0x%2.2x)", value, value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+					user_data);
+}
+
+struct util_ltv_debugger pac_cap_table[] = {
+	UTIL_LTV_DEBUG(0x01, pac_debug_freq),
+	UTIL_LTV_DEBUG(0x02, pac_debug_duration),
+	UTIL_LTV_DEBUG(0x03, pac_debug_channels),
+	UTIL_LTV_DEBUG(0x04, pac_debug_frame_length),
+	UTIL_LTV_DEBUG(0x05, pac_debug_sdu)
+};
+
+bool bt_bap_debug_caps(void *data, size_t len, util_debug_func_t func,
+						void *user_data)
+{
+	return util_debug_ltv(data, len, pac_cap_table,
+				ARRAY_SIZE(pac_cap_table),
+				func, user_data);
+}
+
+static void ase_debug_freq(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	switch (value) {
+	case 0x01:
+		util_debug(func, user_data, "Sampling Frequency: 8 Khz (0x01)");
+		break;
+	case 0x02:
+		util_debug(func, user_data,
+				"Sampling Frequency: 11.25 Khz (0x02)");
+		break;
+	case 0x03:
+		util_debug(func, user_data,
+				"Sampling Frequency: 16 Khz (0x03)");
+		break;
+	case 0x04:
+		util_debug(func, user_data,
+				"Sampling Frequency: 22.05 Khz (0x04)");
+		break;
+	case 0x05:
+		util_debug(func, user_data,
+				"Sampling Frequency: 24 Khz (0x05)");
+		break;
+	case 0x06:
+		util_debug(func, user_data,
+				"Sampling Frequency: 32 Khz (0x06)");
+		break;
+	case 0x07:
+		util_debug(func, user_data,
+				"Sampling Frequency: 44.1 Khz (0x07)");
+		break;
+	case 0x08:
+		util_debug(func, user_data,
+				"Sampling Frequency: 48 Khz (0x08)");
+		break;
+	case 0x09:
+		util_debug(func, user_data,
+				"Sampling Frequency: 88.2 Khz (0x09)");
+		break;
+	case 0x0a:
+		util_debug(func, user_data,
+				"Sampling Frequency: 96 Khz (0x0a)");
+		break;
+	case 0x0b:
+		util_debug(func, user_data,
+				"Sampling Frequency: 176.4 Khz (0x0b)");
+		break;
+	case 0x0c:
+		util_debug(func, user_data,
+				"Sampling Frequency: 192 Khz (0x0c)");
+		break;
+	case 0x0d:
+		util_debug(func, user_data,
+				"Sampling Frequency: 384 Khz (0x0d)");
+		break;
+	default:
+		util_debug(func, user_data,
+				"Sampling Frequency: RFU (0x%2.2x)", value);
+		break;
+	}
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_duration(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "\tvalue: invalid size\n");
+		goto done;
+	}
+
+	switch (value) {
+	case 0x00:
+		util_debug(func, user_data, "Frame Duration: 7.5 ms (0x00)");
+		break;
+	case 0x01:
+		util_debug(func, user_data, "Frame Duration: 10 ms (0x01)");
+		break;
+	default:
+		util_debug(func, user_data, "Frame Duration: RFU (0x%2.2x)",
+				value);
+		break;
+	}
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static const struct util_bit_debugger channel_location_table[] = {
+	UTIL_BIT_DEBUG(0, "\tFront Left (0x00000001)"),
+	UTIL_BIT_DEBUG(1, "\tFront Right (0x00000002)"),
+	UTIL_BIT_DEBUG(2, "\tFront Center (0x00000004)"),
+	UTIL_BIT_DEBUG(3, "\tLow Frequency Effects 1 (0x00000008)"),
+	UTIL_BIT_DEBUG(4, "\tBack Left (0x00000010)"),
+	UTIL_BIT_DEBUG(5, "\tBack Right (0x00000020)"),
+	UTIL_BIT_DEBUG(6, "\tFront Left of Center (0x00000040)"),
+	UTIL_BIT_DEBUG(7, "\tFront Right of Center (0x00000080)"),
+	UTIL_BIT_DEBUG(8, "\tBack Center (0x00000100)"),
+	UTIL_BIT_DEBUG(9, "\tLow Frequency Effects 2 (0x00000200)"),
+	UTIL_BIT_DEBUG(10, "\tSide Left (0x00000400)"),
+	UTIL_BIT_DEBUG(11, "\tSide Right (0x00000800)"),
+	UTIL_BIT_DEBUG(12, "\tTop Front Left (0x00001000)"),
+	UTIL_BIT_DEBUG(13, "\tTop Front Right (0x00002000)"),
+	UTIL_BIT_DEBUG(14, "\tTop Front Center (0x00004000)"),
+	UTIL_BIT_DEBUG(15, "\tTop Center (0x00008000)"),
+	UTIL_BIT_DEBUG(16, "\tTop Back Left (0x00010000)"),
+	UTIL_BIT_DEBUG(17, "\tTop Back Right (0x00020000)"),
+	UTIL_BIT_DEBUG(18, "\tTop Side Left (0x00040000)"),
+	UTIL_BIT_DEBUG(19, "\tTop Side Right (0x00080000)"),
+	UTIL_BIT_DEBUG(20, "\tTop Back Center (0x00100000)"),
+	UTIL_BIT_DEBUG(21, "\tBottom Front Center (0x00200000)"),
+	UTIL_BIT_DEBUG(22, "\tBottom Front Left (0x00400000)"),
+	UTIL_BIT_DEBUG(23, "\tBottom Front Right (0x00800000)"),
+	UTIL_BIT_DEBUG(24, "\tFront Left Wide (0x01000000)"),
+	UTIL_BIT_DEBUG(25, "\tFront Right Wide (0x02000000)"),
+	UTIL_BIT_DEBUG(26, "\tLeft Surround (0x04000000)"),
+	UTIL_BIT_DEBUG(27, "\tRight Surround (0x08000000)"),
+	UTIL_BIT_DEBUG(28, "\tRFU (0x10000000)"),
+	UTIL_BIT_DEBUG(29, "\tRFU (0x20000000)"),
+	UTIL_BIT_DEBUG(30, "\tRFU (0x40000000)"),
+	UTIL_BIT_DEBUG(31, "\tRFU (0x80000000)"),
+	{ }
+};
+
+static void debug_location(const struct iovec *frame, util_debug_func_t func,
+				void *user_data)
+{
+	uint32_t value;
+	uint32_t mask;
+
+	if (!util_iov_pull_le32((void *)frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Location: 0x%8.8x", value);
+
+	mask = util_debug_bit(value, channel_location_table, func, user_data);
+	if (mask)
+		util_debug(func, user_data, "Unknown fields (0x%8.8x)", mask);
+
+done:
+	if (frame->iov_len)
+		util_hexdump(' ', frame->iov_base, frame->iov_len, func,
+				user_data);
+}
+
+static void ase_debug_location(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+
+	debug_location(&frame, func, user_data);
+}
+
+static void ase_debug_frame_length(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint16_t value;
+
+	if (!util_iov_pull_le16(&frame, &value)) {
+		util_debug(func, user_data, "\tvalue: invalid size\n");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Frame Length: %u (0x%4.4x)",
+				value, value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_blocks(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Frame Blocks per SDU: %u (0x%2.2x)",
+				value, value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+struct util_ltv_debugger ase_cc_table[] = {
+	UTIL_LTV_DEBUG(0x01, ase_debug_freq),
+	UTIL_LTV_DEBUG(0x02, ase_debug_duration),
+	UTIL_LTV_DEBUG(0x03, ase_debug_location),
+	UTIL_LTV_DEBUG(0x04, ase_debug_frame_length),
+	UTIL_LTV_DEBUG(0x05, ase_debug_blocks)
+};
+
+bool bt_bap_debug_config(void *data, size_t len, util_debug_func_t func,
+						void *user_data)
+{
+	return util_debug_ltv(data, len, ase_cc_table,
+				ARRAY_SIZE(ase_cc_table),
+				func, user_data);
+}
+
+static const struct util_bit_debugger pac_context_table[] = {
+	UTIL_BIT_DEBUG(0, "\tUnspecified (0x0001)"),
+	UTIL_BIT_DEBUG(1, "\tConversational (0x0002)"),
+	UTIL_BIT_DEBUG(2, "\tMedia (0x0004)"),
+	UTIL_BIT_DEBUG(3, "\tGame (0x0008)"),
+	UTIL_BIT_DEBUG(4, "\tInstructional (0x0010)"),
+	UTIL_BIT_DEBUG(5, "\tVoice Assistants (0x0020)"),
+	UTIL_BIT_DEBUG(6, "\tLive (0x0040)"),
+	UTIL_BIT_DEBUG(7, "\tSound Effects (0x0080)"),
+	UTIL_BIT_DEBUG(8, "\tNotifications (0x0100)"),
+	UTIL_BIT_DEBUG(9, "\tRingtone (0x0200)"),
+	UTIL_BIT_DEBUG(10, "\tAlerts (0x0400)"),
+	UTIL_BIT_DEBUG(11, "\tEmergency alarm (0x0800)"),
+	UTIL_BIT_DEBUG(12, "\tRFU (0x1000)"),
+	UTIL_BIT_DEBUG(13, "\tRFU (0x2000)"),
+	UTIL_BIT_DEBUG(14, "\tRFU (0x4000)"),
+	UTIL_BIT_DEBUG(15, "\tRFU (0x8000)"),
+	{ }
+};
+
+static void debug_context(const struct iovec *frame, const char *label,
+				util_debug_func_t func, void *user_data)
+{
+	uint16_t value;
+	uint16_t mask;
+
+	if (!util_iov_pull_le16((void *)frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "%s: 0x%4.4x", label, value);
+
+	mask = util_debug_bit(value, pac_context_table, func, user_data);
+	if (mask)
+		util_debug(func, user_data, "Unknown fields (0x%4.4x)", mask);
+
+done:
+	if (frame->iov_len)
+		util_hexdump(' ', frame->iov_base, frame->iov_len, func,
+				user_data);
+}
+
+static void ase_debug_preferred_context(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+
+	debug_context(&frame, "Preferred Context", func, user_data);
+}
+
+static void ase_debug_context(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+
+	debug_context(&frame, "Context", func, user_data);
+}
+
+static void ase_debug_program_info(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	const char *str;
+
+	str = util_iov_pull_mem(&frame, len);
+	if (!str) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Program Info: %*s", len, str);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_language(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint32_t value;
+
+	if (!util_iov_pull_le24(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Language: 0x%6.6x\n", value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+struct util_ltv_debugger ase_metadata_table[] = {
+	UTIL_LTV_DEBUG(0x01, ase_debug_preferred_context),
+	UTIL_LTV_DEBUG(0x02, ase_debug_context),
+	UTIL_LTV_DEBUG(0x03, ase_debug_program_info),
+	UTIL_LTV_DEBUG(0x04, ase_debug_language)
+};
+
+bool bt_bap_debug_metadata(void *data, size_t len, util_debug_func_t func,
+						void *user_data)
+{
+	return util_debug_ltv(data, len, ase_metadata_table,
+				ARRAY_SIZE(ase_metadata_table),
+				func, user_data);
+}
diff --git a/src/shared/bap-debug.h b/src/shared/bap-debug.h
new file mode 100644
index 000000000000..93f3b18e17c4
--- /dev/null
+++ b/src/shared/bap-debug.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation.
+ */
+
+bool bt_bap_debug_caps(void *data, size_t len, util_debug_func_t func,
+						void *user_data);
+bool bt_bap_debug_config(void *data, size_t len, util_debug_func_t func,
+						void *user_data);
+bool bt_bap_debug_metadata(void *data, size_t len, util_debug_func_t func,
+						void *user_data);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 925501c48d98..29c0d85854ce 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -29,6 +29,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bap.h"
 #include "src/shared/ascs.h"
+#include "src/shared/bap-debug.h"
 
 /* Maximum number of ASE(s) */
 #define NUM_SINKS 2
@@ -1568,7 +1569,7 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	cc.iov_base = util_iov_pull_mem(iov, req->cc_len);
 	cc.iov_len = req->cc_len;
 
-	if (!bap_print_cc(cc.iov_base, cc.iov_len, bap->debug_func,
+	if (!bt_bap_debug_caps(cc.iov_base, cc.iov_len, bap->debug_func,
 						bap->debug_data)) {
 		ascs_ase_rsp_add(rsp, req->ase,
 				BT_ASCS_RSP_CONF_INVALID,
@@ -1735,49 +1736,6 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 	return 0;
 }
 
-static bool bap_print_ltv(const char *label, void *data, size_t len,
-				util_debug_func_t func, void *user_data)
-{
-	struct iovec iov = {
-		.iov_base = data,
-		.iov_len = len,
-	};
-	int i;
-
-	util_debug(func, user_data, "Length %zu", iov.iov_len);
-
-	for (i = 0; iov.iov_len > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *data;
-
-		if (!ltv) {
-			util_debug(func, user_data, "Unable to parse %s",
-								label);
-			return false;
-		}
-
-		util_debug(func, user_data, "%s #%u: len %u type %u",
-					label, i, ltv->len, ltv->type);
-
-		data = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!data) {
-			util_debug(func, user_data, "Unable to parse %s",
-								label);
-			return false;
-		}
-
-		util_hexdump(' ', ltv->value, ltv->len - 1, func, user_data);
-	}
-
-	return true;
-}
-
-static bool bap_print_metadata(void *data, size_t len, util_debug_func_t func,
-						void *user_data)
-{
-	return bap_print_ltv("Metadata", data, len, func, user_data);
-}
-
 static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 			struct bt_ascs_enable *req, struct iovec *iov,
 			struct iovec *rsp)
@@ -1801,8 +1759,8 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	meta.iov_base = util_iov_pull_mem(iov, req->meta.len);
 	meta.iov_len = req->meta.len;
 
-	if (!bap_print_metadata(meta.iov_base, meta.iov_len, bap->debug_func,
-							bap->debug_data)) {
+	if (!bt_bap_debug_metadata(meta.iov_base, meta.iov_len,
+					bap->debug_func, bap->debug_data)) {
 		ascs_ase_rsp_add(rsp, ep->id,
 				BT_ASCS_RSP_METADATA_INVALID,
 				BT_ASCS_REASON_NONE);
@@ -3175,12 +3133,6 @@ static void bap_notify_ready(struct bt_bap *bap)
 	bt_bap_unref(bap);
 }
 
-bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
-						void *user_data)
-{
-	return bap_print_ltv("CC", data, len, func, user_data);
-}
-
 static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 				struct queue *queue,
 				const uint8_t *value,
@@ -3221,7 +3173,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 
 		pac = NULL;
 
-		if (!bap_print_cc(iov.iov_base, p->cc_len, bap->debug_func,
+		if (!bt_bap_debug_caps(iov.iov_base, p->cc_len, bap->debug_func,
 					bap->debug_data))
 			return;
 
@@ -4632,7 +4584,7 @@ unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 		iov[0].iov_len = sizeof(config);
 
 		if (data) {
-			if (!bap_print_cc(data->iov_base, data->iov_len,
+			if (!bt_bap_debug_caps(data->iov_base, data->iov_len,
 						stream->bap->debug_func,
 						stream->bap->debug_data))
 				return 0;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index ebe4dbf7d858..23edbf4c6953 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -201,9 +201,6 @@ void bt_bap_detach(struct bt_bap *bap);
 bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
 			void *user_data, bt_bap_destroy_func_t destroy);
 
-bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
-						void *user_data);
-
 unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy);
-- 
2.41.0

