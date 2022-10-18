Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 23:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJRXqK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 19:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRXqJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 19:46:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7ACD5F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so15314364pls.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQVOe4oCvjwQHwbJW6UYXvIxrMA6sYEZ8A+uwI77HZM=;
        b=TvFpGEdFJAlVlhaPNXyBr0D9D82AtjKQN76XX53pCBoYSRRcN0apLbT/2q46oi77iZ
         5srZsTXwKGOV08didsyvvSFbE+BqnPI3dlC4btB1zc1ml1/1AdsvO/2+UEHFc6LaxqMX
         NZlDQRbt14ivmPQ7IqfkNdQA0029ngC1p36ep4/ZT6TzK4IBhOZWz0MjUBYvKYDNSJ9Z
         G/h3fULi3l7QpJqOoY34DokIDsMQa971mzBgQ4+rwzvXNwu2sKQZSMOv5uh6KozV3AKp
         ZS4km6ACltRAvHJx0YRMVEa3LB63hIF28ihUzab0WDFyIBa54//nW+kCEJjvcEqHtDQ0
         NSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQVOe4oCvjwQHwbJW6UYXvIxrMA6sYEZ8A+uwI77HZM=;
        b=I1uJX6Q4PRswIDtLfCqd48PPxD9Vo9tR+kXRgxOtOC4zNWa8LYetnJ7zj/RJMGMpFb
         wu94GpwMMPFWuQIbdRQOCeWCVgfrHFKEEKn98w709G0IVynregK8rtz0VtgOKWA16LCU
         hczEsNxU4sVdbk9/4GlKM8INdNPTxOIC047sJAZMtvss+1x5ST2t2/AA+cyzI37sawbw
         z9BFDSpOc3uw7j2h+dtDsIRou8qOYKIuF5v4eptDjL97PLKGikepwip/+ZWQnEWHy7EO
         aMmbHWo000piKbvB+wa0+Ymb6BEau5pthqPxlcdtLZqnX1Zrq/FhmRWTn09C4jC+8BTk
         UNIA==
X-Gm-Message-State: ACrzQf28DHJrSRTUEyO6FFMe9Xl5vLIT44BBpS95qoKY6wsIGKM1mlS/
        0eZ+P2sh/IEJlsDCipru3sXiLLR8AB0=
X-Google-Smtp-Source: AMsMyM7kdbxe7llaAdKv697TcvDPbu8CxKfm2G3CgWBnRNRL4nEgqWydIqFeuPGn58x2sHefrKB6kA==
X-Received: by 2002:a17:90b:3588:b0:20b:590:46a2 with SMTP id mm8-20020a17090b358800b0020b059046a2mr6276441pjb.14.1666136767647;
        Tue, 18 Oct 2022 16:46:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ik3-20020a170902ab0300b00170d34cf7f3sm9137783plb.257.2022.10.18.16.46.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:46:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] monitor/att: Detect cache changes
Date:   Tue, 18 Oct 2022 16:45:59 -0700
Message-Id: <20221018234600.3990980-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018234600.3990980-1-luiz.dentz@gmail.com>
References: <20221018234600.3990980-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect if the were any changes on cache files since
they were last loaded and then attempt to reload them.
---
 monitor/att.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 491f196bf38d..7a4125567498 100644
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
 
@@ -2440,6 +2443,28 @@ static void att_conn_data_free(void *data)
 	free(att_data);
 }
 
+static void gatt_load_db(struct gatt_db *db, const char *filename,
+						struct timespec *mtim)
+{
+	struct stat st;
+
+	if (lstat(filename, &st))
+		return;
+
+	if (!gatt_db_isempty(db)) {
+		/* Check if file has been modified since last time */
+		if (st.st_mtim.tv_sec == mtim->tv_sec &&
+				    st.st_mtim.tv_nsec == mtim->tv_nsec)
+			return;
+		/* Clear db before reloading */
+		gatt_db_clear(db);
+	}
+
+	*mtim = st.st_mtim;
+
+	btd_settings_gatt_db_load(db, filename);
+}
+
 static void load_gatt_db(struct packet_conn_data *conn)
 {
 	struct att_conn_data *data = conn->data;
@@ -2455,22 +2480,14 @@ static void load_gatt_db(struct packet_conn_data *conn)
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

