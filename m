Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhLHWnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbhLHWnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:43:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16EC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso3310731pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xs0aHye2yddwEZkszgswHNqyiNadnHO4Kp4zkIjmceU=;
        b=qYrHZn4P9VIktrEWPBD02PGnSXtWYaRqRS7JaDokLrLh8vuCHYIEUNIl5zO3tqZ5C7
         OX4pehzpnwjhzYmTSrJ9CsU9+UcVQXktfOjLn5D/qN/vrnXyxi5KEMF6V4eB3SqR68V+
         4/ssyNKG0oyXfznXDgwz7tFELbQohMUDRFwiZyHmYKLIcmMkcRSOk9z6s+VbGNHO0Wvf
         K+wcv1elTKKTl09UniuQ2KacdSkpoETQonqNXHqR9D+KR7+sNkEFizuUsmM7zLiXqRbg
         Ri57/8s4qKXxPRLLlikFKv19JIYQ4Ax/OKw+2TorZ8sYfhPLqpgqx6UF/rqOc1CMGzX2
         F4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xs0aHye2yddwEZkszgswHNqyiNadnHO4Kp4zkIjmceU=;
        b=KCGO/bL/N4stBvwUC9Rjt+OgTSeYxAtgqcUQm1XuJyAsWnjn5nWIh8CyCQltt3uv/6
         wXj6ifzcm8KWro8t9atn4qxPOoRH58Ltn/NQYPx3RUxqNFvUu8J/mDWM8bwZ0vvY3ac8
         cvH6gUvUnt+kcsgqtGF8k3riOJ7wBQ+hasL9Kte3s79wqY6FiSXEMTeMTKRDshMWzOCE
         rF3xHG/6f0L7FBBH/lVi5EVpQnM59bSnIKY0+TwDWxe/MtHx+zpECp9qa320Agniufo+
         LwbN7gTnPkQZJrekh/ok+Ccg+D0GHv/3CEiwFAXiXeW1x/1Y1Qc54kCuw7BczXTSpQho
         EiEA==
X-Gm-Message-State: AOAM5314BXOcCal4/hVGK5lyxattsgKHmq2Rxd7mwwM0sK9+VbrDnLqO
        xB36DjXVmLJCFYfqmLxft3BunpiNMV0=
X-Google-Smtp-Source: ABdhPJxVDUN4hNGIQvBhi3OvbW56xTHQpYB/eiuKT/3duZszaOoTJlawjEakskZWKJeZAiOrBho3MQ==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr10807812pjb.7.1639003170212;
        Wed, 08 Dec 2021 14:39:30 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:29 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ V2 PATCH 5/5] profiles/health: Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:23 -0800
Message-Id: <20211208223923.519664-6-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208223923.519664-1-hj.tedd.an@gmail.com>
References: <20211208223923.519664-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the getrandom() syscall.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 profiles/health/hdp.c  | 11 +++++++----
 profiles/health/mcap.c | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 6bc41946f..40b6cc18a 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <unistd.h>
+#include <sys/random.h>
 
 #include <glib.h>
 
@@ -1484,13 +1485,15 @@ static void destroy_create_dc_data(gpointer data)
 static void *generate_echo_packet(void)
 {
 	uint8_t *buf;
-	int i;
 
 	buf = g_malloc(HDP_ECHO_LEN);
-	srand(time(NULL));
+	if (!buf)
+		return NULL;
 
-	for(i = 0; i < HDP_ECHO_LEN; i++)
-		buf[i] = rand() % UINT8_MAX;
+	if (getrandom(buf, HDP_ECHO_LEN, 0) < 0) {
+		g_free(buf);
+		return NULL;
+	}
 
 	return buf;
 }
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 5161ef77c..aad0a08a3 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <time.h>
+#include <sys/random.h>
 
 #include <glib.h>
 
@@ -1888,6 +1889,7 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
 {
 	struct mcap_mcl *mcl;
 	struct connect_mcl *con;
+	uint16_t val;
 
 	mcl = find_mcl(mi->mcls, addr);
 	if (mcl) {
@@ -1903,7 +1905,12 @@ gboolean mcap_create_mcl(struct mcap_instance *mi,
 		mcl->state = MCL_IDLE;
 		bacpy(&mcl->addr, addr);
 		set_default_cb(mcl);
-		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
+		if (getrandom(&val, sizeof(val), 0) < 0) {
+			mcap_instance_unref(mcl->mi);
+			g_free(mcl);
+			return FALSE;
+		}
+		mcl->next_mdl = (val % MCAP_MDLID_FINAL) + 1;
 	}
 
 	mcl->ctrl |= MCAP_CTRL_CONN;
@@ -2013,6 +2020,7 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 	bdaddr_t dst;
 	char address[18], srcstr[18];
 	GError *err = NULL;
+	uint16_t val;
 
 	if (gerr)
 		return;
@@ -2041,7 +2049,12 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		mcl->mi = mcap_instance_ref(mi);
 		bacpy(&mcl->addr, &dst);
 		set_default_cb(mcl);
-		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
+		if (getrandom(&val, sizeof(val), 0) < 0) {
+			mcap_instance_unref(mcl->mi);
+			g_free(mcl);
+			goto drop;
+		}
+		mcl->next_mdl = (val % MCAP_MDLID_FINAL) + 1;
 	}
 
 	set_mcl_conf(chan, mcl);
-- 
2.25.1

