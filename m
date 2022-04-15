Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B18C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 22:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiDOWdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiDOWdY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 18:33:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B48119F
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s137so8783925pgs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GHAnsbP6AFrJg0mQehKfPLFs1ej/e9xkPrmiHnU7ue4=;
        b=RgXTxhgXIi5wf61VjoT2Gl1BL8mWPQY1Iyk+xHXH19UL4RZ63O6NVbN2nT5KWaavNM
         77Sb9Td8iETdooTNfbCLMwwGtMsjRmg41kg/0PV4jqhVdmp4IWhZK4UDo+Pt8nLzD/uh
         0re9+lHgeyCpGA+C8pBCM0INW5V0eAQKxMZZNak1seDZ5F5MkHSSKn5tJNch9EVjcZBI
         S9FNNWqgM29hFtaG2qH5y22lF//9Yk1jXKOP4+z1INbRUWnh2D0cLa8QQzBZ+1ZIptEY
         b46/aGoair5UGvAdI/mCloaYrufr2LfMmXn9E8whjUdWLxeZBOghFvfQ1eIAwL6jy3dO
         7n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHAnsbP6AFrJg0mQehKfPLFs1ej/e9xkPrmiHnU7ue4=;
        b=z9QOal6jbZFRVnntJZ6zwTQTt8izJwuuTJDs1dFQpvhg2+i68WnHdUPOLQzVdirGNY
         Ot+AH+WvJumfqwzOVrZFEddXFOOvgWhpmeEixnLDoIpLMUKsZsDfSNc0CZhyiE0vn4Pv
         QRVLl/JQGC6fT73oWQPgW/o4M0EgI35UdIPQnpq5vn/AEdnTczB2qR0IFnWwfvLmZtIh
         4N91PyZn5EknqckivcmkGTFtvotuqZgKyj/7EZKgmTAaOM3OnVUgNjiSK9uG8ynlEmi5
         Sy0BeAW2ZDlbZc+a0O6h5aZ6vcHoFsCOqfQH0dBbGXF2bPrNw1RdkYFHI0Kdh6XizWsN
         dy4A==
X-Gm-Message-State: AOAM530rTs3gXSqsGycs+qJh45zozfEI2eK22FAgHa80kqpgNMwIc7Dc
        /ricixLIYZSskFR8awtB4YpyvZPxdx8=
X-Google-Smtp-Source: ABdhPJyxIFuwh1TtMxoIw+WJnS4Mces52iJMtZCAXsO1PoRrpU6ylllRCiyeGTD2lvZ14g1jUf5efQ==
X-Received: by 2002:a63:151e:0:b0:39d:7613:9183 with SMTP id v30-20020a63151e000000b0039d76139183mr871224pgl.52.1650061851969;
        Fri, 15 Apr 2022 15:30:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t38-20020a634626000000b0039cc30b7c93sm5132594pga.82.2022.04.15.15.30.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:30:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
Date:   Fri, 15 Apr 2022 15:30:48 -0700
Message-Id: <20220415223049.1155838-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415223049.1155838-1-luiz.dentz@gmail.com>
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When running as a systemd service the CONFIGURATION_DIRECTORY
environment variable maybe set:

https://www.freedesktop.org/software/systemd/man/systemd.exec.html
---
 src/main.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/src/main.c b/src/main.c
index a448320c1..528956643 100644
--- a/src/main.c
+++ b/src/main.c
@@ -64,7 +64,7 @@
 
 struct btd_opts btd_opts;
 static GKeyFile *main_conf;
-static char *main_conf_file_path;
+static char main_conf_file_path[PATH_MAX];
 
 static const char *supported_options[] = {
 	"Name",
@@ -175,18 +175,43 @@ GKeyFile *btd_get_main_conf(void)
 	return main_conf;
 }
 
-static GKeyFile *load_config(const char *file)
+static GKeyFile *load_config(const char *name)
 {
 	GError *err = NULL;
 	GKeyFile *keyfile;
+	int len;
+
+	if (!name)
+		return NULL;
+
+	if (name)
+		snprintf(main_conf_file_path, PATH_MAX, "%s", name);
+	else {
+		const char *configdir = getenv("CONFIGURATION_DIRECTORY");
+
+		/* Check if running as service */
+		if (configdir) {
+			/* Check if there multiple paths given */
+			len = strstr(configdir, ":") - configdir;
+			if (len < 0)
+				len = strlen(configdir);
+		} else {
+			configdir = CONFIGDIR;
+			len = strlen(configdir);
+		}
+
+		snprintf(main_conf_file_path, PATH_MAX, "%*s/main.conf", len,
+						 configdir);
+	}
 
 	keyfile = g_key_file_new();
 
 	g_key_file_set_list_separator(keyfile, ',');
 
-	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
+	if (!g_key_file_load_from_file(keyfile, main_conf_file_path, 0, &err)) {
 		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
-			error("Parsing %s failed: %s", file, err->message);
+			error("Parsing %s failed: %s", main_conf_file_path,
+				err->message);
 		g_error_free(err);
 		g_key_file_free(keyfile);
 		return NULL;
@@ -1194,12 +1219,7 @@ int main(int argc, char *argv[])
 
 	mainloop_sd_notify("STATUS=Starting up");
 
-	if (option_configfile)
-		main_conf_file_path = option_configfile;
-	else
-		main_conf_file_path = CONFIGDIR "/main.conf";
-
-	main_conf = load_config(main_conf_file_path);
+	main_conf = load_config(option_configfile ? : "main.conf");
 
 	parse_config(main_conf);
 
-- 
2.35.1

