Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB855C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhKVVUT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhKVVUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 16:20:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E6C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:17:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y7so15271763plp.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDSVJqzBALYKp2X5NH6gB9CebriBpswNkvlIm83z31Y=;
        b=ivs95tGHKxybr9BhhdFsBfTHBWoDJVgAEBVuqlD0tm7SiazjTR57Utg+DzfHrSo9jX
         7KJp84clsOhT7yWcN8/aC1dUhhFoUcLNVzd+IrmIwFyhIglyqd6H/NYOA5/S2epZmZtY
         I5L4J/YKpiuXMg7jzB/guDjH1dHNY8x4yqGzaA8hg+G2bDlq6IpCutTN5xCpLpNqx55f
         UQN5QbyzKYqgtxBpsSknJEaywCYJZScM3wovf80TD4E6Sbi+XI8/g7ruepoKkLlVDlR6
         MP5uKKNgoFr+G8sv4cnFKiWR7QDOayT94QK0QsIMu9hxFGaqfPqIlHiacSb/As8IkQuP
         L/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDSVJqzBALYKp2X5NH6gB9CebriBpswNkvlIm83z31Y=;
        b=h7qQXjw9aLpE8qLFAxIA5stHl1A8xSEfAk39/afdKYTq9tdimDjJuuvshXjcXx7ppP
         8R93nRRoc3zTxhAqaUgeTOeurf3fGUg/GadNBqV3lnZL2Uz4Y+Ql6zmaaV2cIAPRLLWs
         YL4S3QOiJR1QqAAUnKSj2rduMY9D9Ds8zEuowNDMtPo8mlBOXHcB5/dhOL7OEftqTeiW
         DmXdQUwZijDnY2ohRfFiqlnJbrIai2BPq1DrBFkLvaoNKAOn2hAAnN6//YhDtdYwMMLC
         UNKzPL087PvruGAkFEMZ1dcDze//OIirSsy5uDSFk0HXZct+UHks6iFxHRJj9mbAxdSe
         NFzA==
X-Gm-Message-State: AOAM533JBtB/f5HpFpyOCOdTi1iID/PzikMPDjrnqS/Q0vhkejF9p/P4
        O0rVxp7kO9a1/e/XMgd7o+MtU1Zp8Ts=
X-Google-Smtp-Source: ABdhPJwOYRN4ZWUqp0DXZ4rvKbaK163UwSkWCwYFlgZZaJVVsq/VzbF8EiYcITEJ69oWFdZNTsjI2Q==
X-Received: by 2002:a17:90b:2502:: with SMTP id ns2mr35182476pjb.51.1637615828929;
        Mon, 22 Nov 2021 13:17:08 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z7sm10243406pfe.77.2021.11.22.13.17.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:17:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] uhid: Remove local copy of uhid header
Date:   Mon, 22 Nov 2021 13:17:07 -0800
Message-Id: <20211122211707.2219208-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

uhid.h is part of kernel uapi nowadays so it can be included
directly from linux/uhid.h so this removes the local copy to use it
instead.
---
 Makefile.plugins           |   2 +-
 profiles/input/uhid_copy.h | 199 -------------------------------------
 src/shared/uhid.h          |   3 +-
 3 files changed, 2 insertions(+), 202 deletions(-)
 delete mode 100644 profiles/input/uhid_copy.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 69fb01001..7693c767f 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -68,7 +68,7 @@ endif
 
 if HOG
 builtin_modules += hog
-builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
+builtin_sources += profiles/input/hog.c \
 			profiles/input/hog-lib.c profiles/input/hog-lib.h \
 			profiles/deviceinfo/dis.c profiles/deviceinfo/dis.h \
 			profiles/battery/bas.c profiles/battery/bas.h \
diff --git a/profiles/input/uhid_copy.h b/profiles/input/uhid_copy.h
deleted file mode 100644
index 0ef73d4cc..000000000
--- a/profiles/input/uhid_copy.h
+++ /dev/null
@@ -1,199 +0,0 @@
-#ifndef __UHID_H_
-#define __UHID_H_
-
-/*
- * User-space I/O driver support for HID subsystem
- * Copyright (c) 2012 David Herrmann
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- */
-
-/*
- * Public header for user-space communication. We try to keep every structure
- * aligned but to be safe we also use __attribute__((__packed__)). Therefore,
- * the communication should be ABI compatible even between architectures.
- */
-
-#include <linux/input.h>
-#include <linux/types.h>
-#include <linux/hid.h>
-
-enum uhid_event_type {
-	__UHID_LEGACY_CREATE,
-	UHID_DESTROY,
-	UHID_START,
-	UHID_STOP,
-	UHID_OPEN,
-	UHID_CLOSE,
-	UHID_OUTPUT,
-	__UHID_LEGACY_OUTPUT_EV,
-	__UHID_LEGACY_INPUT,
-	UHID_GET_REPORT,
-	UHID_GET_REPORT_REPLY,
-	UHID_CREATE2,
-	UHID_INPUT2,
-	UHID_SET_REPORT,
-	UHID_SET_REPORT_REPLY,
-};
-
-struct uhid_create2_req {
-	__u8 name[128];
-	__u8 phys[64];
-	__u8 uniq[64];
-	__u16 rd_size;
-	__u16 bus;
-	__u32 vendor;
-	__u32 product;
-	__u32 version;
-	__u32 country;
-	__u8 rd_data[HID_MAX_DESCRIPTOR_SIZE];
-} __attribute__((__packed__));
-
-enum uhid_dev_flag {
-	UHID_DEV_NUMBERED_FEATURE_REPORTS			= (1ULL << 0),
-	UHID_DEV_NUMBERED_OUTPUT_REPORTS			= (1ULL << 1),
-	UHID_DEV_NUMBERED_INPUT_REPORTS				= (1ULL << 2),
-};
-
-struct uhid_start_req {
-	__u64 dev_flags;
-};
-
-#define UHID_DATA_MAX 4096
-
-enum uhid_report_type {
-	UHID_FEATURE_REPORT,
-	UHID_OUTPUT_REPORT,
-	UHID_INPUT_REPORT,
-};
-
-struct uhid_input2_req {
-	__u16 size;
-	__u8 data[UHID_DATA_MAX];
-} __attribute__((__packed__));
-
-struct uhid_output_req {
-	__u8 data[UHID_DATA_MAX];
-	__u16 size;
-	__u8 rtype;
-} __attribute__((__packed__));
-
-struct uhid_get_report_req {
-	__u32 id;
-	__u8 rnum;
-	__u8 rtype;
-} __attribute__((__packed__));
-
-struct uhid_get_report_reply_req {
-	__u32 id;
-	__u16 err;
-	__u16 size;
-	__u8 data[UHID_DATA_MAX];
-} __attribute__((__packed__));
-
-struct uhid_set_report_req {
-	__u32 id;
-	__u8 rnum;
-	__u8 rtype;
-	__u16 size;
-	__u8 data[UHID_DATA_MAX];
-} __attribute__((__packed__));
-
-struct uhid_set_report_reply_req {
-	__u32 id;
-	__u16 err;
-} __attribute__((__packed__));
-
-/*
- * Compat Layer
- * All these commands and requests are obsolete. You should avoid using them in
- * new code. We support them for backwards-compatibility, but you might not get
- * access to new feature in case you use them.
- */
-
-enum uhid_legacy_event_type {
-	UHID_CREATE			= __UHID_LEGACY_CREATE,
-	UHID_OUTPUT_EV			= __UHID_LEGACY_OUTPUT_EV,
-	UHID_INPUT			= __UHID_LEGACY_INPUT,
-	UHID_FEATURE			= UHID_GET_REPORT,
-	UHID_FEATURE_ANSWER		= UHID_GET_REPORT_REPLY,
-};
-
-/* Obsolete! Use UHID_CREATE2. */
-struct uhid_create_req {
-	__u8 name[128];
-	__u8 phys[64];
-	__u8 uniq[64];
-	__u8 *rd_data;
-	__u16 rd_size;
-
-	__u16 bus;
-	__u32 vendor;
-	__u32 product;
-	__u32 version;
-	__u32 country;
-} __attribute__((__packed__));
-
-/* Obsolete! Use UHID_INPUT2. */
-struct uhid_input_req {
-	__u8 data[UHID_DATA_MAX];
-	__u16 size;
-} __attribute__((__packed__));
-
-/* Obsolete! Kernel uses UHID_OUTPUT exclusively now. */
-struct uhid_output_ev_req {
-	__u16 type;
-	__u16 code;
-	__s32 value;
-} __attribute__((__packed__));
-
-/* Obsolete! Kernel uses ABI compatible UHID_GET_REPORT. */
-struct uhid_feature_req {
-	__u32 id;
-	__u8 rnum;
-	__u8 rtype;
-} __attribute__((__packed__));
-
-/* Obsolete! Use ABI compatible UHID_GET_REPORT_REPLY. */
-struct uhid_feature_answer_req {
-	__u32 id;
-	__u16 err;
-	__u16 size;
-	__u8 data[UHID_DATA_MAX];
-} __attribute__((__packed__));
-
-/*
- * UHID Events
- * All UHID events from and to the kernel are encoded as "struct uhid_event".
- * The "type" field contains a UHID_* type identifier. All payload depends on
- * that type and can be accessed via ev->u.XYZ accordingly.
- * If user-space writes short events, they're extended with 0s by the kernel. If
- * the kernel writes short events, user-space shall extend them with 0s.
- */
-
-struct uhid_event {
-	__u32 type;
-
-	union {
-		struct uhid_create_req create;
-		struct uhid_input_req input;
-		struct uhid_output_req output;
-		struct uhid_output_ev_req output_ev;
-		struct uhid_feature_req feature;
-		struct uhid_get_report_req get_report;
-		struct uhid_feature_answer_req feature_answer;
-		struct uhid_get_report_reply_req get_report_reply;
-		struct uhid_create2_req create2;
-		struct uhid_input2_req input2;
-		struct uhid_set_report_req set_report;
-		struct uhid_set_report_reply_req set_report_reply;
-		struct uhid_start_req start;
-	} u;
-} __attribute__((__packed__));
-
-#endif /* __UHID_H_ */
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index 839809d9a..55ae839f3 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -10,8 +10,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-
-#include "profiles/input/uhid_copy.h"
+#include <linux/uhid.h>
 
 struct bt_uhid;
 
-- 
2.33.1

