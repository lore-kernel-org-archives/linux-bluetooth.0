Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B4C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 19:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCPTgk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCPTgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 15:36:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99014B810
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:36:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o11so2940993ple.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678995396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UOVXoXH3ppT+bqnNcQC5HPlzP/AINb05H+SRFhmdGU=;
        b=Ip1c7pUsiC5scJ8uKIq9O0BXaor2jgyR4QTIwR/LdLp7s0kHwlN36V1kEqFi9F12OL
         qnQuZj7mh+RY6BGfC2OuAwTjYoEknal/XCygXvfUQwEhVcBwku26RD3K2xE7lNqNIzOE
         6po1Tgj+GqJ7YKgKk2y0M3On6CvgPJNNmIhZkYNw0fHg3FhDAWUeSyMytZF/0TMPvFTv
         hr2sfzBUtnHgfo17cDo7kr+zL6U1moV1AviBzWya3ENFQUAIcAOpNAa2qrwQSstQcfCn
         NGefHey02vO2mK4+C9HYL/lRZW+H+oJP49LcGSPhbkUeQ/szSgT7bH9mHtciMt8opoyS
         6Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UOVXoXH3ppT+bqnNcQC5HPlzP/AINb05H+SRFhmdGU=;
        b=TX72CHgCSnCsvorK+QRD4veT24R440IMozqKiC7cu/cxx0EW7dmLPGAXkawhKZcU2u
         PUcjCYHasAQpuuPS0RZ+1U0Ggmku8Xx10XG+jgf5BWm5uC9wMl1HXmUOfBHYcHDvDYaX
         8yDs0seDf2p0si6p2q+rrAEBK0xc3zAU10pWLjw3ATUiyIS8HM7p1QEcmegk+fn6NDms
         kOTUkfHps6Z1UAlSARW8ciN4VUCTw6g3vje0Iqg2TOhltrFRdsWpDOzjWYqUh0kXIN6H
         VBxz7MBgC8zpDRcIZam2FbOrMB9TCCuu6PaMYFXqMeH3w/k3jUBQiYpchj5+77wPoT9r
         pz5Q==
X-Gm-Message-State: AO0yUKWTwBzn7f2czSijtNQ9ZuxeifI/I9IgLqWlyAUQIddAjHFe93p5
        Tl5gAvzqPbuGsxt1K74HginX/TwX1hM=
X-Google-Smtp-Source: AK7set+wlV3HfOZU+q1gKMF0xH+0+tnRJ7AhqDH4VwgikbMhK0jkMCUMfYyu8/sjta1M/S0tGkMDqw==
X-Received: by 2002:a05:6a21:6da9:b0:d5:e640:15ec with SMTP id wl41-20020a056a216da900b000d5e64015ecmr5521267pzb.29.1678995395438;
        Thu, 16 Mar 2023 12:36:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id e17-20020a63ee11000000b00478c48cf73csm12151pgi.82.2023.03.16.12.36.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:36:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not creating a request for notifications
Date:   Thu, 16 Mar 2023 12:36:34 -0700
Message-Id: <20230316193634.1195948-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Notifications were using bt_att_send directly instead of
bt_gatt_client_write_value thus it wouldn't create a request which
causes the instance to not be able to track it which in turn may cause
the client to trigger its idle callback too early.

Fixes: https://github.com/bluez/bluez/issues/490
---
 src/shared/gatt-client.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 9ffc10b0b44a..efc013a20dcf 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1660,31 +1660,30 @@ static void complete_notify_request(void *data)
 }
 
 static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
-						bt_att_response_func_t callback)
+					bt_gatt_client_callback_t callback)
 {
-	uint8_t pdu[4];
 	unsigned int att_id;
+	uint16_t value;
 	uint16_t properties = notify_data->chrc->properties;
 
 	assert(notify_data->chrc->ccc_handle);
-	memset(pdu, 0, sizeof(pdu));
-	put_le16(notify_data->chrc->ccc_handle, pdu);
 
 	if (enable) {
 		/* Try to enable notifications or indications based on
 		 * whatever the characteristic supports.
 		 */
 		if (properties & BT_GATT_CHRC_PROP_NOTIFY)
-			pdu[2] = 0x01;
+			value = cpu_to_le16(0x0001);
 		else if (properties & BT_GATT_CHRC_PROP_INDICATE)
-			pdu[2] = 0x02;
-
-		if (!pdu[2])
+			value = cpu_to_le16(0x0002);
+		else
 			return false;
 	}
 
-	att_id = bt_att_send(notify_data->client->att, BT_ATT_OP_WRITE_REQ,
-						pdu, sizeof(pdu), callback,
+	att_id = bt_gatt_client_write_value(notify_data->client,
+						notify_data->chrc->ccc_handle,
+						(void *)&value, sizeof(value),
+						callback,
 						notify_data_ref(notify_data),
 						notify_data_unref);
 	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
@@ -1714,8 +1713,8 @@ static bool notify_set_ecode(const void *data, const void *match_data)
 	return true;
 }
 
-static void enable_ccc_callback(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void enable_ccc_callback(bool success, uint8_t att_ecode,
+						void *user_data)
 {
 	struct notify_data *notify_data = user_data;
 
@@ -1723,10 +1722,9 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 
 	notify_data->chrc->ccc_write_id = 0;
 
-	bt_gatt_client_ref(notify_data->client);
+	bt_gatt_client_ref_safe(notify_data->client);
 
-	if (opcode == BT_ATT_OP_ERROR_RSP)
-		notify_data->att_ecode = process_error(pdu, length);
+	notify_data->att_ecode = att_ecode;
 
 	/* Notify for all remaining requests. */
 	complete_notify_request(notify_data);
@@ -2165,8 +2163,8 @@ struct value_data {
 	const void *data;
 };
 
-static void disable_ccc_callback(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void disable_ccc_callback(bool success, uint8_t att_ecode,
+						void *user_data)
 {
 	struct notify_data *notify_data = user_data;
 	struct notify_data *next_data;
-- 
2.39.2

