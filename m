Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4975C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8376206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXsgyqHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbgFYVAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405069AbgFYVAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 17:00:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120AC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:00:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p11so3596009pff.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHDhMlgJTibjtwElhqt5x8hbWAW3rqhB5KyDah6RhQA=;
        b=lXsgyqHlKGreVK10DFO+zw1QF7twQPb5h+iGzFnYP6Q7/iOMLwDGxjgAOc1t5uApE9
         u5a+xO4TKNFZdbVGCJgq+j0/f6zHmCjNHzFjJ5xJi8nrZakg9Ma2pMP3ArERitUiTBiW
         5K/9cXxk8x6ZyEIAx3rfoEwtwvqgogqlo76EH3EnSXe63skwxITOhoSG5F+wdFG8p6ej
         wH3nTQ3Q8Lv4aojX4TUsirZfpUsq5dW4hJc1kvhuFpsuNIRZhVKLYE3R6EbnEl+erLf9
         vNduNXEu/S21cj7s5gzt6yi3qkCtEylVs2Qoe2V+sLjkCBwTVdvcHAPXrZ/ZjACq6st6
         Xjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHDhMlgJTibjtwElhqt5x8hbWAW3rqhB5KyDah6RhQA=;
        b=f61v7nX5zyhhj5yeA3hAT2ekGCT1htLJ+YLxUTE6jbLp63SFm3hTMbPEZwJHDPogoV
         U5LwTCoiVC5JHE2HCssZUwv+KLlEkQz2oQCmxf7jnLq6xsEmw9csSXPKybBDBEB/C13J
         tU+lW4GuUk+WkJeqAcWINOW5qcqfpeQEg1p5CMGD+TPBU6PHIQ5ZHra9ulTIDrbkqzde
         +pc1XcFydIXcqHTSaR6zt0yy28SiMx2MSlUCpKBbbi9HgMOkVJ8BCbWSxN8eAlfYOQ/h
         sTXGb76U74o3lD9UAd91YE2f6fjkx5ySKWUSqioWuKEWFiaWOhtJYrjtyRXcRpqciRdv
         vCsQ==
X-Gm-Message-State: AOAM532M8sLC153j7HqNDo1XfmKN0dg+enoluI3pIcJwK/mHHxzFysdr
        bblnbyYeZeBJNkq8rbt1FxkS1kXx1gU=
X-Google-Smtp-Source: ABdhPJyZOSMWU8rgVaEAHaJNqb7SpqgcLMJpwZXNNA2AtJ36rqU6Hin5bILIOe++KSIatrzvbB/GiQ==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr26707027pgn.194.1593118817799;
        Thu, 25 Jun 2020 14:00:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m18sm24123194pfo.173.2020.06.25.14.00.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:00:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix freeing instance while processing notification
Date:   Thu, 25 Jun 2020 14:00:16 -0700
Message-Id: <20200625210016.2233909-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If CCC fails to be programmed the callback would be run without taking
a reference which may lead to freeing the client instance while there
are still notification to be processed.

To fix this handling of both success and failure to program the CCC will
now take a reference to the client, also in case of failure instead of
attempting to program the CCC once again the code now notify all the
queued requests which is consistent with how the success case is
handled.
---
 src/shared/gatt-client.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 19ff6ab65..db079e75a 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -190,6 +190,7 @@ struct notify_data {
 	struct bt_gatt_client *client;
 	unsigned int id;
 	unsigned int att_id;
+	uint8_t att_ecode;
 	int ref_count;
 	struct notify_chrc *chrc;
 	bt_gatt_client_register_callback_t callback;
@@ -1565,7 +1566,8 @@ static void complete_notify_request(void *data)
 	notify_data->att_id = 0;
 
 	if (notify_data->callback)
-		notify_data->callback(0, notify_data->user_data);
+		notify_data->callback(notify_data->att_ecode,
+						notify_data->user_data);
 }
 
 static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
@@ -1617,36 +1619,17 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct notify_data *notify_data = user_data;
-	uint8_t att_ecode;
 
 	assert(notify_data->chrc->ccc_write_id);
 
 	notify_data->chrc->ccc_write_id = 0;
 
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		att_ecode = process_error(pdu, length);
-
-		/* Failed to enable. Complete the current request and move on to
-		 * the next one in the queue. If there was an error sending the
-		 * write request, then just move on to the next queued entry.
-		 */
-		queue_remove(notify_data->client->notify_list, notify_data);
-		notify_data->callback(att_ecode, notify_data->user_data);
-
-		while ((notify_data = queue_pop_head(
-					notify_data->chrc->reg_notify_queue))) {
-
-			if (notify_data_write_ccc(notify_data, true,
-							enable_ccc_callback))
-				return;
-		}
-
-		return;
-	}
-
-	/* Success! Report success for all remaining requests. */
 	bt_gatt_client_ref(notify_data->client);
 
+	if (opcode == BT_ATT_OP_ERROR_RSP)
+		notify_data->att_ecode = process_error(pdu, length);
+
+	/* Notify for all remaining requests. */
 	complete_notify_request(notify_data);
 	queue_remove_all(notify_data->chrc->reg_notify_queue, NULL, NULL,
 						complete_notify_request);
-- 
2.25.3

