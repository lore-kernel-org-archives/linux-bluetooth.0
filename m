Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3939DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B822070E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC81Zl+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGQTPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgGQTPU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:15:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3BC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 207so5860653pfu.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q9H7Dmvj+o5rqZS7a9SM6wIi9VBpMGGwPN+3ZrU8m10=;
        b=dC81Zl+9VTGrL7AkP6HTC9WEGMwXKRb3Vj+ck/pu4M0S47xj8/fJap9oC8/vjC+cAz
         zA5B/2lQvOekItjKUy3r8YqjVQ1eW/BbWw21Q/y0VEiJY6wYMxUwOwmgbpTcTY+5c25T
         qMKAMHkK10rJU6BGjZqXtV8KvUNV5Qrd6/5/Ntd1WgaGK5hV4mH4lCUol4wHfX3aGHPb
         khLWjnDvmnp70FevaNX8kzEh9QWZjP95fLJoE0Inr1uTMVhuLCLNwZ7O2JiUov6fpBKp
         lF85udH9yhxBuEeGuI5/dKMJcfqqAn62DA8KLvCDY+ud3Ni8Atp32U1gA4b46mnzktY3
         Liaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9H7Dmvj+o5rqZS7a9SM6wIi9VBpMGGwPN+3ZrU8m10=;
        b=ojgHF7Pi1mrjdMp/IuDq6r4DguqRTPoH8p3Oc8DvLU99b3suASI7t3mikjJ+Q/wH1W
         wuw86rJ9qjWvbqLJDm9mVb/xM6EyZp/qspixWrPoTMYD1fSS2PZugqtrhaW0xlsvnfAu
         If7rjVON1RxoB3ADW/1WRTLyQ/TJacj+moQS3wrw/Yzo4od6dfMgVSrml/Ysz8d5DpzF
         0hXIjL0JF6DIuqKDbuHrPmv+67KB/fdw3dXyLeguas4DUU5b/LR/z4W5jNJ9vWcUc1aF
         6LhoguPghMer20HTGXS7LYT6f7wEuI75wpazBuPftK19QepmbcKH7RARwfTJr3G8cr3O
         WGdw==
X-Gm-Message-State: AOAM530BYbyfDIrEifBlz8STNgcqYnQKqQEuEty8Qlph3vF8gl3egoyf
        G6iXPzwea7Y4Mbjpe5jkXKDVinNpLAA=
X-Google-Smtp-Source: ABdhPJybdTArBWSGRRs9r2Rw2wXC9SD26Xnp4l2efKvY4Yc4Ffmq2sWO3feUcW/6HCiBWKutTbBbxQ==
X-Received: by 2002:a05:6a00:84e:: with SMTP id q14mr9299793pfk.309.1595013319293;
        Fri, 17 Jul 2020 12:15:19 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p9sm6488334pgc.77.2020.07.17.12.15.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:15:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/gatt-client: Remove notification if its attribute is removed
Date:   Fri, 17 Jul 2020 12:15:13 -0700
Message-Id: <20200717191515.220621-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
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
2.26.2

