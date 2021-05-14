Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBBC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BA4613DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhENVOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhENVOS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 17:14:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F7C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:13:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11so529905pjm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OjKzQexm5KcgIQnR9+PKFce0Gqj/cHsbI57j7Kiy178=;
        b=AsXU55DvJZB5mv0OUfwX2W+eYbXREu/v6G6vsV8VXVjCYcnP68pxFjP4Txfj6WU3mo
         PfevfdQ/UumuOr6tkc7y6wHlhBlQ5fYaLkXle+V5q9O7PH22bbUoltXzEo6djXYh7ovM
         lprefn9ipNf+vl0el32SflbnQrGJmnrqF+fUk+FQyrsmU8rqpvldUJegA22lvNZVH7c2
         SPNjLLkI0NaMCVqqw0lxKUJuWARevOlmuacdALvTj3YkX4LbwgXI8xs4DvANX2J9c/Zo
         m2r+iffvEKyaxijHWAMT3QZoHnCRGsaRDt+5bXxcllT4HvwrBDeevqhZ+9GSdSwYrhIP
         Vcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OjKzQexm5KcgIQnR9+PKFce0Gqj/cHsbI57j7Kiy178=;
        b=ckDM+jrrEUZuV4qIodf3VIlFdKYkMyzvR+Uit6AKFtzbwssuzzF4PBTQngBshDVvS1
         M72FfXKUoPUxM/lwre1APp6UUJN2RPuctGuMHNwnols4h+6d2F/Zp3B/AvYavE0R/8qd
         SQVpSl7UrkmMI0w3tCthu3Sz+44kr8s989NUvKDuQO3w7e90obEhsLHLmmvJd6ib8wSu
         ra5oFPahUD76WSbEYvlL2RgWLeR4v/x+JV3wLX9FMfJsbIYhDweRv3afHQUje4v7vhj3
         cCOqIIq9ts9xGNiVFuKLjilsLwe8FGjmQj5s1iujMDGhREIB8uxZozG9T2O9H+pasg6T
         MSOQ==
X-Gm-Message-State: AOAM533oVsnOzZwTWz4xJsqTtmDEzVRvgLYexCXOg6MGguBf7ObQiORQ
        JCGps8PWuJoMD/A1IPJbD93A3ii7XbY=
X-Google-Smtp-Source: ABdhPJx5jR43v3VYo1SJvEpDeMDsYEGkah9S6M3akbN5i8mVcMG2Q+a678eqrrCxjq3hLeTDD1ee2g==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr54876957pjb.155.1621026785202;
        Fri, 14 May 2021 14:13:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f13sm4746077pfa.207.2021.05.14.14.13.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:13:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] main.conf: Add option to enable experimental features
Date:   Fri, 14 May 2021 14:13:04 -0700
Message-Id: <20210514211304.17237-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The adds options Experimental which is the equivalent to
-E/--experimental command line option.
---
 src/btd.h     |  1 +
 src/main.c    | 13 ++++++++++---
 src/main.conf |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index a3247e4fd..6af54a99a 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -105,6 +105,7 @@ struct btd_opts {
 	gboolean	debug_keys;
 	gboolean	fast_conn;
 	gboolean	refresh_discovery;
+	gboolean	experimental;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
diff --git a/src/main.c b/src/main.c
index c32bda7d4..c82812201 100644
--- a/src/main.c
+++ b/src/main.c
@@ -715,6 +715,13 @@ static void parse_config(GKeyFile *config)
 	else
 		btd_opts.refresh_discovery = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"Experimental", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		btd_opts.experimental = boolean;
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -812,6 +819,7 @@ static void init_defaults(void)
 	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
+	btd_opts.experimental = false;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
@@ -891,7 +899,6 @@ static char *option_configfile = NULL;
 static gboolean option_compat = FALSE;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
-static gboolean option_experimental = FALSE;
 
 static void free_options(void)
 {
@@ -975,7 +982,7 @@ static GOptionEntry options[] = {
 			"Specify an explicit path to the config file", "FILE"},
 	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
 				"Provide deprecated command line interfaces" },
-	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
+	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &btd_opts.experimental,
 				"Enable experimental interfaces" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
@@ -1042,7 +1049,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	if (option_experimental)
+	if (btd_opts.experimental)
 		gdbus_flags = G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 
 	g_dbus_set_flags(gdbus_flags);
diff --git a/src/main.conf b/src/main.conf
index f47cab46d..bf8a86080 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -86,6 +86,10 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
+# Enables experimental features and interfaces.
+# Defaults to false.
+#Experimental = false
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.30.2

