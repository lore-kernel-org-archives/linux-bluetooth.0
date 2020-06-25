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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C9520768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDJHwNnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbgFYVL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391179AbgFYVL2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 17:11:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECEC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:11:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so3349480plr.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2020 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P3eQ7KJiOLP1SitBTtMnSlcHe/6bydu/h07euCIprVQ=;
        b=YDJHwNnzo/ypKC5vqLOPtjJTdl7zLSEOrcP855s2syhaPvfVw7Ga9IpmGnijlqYN+r
         sxyC/Z1WsrsnSnl/20ZaS9oSRvqWzwf5ZVIfTeh9B/tYWUySLBaiWSWa3WgPLIj7lIMu
         2Wek4Q0sdOeuKTvqjkAX/rj6NRBrCVtgaub5V73hrd7Lev8lUDoJ0fJy1cEKFNNf0Ypf
         KZ+eLU3hAp76sjuefBCLUM7KO0Gnur18TBxWpg0Spc+NIdimMNlcz8qDo7OtgKwpUYhR
         nXs+esMb4X68KZMOH8FatqKwAXlKY26RX6avNsuoaiy8eKCuesSn5DY5AHGBphGiySeS
         ontQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P3eQ7KJiOLP1SitBTtMnSlcHe/6bydu/h07euCIprVQ=;
        b=gcqPPAJbOPZB0jMo+mVFTwIBgEwgFoUOTgMjff4RxGKOTrAfzhRJL5BilDFErY9R8O
         jqy0TcOlCNV2jIXVAGzioHN9Wdd7gudG4EXxJaInONJ3g4Cbzp7wtmtenDZfxZ74VKkP
         NzH6pFOdIjfroaNKan2Xjl+2g9tAZOWYkj5k7MzeKJEjIgm5oQVwYs3j55xLi87aVJbA
         BP/tsqfsIr6IwGvH4lU7Hfq7+nXy4L0sDB5zU0KNHBfwHrLtXBoz+cmz1nU4S4I8Eil6
         HVxKNMt0tIIRJsw29mtuh6odecM2eDir9QI/GwlDa4gV2I6HvBxkO58cg1JrfazyHGBy
         NJ2w==
X-Gm-Message-State: AOAM532IcIcLg7WVDQRHiSte3Ye6aAkT22VX1UcNb8syWJHuDHd/33N2
        1qpg2YMKoLqwDLm443H1zvU5Ja4tVQk=
X-Google-Smtp-Source: ABdhPJyCTLGIVpfeWXnbgF6YNpITD3p8/o5UE/2gwwf/9n5K4d6D/ChBFutn9MFGRJWxxGX+00szRw==
X-Received: by 2002:a17:90a:8b09:: with SMTP id y9mr5346015pjn.90.1593119487463;
        Thu, 25 Jun 2020 14:11:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gm11sm9326294pjb.9.2020.06.25.14.11.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:11:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/gatt-client: Fix freeing instance while processing notification
Date:   Thu, 25 Jun 2020 14:11:25 -0700
Message-Id: <20200625211125.2239435-1-luiz.dentz@gmail.com>
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
 src/shared/gatt-client.c | 46 +++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 19ff6ab65..421f9a13c 100644
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
@@ -1613,43 +1615,35 @@ static uint8_t process_error(const void *pdu, uint16_t length)
 	return error_pdu->ecode;
 }
 
+static bool notify_set_ecode(const void *data, const void *match_data)
+{
+	struct notify_data *notify_data = (void *)data;
+	uint8_t ecode = PTR_TO_UINT(match_data);
+
+	notify_data->att_ecode = ecode;
+
+	return true;
+}
+
 static void enable_ccc_callback(uint8_t opcode, const void *pdu,
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
-	queue_remove_all(notify_data->chrc->reg_notify_queue, NULL, NULL,
-						complete_notify_request);
+	queue_remove_all(notify_data->chrc->reg_notify_queue, notify_set_ecode,
+				UINT_TO_PTR(notify_data->att_ecode),
+				complete_notify_request);
 
 	bt_gatt_client_unref(notify_data->client);
 }
-- 
2.25.3

