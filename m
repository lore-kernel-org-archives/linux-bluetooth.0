Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADDC48BE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 07:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732E20663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QGLuUrYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfFXHck (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:32:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46670 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfFXHck (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 03:32:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so11522683ljg.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2019 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFoM+UpluEGUM//acirGOnRcE/KbnEiRh0cbA2fZdDc=;
        b=QGLuUrYmxcBWSHh9uwMTuC9Ox1TUP5eez6jw5RG89x4YCZvJxEtyEidv+8WSUlPZBw
         q0WUFc0ahoevsFKkiXvaBAVHO2Ke+KmnZYDC7ZZgxfvd/j9y0heVtQj4vzl6U6gT+vPJ
         K7Gw7IvniuwCRz/+SUw2PQETskHQeclK1Sinm4GKn/cqZw/YU/YbgmLzNBtkilkBzofg
         ZNiY/WCjghKv1OdkDrWnVFF6rOTOW8qJOQJstlmeRWmYGjwVfl1SUmbTz9shnZVpMWno
         3JyVEL046MwlEt49Ewg4xzqQV+ntrcXXRatoBxdT2o28zST3GVXU1PhnFgldbfGyUtWn
         ioZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFoM+UpluEGUM//acirGOnRcE/KbnEiRh0cbA2fZdDc=;
        b=ocWq9GTL3wU56eXuJC31//1XMlMPJ2j8avNw0mhSIIsKPTGsNbHVAmMu1iB6g8uiMK
         DNg/of+c2rZJ44jy8dNKmM3j/VWv0+tpsiWug35oUyQlWBb6yRwd5jEUI4mY+1HajdFi
         +8+L5j15ozb9cHE1hvtYiNLp2gjwTMLpW1DWXoKJ4Po3UfzPGeUhzEWPpBruklLAWfww
         o823esvVZ3ynHSJj8rKRSiZZT4Yvk4abD1O6hkEVpBGRWHF3fBZeeSxUmKSWNzDC/pit
         hviOdlxpSfRdDfN2J7vSEcgn0YiBTcm32b9S0qYijkMzLsK16+yejA9fxgNyxwCITnqQ
         ClMA==
X-Gm-Message-State: APjAAAUnGAo0mMtVStrJnR3nv0ZXndtSIg8jchjIYkzzA53U+Bj5mSdZ
        V/zSFXxy+3sVxWJFgRWSeJiIvpb2Uj4=
X-Google-Smtp-Source: APXvYqx+K84fEFDkl88HJ6QqQWJlcuG7CfFViU3YI2UZcsSjJIRoGGdgcrI11dPdfLnOaxz6q03+Mw==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr8140452ljg.216.1561361557310;
        Mon, 24 Jun 2019 00:32:37 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id k4sm1609873ljg.59.2019.06.24.00.32.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 00:32:36 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 2/2] mesh: Added --io option
Date:   Mon, 24 Jun 2019 09:32:29 +0200
Message-Id: <20190624073229.8652-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624073229.8652-1-michal.lowas-rzechonek@silvair.com>
References: <20190624073229.8652-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows specifying io type and options when invoking the daemon.

By default, meshd runs with MESH_IO_TYPE_GENERIC and tries to attach to
the first available HCI interface.

Option "--index=<n>" is now just a shortcut for "--io=generic:<n>"
---
 mesh/main.c | 94 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 262e3da48..c9bf850f6 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -39,6 +39,7 @@
 
 static const struct option main_options[] = {
 	{ "index",	required_argument,	NULL, 'i' },
+	{ "io",		required_argument,	NULL, 'I' },
 	{ "config",	optional_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
@@ -49,16 +50,23 @@ static const struct option main_options[] = {
 
 static void usage(void)
 {
-	l_info("");
-	l_info("Usage:\n"
+	fprintf(stderr,
+		"Usage:\n"
 	       "\tbluetooth-meshd [options]\n");
-	l_info("Options:\n"
-	       "\t--index <hcinum>  Use specified controller\n"
+	fprintf(stderr,
+		"Options:\n"
+	       "\t--index <hcinum>  Equivalent of `--io=generic:<hcinum>`\n"
+	       "\t--io <io>         Use specified io (default: generic)\n"
 	       "\t--config          Configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
 	       "\t--dbus-debug      Enable D-Bus debugging\n"
 	       "\t--help            Show %s information\n", __func__);
+	fprintf(stderr,
+	       "io:\n"
+	       "\tgeneric[:<index>]\n"
+	       "\t\tUse generic HCI io on interface hci<index>, or the first\n"
+	       "\t\tavailable one\n");
 }
 
 static void do_debug(const char *str, void *user_data)
@@ -107,6 +115,37 @@ static void signal_handler(uint32_t signo, void *user_data)
 	terminated = true;
 }
 
+static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
+{
+	if (strstr(optarg, "generic") == optarg) {
+		int *index = l_new(int, 1);
+
+		*type = MESH_IO_TYPE_GENERIC;
+		*opts = index;
+
+		optarg += strlen("generic");
+		if (!*optarg) {
+			*index = MGMT_INDEX_NONE;
+			return true;
+		}
+
+		if (*optarg != ':')
+			return false;
+
+		optarg++;
+
+		if (sscanf(optarg, "hci%d", index) == 1)
+			return true;
+
+		if (sscanf(optarg, "%d", index) == 1)
+			return true;
+
+		return false;
+	}
+
+	return false;
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
@@ -114,7 +153,9 @@ int main(int argc, char *argv[])
 	bool dbus_debug = false;
 	struct l_dbus *dbus = NULL;
 	const char *config_dir = NULL;
-	int index = MGMT_INDEX_NONE;
+	enum mesh_io_type io_type = MESH_IO_TYPE_NONE;
+	char *io = NULL;
+	void *io_opts = NULL;
 
 	if (!l_main_init())
 		return -1;
@@ -123,7 +164,6 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
-		const char *str;
 
 		opt = getopt_long(argc, argv, "i:c:ndbh", main_options, NULL);
 		if (opt < 0)
@@ -131,18 +171,20 @@ int main(int argc, char *argv[])
 
 		switch (opt) {
 		case 'i':
-			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
-				str = optarg + 3;
-			else
-				str = optarg;
-			if (!isdigit(*str)) {
-				l_error("Invalid controller index value");
-				status = EXIT_FAILURE;
+			if (io) {
+				l_error("Use either --index or --io, not both");
+				status = EXIT_SUCCESS;
 				goto done;
 			}
-
-			index = atoi(str);
-
+			io = l_strdup_printf("generic:%s", optarg);
+			break;
+		case 'I':
+			if (io) {
+				l_error("Use either --index or --io, not both");
+				status = EXIT_SUCCESS;
+				goto done;
+			}
+			io = l_strdup(optarg);
 			break;
 		case 'n':
 			detached = false;
@@ -167,8 +209,20 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!parse_io(io, &io_type, &io_opts)) {
+		l_error("Invalid io: %s", io);
+		status = EXIT_FAILURE;
+		goto done;
+	}
+
+	if ((io_type == MESH_IO_TYPE_NONE) && !io_opts) {
+		int *index = l_new(int, 1);
+		*index = MGMT_INDEX_NONE;
+		io_type = MESH_IO_TYPE_GENERIC;
+		io_opts = index;
+	}
 
-	if (!mesh_init(config_dir, MESH_IO_TYPE_GENERIC, &index)) {
+	if (!mesh_init(config_dir, io_type, io_opts)) {
 		l_error("Failed to initialize mesh");
 		status = EXIT_FAILURE;
 		goto done;
@@ -198,6 +252,12 @@ int main(int argc, char *argv[])
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
+	if (io)
+		l_free(io);
+
+	if (io_opts)
+		l_free(io_opts);
+
 	mesh_cleanup();
 	l_dbus_destroy(dbus);
 	l_main_exit();
-- 
2.19.1

