Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74811C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 19:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiCYTgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCYTgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 15:36:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBF1D3072
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:24:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s8so7182544pfk.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/ScXRMHcRp85QtICSYw8maTQrMuT4aqx8kRP7vEhik=;
        b=iRcAsuNOfP99ZwytexBptaa/dwVZYExy8wKAwjlRx/Vc7frWlJPDBcYGyqvtEz90Kj
         6bGFfrN+v+emK+IL0vgyFJmgS4vaM7g9Efq7FGKKixLLsHO6RO9Oe/vL97gz7XwDdmz0
         LM149W6+MHYwiMAJf1HYCDA4999QcsA1I8Sle9nEkEVrwsOJWG7cAWzrd/3Lw/pivtO4
         F2qBwnxgvm6SdssDK3lP4O60kI/5arg4FxKJBRare+8vgLJlLlfopHWuLgzRHFcUPgS1
         mRXRcRKxWozqLJs77Fuxh9vftI66OHme5c+PQQQ6PHbo9GpZIFvKtOf0f5A/rJgffv8Q
         gJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3/ScXRMHcRp85QtICSYw8maTQrMuT4aqx8kRP7vEhik=;
        b=BlN8pY4SSmQYunalJcdfer/SIdSM2ItJDNxEI/+aiZ1b6M1bsGeXgG3BpaWl2di1Ps
         pETRAadr0IhZDmKi4a3tuHsP01zAycQRVWiAQuHzj4Dpq5pqW2m8vP9zhlqadhJxZeRF
         p5n2Smqfu6/T7Mgt80iuJh/22G+Uhp4J0IXamzoqvhbiBvQu0a3xs4F96DXZ4JcDtdLn
         xsylYcEHXNUdkiOS3/PGjIYoglu4pIpi4bl1VZXQB7lYIxiidLX6eur5zIpTPL8dRXOV
         A8jf1jGS8e7tt25DCZKAtdUPc8IAh2iclEVfPbOp/TW+jF6vHsqDx6Pzs6Ns01AN26HL
         0CYw==
X-Gm-Message-State: AOAM532/Aqak5PZY5U0rFHF5chM2hTL10R+7DbPJXhZHnLjBswJQj7kw
        +6ZoSwMuQcO39xWj4dhRN7efIVxVJJQ=
X-Google-Smtp-Source: ABdhPJx/yIA2H64eP5jA+qUeAT7sfiZLvsMIidcEz0ASLQQhujBRfw3rsfdBzLdQMv8KVY/z6UYBCg==
X-Received: by 2002:a17:902:7781:b0:153:35ef:e3d1 with SMTP id o1-20020a170902778100b0015335efe3d1mr13356022pll.116.1648232178815;
        Fri, 25 Mar 2022 11:16:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a194600b001c61a0f3debsm6624277pjh.10.2022.03.25.11.16.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:16:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt: Remove mgmt_set_verbose
Date:   Fri, 25 Mar 2022 11:16:17 -0700
Message-Id: <20220325181617.332701-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The likes of btmon already decode the commands/events so there is no
need to have the code hexdump their contents.
---
 src/shared/mgmt.c | 22 ----------------------
 src/shared/mgmt.h |  1 -
 2 files changed, 23 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index cf518cc2b..4d7b64f2b 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -50,7 +50,6 @@ struct mgmt {
 	mgmt_debug_func_t debug_callback;
 	mgmt_destroy_func_t debug_destroy;
 	void *debug_data;
-	bool verbose;
 };
 
 struct mgmt_request {
@@ -193,15 +192,6 @@ static void mgmt_log(struct mgmt *mgmt, const char *format, ...)
 	va_end(ap);
 }
 
-static void mgmt_hexdump(struct mgmt *mgmt, char dir, const void *data,
-							size_t len)
-{
-	if (!mgmt->verbose)
-		return;
-
-	util_hexdump(dir, data, len, mgmt->debug_callback, mgmt->debug_data);
-}
-
 static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 {
 	struct iovec iov;
@@ -229,8 +219,6 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
 
 	DBG(mgmt, "[0x%04x] command 0x%04x", request->index, request->opcode);
 
-	mgmt_hexdump(mgmt, '<', request->buf, ret);
-
 	queue_push_tail(mgmt->pending_list, request);
 
 	return true;
@@ -382,8 +370,6 @@ static bool can_read_data(struct io *io, void *user_data)
 	if (bytes_read < 0)
 		return false;
 
-	mgmt_hexdump(mgmt, '>', mgmt->buf, bytes_read);
-
 	if (bytes_read < MGMT_HDR_SIZE)
 		return true;
 
@@ -602,14 +588,6 @@ bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 	return true;
 }
 
-void mgmt_set_verbose(struct mgmt *mgmt, bool value)
-{
-	if (!mgmt)
-		return;
-
-	mgmt->verbose = value;
-}
-
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close)
 {
 	if (!mgmt)
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 0f3e54c16..b413cea78 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -28,7 +28,6 @@ typedef void (*mgmt_debug_func_t)(const char *str, void *user_data);
 
 bool mgmt_set_debug(struct mgmt *mgmt, mgmt_debug_func_t callback,
 				void *user_data, mgmt_destroy_func_t destroy);
-void mgmt_set_verbose(struct mgmt *mgmt, bool value);
 
 bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
 
-- 
2.35.1

