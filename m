Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E0C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C09C61925
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEKHYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKHYq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 03:24:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE28C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:23:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so22882397ybp.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hq3OAqf8KWJqIcKPp9Wed0kiOfRYA7pD1gZRGA3gWHI=;
        b=DLBm16lSmIhY4hP9HqpJrFRLr3pKA0lgoVYnuz71RIavrqZX6SN7E6KbB3F5Suaj70
         BzORkXJfdjCjpUPliBFABjLznTd0Ea3gV5MJN/D5Qjd6E9BveK9cQmTKeLjr123UobLD
         tWmtfP3r/MdRFrCCfXxSkR49BsxtkZAUh+fXsk3nQbnwVaCbZGwR/i1hfKewPA/4uE1q
         YwgvQ75Yg7Dhu/Q9vrOp+qszFVehAOBhRDzRlCmkm1zglTiA2JusADp6v08gluYMzsk8
         Z6VVWhQgMxdayxYWTOmflxV3RiwVl28hGQhLLBlj5mp2i/vMPFY0qoutrToEqM9WDC7n
         L61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hq3OAqf8KWJqIcKPp9Wed0kiOfRYA7pD1gZRGA3gWHI=;
        b=uN+VdDjQOAtZoz4mCw20d8at4yPP8BaGYAEJryOx7H/37SmmhA6pePghcdEMQVHrjS
         4ZHAcABznwSvWf0awaAdyzXJbiVDK85p0/Tljswpz7G5hVgwyerf0XbQicPkFuJAKKUS
         eLmsCh35EiQEge5MrHnMqE21SCjx99ik+DarKB1eVTFJBZRUrURhZTeZn4th1/rMNkDd
         XZTGgIzr2wfD7VhbZ43UlzPf5Jjps8zWPYnCXg3ch80MW/TSizB+E+/YtkabtnZn+2SR
         XVhPXt1XYdI6LMOyUvAslirEKmN+VJZ8HZ56490ZdSRxTL5kTNvOh0ZcnBS8bhDl1YHG
         iiBg==
X-Gm-Message-State: AOAM531IH/GBP69IkeBJO1Xttz4tHaHpu+vFnNDjD2HaqCS0Zu5xmt7g
        1JlYMbhUUqRHWXEsYNoaXkorrn+lSh8yt7u4SxxB9O15HrqPPffo+HjbrWolvEDd/RD95bYNEtd
        rHTe3sRszUHhPSHOn2w/jnkUK8PNDB6qHYdvvg7A2nkqCarkhypn0oB+l8yzRw+MChDBM8t0nEg
        /AncCE9YNASA0=
X-Google-Smtp-Source: ABdhPJxlZl6yQZ/pP1gUbHXdHTRBVML0vJs9nYD/RcIE3HFkCgiv4uzdWnPQOCnnUo31GeiEtrWmkhN/4PwvXa5M1g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:cbc0:6ee0:8475:58e])
 (user=howardchung job=sendgmr) by 2002:a25:2e47:: with SMTP id
 b7mr37898510ybn.397.1620717819976; Tue, 11 May 2021 00:23:39 -0700 (PDT)
Date:   Tue, 11 May 2021 15:23:33 +0800
Message-Id: <20210511152320.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
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
index a3247e4fd80a..1c9e9b2eff1f 100644
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
@@ -122,6 +126,8 @@ struct btd_opts {
 	uint8_t		key_size;
 
 	enum jw_repairing_t jw_repairing;
+
+	struct btd_advmon_opts	advmon;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index c32bda7d407d..617975d25cb1 100644
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
 
@@ -793,6 +799,18 @@ static void parse_config(GKeyFile *config)
 		}
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
@@ -832,6 +850,8 @@ static void init_defaults(void)
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
+
+	btd_opts.advmon.rssi_sampling_period = 0;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index f47cab46dc10..9ad8895bd700 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -244,3 +244,9 @@
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
2.31.1.607.g51e8a6a459-goog

