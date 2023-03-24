Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD83C76195
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 23:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCXXjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCXXjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 19:39:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7915176
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso3109385pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679701141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrPCOvhSTHSd3T8ChT3FS2w8tFsJgg8u3qBbteprq3k=;
        b=NP4n2Y4icX7rm7Unnbg9/H4sAww/9qmEf8rLhx89m7Kza/WrOZBkUofSERDwpW8026
         SWyim7gOTG8GJkxX4/ONWW4xbAxMh3c3IvX9fJr9vZzCJ3Q1VpmYwWgiWZ+zp4VMm7hJ
         RwpfWj7npjmAxeSfB5oZkPOPnT5bzc3Iqcwgml/2CxH9s4/F5LcRMet76HyfOwGTJgVK
         h5cFBDUtV+yYoQQffMOKzbF2EW4K0Xk4MYtesCD9dKNazqCEhME8HTr0CVi39YuB0vUZ
         esjY1ZS0hJMaZ46EDhHiSDyxUBWfhmRnpYP0QHbB20bRj7XpGCWKL3NXsnCl7Lt0tbQp
         EYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrPCOvhSTHSd3T8ChT3FS2w8tFsJgg8u3qBbteprq3k=;
        b=oIvlSo9Q+m/B85nn1JZOtnD0c//xSyS51iAFoysdN34N0SEjwSGIk4yM9J4eUFM17X
         +hRSZyCfxXYaTfv1DEgPLW9acGAva/yrURv6uPBfLir6fyapshzxFA0Ie/00JvSnZ/1e
         KB8xibuItf3Cmj/YtId75rw3+4ieAXlzsYM08P+Dmz1OuN/y/FB9gEDhUTADfB24KzFA
         q5Y/O/yeohdDlNjTHMLT7hHebonzxZo9edT17NjBLeqKovMkdz51yDJWrRdR0OgzoZBl
         LYR9r1yi3wBRA4wfBQhSlDu+hRU/Uq0G7+uzgpqCyDq1VdwXIa+HLX1lRmJDfkWWbZuQ
         uokg==
X-Gm-Message-State: AAQBX9dCJD5962TEP6h2QNAlzzHlK/WF3wz0WIh4b1JBfszu7ZVdsVLU
        LjSGaPOyi/DJIC/+Y4MMtn6fs2ROKTA=
X-Google-Smtp-Source: AKy350ZAvkVkR7G0cNIzd2QZwAHUm9fAR+uVM+29UT4xytg0FhI0HQSYW4h9kZhy0CHpqyMsbDVPnw==
X-Received: by 2002:a17:902:d4c7:b0:19e:82d5:634c with SMTP id o7-20020a170902d4c700b0019e82d5634cmr4162879plg.53.1679701141573;
        Fri, 24 Mar 2023 16:39:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm13666771plr.161.2023.03.24.16.38.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:39:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] monitor/att: Fix not loading gatt_db for devices using RPA
Date:   Fri, 24 Mar 2023 16:38:55 -0700
Message-Id: <20230324233856.3693370-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324233856.3693370-1-luiz.dentz@gmail.com>
References: <20230324233856.3693370-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device using RPA have its storage using its identity address so this
uses keys_resolve_identity to attempt to resolve the destination
address instead of always using the connection address.
---
 monitor/att.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index 42d1afe701a1..cf440c6844c0 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -42,6 +42,7 @@
 #include "display.h"
 #include "l2cap.h"
 #include "att.h"
+#include "keys.h"
 
 struct att_read {
 	struct gatt_db_attribute *attr;
@@ -2885,9 +2886,14 @@ static void load_gatt_db(struct packet_conn_data *conn)
 	char filename[PATH_MAX];
 	char local[18];
 	char peer[18];
+	uint8_t id[6], id_type;
 
 	ba2str((bdaddr_t *)conn->src, local);
-	ba2str((bdaddr_t *)conn->dst, peer);
+
+	if (keys_resolve_identity(conn->dst, id, &id_type))
+		ba2str((bdaddr_t *)id, peer);
+	else
+		ba2str((bdaddr_t *)conn->dst, peer);
 
 	create_filename(filename, PATH_MAX, "/%s/attributes", local);
 	gatt_load_db(data->ldb, filename, &data->ldb_mtim);
-- 
2.39.2

