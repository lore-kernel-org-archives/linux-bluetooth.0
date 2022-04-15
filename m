Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A37C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 21:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355041AbiDOV0c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354653AbiDOV0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 17:26:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C7E0AFD
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 14:22:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id be5so7949401plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vo9Mm/8ugT+ZMa+jmm5grG/1Sj2jaI41Nsvz/X5hhlE=;
        b=FiMPlQJP6V47mu6AKGpseQOfPKnEIkhNu8aogv9Bgfshj7FRGM1AeCSycpIq+PGLki
         pg8GA2eqtGbUYClmyTfX6csjSwiflpp/SJB94M+Oad5vpzGEkFasJqALS9gsq6gNe2hO
         aLwyGaUAKS1aPTDkyiE9y86WR0sVkdT9rRU9/iEwA7DTxteGdlGESaxTlq65k0aEpQVS
         Q7ZJDSVeHpGcyG0tKHEQAIG8UvEXEnnf0BDC+vaqzL3mmLjiduUyJh66Tok1c3i84wi/
         het4vVyZxus0XOrG90tpSNFEt+OdamvA1IGbzc4ryMwHFqLmADlePk7l0krT0jYN2A8X
         8NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo9Mm/8ugT+ZMa+jmm5grG/1Sj2jaI41Nsvz/X5hhlE=;
        b=bgitaZEiOFEVuCoIVIaqo4DBq/twOMkV7NVJ0zdq2q4CXWAR0HBIZrvx5TIE5ndZtY
         mQJtvi+MJGc17PsqRbmu+x/6wFSi4d39p16pZKuLi04/RznRArIpggNvjvBAc07egPwY
         CIkAS6Q3ubszgV3E5U6/8yg+wjkgnqZWK6yG4Dqp+N65o4fzSRiVFPMC/FHsPU902u0+
         7thSBUXFD2ik/7/kFJzosRKYjX8NJosX5rQA/hT5RAi3TXBdA5j43nC091t5lqTf/7eo
         LD7SuyHKDYC1eGAaiFLg9DhGSgHH8l6gX0E7gGF8eKSsUOnhbDeEOPWEwTCy8VlQ/58M
         s2OQ==
X-Gm-Message-State: AOAM5317MHVwBgOq1/Ws6y7uAHKvk7l7fCcx1sm+O+4/Hf160W/BolhP
        leH0DCXQFKLUKOnqe1YJ89R+NEtgu4A=
X-Google-Smtp-Source: ABdhPJyN+RbxQFWB5bUyqkIlq8NdTwb/Ltx0DUTr3WpQpcBbE0CKIx8bEVmnvwhKgP4I0+LTgpD4pg==
X-Received: by 2002:a17:902:9001:b0:156:a567:2683 with SMTP id a1-20020a170902900100b00156a5672683mr698467plp.164.1650057773760;
        Fri, 15 Apr 2022 14:22:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00505f920ffb8sm3740494pfq.179.2022.04.15.14.22.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:22:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
Date:   Fri, 15 Apr 2022 14:22:50 -0700
Message-Id: <20220415212251.1065432-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415212251.1065432-1-luiz.dentz@gmail.com>
References: <20220415212251.1065432-1-luiz.dentz@gmail.com>
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
index a448320c1..890d159d7 100644
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
+	if (name[0] == '/')
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
+		snprintf(main_conf_file_path, PATH_MAX, "%*s/%s", len,
+						 configdir, name);
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

