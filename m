Return-Path: <SRS0=UJar=3C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E97C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63532084D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="vf30F3jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgAMM1i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:27:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35940 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgAMM1i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jan 2020 07:27:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so6715714lfe.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2020 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QvN5JmzmAn+sWS392TnYXp0i/9dMEJWaZaNmD4tvczg=;
        b=vf30F3jRzPBhoFO4npNv4n9bJ9UlZZl23kZRIkRQ1z+Y4PvKgbrNXEYNwwidwugu1K
         lE5KxALiaxWTiQEMu1psqrjoQT7n9YTjXG/euERIcosywu0aFxUDHlQvVG/epaeflvLK
         Yj9YQuPDPcExVGoTAXGa+4M1wU582EywrE4oGx11MQi+dRC9beHxskyrlDj2EG6bXR50
         LQ9QQ199jbk0t9P38qX1ixn2Rl9Y12Wi+Pplpf4XoWLi4HejSlA62nciZbs91u9t3J6m
         qEe7jstz3V2lBn1atIE5wUZZ1dmtmTTBO/uOFVyMU8o2wLLa9Ct13g62Zdevb05ZcemF
         aWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvN5JmzmAn+sWS392TnYXp0i/9dMEJWaZaNmD4tvczg=;
        b=C0z0sT7JgP/p8+7C3riw+xzeFNE5xxr+SsLtK6MkQT4bjPseNHBmx9yllOTiXCotGD
         m+tLUC8IPfB19thWIR6X5ZWZs4KsEKMTxGwckR2nZzKo9boqmey2tpP2iWE4qPZaciNz
         wh+sCQR+ik/KB/gKux2LKtOaxk50vMuiaIU5N66/4O4Kb4du2YV2m6Nm6t62ZP+47UNy
         tt92czheKC1WGLuj+JDishudHoTl5A1a0Sq1YHqlYfS/NP25PaG/RYy0WHmndK3wcQDU
         YRJzowKGGIABn2oqfdfOsum2R2xUrzMJ8fOLJI/aSH4S8A+3Ho+B5GbIQqlk19dynsvx
         ifOw==
X-Gm-Message-State: APjAAAUpnBl2r1w1Kf+gGObloURrD9ikZX2oolLbQW58xdY26bjPsxLu
        v6+SCkoPLUclRvthW8mJUIzwnjl1H6Q=
X-Google-Smtp-Source: APXvYqxPvBry3LMIrnYMptYry1MRSuwz3ItscbtyYJYU1sQrEv68bsTuYctH02cHb38AyzXe9lXX5g==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr9298192lfa.63.1578918455862;
        Mon, 13 Jan 2020 04:27:35 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l7sm5571758lfc.80.2020.01.13.04.27.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:27:35 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH RESEND BlueZ 1/1] mesh: Add --io option
Date:   Mon, 13 Jan 2020 13:27:25 +0100
Message-Id: <20200113122726.768-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
References: <20200113122726.768-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/main.c | 99 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 18 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 010edcf85..243e756f9 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -40,10 +40,12 @@
 
 static const char *config_dir;
 static const char *mesh_conf_fname;
-static int ctlr_index = MGMT_INDEX_NONE;
+static enum mesh_io_type io_type;
+static void *io_opts;
 
 static const struct option main_options[] = {
 	{ "index",	required_argument,	NULL, 'i' },
+	{ "io",		required_argument,	NULL, 'I' },
 	{ "config",	optional_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
@@ -54,16 +56,23 @@ static const struct option main_options[] = {
 
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
@@ -100,8 +109,8 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 		return;
 	}
 
-	if (!mesh_init(config_dir, mesh_conf_fname, MESH_IO_TYPE_GENERIC,
-				&ctlr_index, mesh_ready_callback, dbus)) {
+	if (!mesh_init(config_dir, mesh_conf_fname, io_type, io_opts,
+					mesh_ready_callback, dbus)) {
 		l_error("Failed to initialize mesh");
 		l_main_quit();
 	}
@@ -133,12 +142,44 @@ static void signal_handler(uint32_t signo, void *user_data)
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
 
 	if (!l_main_init())
 		return -1;
@@ -153,7 +194,6 @@ int main(int argc, char *argv[])
 
 	for (;;) {
 		int opt;
-		const char *str;
 
 		opt = getopt_long(argc, argv, "i:c:f:ndbh", main_options, NULL);
 		if (opt < 0)
@@ -161,18 +201,20 @@ int main(int argc, char *argv[])
 
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
-			ctlr_index = atoi(str);
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
@@ -200,6 +242,21 @@ int main(int argc, char *argv[])
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
@@ -225,6 +282,12 @@ int main(int argc, char *argv[])
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

