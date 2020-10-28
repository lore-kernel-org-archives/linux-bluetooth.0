Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E91EC4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75632473C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAVpl4RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgJ1V6b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgJ1V6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656BC0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z1so282655plo.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fn8XfL+egm3syH01TjqE+HZMzMwCtsnR76UrEMv7X64=;
        b=jAVpl4RYmmCOGZ6oYe5GBCeftuDFt3R5QjytMki35a1do/5sxB7POQrNFziQ5V2fYA
         zjV4CTpgzFCFvUR5jM/XXFfRPokLoUHlMpuzDGlua5HUKLTfFQuHZ3R8sgSAZhNlqrlJ
         6rJc+1cpXihR5rZSXFuPDbXcRAEm17GdBxRTBSU3SrNTcybT4pe94M6vygTzaLjSeTJu
         0kNVO5hkqgo37q9vsKEZPnebmVUwbOF16tFoTXZtJ3Fun62OG2Qs1vVX2kxuG2jW61Zc
         8fazfssME8MJUsToGzjQHk4zUTSg/nu/XoxjRuV8YO1CfScKuxiZyhIwfavpIWNAvMcW
         RoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fn8XfL+egm3syH01TjqE+HZMzMwCtsnR76UrEMv7X64=;
        b=bj/IeidyJfWIO+8RhFag0WK7RSoKmO8SACRoOUIQG/F/vE0dIo6VwIR4vr3v3n/vtl
         BDatqjQJTHlXHe9ogJz2bDaFPfOK0gMcLT2KwevLmqQXG6niB1BpTfcbVN/6xQB4+LxG
         R0NrYOdDeOeUd7T0ZFduUzdNmvBCCVCL2tLtdL7nonVYU6mprwreyXY4cUq1aqQ84hzT
         X+reQ+VJki8QWzpAvldpQQ4mYZkcDHUv4YtmKCW0rp83CfGrq68m2oxgBG4kFyWGwJAY
         yRxWg3uKF9qEl9T15RB6mpBKMCuB2NB0uwFnvmo6V6MgZjwQ5Bd7LBUQdqW+4/XmDOXP
         58Ng==
X-Gm-Message-State: AOAM53355TkYmgJsU+5tB2OPVb9bx9tjR/dBPtKVMI1WuY+GbzFtAAVU
        S6pDz+iQ2Hb98sfkLQSGcOqbPMK5ojjmyw==
X-Google-Smtp-Source: ABdhPJzFuQe3B6r5SFSn/pwVdLgz5y4hP4Fp7brb4RQaDoB98hEYwH0fVsSGxMI3Tcv0gOtapM/Y+g==
X-Received: by 2002:a17:902:6b44:b029:d3:e78a:8ab6 with SMTP id g4-20020a1709026b44b02900d3e78a8ab6mr933355plt.72.1603922310073;
        Wed, 28 Oct 2020 14:58:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m13sm355290pjl.45.2020.10.28.14.58.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] core: Rename hcid.h to btd.h
Date:   Wed, 28 Oct 2020 14:58:24 -0700
Message-Id: <20201028215824.608794-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since we use btd term for daemon APIs it makes sense to use it also
for the header name instead of hcid.
---
 Makefile.am               | 2 +-
 plugins/neard.c           | 2 +-
 plugins/policy.c          | 2 +-
 profiles/audio/a2dp.c     | 2 +-
 profiles/audio/avdtp.c    | 2 +-
 profiles/scanparam/scan.c | 2 +-
 src/adapter.c             | 2 +-
 src/agent.c               | 2 +-
 src/{hcid.h => btd.h}     | 0
 src/device.c              | 2 +-
 src/gatt-client.c         | 2 +-
 src/gatt-database.c       | 2 +-
 src/main.c                | 2 +-
 src/plugin.c              | 2 +-
 src/rfkill.c              | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename src/{hcid.h => btd.h} (100%)

diff --git a/Makefile.am b/Makefile.am
index 56279c4ba..69b95828f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -272,7 +272,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
-			src/rfkill.c src/hcid.h src/sdpd.h \
+			src/rfkill.c src/btd.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
diff --git a/plugins/neard.c b/plugins/neard.c
index 091b39333..e07b51106 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -29,7 +29,7 @@
 #include "src/device.h"
 #include "src/eir.h"
 #include "src/agent.h"
-#include "src/hcid.h"
+#include "src/btd.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
diff --git a/plugins/policy.c b/plugins/policy.c
index dac1b7a24..ba9e1be02 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -30,7 +30,7 @@
 #include "src/device.h"
 #include "src/service.h"
 #include "src/profile.h"
-#include "src/hcid.h"
+#include "src/btd.h"
 
 #define CONTROL_CONNECT_TIMEOUT 2
 #define SOURCE_RETRY_TIMEOUT 2
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6e05db103..626f61d34 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -30,7 +30,7 @@
 
 #include "gdbus/gdbus.h"
 
-#include "src/hcid.h"
+#include "src/btd.h"
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index bcb0c71da..4c39088b8 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -29,7 +29,7 @@
 #include "lib/uuid.h"
 
 #include "btio/btio.h"
-#include "src/hcid.h"
+#include "src/btd.h"
 #include "src/log.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 41350c988..739a9a46d 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -32,7 +32,7 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "attrib/att.h"
-#include "src/hcid.h"
+#include "src/btd.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
diff --git a/src/adapter.c b/src/adapter.c
index 676cf97ce..1f075ef5f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -48,7 +48,7 @@
 #include "src/shared/gatt-db.h"
 
 #include "btio/btio.h"
-#include "hcid.h"
+#include "btd.h"
 #include "sdpd.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/src/agent.c b/src/agent.c
index 770a63838..7d66cf50d 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -30,7 +30,7 @@
 
 #include "log.h"
 #include "error.h"
-#include "hcid.h"
+#include "btd.h"
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/src/hcid.h b/src/btd.h
similarity index 100%
rename from src/hcid.h
rename to src/btd.h
diff --git a/src/device.c b/src/device.c
index de7f1c57d..7ddd3da64 100644
--- a/src/device.c
+++ b/src/device.c
@@ -44,7 +44,7 @@
 #include "btio/btio.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
-#include "hcid.h"
+#include "btd.h"
 #include "adapter.h"
 #include "gatt-database.h"
 #include "attrib/gattrib.h"
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 7fbf0093b..0cf5324ff 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -30,7 +30,7 @@
 
 #include "log.h"
 #include "error.h"
-#include "hcid.h"
+#include "btd.h"
 #include "adapter.h"
 #include "device.h"
 #include "src/shared/io.h"
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d8b7d261a..6694a0174 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -31,7 +31,7 @@
 #include "src/shared/gatt-server.h"
 #include "log.h"
 #include "error.h"
-#include "hcid.h"
+#include "btd.h"
 #include "adapter.h"
 #include "device.h"
 #include "gatt-database.h"
diff --git a/src/main.c b/src/main.c
index 6e18d5ef1..0ae45015f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -42,7 +42,7 @@
 #include "shared/mainloop.h"
 #include "lib/uuid.h"
 #include "shared/util.h"
-#include "hcid.h"
+#include "btd.h"
 #include "sdpd.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/src/plugin.c b/src/plugin.c
index 6fe394f5f..dd7b406c8 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -24,7 +24,7 @@
 #include "btio/btio.h"
 #include "src/plugin.h"
 #include "src/log.h"
-#include "src/hcid.h"
+#include "src/btd.h"
 
 static GSList *plugins = NULL;
 
diff --git a/src/rfkill.c b/src/rfkill.c
index 6309a7768..ec9fcdfdd 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -28,7 +28,7 @@
 
 #include "log.h"
 #include "adapter.h"
-#include "hcid.h"
+#include "btd.h"
 
 enum rfkill_type {
 	RFKILL_TYPE_ALL = 0,
-- 
2.26.2

