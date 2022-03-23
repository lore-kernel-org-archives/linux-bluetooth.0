Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F59C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbiCWUPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiCWUPQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5E8933B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb19so2810901pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=NfzgRo2RTkRfThXJJc2bShOzQK2488gfl7PltLMV19W3Zdu8vrsRQV3sOHTZ51OPmM
         HG9nVDeY+Z63z+QlSBU7gte66M614sGvHOS63WnYTB6cITod5yrkkHz+Z6mi4POwHKXi
         kyRLkbdUqP/T5Q9115/+0r2Fek3Kuo+5GkMtzxRTyhElVm9Gat3oWJGRRc18E8v/UAy7
         iVno/m9bdzkl/H6MMaBZdrTNyEe3pSwhKsliy5pk0W1slPYDM765W4op7f+2fEYrHCuT
         KMR8bMuYLwGHcaWxUdAmjhQp9MCj+jaQ+gM/eEuNyRC/rFkZ1gfe4LA9s1Tb0pJehzJI
         CBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMeVwZRc+kCFv6ywPENuuniweobbSTLYVjAmAjxzwIE=;
        b=JrSCJw5V7kVKQVIPmIJ03ugZTX1EcZYT4mz0kCLnO5dWi6sp41PvDKX6uBL5ZU/t43
         YZ6Frjtp48jY2qX0J17nNo2zPupNy/qgrlBQqU3b+4GCp18zkQVmvVWsn9xG2DAdBzyt
         h7w7H80W6qCa5Qaa9bRYbxFDgAPR/gtcG0x4yFwSqLGbK+aqfFUoqA3AAY/842x6jKrD
         dRJrS0tm4wpbIT7amhtVTcCBDquS5/XbWb2Jk0YIGT4KfLBsavjI59NrDZtzDce41I5U
         tIKfkhXjVdyDf1jpPf93T5VbVK+Iz/MEU+elxqgpuAzHTiDOGaJSaaxun5bIwoTXlpG2
         aRXA==
X-Gm-Message-State: AOAM531wcrciAsSkb5uLCt8nd6tSllcsFW9pEXPNhnf09DFxv2B+78yS
        luFa2Hfn+G2ECIg5wpjY/9uydwxTy/M=
X-Google-Smtp-Source: ABdhPJzUlH0kmoSZ2cifYJKXdWww4LHmhkh9rODjZLOgGH1oy0Z9x6f10vprzHZcg0O6vhdeb//DOA==
X-Received: by 2002:a17:902:cec5:b0:154:6b18:6157 with SMTP id d5-20020a170902cec500b001546b186157mr1759632plg.145.1648066424610;
        Wed, 23 Mar 2022 13:13:44 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/9] mgmt: Add DBG macro
Date:   Wed, 23 Mar 2022 13:13:34 -0700
Message-Id: <20220323201341.3596128-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
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

