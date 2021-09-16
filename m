Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8035C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB438611C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhIPWjt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbhIPWjt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 18:39:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436AC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:38:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w6so4876939pll.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6uTWO2+CjCqhyRHSMgXWD022m5RXADuHw9lscgIZBI=;
        b=VOF5VjVYVeNnOdwg6naRv/33UhtGWqw7QJGtnxFCSV/0w+YmJXONpDTE74KPeYHtt1
         wWEqyiiMbYJjaypnMVqHWJ5W3iLGCU4B8U3tjYKyejNjgg7/C0ID6NTJt146LEt3SN62
         RHGfdpvz1u1+Ph44t3USB1ZhRBzZgqjDUEo6YE9SeuxzefveIwkyPooTHoowc88QW/CA
         ArwKUXNxmhIryOArEeEARjFZAL6k/IOD0LeEBHG8UafArsxd3z5Qr2HkDx7hDAo1xCko
         vQV35sYQXilCuPafKVvuENlp2iCX8a8f23HczRf/RlYktwVkE7q3myMn/BhhFVG1zMPm
         RTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6uTWO2+CjCqhyRHSMgXWD022m5RXADuHw9lscgIZBI=;
        b=tEdLydiii4+9kIfBqMrPShqCKhiomjW0JPBBtwY5v/6BWc+L08s2UvtcI8unmZqb+y
         MpF2ib+oOxLelLeavCxMIkATMKKLYwgFjU19Ax8iML/wrX2gfzAoEhzgSBIq9XcvJXoV
         bI/hjgV1juZyVNI8uUjFoF7rK026jMfEiACACFElmyAZslxuvOeXssWj1i47Y0IMmddO
         3804DmdRcskv8b6j9FrprS1e83YU22zRHT6KZCQSN1gEluzL8oDA9UbMwFVTwPW5S9Pj
         vZ9EwHHGH3k4ua27juKKfIv3HL9Xl0IYCc1e7qiIJA4n7peK6QBwJC47JIANHnyC2nMy
         RI2A==
X-Gm-Message-State: AOAM530dwDW0aIAsAa0MAg3ECMCpMBEMIbFvYlomI14MC08JkJtfxMhE
        GjbL7AWdN2U4IoUVSZQKLsXu6nRFx0g=
X-Google-Smtp-Source: ABdhPJy/BhyWkBUZ9hHCuSyjeGH0lcx4clgnMhkN4GcnEiK4xAP5Z+TP/f/hEabybDWvL044QSMlyg==
X-Received: by 2002:a17:90a:8b0d:: with SMTP id y13mr4179831pjn.211.1631831906665;
        Thu, 16 Sep 2021 15:38:26 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t2sm8643778pje.5.2021.09.16.15.38.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:38:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] admin: Fix leaking uuids loads from storage
Date:   Thu, 16 Sep 2021 15:38:24 -0700
Message-Id: <20210916223825.276530-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace:

8 bytes in 1 blocks are definitely lost in loss record 27 of 274
   at 0x4839809: malloc (vg_replace_malloc.c:307)
   by 0x495BBB8: g_malloc (in /usr/lib64/libglib-2.0.so.0.6600.8)
   by 0x494C024: g_key_file_get_string_list (in /usr/lib64/libglib-2.0.so.0.6600.8)
   by 0x131ECD: key_file_load_service_allowlist (admin.c:294)
   by 0x131ECD: load_policy_settings (admin.c:346)
   by 0x131ECD: admin_policy_adapter_probe (admin.c:497)
   by 0x18F554: probe_driver (adapter.c:4858)
   by 0x19DF5A: load_drivers (adapter.c:4873)
   by 0x19DF5A: adapter_register (adapter.c:8975)
   by 0x19DF5A: read_info_complete (adapter.c:9791)
   by 0x1CE831: request_complete (mgmt.c:264)
   by 0x1CF7D4: can_read_data (mgmt.c:356)
   by 0x1DE634: watch_callback (io-glib.c:157)
   by 0x4953A9E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6600.8)
   by 0x49A5A97: ??? (in /usr/lib64/libglib-2.0.so.0.6600.8)
   by 0x4953162: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6600.8)
---
 plugins/admin.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 8390f3c32..c232c057c 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -12,6 +12,7 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 #include <sys/file.h>
@@ -74,7 +75,7 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 
 static void free_service_allowlist(struct queue *q)
 {
-	queue_destroy(q, g_free);
+	queue_destroy(q, free);
 }
 
 static void admin_policy_free(void *data)
@@ -307,7 +308,7 @@ static void key_file_load_service_allowlist(GKeyFile *key_file,
 		if (!uuid)
 			goto failed;
 
-		if (bt_string_to_uuid(uuid, *uuids)) {
+		if (bt_string_to_uuid(uuid, uuids[i])) {
 
 			btd_error(admin_policy->adapter_id,
 					"Failed to convert '%s' to uuid struct",
@@ -318,14 +319,16 @@ static void key_file_load_service_allowlist(GKeyFile *key_file,
 		}
 
 		queue_push_tail(uuid_list, uuid);
-		uuids++;
 	}
 
 	if (!service_allowlist_set(admin_policy, uuid_list))
 		goto failed;
 
+	g_strfreev(uuids);
+
 	return;
 failed:
+	g_strfreev(uuids);
 	free_service_allowlist(uuid_list);
 }
 
-- 
2.31.1

