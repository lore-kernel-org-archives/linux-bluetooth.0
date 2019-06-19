Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C4C31E5E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9222070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 11:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ls8SuX42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfFSLZP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:25:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36806 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFSLZP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 07:25:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so2890664ljj.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5uCW0IqgmjfZV+HHJMvGjiNm//KqdJ021RmLjTm8vI=;
        b=Ls8SuX42drx93T8EXRjD7svMKMHdCB81w7io8Mncfj/LVxEAbv9a/EbVTAIbWipEl0
         fSTUh9ONbLAxQEwx4IPkXtFkR611VyE3KWFf3qJ+Ib0Z8MzZ8GcHLav+jCi9QeulvclJ
         f5W2EkG9Vr9jrUyKs1aO7Vsagv4Kr9rxgjL+qDvwV5I0KejXFtdLckaBRQZgrlMmTdGf
         bG9B1fUsh9HFKIFxPIfDhJJurxTFh1sIixLjT2Snj2zf1HjwwADD+vTLbMqu3NcPjSU/
         H2sPvMU3XN48eNB/ZsHlVuuTUdtK90zQ9SeA9nRRkXXfNrXVstd2ddXnXK6//bJ5Zmto
         jjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5uCW0IqgmjfZV+HHJMvGjiNm//KqdJ021RmLjTm8vI=;
        b=NjLJBDBYCWa1dLaLaVnqbBTbKqvNoitzxTsaATcPDMSMXjGpuF/uVITVhQTMtZ0lsw
         AaxzGBcV6FsYHB6DbBiHJcgKBJyxGeddgqsSHQcqI7gWYknvcZKcUN/ck13Bs8Stl8MS
         c2+0qaXMOf8wHqajUAD/4ErxAn+/8ZRh73q2px5K1vxnOii4AymAfgfh8r+H4IZseUOG
         BigRXrNTVdQ4zMAN459yV67trXrLT8jFmhL8k86Avz9hFP8kqrsSKHW/oJbu15D0uItr
         TxfwaNWtpn1L90VjVDF9EQq3tLDdI1VnWpFDoXsYTqleuUXovS0M888+7PyRWrOeYPF4
         D8fA==
X-Gm-Message-State: APjAAAWo5NJxpMAzp0Q7N6aGZ2OSaJWgWv4ElOEEB8wsORpJoA+Clvq2
        47EYwdQZFauf7F0rYUSYWZH5zsY9M0s=
X-Google-Smtp-Source: APXvYqyni9ljZ79O+ImIrmsRbkQ/J9QPQyQ/QWtlM7WhEv5bvMtxpf3Xp0Bzi7HXmbmHaoeqrD88CQ==
X-Received: by 2002:a2e:9212:: with SMTP id k18mr19691141ljg.15.1560943511968;
        Wed, 19 Jun 2019 04:25:11 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u13sm2635066lfc.5.2019.06.19.04.25.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 04:25:11 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/2] mesh: Changed --index option to --io
Date:   Wed, 19 Jun 2019 13:25:03 +0200
Message-Id: <20190619112503.3398-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619112503.3398-1-michal.lowas-rzechonek@silvair.com>
References: <20190619112503.3398-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows specifying io type and options when invoking the daemon.

By default, meshd runs with MESH_IO_TYPE_GENERIC and tries to attach to
the first available HCI interface.
---
 mesh/main.c | 73 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 262e3da48..233d95f30 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -38,7 +38,7 @@
 #include "mesh/mesh-io.h"
 
 static const struct option main_options[] = {
-	{ "index",	required_argument,	NULL, 'i' },
+	{ "io",		required_argument,	NULL, 'i' },
 	{ "config",	optional_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
@@ -49,16 +49,22 @@ static const struct option main_options[] = {
 
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
+	       "\t--io=<io>         Use specified io\n"
 	       "\t--config          Configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
 	       "\t--dbus-debug      Enable D-Bus debugging\n"
 	       "\t--help            Show %s information\n", __func__);
+	fprintf(stderr,
+	       "io:\n"
+	       "\tgeneric[:<index>]\n"
+	       "\t\tUse generic HCI io on interface hci<index>, or the first\n"
+	       "\t\tavailable\n");
 }
 
 static void do_debug(const char *str, void *user_data)
@@ -107,6 +113,37 @@ static void signal_handler(uint32_t signo, void *user_data)
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
@@ -114,7 +151,8 @@ int main(int argc, char *argv[])
 	bool dbus_debug = false;
 	struct l_dbus *dbus = NULL;
 	const char *config_dir = NULL;
-	int index = MGMT_INDEX_NONE;
+	enum mesh_io_type io_type = MESH_IO_TYPE_NONE;
+	void *io_opts = NULL;
 
 	if (!l_main_init())
 		return -1;
@@ -123,7 +161,6 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
-		const char *str;
 
 		opt = getopt_long(argc, argv, "i:c:ndbh", main_options, NULL);
 		if (opt < 0)
@@ -131,18 +168,11 @@ int main(int argc, char *argv[])
 
 		switch (opt) {
 		case 'i':
-			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
-				str = optarg + 3;
-			else
-				str = optarg;
-			if (!isdigit(*str)) {
-				l_error("Invalid controller index value");
+			if (!parse_io(optarg, &io_type, &io_opts)) {
+				l_error("Invalid io: %s", optarg);
 				status = EXIT_FAILURE;
 				goto done;
 			}
-
-			index = atoi(str);
-
 			break;
 		case 'n':
 			detached = false;
@@ -167,8 +197,14 @@ int main(int argc, char *argv[])
 		}
 	}
 
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
@@ -198,6 +234,9 @@ int main(int argc, char *argv[])
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
+	if (io_opts)
+		l_free(io_opts);
+
 	mesh_cleanup();
 	l_dbus_destroy(dbus);
 	l_main_exit();
-- 
2.19.1

