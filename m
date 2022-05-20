Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D12C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiETERF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiETERF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 00:17:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534426B671
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:04 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a19so6742439pgw.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X1tWqgEEva7mkuzTKbVhg+7xlep5rVnxIn+4oJ8Ey4k=;
        b=ORzOywuLtxLy8TNUaOO1kJq2fokVfdNHZonenAOzur8tHwDsXZlfNn9TTxpT03SXWd
         h+OCmPxeqxb13PNvgEVs3ZVUYQ/87A2jZ9d9vB7lbztuiwIrAF+DesszgPIgJ5fPRgdx
         YqpVpfz2Ml1ai4WpVxjYZbbG1Chc1wF5QrpHjltM8oIJf2heZjyefM8Hqvqc9Y2xyfnm
         dkSzq1SaUh+D/a5mcLUs7sNLxbLM9UHtqiG/xgqNIcWnlzqyZ82ASpi09JUHFCrYER9Z
         eC+IxG7xCWgFKOryt1v3EOZBQD0PtmTkQPF8U3w8aTTsuw/Yn86H0EPr5T96Q6Yjtytm
         KoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1tWqgEEva7mkuzTKbVhg+7xlep5rVnxIn+4oJ8Ey4k=;
        b=RaIpyeozntu83EkBAiwLkFnLTEAp4eomz7FzMkcxZdro0S7o4B5x4SPirxdSPugAuB
         fssVmZGwJJ8Z7lAJt0BerzkpFc2bfS0fO8viuJKyImPeDevca8V2UzbaeBkpaqdo3D8H
         ZyCqXQ6ZmVIRwDwytKk2p4S1JXkSkudPxXXaSfkFni3dDtvW1/FvfJtY32qMU+YylEpF
         msxcofE7R1fUknTzTf3dukZDKzAqGJAzlIUAsX1XE66hXxg+WUb9+i7I4YS5wcNz6sDT
         tGMoKCyTOw46Flu8T8rqX23Pxs+scLEu4VvjX/hnGPMFpr8QTEqXvbn6k6JikOkUvZgq
         PJTw==
X-Gm-Message-State: AOAM532k4Ti6LDAnwNJqpOcdS54vvhjRj5T/xE1BcO4x6GvTIgJjvZKR
        aJA73dacOFkwDsX/cpXONjeCSVPEjjY=
X-Google-Smtp-Source: ABdhPJzGig529p1NIITWRduaWFR7zJ3DUxGXMCjKe9jNvgjOhkXhHEgzsiRitPXMS0+rojrau8HgNg==
X-Received: by 2002:a63:5357:0:b0:3f2:6210:f8e9 with SMTP id t23-20020a635357000000b003f26210f8e9mr6670136pgl.158.1653020223536;
        Thu, 19 May 2022 21:17:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm381405pjg.37.2022.05.19.21.17.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:17:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] gatt: Store local GATT database
Date:   Thu, 19 May 2022 21:16:56 -0700
Message-Id: <20220520041701.2572197-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
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

