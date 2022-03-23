Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbiCWWli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbiCWWlh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA046369F7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so3323013pjm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=YPFTFboKlOndWgAUCm6AvrIuwl1S7MFfxR9g/5W7N4RjfcDndJkrYpZ9GyicikdWpr
         IULDJncDyVX/7Mnm9nA8yhpl3N9ntTLE9WoClz4g4zswV3C23eGU3YaLmB7rTwaDWfwk
         gNNu0MVwnS+4uWwJLCI3yOTvMoNvNrXXmB/x72ecuvVDskTSTnzdc4uabwtX9YDuC3tQ
         o6h1cyiU4iFOCiGNr80YS8sNFO/AhB0tbGQedZ9QS1fY9PrMUtvJfenySs53erLd5VpJ
         EGf7tio1VcKhKbhNRUfDXYX96ABN55CO1HvIqwI9nPlRtg25tIA1mlqGzfsXz5ZwwwGh
         aSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=tMHF3zZmEbyGTJatqd04MkDVbs5UH9h5BApao8Z8b/mR4Te5LXlWpu8XoEDXzYDIdy
         2QmZN/vu5wOpxmtL/pZZlJj6Xr63kUSP9pX7/QvdF+W1HO1VDJ3bltJPwpzFxiZmjlYa
         gEe82wzT/zaATdcEWDQ9ijw2yXkvckK53fzGDcb7ZIaleepFvs/HASt0MZF7UQuPXQ97
         2u75Ea4hdzsZZIHZJXRSRfLdUcJXY3ZAF5BiuKme1KzyiMRRMzjkLvVKvVLdMm0BRMHM
         vTVmAQGQ0vOe7y3CsEwpinTVFJh8gX2NdALHcCVtaf/fiL+OkSGYQxIZxo8dkL0Sjyw3
         Yq5A==
X-Gm-Message-State: AOAM531VZZ1lKDuqWhsDsQlN+26K16r4YVhongxEz6xh2Yxep7R64V6z
        QBtbDRwBTnt/F5HRvB3FrdqfOBycmcU=
X-Google-Smtp-Source: ABdhPJzXwjyHoTMz/lTwRHmwE3nFJMfVwdPN9ivACe14eFv/vsKf7444Fne+KaYF/0FdAdwZ/5KGsA==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id o2-20020a170902bcc200b0014f23c6c8c5mr2237566pls.131.1648075206182;
        Wed, 23 Mar 2022 15:40:06 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/9] mgmt: Add DBG macro
Date:   Wed, 23 Mar 2022 15:39:56 -0700
Message-Id: <20220323224003.3736525-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds mgmt_log wrapper for util_debug and DBG so file and function
names are printed with the logs.
---
 src/shared/mgmt.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 95229c248..c7e6a6c1d 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -27,6 +27,9 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/timeout.h"
 
+#define DBG(_mgmt, _format, arg...) \
+	mgmt_log(_mgmt, "%s:%s() " _format, __FILE__, __func__, ## arg)
+
 struct mgmt {
 	int ref_count;
 	int fd;
@@ -177,6 +180,18 @@ static bool request_timeout(void *data)
 	return false;
 }
 
+static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
+{
+	va_list ap;
+
+	if (!mgmt || !format || !mgmt->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(mgmt->debug_callback, mgmt->debug_data, format, ap);
+	va_end(ap);
+}
+
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -187,8 +202,8 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 
 	ret = io_send(mgmt->io, &iov, 1);
 	if (ret < 0) {
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"write failed: %s", strerror(-ret));
+		DBG(mgmt, "write failed: %s", strerror(-ret));
+
 		if (request->callback)
 			request->callback(MGMT_STATUS_FAILED, 0, NULL,
 							request->user_data);
@@ -202,9 +217,7 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 							request,
 							NULL);
 
-	util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%04x",
-				request->index, request->opcode);
+	DBG(mgmt, "[0x%04x] command 0x%04x", request->index, request->opcode);
 
 	util_hexdump('<', request->buf, ret, mgmt->debug_callback,
 							mgmt->debug_data);
@@ -283,9 +296,7 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 	request = queue_remove_if(mgmt->pending_list,
 					match_request_opcode_index, &match);
 	if (!request) {
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"Unable to find request for opcode 0x%04x",
-				opcode);
+		DBG(mgmt, "Unable to find request for opcode 0x%04x", opcode);
 
 		/* Attempt to remove with no opcode */
 		request = queue_remove_if(mgmt->pending_list,
@@ -383,8 +394,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		cc = mgmt->buf + MGMT_HDR_SIZE;
 		opcode = btohs(cc->opcode);
 
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%04x complete: 0x%02x",
+		DBG(mgmt, "[0x%04x] command 0x%04x complete: 0x%02x",
 						index, opcode, cc->status);
 
 		request_complete(mgmt, cc->status, opcode, index, length - 3,
@@ -394,15 +404,13 @@ static bool can_read_data(struct io *io, void *user_data)
 		cs = mgmt->buf + MGMT_HDR_SIZE;
 		opcode = btohs(cs->opcode);
 
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] command 0x%02x status: 0x%02x",
+		DBG(mgmt, "[0x%04x] command 0x%02x status: 0x%02x",
 						index, opcode, cs->status);
 
 		request_complete(mgmt, cs->status, opcode, index, 0, NULL);
 		break;
 	default:
-		util_debug(mgmt->debug_callback, mgmt->debug_data,
-				"[0x%04x] event 0x%04x", index, event);
+		DBG(mgmt, "[0x%04x] event 0x%04x", index, event);
 
 		process_notify(mgmt, event, index, length,
 						mgmt->buf + MGMT_HDR_SIZE);
-- 
2.35.1

