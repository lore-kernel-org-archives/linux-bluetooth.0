Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CB6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 21:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhKVVST (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhKVVSS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 16:18:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DAAC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:15:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so14823710pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN0nztUGMZWHzm/rqFtS/jpqB9XAmgCpryioRRAxZEM=;
        b=bw9nfyNEm/ieEG05/Pt0zzoJ0c2WzTJTRHhiSEEgb/hZRJtZ5zN3WH/OULIkpOL5da
         bWiwUJW1bBnJO0GBxrzv8buteoMmGCD5PX+Sp8NfqOVgleU2YL/Mxdj7qNVrnetrhZpd
         mG9aLN1I3PRy72BTB5J/aAfgaWZXGkxnekcefeB68Ht9nhHLPHBHd2QYqxRDrIY+U6Ye
         nQ9BvypBHSfjSpmGvs36NuA7B8eF14JYeluRBnsSEaN2+/26EOmCJpYd6qKBRf5b+VAL
         4xmR7tmMG3HmYKaVYxn7olObkYYsIRm8zb+/hPJ3PT0tjVNJkpHeS6hrMpuCcyoozelK
         1RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN0nztUGMZWHzm/rqFtS/jpqB9XAmgCpryioRRAxZEM=;
        b=yoM7qns3LlA0JOyIVMkjWlp00Uw3gRSTXP9edRX56lujbi1E4NHQCurEKYg33nBr9D
         6fs9p+G/Vql8/RiK6KKlU6fMpVUjfXqZpuWWmwKm6Z1DxuPR2eUybxHjgwLmP5XjED6/
         okzhwm+B5jLrMyJRznmChywqMBH9c/G25VlbGwewHOjCpGpgfuuwtrYzAFwBl3Nihf9z
         qhwXNYq+889tufIUhFnm4DD/05viZ/TyEHMRkj9faG8qhSVDO/Saf2msXODpyyEsACaY
         rmQE8Hd/XwcJmJ42wk6FLe7cqTHHjmwtL/yJDdwt86ndh+l5jWZmY3aVAmtEKJhGPfjG
         8nAg==
X-Gm-Message-State: AOAM531Qmhbj8aQNq7O3hfMXO5rrcmnuK6OyEH9GI5GU7zEvOtlBtbNT
        y6LBM2x79cmzSmdrnyedBUKTArwOsgY=
X-Google-Smtp-Source: ABdhPJx1iCUBdlgnTdfS897uiDvgIDvvK+AtIgvGAG7+AnnQ0YL43/IOQPIsX8j1fu1lF/sQxpXYJA==
X-Received: by 2002:a17:90b:2389:: with SMTP id mr9mr36605096pjb.152.1637615710432;
        Mon, 22 Nov 2021 13:15:10 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h36sm7414763pgb.9.2021.11.22.13.15.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:15:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] uhid: Remove local copy of uhid header
Date:   Mon, 22 Nov 2021 13:15:09 -0800
Message-Id: <20211122211509.2216902-1-luiz.dentz@gmail.com>
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
 profiles/input/uhid_copy.h | 199 -------------------------------------
 src/shared/uhid.h          |   3 +-
 2 files changed, 1 insertion(+), 201 deletions(-)
 delete mode 100644 profiles/input/uhid_copy.h

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

