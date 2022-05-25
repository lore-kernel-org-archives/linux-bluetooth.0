Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 01:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiEYBGV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 21:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiEYBGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 21:06:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D37815834
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 18:06:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9so8457784ilq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taLYeXb3Om70PCLdzETS3EegPkDAy1yL2opmAKp+/ok=;
        b=KLq7QzFeecAz7j8GsOb/6Zq3TdlL9pd+rHEj/kUsKLO5j+5tefVki5LvLOvoMyAMbU
         GZ65nwVyCsBDakoIRVNA0IonN4wuRxf5rFyBMju0wOpsng9kleAwoACR7LJ41VHh9qca
         b9XAx6m/n3YC+LkNrzvNqATK44eEzxmgLVw8Kj905oWlnIq06+4nHmcCge/lGUsi1BwE
         1ksdcXfQH5iNEmvYuVzfHUL7CRqnbM3v+1Q37jebR06kI1CC0m+EjxAc2ddoKYmelNwQ
         /dm7aQ/98176d3c85kL+16YVvQkf21LaHohKcrJBQVod3CfnHFNy8Xezv42+ueNs78tJ
         F6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taLYeXb3Om70PCLdzETS3EegPkDAy1yL2opmAKp+/ok=;
        b=1xQUXUqTGc9tV+sDfyY5pxEd83NKtMSpJCnu/8PRsW9lVbFTvNb6p1gy3IX0iFh7c/
         ak5gkB1SFv9q21wrvvpNV94zQT3V6JNejxyE64Gun5d4u8lJg0Fdl3rFq8bzbBLB/Q2V
         ligD7NeAm3JLLynZRDWLVFVAB3gX4VPeLghUyl8q0neHE1kCLKqWzfark+99TX8Ivqpm
         Te+g9/sPbDK7Rakx1SEw9yLfZDzflpiaFA65tTo45D8zmtr2ee0lmgswR57HqnJfBEzg
         SVkenoxsv86rmpRkZ/wZgakS+aC8YAHcC0lcoVWJEwzUq0XSfQ4CU2ozYK0XfA+2JX3T
         S8cg==
X-Gm-Message-State: AOAM531Ys9ISolDQvW31B8vXih5k2vgrPaW24J/o7/d5Gz6DYdyk/ZEE
        /E+C/1KyRsWcQGvao1Dn7S/ziQPSgqw=
X-Google-Smtp-Source: ABdhPJyYJkHYrUCj2OtXldkiyKFg5Anqy4htYuw9hZb37Yh1t11x3N4FLtlbl8n+Q5V1yLvAJXqpJQ==
X-Received: by 2002:a92:c547:0:b0:2cf:90b9:67be with SMTP id a7-20020a92c547000000b002cf90b967bemr15231112ilj.119.1653440777454;
        Tue, 24 May 2022 18:06:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f9-20020a056638022900b0032e3bf65b5esm3826730jaq.38.2022.05.24.18.06.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 18:06:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor/att: Attempt to reload if database is empty
Date:   Tue, 24 May 2022 18:06:14 -0700
Message-Id: <20220525010615.3670970-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If database is empty attempt to reload since the daemon may have
updated its cache in the meantime.
---
 monitor/att.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index d4fd18fd2..27d4730fc 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1232,32 +1232,39 @@ static void att_conn_data_free(void *data)
 
 static void load_gatt_db(struct packet_conn_data *conn)
 {
-	struct att_conn_data *data;
+	struct att_conn_data *data = conn->data;
 	char filename[PATH_MAX];
 	bdaddr_t src;
 	char local[18];
 	char peer[18];
 
+	if (!data) {
+		data = new0(struct att_conn_data, 1);
+		data->rdb = gatt_db_new();
+		data->ldb = gatt_db_new();
+		conn->data = data;
+		conn->destroy = att_conn_data_free;
+	}
+
+	if (!gatt_db_isempty(data->ldb) && !gatt_db_isempty(data->rdb))
+		return;
+
 	if (hci_devba(conn->index, &src) < 0)
 		return;
 
-	data = new0(struct att_conn_data, 1);
-	data->rdb = gatt_db_new();
-	data->ldb = gatt_db_new();
-	conn->data = data;
-	conn->destroy = att_conn_data_free;
-
 	ba2str(&src, local);
-
-	create_filename(filename, PATH_MAX, "/%s/attributes", local);
-
-	btd_settings_gatt_db_load(data->ldb, filename);
-
 	ba2str((bdaddr_t *)conn->dst, peer);
 
-	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
+	if (gatt_db_isempty(data->ldb)) {
+		create_filename(filename, PATH_MAX, "/%s/attributes", local);
+		btd_settings_gatt_db_load(data->ldb, filename);
+	}
 
-	btd_settings_gatt_db_load(data->rdb, filename);
+	if (gatt_db_isempty(data->rdb)) {
+		create_filename(filename, PATH_MAX, "/%s/cache/%s", local,
+								peer);
+		btd_settings_gatt_db_load(data->rdb, filename);
+	}
 }
 
 static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
@@ -1271,14 +1278,12 @@ static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
 	if (!conn)
 		return NULL;
 
-	data = conn->data;
 	/* Try loading local and remote gatt_db if not loaded yet */
-	if (!data) {
-		load_gatt_db(conn);
-		data = conn->data;
-		if (!data)
-			return NULL;
-	}
+	load_gatt_db(conn);
+
+	data = conn->data;
+	if (!data)
+		return NULL;
 
 	if (frame->in) {
 		if (rsp)
-- 
2.35.1

