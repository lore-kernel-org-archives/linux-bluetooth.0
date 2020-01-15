Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63913C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9D5207E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 11:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="u71rJnqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgAOLu7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:50:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44322 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgAOLu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 06:50:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so15431813wrm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kAW6CuXLik4Dd8lYpo4G/qEALqscxuKG5AZ67rZeM8=;
        b=u71rJnqkXryBSbATFcdu4mAAAhZvMQI+K4CYbTeeZSnmkBfvLqEyQg+DuvzQNpfaVp
         2SDQNgX/raf7T1WCg9ToUwpvHU55t3kxIrY+OEQdoSF6sVu4RXV9vrzbKR9q/h0KRNcB
         EoJBfj1ZBM+Vihh6FuQYNc6DtSNdGpStii7LN3qDKFIxObusGG964LQxWioRnseKOyt0
         FPME2VuoJbOYbCxiChePap1syFDCyH7RWEUrdxWxAHxFXTy1NITvbdEzrQZ53KufqBHq
         G8+JN29+mVFxvJhHh22q+Q8ReGHQD7gFzJHOoPa2X/rOw47kfZT3JhM7cU6N29oStgUM
         PoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3kAW6CuXLik4Dd8lYpo4G/qEALqscxuKG5AZ67rZeM8=;
        b=IcdgUONoD1vgUacP8SNjWl6FJs57TU+HiICm6Su6G7fZF62rpebNW3JE0sHWhKkpZb
         VF3ahvNttyXWXvPic1ozLZIT1d0NvPqPCTgifEvIh0KKQ7PxcQDqn3EzSeUTSWYXmQ96
         788FChflb9P5XQ4uPTaTR7PUtE23Gue3VEpkmDsLT1IHvhXcuYUpc1pqMnYiifkyKOAf
         t5IrUxFNiMbc22ZxijH2Nl/NUQ1EwdE0wjznN5VQFnUR+d5+CCvliaRCEl6ON+qQH1tn
         CgLU0FtUkNS/GzLTiqL7hHB5JRMeot7fbKkAqckurANBtM3ZfxULps00tUvoDbaQVjdo
         k0iQ==
X-Gm-Message-State: APjAAAX5qDUPxjQEoV32WKXxGyYYQGiifPkMt/khMVaMbwp5cwc6dN5e
        628a35rBM83F+ELxQcg14dHgMRGw4Cw=
X-Google-Smtp-Source: APXvYqx07cGUD+xLM1L+cIVy/y+1Zg7Gpb2ZTv3dwzJzTph6ouyTvExaTJbdueEoouKoPOhdm2PgFg==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr31606022wrs.213.1579089054519;
        Wed, 15 Jan 2020 03:50:54 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z123sm24405987wme.18.2020.01.15.03.50.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 03:50:53 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] mesh: Rename --index to --io, allow additional io types types.
Date:   Wed, 15 Jan 2020 12:50:49 +0100
Message-Id: <20200115115049.27504-1-michal.lowas-rzechonek@silvair.com>
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
v3: Remove superfluous default configuration from main()

 mesh/main.c | 86 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 010edcf85..598398e9a 100644
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
@@ -200,6 +232,14 @@ int main(int argc, char *argv[])
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
 
 	if (!detached)
 		umask(0077);
@@ -225,6 +265,12 @@ int main(int argc, char *argv[])
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

