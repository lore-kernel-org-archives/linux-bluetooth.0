Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF35C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiERWRd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiERWR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:17:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE5C209B7B
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k16so3412068pff.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X1tWqgEEva7mkuzTKbVhg+7xlep5rVnxIn+4oJ8Ey4k=;
        b=QjA4Y0v2YTe27PF8DPNjxYE5AbRZWSG3Qx9yYvA66zdPD9kGqBhW40XA2Gpt7uPRTN
         vnyGTDijWa7lTNmFdRj17aS2HzFdhYMsr3wPU10WEsAJEk04zyuVxAxqm8tdtFMG+buP
         LhHwpLf8JSkybL5DWptEZFgSPJfU5q5PONThtrljFX7d5PYvAgFnZr+FHBbpeBwGRdFK
         LgvUS/XMpNSMVQV2JFP4W5lH2uj6VAtPXBEkO5t9KzPLEyAZmjoQzYeKWWowOVcz8/Wd
         vwyV3rZta14FE8FSkUwqFjAnB6RqRCp0BfwCwvzogPDJsU0KEuWtVuhKr5D5C29nfvY6
         f6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1tWqgEEva7mkuzTKbVhg+7xlep5rVnxIn+4oJ8Ey4k=;
        b=hUciMAq2vY21bLo9G0Bv5mRPxT7m6RrLO8j9192hV+L7Ui2SFYuK7SM4SnZzVNzfZo
         rVmQfqriTB7Jp9sxa26aOiyCLr9UQhiht0iASx2DrSZ3emBlq8eWnybV1Hoavt+4UeMe
         iOG3DYXh6dZ+OWkHd718hIUIGf9bpVMI+oh1Q2RqLkTvMzTD4BhvT/gjhpqQglPZ+l1m
         IpOS7s7G8luheI0pU1fK0NpX0ohO44xqrFwvkNOE/qAWsS6Uymb9w5a8v3vBex+Ic+XO
         gh1290Bjn+u+/02qmYN/P9tEQ3spJ3Mc2vsqD9dKNFAtWeIOhz3J/KqxgeRoPywU7Qab
         SwwA==
X-Gm-Message-State: AOAM533NbtskRyFDRlVadYthNWLeDcyFm+uoM4zqG8hB6w9cQuwfYjX9
        6gj8rJ8Vz4+ZgvpglyAbfb16TJapUpY=
X-Google-Smtp-Source: ABdhPJyfd1Ft7ZpuIWiaMm+DqsV32MfhULnx5yJBrAhEirKTJNpwxZFrVvJTMPEL3TNeoE2nUpmw7g==
X-Received: by 2002:a05:6a00:24d5:b0:50d:eea9:507 with SMTP id d21-20020a056a0024d500b0050deea90507mr1696353pfv.15.1652912247347;
        Wed, 18 May 2022 15:17:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001619b38701bsm2201363plb.72.2022.05.18.15.17.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:17:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] gatt: Store local GATT database
Date:   Wed, 18 May 2022 15:16:57 -0700
Message-Id: <20220518221701.2220062-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518221701.2220062-1-luiz.dentz@gmail.com>
References: <20220518221701.2220062-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables storing the local (adapter) GATT database which later will
be used by btmon to decode GATT handles.
---
 src/gatt-database.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index d32f616a9..cf651b5f5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -38,6 +38,8 @@
 #include "dbus-common.h"
 #include "profile.h"
 #include "service.h"
+#include "textfile.h"
+#include "settings.h"
 
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
 #define GATT_PROFILE_IFACE	"org.bluez.GattProfile1"
@@ -1528,6 +1530,17 @@ static void send_service_changed(struct btd_gatt_database *database,
 		error("Failed to notify Service Changed");
 }
 
+static void database_store(struct btd_gatt_database *database)
+{
+	char filename[PATH_MAX];
+
+	create_filename(filename, PATH_MAX, "/%s/attributes",
+				btd_adapter_get_storage_dir(database->adapter));
+	create_file(filename, 0600);
+
+	btd_settings_gatt_db_store(database->db, filename);
+}
+
 static void gatt_db_service_added(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
@@ -1538,6 +1551,8 @@ static void gatt_db_service_added(struct gatt_db_attribute *attrib,
 	database_add_record(database, attrib);
 
 	send_service_changed(database, attrib);
+
+	database_store(database);
 }
 
 static bool ccc_match_service(const void *data, const void *match_data)
-- 
2.35.1

