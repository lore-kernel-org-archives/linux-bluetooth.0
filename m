Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7048C433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A332074B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUC56eiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGPXTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgGPXTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:19:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3051C08C5CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mn17so5591576pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HeZXwV8yLxbY3gUDwoAQlT9mAbB9u1/YqIhjlLCDDdI=;
        b=tUC56eiCD/aT0BlQDJwZ0AhSw+h5q5mTFpWNTIz9Rf8uY8xLQrMi/4B+z4F5nH097Q
         jStadvqIXBzoJH+0W/ngYmuAgVaRYZqYpTb9m2MwMTz5MUW8iyUFCVaAWSGz8KoN7Rep
         D1uJmI/WqsIvhEQrT2Qv3sYDgZWEwYC5gWAQTRUYGKbYDshj9p2ui+evxytb4pMgZR6Z
         V84I61+sSEw676t63oUPsOWZAmHNuJg3ZF9YcBMu9AXi6yw2Dn+7xV3u/PWYuEsbjXX0
         aAUgZvYe9Fv3jfU4x3j5coVMk2mmPDHJCUZPw6oM5dMeKLspjNJyI/FqRWQnDUjmy5mA
         ZDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeZXwV8yLxbY3gUDwoAQlT9mAbB9u1/YqIhjlLCDDdI=;
        b=AUgnYFJ8ndK5z7pN9Y2qMhXTCCBSHpQXmTbL9bObx7BELl8ur51R8nTgQpmSP3NoTJ
         tOBPwQduR1l+/41fU/VYry0TCKcM+muBP5QjgXdAS1TJ2YxGG36tZqiSZ/88kjhc3esx
         /czAEjokQ+8mvkhInYSLE2Zi9Sm96gYp2FbV8Xr157rinprtc9BHjjXO+2/7x5eJCgVE
         AxlRbsqEnQSY0iYLjtMHANU2PzvEemkCbIPoSicx72q7JV4xPQqAbHW/ymFUlkeTUEqS
         D1pt1VJ/7G48VPhArIp1j1Tww+yziUkbOqiODIhchLoK6qJh+iwJ/W8MrSmmGfxwWd9p
         Q2rw==
X-Gm-Message-State: AOAM533Wwy4EaCeUMco4e+YqSka6Ygl68rUTd0JsJdEvvtnG/Dykdsyt
        EYHNSLsO9csi4EM/8C/0xYH813KkDjI=
X-Google-Smtp-Source: ABdhPJxkbMksebSnHK9DUdx7VczpcMEC+0UCKkIwmvynQN+3D7NfvEoUESbKWfFnTZJIGogSHHpt1A==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr5429639ple.180.1594941540986;
        Thu, 16 Jul 2020 16:19:00 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm6024530pgf.53.2020.07.16.16.18.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:19:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/gatt-client: Remove notification if its attribute is removed
Date:   Thu, 16 Jul 2020 16:18:56 -0700
Message-Id: <20200716231857.934396-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200716231857.934396-1-luiz.dentz@gmail.com>
References: <20200716231857.934396-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the attribute is being removed from the database it means the
notification shall also be dropped, that way users don't have to
cleanup its subscriptions themselves.
---
 src/shared/gatt-client.c | 70 +++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0b81a7a5c..e21aca1f0 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -174,9 +174,12 @@ static void request_unref(void *data)
 }
 
 struct notify_chrc {
+	struct bt_gatt_client *client;
+	struct gatt_db_attribute *attr;
 	uint16_t value_handle;
 	uint16_t ccc_handle;
 	uint16_t properties;
+	unsigned int notify_id;
 	int notify_count;  /* Reference count of registered notify callbacks */
 
 	/* Pending calls to register_notify are queued here so that they can be
@@ -235,6 +238,51 @@ static void find_ccc(struct gatt_db_attribute *attr, void *user_data)
 	*ccc_ptr = attr;
 }
 
+static bool match_notify_chrc(const void *data, const void *user_data)
+{
+	const struct notify_data *notify_data = data;
+	const struct notify_chrc *chrc = user_data;
+
+	return notify_data->chrc == chrc;
+}
+
+static void notify_data_cleanup(void *data)
+{
+	struct notify_data *notify_data = data;
+
+	if (notify_data->att_id)
+		bt_att_cancel(notify_data->client->att, notify_data->att_id);
+
+	notify_data_unref(notify_data);
+}
+
+static void notify_chrc_free(void *data)
+{
+	struct notify_chrc *chrc = data;
+
+	if (chrc->notify_id)
+		gatt_db_attribute_unregister(chrc->attr, chrc->notify_id);
+
+	queue_destroy(chrc->reg_notify_queue, notify_data_unref);
+	free(chrc);
+}
+
+static void chrc_removed(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct notify_chrc *chrc = user_data;
+	struct bt_gatt_client *client = chrc->client;
+	struct notify_data *data;
+
+	chrc->notify_id = 0;
+
+	while ((data = queue_remove_if(client->notify_list, match_notify_chrc,
+								chrc)))
+		notify_data_cleanup(data);
+
+	queue_remove(client->notify_chrcs, chrc);
+	notify_chrc_free(chrc);
+}
+
 static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 							uint16_t value_handle)
 {
@@ -274,22 +322,18 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
 	if (ccc)
 		chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
 
+	chrc->client = client;
+	chrc->attr = attr;
 	chrc->value_handle = value_handle;
 	chrc->properties = properties;
+	chrc->notify_id = gatt_db_attribute_register(attr, chrc_removed, chrc,
+									NULL);
 
 	queue_push_tail(client->notify_chrcs, chrc);
 
 	return chrc;
 }
 
-static void notify_chrc_free(void *data)
-{
-	struct notify_chrc *chrc = data;
-
-	queue_destroy(chrc->reg_notify_queue, notify_data_unref);
-	free(chrc);
-}
-
 static bool match_notify_data_id(const void *a, const void *b)
 {
 	const struct notify_data *notify_data = a;
@@ -303,16 +347,6 @@ struct handle_range {
 	uint16_t end;
 };
 
-static void notify_data_cleanup(void *data)
-{
-	struct notify_data *notify_data = data;
-
-	if (notify_data->att_id)
-		bt_att_cancel(notify_data->client->att, notify_data->att_id);
-
-	notify_data_unref(notify_data);
-}
-
 struct discovery_op;
 
 typedef void (*discovery_op_complete_func_t)(struct discovery_op *op,
-- 
2.25.3

