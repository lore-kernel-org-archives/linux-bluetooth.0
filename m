Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39389C47080
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 02:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE561168
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 02:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhEXCpM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 May 2021 22:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhEXCpM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 May 2021 22:45:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B3C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 19:43:43 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x13-20020a65414d0000b029021b7c343d32so1485383pgp.19
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1FzVE3PAeI49l0j73y3tYJ0lzNJx+HJPjdIbesY8aKY=;
        b=vaxA+oID7XBF3NyoW/wK+yynhI50dH4vVr0ka/IY4J5gxD15pkUWW2TbQGnYK6Ny1f
         lRgQmL6ob2fSMFytag0o5evH8IZYu052vi1Ic9LdI1te+NqguLQt9QAKSclxPoxTkA9F
         ZKuPi3eXzHwE/Sd0quK87kAEy/ND9QWbdtV6OF2ng/WEeoU3IbmxI6Diwuu/2caHUOZv
         kKNMYGvp8lTzZiyL0nHtxJekGeACaJFAL0q+iocINfy6o2qTKnwkrpQHktTNYZthysfZ
         NOweTR3lB8EO1h2WA0KU7XHynN+aecWTnav4C2R694XMk0YWd5jXk8rBdJvSw8oDnwWV
         dqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1FzVE3PAeI49l0j73y3tYJ0lzNJx+HJPjdIbesY8aKY=;
        b=NBolcoPQvmtHT/e0lfn3G+Rj+pqTKpU8tqkeqkQtLmS1slO2H2BO2pSMtsEI7H9kKT
         mOY33PVhav4OyCduxUgRmwq+n0BwOBN1lmDT2XVWNKkcCRU/G9ThItmFSOqq8OnPbl49
         HJRVbbi02Y1xie4EICUV8qmMiRFXyqBBfhMdqytX3ZW1NONllgqJh8iCGfdO3rY/3E1V
         AklnTgvoe5gzjY/P3uTiPxNAJZeFdQwzEhl+qSXj2Htk4znI7v9QxlsqBzH2sB54w6z8
         SaeYHPrrtRkjOrSIG2BPK/lanKlV/vuyCRMKfUPe1cQhnct60FtPxo2drAPZSUIQI9mO
         QHxQ==
X-Gm-Message-State: AOAM5330s+Vo9xx2M7/VFrYDpmr+kUBaSb+gErs65NfkSasUwXkE6eLj
        IoBk1t8K7n4qBcAck1ETybyzvpK+fTKrHAMg2JN5TFy04/ZznOjswOkXkqecFP7VklE6lqmCtmH
        G70+7FyO2XdL/RBTeNBMx/KuX8FL6XXeckXACdpTq1GguBtm8pUIF9q2YJurY4dh+R4dZhzlu3D
        PT4vHsgyWDXK8=
X-Google-Smtp-Source: ABdhPJzO5hMcLFRCSZhJEviatcGkbz7ozzgDqe2yccaT/cdHpGXh+iRHAQJPl+AQKlRl1Im3/j8J+SSNbbs2swU9PQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:405a:37d1:d35f:13c9])
 (user=howardchung job=sendgmr) by 2002:a17:90a:f518:: with SMTP id
 cs24mr22805794pjb.182.1621824223046; Sun, 23 May 2021 19:43:43 -0700 (PDT)
Date:   Mon, 24 May 2021 10:43:37 +0800
Message-Id: <20210524104329.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [Bluez PATCH v1] core: Add RSSI sampling period in system parameter
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>, apusaka@chromium.org,
        mmandlik@chromium.org, mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Add an option in main.conf to configure the default RSSI sampling
period for advertisement monitor.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mmandlik@chromium.org
Reviewed-by: mcchou@chromium.org
---

 src/adv_monitor.c |  4 ++--
 src/btd.h         |  6 ++++++
 src/main.c        | 20 ++++++++++++++++++++
 src/main.conf     |  6 ++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 9f04aaefbf22..17f1777eb1da 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -25,6 +25,7 @@
 #include "lib/mgmt.h"
 
 #include "adapter.h"
+#include "btd.h"
 #include "dbus-common.h"
 #include "device.h"
 #include "log.h"
@@ -49,7 +50,6 @@
 #define ADV_MONITOR_DEFAULT_HIGH_TIMEOUT 10	/* second */
 #define ADV_MONITOR_UNSET_SAMPLING_PERIOD 256	/* 100 ms */
 #define ADV_MONITOR_MAX_SAMPLING_PERIOD	255	/* 100 ms */
-#define ADV_MONITOR_DEFAULT_SAMPLING_PERIOD 0	/* 100 ms */
 
 struct btd_adv_monitor_manager {
 	struct btd_adapter *adapter;
@@ -831,7 +831,7 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 		h_rssi_timeout = ADV_MONITOR_DEFAULT_HIGH_TIMEOUT;
 
 	if (sampling_period == ADV_MONITOR_UNSET_SAMPLING_PERIOD)
-		sampling_period = ADV_MONITOR_DEFAULT_SAMPLING_PERIOD;
+		sampling_period = btd_opts.advmon.rssi_sampling_period;
 
 	if (h_rssi < ADV_MONITOR_MIN_RSSI || h_rssi > ADV_MONITOR_MAX_RSSI ||
 		l_rssi < ADV_MONITOR_MIN_RSSI ||
diff --git a/src/btd.h b/src/btd.h
index 6af54a99a02b..d7288354698a 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -89,6 +89,10 @@ struct btd_avdtp_opts {
 	uint8_t  stream_mode;
 };
 
+struct btd_advmon_opts {
+	uint8_t		rssi_sampling_period;
+};
+
 struct btd_opts {
 	char		*name;
 	uint32_t	class;
@@ -123,6 +127,8 @@ struct btd_opts {
 	uint8_t		key_size;
 
 	enum jw_repairing_t jw_repairing;
+
+	struct btd_advmon_opts	advmon;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index 57db9c134854..516509e3f076 100644
--- a/src/main.c
+++ b/src/main.c
@@ -145,6 +145,11 @@ static const char *avdtp_options[] = {
 	NULL
 };
 
+static const char *advmon_options[] = {
+	"RSSISamplingPeriod",
+	NULL
+};
+
 static const struct group_table {
 	const char *name;
 	const char **options;
@@ -155,6 +160,7 @@ static const struct group_table {
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
 	{ "AVDTP",	avdtp_options },
+	{ "AdvMon",	advmon_options },
 	{ }
 };
 
@@ -802,6 +808,18 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	val = g_key_file_get_integer(config, "AdvMon", "RSSISamplingPeriod",
+									&err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		val = MIN(val, 0xFF);
+		val = MAX(val, 0);
+		DBG("RSSISamplingPeriod=%d", val);
+		btd_opts.advmon.rssi_sampling_period = val;
+	}
+
 	parse_br_config(config);
 	parse_le_config(config);
 }
@@ -842,6 +860,8 @@ static void init_defaults(void)
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+
+	btd_opts.advmon.rssi_sampling_period = 0;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index bf8a86080a24..198899541459 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -248,3 +248,9 @@
 # The value is in seconds.
 # Default: 2
 #ResumeDelay = 2
+
+[AdvMon]
+# Default RSSI Sampling Period. This is used when a client registers an
+# advertisement monitor and leaves the RSSISamplingPeriod unset.
+# Default: 0
+#RSSISamplingPeriod=0
-- 
2.31.1.818.g46aad6cb9e-goog

