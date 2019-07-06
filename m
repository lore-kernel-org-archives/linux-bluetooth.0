Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086ABC0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD8620838
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 15:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="TPelj5MC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfGFPjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:39:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41588 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFPjV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 11:39:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so8118754lfa.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jul 2019 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cbrCpLDOv7/fTIQ0xWSBoFSjEuZ5i40hU8rufsoqWPs=;
        b=TPelj5MCtrzKckfGUcX07UVKlZfgMonG6VwEVo9iD1Sv3ailCdgngPLzEXo6aQpL/P
         K1DsA+6lASE9KQ+xwuHRABLHsBnUBQfYtGI8aqLie1miCOyMKPJStzEMgWxKELGcJgU6
         eUJRg34Kd95u8DUFzl03j+G7OBPQf+VbLW+mK3XVWR66wjB5SKX0AE4lRjUtc0oMo0Yh
         sy+KFExlCAXrfx3A1TCr/zNWKbutkAzLd8ANJ+PH4iB7+fTHMbwCyemVqCQ4WfprX+bO
         KeJeF9Z5g95yurMqAMAm3V8jUxkwdhxRn8LvDrJi3q4IDfwJ3Sc1PaJGxkbc5PusMgfM
         6W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbrCpLDOv7/fTIQ0xWSBoFSjEuZ5i40hU8rufsoqWPs=;
        b=XDg4GLA1o6sMriFyTXoFtFWsgXmVPfpuuG0mIQ8QY+GIiT1IfeS/aNuy/usX8gI5jw
         hHaKuHl2fSN4XbGgfNuuAiQWWIUenM5LqnZIWwu/ea9HWYETewLUkm9ol4dZx5nJvlJy
         7gNM0KA4RzIYb2ha0Cfm9eoE6vwF08mO6I6mCFuyLbGxq/Pi1noObsCNFUX/YzrvrhhS
         3WDDNG4JfXoo0vyjzHZDfptyU1H6GO0VL/g2bHtIkWgI4xd0SABQBAGXUOK7T2Tl4rZ2
         7Lad3QOornXf/VmCrnIznu4G+9tDP0IDptB3VnJ2oXbzRKC4lgUQ1055F753gsU/8eMN
         +F4Q==
X-Gm-Message-State: APjAAAXV3NbIMrSR8QadD+/74q4FpJPvNbirbtRidIT4SRgjzerJwLKI
        6sqCT/Pz8ttTJzyItBrIg+tModgNB0U=
X-Google-Smtp-Source: APXvYqz+7HPfFNPghpF1bLp3wkMkKQ0bYe4a2iQdAqA2iWp7+/957CDDSfWK22LiXtLdbsYSejDq/A==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr4206934lfm.17.1562427557491;
        Sat, 06 Jul 2019 08:39:17 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id u9sm1910609lfk.64.2019.07.06.08.39.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 08:39:16 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/1] mesh: Added --io option
Date:   Sat,  6 Jul 2019 17:39:04 +0200
Message-Id: <20190706153904.12009-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190706153904.12009-1-michal.lowas-rzechonek@silvair.com>
References: <20190706153904.12009-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/main.c            | 48 +++++++++++++++++++++++++++---------------
 mesh/mesh-io-api.h     |  2 ++
 mesh/mesh-io-generic.c | 30 ++++++++++++++++++++++++++
 mesh/mesh-io.c         |  9 ++++++--
 mesh/mesh-io.h         |  2 +-
 mesh/mesh.c            |  4 ++--
 mesh/mesh.h            |  2 +-
 7 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 262e3da48..7adb0c2d2 100644
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
@@ -114,7 +122,7 @@ int main(int argc, char *argv[])
 	bool dbus_debug = false;
 	struct l_dbus *dbus = NULL;
 	const char *config_dir = NULL;
-	int index = MGMT_INDEX_NONE;
+	char *ioarg = NULL;
 
 	if (!l_main_init())
 		return -1;
@@ -123,7 +131,6 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
-		const char *str;
 
 		opt = getopt_long(argc, argv, "i:c:ndbh", main_options, NULL);
 		if (opt < 0)
@@ -131,18 +138,20 @@ int main(int argc, char *argv[])
 
 		switch (opt) {
 		case 'i':
-			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
-				str = optarg + 3;
-			else
-				str = optarg;
-			if (!isdigit(*str)) {
-				l_error("Invalid controller index value");
-				status = EXIT_FAILURE;
+			if (ioarg) {
+				l_error("Use either --index or --io, not both");
+				status = EXIT_SUCCESS;
 				goto done;
 			}
-
-			index = atoi(str);
-
+			ioarg = l_strdup_printf("generic:%s", optarg);
+			break;
+		case 'I':
+			if (ioarg) {
+				l_error("Use either --index or --io, not both");
+				status = EXIT_SUCCESS;
+				goto done;
+			}
+			ioarg = l_strdup(optarg);
 			break;
 		case 'n':
 			detached = false;
@@ -167,8 +176,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!ioarg)
+		ioarg = l_strdup("generic");
 
-	if (!mesh_init(config_dir, MESH_IO_TYPE_GENERIC, &index)) {
+	if (!mesh_init(config_dir, ioarg)) {
 		l_error("Failed to initialize mesh");
 		status = EXIT_FAILURE;
 		goto done;
@@ -198,6 +209,9 @@ int main(int argc, char *argv[])
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
+	if (ioarg)
+		l_free(ioarg);
+
 	mesh_cleanup();
 	l_dbus_destroy(dbus);
 	l_main_exit();
diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 4cdf1f80a..b7807da53 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -19,6 +19,7 @@
 
 struct mesh_io_private;
 
+typedef void *(*mesh_io_opts_t)(const char *optarg);
 typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
 typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
@@ -35,6 +36,7 @@ typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, const uint8_t *pattern,
 								uint8_t len);
 
 struct mesh_io_api {
+	mesh_io_opts_t		opts;
 	mesh_io_init_t		init;
 	mesh_io_destroy_t	destroy;
 	mesh_io_caps_t		caps;
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 42aaa0947..47d0de247 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -312,6 +312,35 @@ static void read_info(int index, void *user_data)
 	hci_init(io);
 }
 
+static void *dev_opts(const char *optarg)
+{
+	int *index = l_new(int, 1);
+
+	if (strstr(optarg, "generic") != optarg)
+		goto fail;
+
+	optarg += strlen("generic");
+	if (!*optarg) {
+		*index = MGMT_INDEX_NONE;
+		return index;
+	}
+
+	if (*optarg != ':')
+		goto fail;
+
+	optarg++;
+
+	if ((sscanf(optarg, "hci%d", index) != 1) &&
+					(sscanf(optarg, "%d", index) != 1)) {
+		goto fail;
+	}
+
+	return index;
+fail:
+	l_free(index);
+	return NULL;
+}
+
 static bool dev_init(struct mesh_io *io, void *opts)
 {
 	if (!io || io->pvt)
@@ -783,6 +812,7 @@ static bool filter_set(struct mesh_io *io,
 }
 
 const struct mesh_io_api mesh_io_generic = {
+	.opts = dev_opts,
 	.init = dev_init,
 	.destroy = dev_destroy,
 	.caps = dev_caps,
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 62a8c0e2c..32acd9c2c 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -52,15 +52,20 @@ static bool match_by_type(const void *a, const void *b)
 	return io->type == type;
 }
 
-struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts)
+struct mesh_io *mesh_io_new(const char *optarg)
 {
 	const struct mesh_io_api *api = NULL;
+	enum mesh_io_type type = MESH_IO_TYPE_NONE;
 	struct mesh_io *io;
+	void *opts;
 	uint16_t i;
 
 	for (i = 0; i < L_ARRAY_SIZE(table); i++) {
-		if (table[i].type == type) {
+		opts = table[i].api->opts(optarg);
+
+		if (opts) {
 			api = table[i].api;
+			type = table[i].type;
 			break;
 		}
 	}
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 6585205c7..0c367acb7 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -80,7 +80,7 @@ typedef void (*mesh_io_recv_func_t)(void *user_data,
 typedef void (*mesh_io_status_func_t)(void *user_data, int status,
 							uint8_t filter_id);
 
-struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts);
+struct mesh_io *mesh_io_new(const char *optarg);
 void mesh_io_destroy(struct mesh_io *io);
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 26acfd4dc..31295d9c6 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -136,7 +136,7 @@ void mesh_unreg_prov_rx(prov_rx_cb_t cb)
 	mesh_io_deregister_recv_cb(mesh.io, MESH_IO_FILTER_PROV);
 }
 
-bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
+bool mesh_init(const char *config_dir, const char *optarg)
 {
 	struct mesh_io_caps caps;
 
@@ -158,7 +158,7 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 	if (!storage_load_nodes(config_dir))
 		return false;
 
-	mesh.io = mesh_io_new(type, opts);
+	mesh.io = mesh_io_new(optarg);
 	if (!mesh.io)
 		return false;
 
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 14b1fb517..4df0615fc 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -32,7 +32,7 @@ enum mesh_io_type;
 
 typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 								uint16_t len);
-bool mesh_init(const char *in_config_name, enum mesh_io_type type, void *opts);
+bool mesh_init(const char *config_dir, const char *optarg);
 void mesh_cleanup(void);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
-- 
2.22.0

