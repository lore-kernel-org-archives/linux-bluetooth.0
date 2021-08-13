Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15180610E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbhHMMUI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbhHMMUG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E24C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:40 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e2-20020a17090a3b8200b001791a53ce87so4250218pjc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ezhVvYP/dsDxlbl9kAF9fitIxAnV25R0vLYiRMy9y5c=;
        b=F9JrxTYssvSjSmxsMdiCondHiW4TD4MuYlD0DrSyaBIyYvnYtrvyEUiaHwVVoIuvn0
         GxQXH5dkCwDYE3hbbnFTb5GulFqu/g2bw0xAcuV7TQjDB7isMDEUSRljHXuk9yJuq9S+
         9kDcWGkwNrDi+YRgC/hE32xcFFyknZ2oUZZgLDWH4Z319HClh8VXzB54vZnqgspnkyjD
         jIek5+0qDmUniAy9Gzj6KGAaINdhQfEYUY7+GGbZ5IiN+6wMpqI5cCHKV/7vcAPxT8dB
         7k/zRz0p8fFciWsRnk4IS0pDfDqtzheGIRuaUxr7sM8NFegbO6xypthPrXGOjTVDz1bJ
         AZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ezhVvYP/dsDxlbl9kAF9fitIxAnV25R0vLYiRMy9y5c=;
        b=r1+yGy2ThYBmpck1FGqhI/61M8WJul77p4aw0hgnLtMExdidFITSM3MzfyaaDTL0Ig
         6Bj2mdogtp4jKijrexGYl3mN9CYqrDGWj4FjvVNxSSyyM2A8vtkzjmtExaCHAXA8soka
         spp3YtKg1pxRqf//mVMOvKXBzLVNFW+Sp4A/clQS1EaxG4eGsYGFj5biDD+Yek5vNgq4
         wV5mWVTbEPAE97RUNomDRz5bT6Zk73CAv9hbqliEou7v5yDYaPsfHkm6EuyNZtqsVlnB
         AgWnznK+Ky0cmAJ0qIeKDJysCqKCvKMENCDRKinodwf2+H/10aNFmkbLHSrqtV2FeJba
         mYcg==
X-Gm-Message-State: AOAM533LvRvuphXR9V/yEen6H111yKJO2yKNEt4qHDosKjiiRcwUQG9G
        jD6vJrON3sIpKym5RC9caTZ6+kslZAaSM815IeH5/keXKN1PDS0KE5ZI4SvXVkduzhztGn38doj
        M/lktYZevxSV4H69V1+t5PDqwbC4c1SfLeTFu26ppZndSHMFJRbG14zRckrN6T2s+zoUrMdw26J
        pt
X-Google-Smtp-Source: ABdhPJxLxx+L0OeTfE8UAPFnN8CxH205A+juV88I+9AJ0Qkf1T1kQfp8eRf9dYkYvfWkJqeNZRxJlQ4aPn5u
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:90b:396:: with SMTP id
 ga22mr205472pjb.0.1628857179053; Fri, 13 Aug 2021 05:19:39 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:46 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.1.I3be2e373e96293524fa38328ebac177eddc71938@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 01/62] lib: Inclusive language in HCI commands and events
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are preferred, as reflected in the BT
core spec 5.3.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 lib/hci.h          | 14 +++++++-------
 tools/parser/hci.c |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 3382b87bf3..9d3cdfd06b 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -421,11 +421,11 @@ typedef struct {
 } __attribute__ ((packed)) change_conn_link_key_cp;
 #define CHANGE_CONN_LINK_KEY_CP_SIZE 2
 
-#define OCF_MASTER_LINK_KEY		0x0017
+#define OCF_CENTRAL_LINK_KEY		0x0017
 typedef struct {
 	uint8_t		key_flag;
-} __attribute__ ((packed)) master_link_key_cp;
-#define MASTER_LINK_KEY_CP_SIZE 1
+} __attribute__ ((packed)) central_link_key_cp;
+#define CENTRAL_LINK_KEY_CP_SIZE 1
 
 #define OCF_REMOTE_NAME_REQ		0x0019
 typedef struct {
@@ -1804,13 +1804,13 @@ typedef struct {
 }  __attribute__ ((packed)) evt_change_conn_link_key_complete;
 #define EVT_CHANGE_CONN_LINK_KEY_COMPLETE_SIZE 3
 
-#define EVT_MASTER_LINK_KEY_COMPLETE		0x0A
+#define EVT_CENTRAL_LINK_KEY_COMPLETE		0x0A
 typedef struct {
 	uint8_t		status;
 	uint16_t	handle;
 	uint8_t		key_flag;
-} __attribute__ ((packed)) evt_master_link_key_complete;
-#define EVT_MASTER_LINK_KEY_COMPLETE_SIZE 4
+} __attribute__ ((packed)) evt_central_link_key_complete;
+#define EVT_CENTRAL_LINK_KEY_COMPLETE_SIZE 4
 
 #define EVT_READ_REMOTE_FEATURES_COMPLETE	0x0B
 typedef struct {
@@ -2149,7 +2149,7 @@ typedef struct {
 	uint16_t	interval;
 	uint16_t	latency;
 	uint16_t	supervision_timeout;
-	uint8_t		master_clock_accuracy;
+	uint8_t		central_clock_accuracy;
 } __attribute__ ((packed)) evt_le_connection_complete;
 #define EVT_LE_CONN_COMPLETE_SIZE 18
 
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index d395e37f54..a1253acdf7 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -1084,7 +1084,7 @@ static inline void remote_name_req_dump(int level, struct frame *frm)
 
 static inline void master_link_key_dump(int level, struct frame *frm)
 {
-	master_link_key_cp *cp = frm->ptr;
+	central_link_key_cp *cp = frm->ptr;
 
 	p_indent(level, frm);
 	printf("flag %d\n", cp->key_flag);
@@ -1771,7 +1771,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_DISCONNECT_LOGICAL_LINK:
 			generic_command_dump(level + 1, frm);
 			return;
-		case OCF_MASTER_LINK_KEY:
+		case OCF_CENTRAL_LINK_KEY:
 			master_link_key_dump(level + 1, frm);
 			return;
 		case OCF_READ_REMOTE_EXT_FEATURES:
@@ -3116,7 +3116,7 @@ static inline void remote_name_req_complete_dump(int level, struct frame *frm)
 
 static inline void master_link_key_complete_dump(int level, struct frame *frm)
 {
-	evt_master_link_key_complete *evt = frm->ptr;
+	evt_central_link_key_complete *evt = frm->ptr;
 
 	p_indent(level, frm);
 	printf("status 0x%2.2x handle %d flag %d\n",
@@ -3874,7 +3874,7 @@ static inline void event_dump(int level, struct frame *frm)
 	case EVT_CHANGE_CONN_LINK_KEY_COMPLETE:
 		generic_response_dump(level + 1, frm);
 		break;
-	case EVT_MASTER_LINK_KEY_COMPLETE:
+	case EVT_CENTRAL_LINK_KEY_COMPLETE:
 		master_link_key_complete_dump(level + 1, frm);
 		break;
 	case EVT_REMOTE_NAME_REQ_COMPLETE:
-- 
2.33.0.rc1.237.g0d66db33f3-goog

