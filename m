Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLIBDW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLIBDT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:03:19 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3B87C9C
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:03:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 62so2508012pgb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 17:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDmk6XJFFnl2esSiVNZZnxUUtO+P3SzcAI3cvB9o72o=;
        b=e6KRa/jLCIMko9fmt378Ngkzhet4P2/gxrXshtOgyjJMXO8MRsQk5ybySaSt6Bwvqz
         TfakthUtCX5qH5fnmF1Wueriip3gIS6kvJXoN3qEZMeOYy0HOvYuqg5Xdlqb98BP9HQ0
         NB7nm78YGwxQRmdTfuIH/WtT2LLCc5iWVhfRbs2Hd1DxZbd294VT+THuM4EYgx3IDnlR
         Xe8x7aHBkPVsgsX3kb6NY4wvMQ8gRHDB3q6nVUIa6k/J+mBvru6sMMINJevZWdPxGz2g
         EIGD/yTkiWH+czaKCP6SJ0vOZoYzaMMfH0rP4NoEmSBjZayvl4ojVxHni0pwN5HhZs07
         K7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDmk6XJFFnl2esSiVNZZnxUUtO+P3SzcAI3cvB9o72o=;
        b=nk51bnytpdo7Wi1EGzx5eyDK6ImiouQb9kz+2KXTgJTp8Ymzw8CYlKRobzn0NN+Nz3
         hsvirT7qB6ptwOSikabOVcVulrPpxb2VDfkF0hbGZ7mr/DETgfoTy/iPQANDlFvAjxc5
         dD5hZBHA5C/aoGfr6RQN/NoqtOrWAiMNqYAZFwLnAWuMBUfhcrWY/awlPC9Sm0rBKMF2
         Z876S8bLBzVWFpEyN03NddOBGdV60HhAZPTG0CQ++uexlDIXoxGzV5IWeQIT0UlOCJ5S
         n/NJk3btgFWsKeFpb99ydtfP7hn/nDXbFXU4EodKxnxMC9Vs5x8MzU9cc4PoUw52foVk
         2UZg==
X-Gm-Message-State: ANoB5pkdLKtn7kwzDbVp3w01wq2DFdltZVlYx4yQH4VV2w8qLvEG0rxr
        q3VjquH8QX0dZoXLIFcyUu5w/F3jQSL50Q==
X-Google-Smtp-Source: AA0mqf4NguziJLg21wg7fKl0licnLgG9ANkTMo7n9X4X+CJqEru/NKkea2bAVQrdcckUZCbRYrSIWA==
X-Received: by 2002:a62:1781:0:b0:574:58d1:cf9f with SMTP id 123-20020a621781000000b0057458d1cf9fmr3529053pfx.27.1670547797126;
        Thu, 08 Dec 2022 17:03:17 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm100253pfk.151.2022.12.08.17.03.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:03:16 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/bap: Log error message if request cannot be sent
Date:   Thu,  8 Dec 2022 17:03:11 -0800
Message-Id: <20221209010314.707606-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure a error message is logged if a request cannot be sent
for some reason.
---
 src/shared/bap.c | 71 +++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 59ef81d11882..04ef4f44c1dd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3397,9 +3397,13 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	};
 	size_t i;
 
+	DBG(bap, "req %p", req);
+
 	if (!gatt_db_attribute_get_char_data(ascs->ase_cp, NULL, &handle,
-						NULL, NULL, NULL))
+						NULL, NULL, NULL)) {
+		DBG(bap, "Unable to find Control Point");
 		return false;
+	}
 
 	hdr.op = req->op;
 	hdr.num = 1 + queue_length(req->group);
@@ -3416,12 +3420,41 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	ret = bt_gatt_client_write_without_response(bap->client, handle,
 							false, iov.iov_base,
 							iov.iov_len);
-	if (!ret)
+	if (!ret) {
+		DBG(bap, "Unable to Write to Control Point");
 		return false;
+	}
 
 	bap->req = req;
 
-	return false;
+	return true;
+}
+
+static void bap_req_complete(struct bt_bap_req *req,
+				const struct bt_ascs_ase_rsp *rsp)
+{
+	struct queue *group;
+
+	if (!req->func)
+		goto done;
+
+	if (rsp)
+		req->func(req->stream, rsp->code, rsp->reason, req->user_data);
+	else
+		req->func(req->stream, BT_ASCS_RSP_UNSPECIFIED, 0x00,
+						req->user_data);
+
+done:
+	/* Detach from request so it can be freed separately */
+	group = req->group;
+	req->group = NULL;
+
+	queue_foreach(group, (queue_foreach_func_t)bap_req_complete,
+							(void *)rsp);
+
+	queue_destroy(group, NULL);
+
+	bap_req_free(req);
 }
 
 static bool bap_process_queue(void *data)
@@ -3429,14 +3462,17 @@ static bool bap_process_queue(void *data)
 	struct bt_bap *bap = data;
 	struct bt_bap_req *req;
 
+	DBG(bap, "");
+
 	if (bap->process_id) {
 		timeout_remove(bap->process_id);
 		bap->process_id = 0;
 	}
 
 	while ((req = queue_pop_head(bap->reqs))) {
-		if (!bap_send(bap, req))
+		if (bap_send(bap, req))
 			break;
+		bap_req_complete(req, NULL);
 	}
 
 	return false;
@@ -3482,33 +3518,6 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	return true;
 }
 
-static void bap_req_complete(struct bt_bap_req *req,
-				const struct bt_ascs_ase_rsp *rsp)
-{
-	struct queue *group;
-
-	if (!req->func)
-		goto done;
-
-	if (rsp)
-		req->func(req->stream, rsp->code, rsp->reason, req->user_data);
-	else
-		req->func(req->stream, BT_ASCS_RSP_UNSPECIFIED, 0x00,
-						req->user_data);
-
-done:
-	/* Detach from request so it can be freed separately */
-	group = req->group;
-	req->group = NULL;
-
-	queue_foreach(group, (queue_foreach_func_t)bap_req_complete,
-							(void *)rsp);
-
-	queue_destroy(group, NULL);
-
-	bap_req_free(req);
-}
-
 static void bap_cp_notify(struct bt_bap *bap, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
-- 
2.37.3

