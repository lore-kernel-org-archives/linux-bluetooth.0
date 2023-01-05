Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A90C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Jan 2023 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjAEWKL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjAEWJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 17:09:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563AC67BE4
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 14:09:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p24so18276667plw.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWJ9a+qVJy1gWUNU381hC5U7R/t9smb2m2ZecZHXjMI=;
        b=XwGX3NSLqwbaFY0m0V8PU39WiX1KQuTwVOYUoFJV0s5lj/ue5TJvZbJhOYLuTkl+Yx
         Np7TZCsytKYysjNLTgprFxY9KHFe+AvgOdhG984gbdqp50k3zXKaur95Ko5l1rlnRQUz
         8AzcsOIMOtC6ZnJ64NWqPKHc75oZ6a8oMMi8YmBYHq5jgKQZya3BOUc7ClHRo1fHmCb2
         eoOHh0VWUlXVAFXKyloSSkHBkp50IhaOZJkcK1WRoMJ34OZnX6+n3LMa7r9ADbyIg/Sq
         IlPwU9UJ1SeBJ9IqrI0IoCmzQ8A5zUIIS9dDrTYv+OGrJFthltncR32tbbE9P8mZtcUh
         uV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWJ9a+qVJy1gWUNU381hC5U7R/t9smb2m2ZecZHXjMI=;
        b=ll8kSbG1S0WlSKPkQQCQ89duCN7XKKNnO5IGhm/eizhbu+8zM3qzRzCVkBErxzKTEl
         RwSOjD66w3g+EvNMs5wL+LXbjwMS5pn4Pw6S0gA0etZHw3Ra6kniowUrNM2jm9hatGun
         V1pwTcWjlowObgiHYpDKNra1jeXLhw4kDLDeizqgHgujgUfrvAFo2E7OZH8yG4SS2iiW
         GhvVtPmuioJAeXUW05RfU7mXl7zv8RqNPMQqA/TwiOdnyTfy+LMeZv/0Vij0m7qcxI07
         xJIcu8tL7Hc+kKiORXhSty9ZLQqd7K1lhbImSwMRkotWz4RHqQBudZFNhBYITC5JBsHX
         yimg==
X-Gm-Message-State: AFqh2kroIHpYQCSTQww3jya7P/OB2s7kSbpl0R3l9YBHZzdik7zFKMgD
        oH6E9CayNd2t7JT7Ap8Cn0AOiIKVfz4=
X-Google-Smtp-Source: AMrXdXvQbUo632XcGiGwlbcHKJVMu4WdnW2r6lsq9OGKfjQC8I/TKGC8aR+qo3R1X/vd6tuoOGjmRw==
X-Received: by 2002:a17:903:28e:b0:193:a5b:cd01 with SMTP id j14-20020a170903028e00b001930a5bcd01mr1054953plr.19.1672956587946;
        Thu, 05 Jan 2023 14:09:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001929827731esm16744861plb.201.2023.01.05.14.09.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-client: Allow registering with NULL callback
Date:   Thu,  5 Jan 2023 14:09:42 -0800
Message-Id: <20230105220944.2373424-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230105220944.2373424-1-luiz.dentz@gmail.com>
References: <20230105220944.2373424-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_gatt_client_register_notify allow registering with NULL
callback which is interpreted as the CCC write has already been
performed therefore it won't be written again.
---
 src/shared/gatt-client.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4aa5d7d92957..593b0f27f871 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1711,8 +1711,11 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 		 * descriptor.
 		 */
 		chrc = notify_chrc_create(client, handle);
-		if (!chrc)
+		if (!chrc) {
+			DBG(client, "Unable to locate characteristic at 0x%04x",
+							handle);
 			return 0;
+		}
 	}
 
 	/* Fail if we've hit the maximum allowed notify sessions */
@@ -1750,9 +1753,10 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	}
 
 	/*
-	 * If the ref count > 1, then notifications are already enabled.
+	 * If the ref count > 1, ccc handle cannot be found or registration
+	 * callback is not set consider notifications are already enabled.
 	 */
-	if (chrc->notify_count > 1 || !chrc->ccc_handle) {
+	if (chrc->notify_count > 1 || !chrc->ccc_handle || !callback) {
 		complete_notify_request(notify_data);
 		return notify_data->id;
 	}
@@ -2176,6 +2180,9 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 	struct bt_gatt_client *client = user_data;
 	struct value_data data;
 
+	if (queue_isempty(client->notify_list))
+		return;
+
 	bt_gatt_client_ref(client);
 
 	memset(&data, 0, sizeof(data));
@@ -3670,7 +3677,8 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy)
 {
-	if (!client || !client->db || !chrc_value_handle || !callback)
+	if (!client || !client->db || !chrc_value_handle ||
+				(!callback && !notify))
 		return 0;
 
 	if (client->in_svc_chngd)
-- 
2.37.3

