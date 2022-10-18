Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 21:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJRV2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRV2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 17:28:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30EAA3FE
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 14:28:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 128so14453477pga.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbSj7fj+X30LLZftuEXUEleVFi2jSrK/Zu4j8/Qe0RU=;
        b=hD5nW/hc9gVohUZkwYxrru36jsdERdDbdXEnqft5GlfoNezeMJsEl0DTM+JgoeL+6i
         J3yAu3ZjzavJ/5DcyI3MOGZwfHkSCl1MSSkVAyE1yacsan4W1lP9ddjQNKYS3z4NWQCS
         0liDD3TngL/wHb3IG8EO+QA99Xec4w6fOKCsMYsx20D51xBD37qW+98qd6wC7uuVi1hG
         y7CqyfPnZjtOdajROajs6s4E8NtTgRbeGKVYJ54OLlXPZ6+ITwx1vf35HnmFiHNRnZKO
         bjq1MDHwNhQuOx75lRRgeT0cHZOs4zDhL1EApNH1a2kwWoWHCH9j7tLDC5qhoLF6s13l
         Uw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbSj7fj+X30LLZftuEXUEleVFi2jSrK/Zu4j8/Qe0RU=;
        b=BslsE1zxiXxAMZk74/dYJXPZmZaliMkO/NHnea4XNjZwrcbRUMBw5h/Ncgc6qZ+ISR
         +VfsECKfxtW9vpj6RQvGPv5V5rEUTYQwI6oNfoyEsZVIKrcRQRS7cNIYJ2wN/TDSY8gR
         n0HCXoB/tT+aypTPYQifg1sPQkHrCC00zbkUQL4xir/KAbddxxzrYTy1cxxcRME1aIyD
         H1480fVC0l1MygyrnwsDz63Pxsa+M8KWx5gR9H5E6XtKGc5IEqjS2ZIgVhWyAgyj532R
         SKAgAQvO803v9S7GmPBvi1rq9ZOe5C2GbdYngFR98W+ZsxgnA/lb0HKBRAqY0FgPSbQ5
         nBNA==
X-Gm-Message-State: ACrzQf1iWOJEZs596LAWmA86Z74ClZjOEpLw6gXV9Ef4DktwqjjaAdvV
        NzBY5FLs4ph0g3ZvKuBFEJ0o47QXulM=
X-Google-Smtp-Source: AMsMyM6iUCX0JZ8hqgwT6V1Q2sM2A88V99B0vvy7DyyOhvaX85/DMIICk1rXpQTjVix6oKEAOSLidw==
X-Received: by 2002:a63:5466:0:b0:43c:bc41:73a with SMTP id e38-20020a635466000000b0043cbc41073amr4430370pgm.77.1666128484738;
        Tue, 18 Oct 2022 14:28:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b0017f7c4e260fsm9230653plh.150.2022.10.18.14.28.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:28:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor/att: Detect cache changes
Date:   Tue, 18 Oct 2022 14:28:00 -0700
Message-Id: <20221018212800.3967256-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018212800.3967256-1-luiz.dentz@gmail.com>
References: <20221018212800.3967256-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect if the were any changes on cache files since
they were last loaded and then attempt to reload them.
---
 monitor/att.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 491f196bf38d..6143b79b58ae 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -22,6 +22,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <linux/limits.h>
+#include <sys/stat.h>
 
 #include <glib.h>
 
@@ -2426,7 +2427,9 @@ struct att_read {
 
 struct att_conn_data {
 	struct gatt_db *ldb;
+	struct timespec ldb_mtim;
 	struct gatt_db *rdb;
+	struct timespec rdb_mtim;
 	struct queue *reads;
 };
 
@@ -2440,6 +2443,26 @@ static void att_conn_data_free(void *data)
 	free(att_data);
 }
 
+static void gatt_load_db(struct gatt_db *db, const char *filename,
+						struct timespec *mtim)
+{
+	if (!gatt_db_isempty(db)) {
+		struct stat st;
+
+		if (lstat(filename, &st))
+			return;
+
+		/* Check if file has been modified since last time */
+		if (st.st_mtim.tv_sec == mtim->tv_sec &&
+				    st.st_mtim.tv_nsec == mtim->tv_nsec)
+			return;
+
+		*mtim = st.st_mtim;
+	}
+
+	btd_settings_gatt_db_load(db, filename);
+}
+
 static void load_gatt_db(struct packet_conn_data *conn)
 {
 	struct att_conn_data *data = conn->data;
@@ -2455,22 +2478,14 @@ static void load_gatt_db(struct packet_conn_data *conn)
 		conn->destroy = att_conn_data_free;
 	}
 
-	if (!gatt_db_isempty(data->ldb) && !gatt_db_isempty(data->rdb))
-		return;
-
 	ba2str((bdaddr_t *)conn->src, local);
 	ba2str((bdaddr_t *)conn->dst, peer);
 
-	if (gatt_db_isempty(data->ldb)) {
-		create_filename(filename, PATH_MAX, "/%s/attributes", local);
-		btd_settings_gatt_db_load(data->ldb, filename);
-	}
+	create_filename(filename, PATH_MAX, "/%s/attributes", local);
+	gatt_load_db(data->ldb, filename, &data->ldb_mtim);
 
-	if (gatt_db_isempty(data->rdb)) {
-		create_filename(filename, PATH_MAX, "/%s/cache/%s", local,
-								peer);
-		btd_settings_gatt_db_load(data->rdb, filename);
-	}
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
+	gatt_load_db(data->rdb, filename, &data->rdb_mtim);
 }
 
 static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
-- 
2.37.3

