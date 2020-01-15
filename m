Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43136C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11515207E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lOUQcJQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAOItD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:49:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52807 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOItD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 03:49:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so16907829wmc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gQAZen/G0w51BxpOZfJMOciCUwLwrE/yRPpBDPUvwA=;
        b=lOUQcJQesJueBrLEqI3YNWVYRw+SR0i12yepRBvhJqbjiU4+6SSc1CaMXz9Ie/xfQW
         RdLXdnQQtnadP0eINyCmDGBrnQ5OYrbrzyPybSpymCLn4oGhl002NtBqexVHOp+v0T3w
         03DixPAvkMKI2OzVpBfnnmDWIQZx4Yu8/JsfRlFS8DcHj/MwWxje4K3aOVJOn5xdo27w
         557uLwDeBxA9IeinLJQgYxjugRi9tyPSVmqen/I35U2A6sRuj3tFQABnHKz+fjjaWhR/
         xTVSqMBiA0C/DTp98KJvfWXzlq0ePszKyC61CexJbi4CIDWUQ5KuAjCF5ZeKcRZPSvb8
         721Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gQAZen/G0w51BxpOZfJMOciCUwLwrE/yRPpBDPUvwA=;
        b=Www8fR8FZ9TVUbLTWHJdMjHdp6HYPgiLaCwiQZSkKw88WkR3jxC1nrOrvC9hfpadeu
         5dTDP9mHZ9dt3aFKdQ/5D2ZpOD8NO5MnU/8s3r7P1h3rUlQIhpQfktS+6iX00dfc2TTd
         iKJBxTOjrw/xJ7ke8flxdEGpmia5Jd2MiFJUv47SH45Mvd1Mq74dTJD/MnzVh4ZovxHC
         T7RIyRJj8ovtdwJ5JSqFf53eG0aHEkworvOJt9NbB4maxaoB7vlPq+IO0l4Cu/oirs/S
         9Gs3HOtiOhZ3I43IxhTbA8NZ3KM+Irye5axPV4/r7teBmEREyi7vFRwxGd/KMmcgv+6i
         1ElQ==
X-Gm-Message-State: APjAAAUXvrbYrEXKMxacSEYtDyW4Sdy3dlYXwwbMva3Fp3Ms0yP1Z+cr
        I53L91NG8e2rcSxFqzd3YOcOKxdqgaA=
X-Google-Smtp-Source: APXvYqwBI4WoSxVmAU+YZNFuG4cO4avEoneZbTD+U166IE+59lFNNYEM125BWeiRk3+HKqCZvmJdig==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr31993544wml.3.1579078140144;
        Wed, 15 Jan 2020 00:49:00 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x14sm21845467wmj.42.2020.01.15.00.48.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:48:59 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] mesh: Rename --index to --io, support additional io types.
Date:   Wed, 15 Jan 2020 09:48:54 +0100
Message-Id: <20200115084854.21538-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows specifying io type and options when invoking the daemon.

When no "-i" is passed, meshd still runs with MESH_IO_TYPE_GENERIC and
tries to attach to the first available HCI interface.

Options "-i <n>" and "-i hci<n>" are just shortcuts for
"--io=generic:<n>" and "--io=generic:hci<n>", respectively.
---
 mesh/main.c | 93 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 010edcf85..42aa39e4f 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -40,10 +40,11 @@
 
 static const char *config_dir;
 static const char *mesh_conf_fname;
-static int ctlr_index = MGMT_INDEX_NONE;
+static enum mesh_io_type io_type;
+static void *io_opts;
 
 static const struct option main_options[] = {
-	{ "index",	required_argument,	NULL, 'i' },
+	{ "io",		required_argument,	NULL, 'i' },
 	{ "config",	optional_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
@@ -54,16 +55,22 @@ static const struct option main_options[] = {
 
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
+	       "\t--io <io>         Use specified io (default: generic)\n"
 	       "\t--config          Configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
 	       "\t--dbus-debug      Enable D-Bus debugging\n"
 	       "\t--help            Show %s information\n", __func__);
+	fprintf(stderr,
+	       "io:\n"
+	       "\t([hci]<index> | generic[:[hci]<index>])\n"
+	       "\t\tUse generic HCI io on interface hci<index>, or the first\n"
+	       "\t\tavailable one\n");
 }
 
 static void do_debug(const char *str, void *user_data)
@@ -100,8 +107,8 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 		return;
 	}
 
-	if (!mesh_init(config_dir, mesh_conf_fname, MESH_IO_TYPE_GENERIC,
-				&ctlr_index, mesh_ready_callback, dbus)) {
+	if (!mesh_init(config_dir, mesh_conf_fname, io_type, io_opts,
+					mesh_ready_callback, dbus)) {
 		l_error("Failed to initialize mesh");
 		l_main_quit();
 	}
@@ -133,12 +140,45 @@ static void signal_handler(uint32_t signo, void *user_data)
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
 	bool detached = true;
 	bool dbus_debug = false;
 	struct l_dbus *dbus = NULL;
+	char *io = NULL;
+	int hci_index;
 
 	if (!l_main_init())
 		return -1;
@@ -153,7 +193,6 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
-		const char *str;
 
 		opt = getopt_long(argc, argv, "i:c:f:ndbh", main_options, NULL);
 		if (opt < 0)
@@ -161,18 +200,11 @@ int main(int argc, char *argv[])
 
 		switch (opt) {
 		case 'i':
-			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
-				str = optarg + 3;
+			if (sscanf(optarg, "hci%d", &hci_index) == 1 ||
+					sscanf(optarg, "%d", &hci_index) == 1)
+				io = l_strdup_printf("generic:%s", optarg);
 			else
-				str = optarg;
-			if (!isdigit(*str)) {
-				l_error("Invalid controller index value");
-				status = EXIT_FAILURE;
-				goto done;
-			}
-
-			ctlr_index = atoi(str);
-
+				io = l_strdup(optarg);
 			break;
 		case 'n':
 			detached = false;
@@ -200,6 +232,21 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!io)
+		io = l_strdup_printf("generic");
+
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
 
 	if (!detached)
 		umask(0077);
@@ -225,6 +272,12 @@ int main(int argc, char *argv[])
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
2.20.1

