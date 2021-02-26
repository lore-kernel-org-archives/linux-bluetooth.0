Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3911C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5119D64F2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 18:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZSMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 13:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBZSMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 13:12:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD5C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 10:12:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t5so7057738pjd.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWTLFQr2VCDAa4yM8hMvlta9+OacvlzJyLs7EnjdZCg=;
        b=V61IxsDjfcHotzxC/kZWcAbvxa/ez4L0HlOuOfupftvubHox9jPqSDKDaPeGtiWfZH
         x7zCRA2UKLeDinNTLsZ0tc84CLAPZvjgxK2+QZZQRqdG+OKmzcDVQdw8QnzPQNbNnG04
         fHV4d3fjr+rPZ3dhziZ9vAJuIyR9Mpxz1OaLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWTLFQr2VCDAa4yM8hMvlta9+OacvlzJyLs7EnjdZCg=;
        b=ayhNLTSRD6PPXvZwecEK+5BijI8OEMx7yEE/CoH/9JCZWMgSMcDlbWB1jHtaRI8p3X
         GwIoWE7xu0uYi9hPls1B1DjL2braPohDcxe9fQpVCEVi+17GB9szkBY8hdpbFmLClEmI
         l80lRAQ7hB7/VN1HuH98rBUBkZ42X5j0RB7c5OoEIRAhtoS65ZpvbfnRyzbKXGIdbc8q
         Cpgx1Gl09+XR2Caux1iI107qDeaI+mgnL3Iaz9+XrOW7IyGGqAoJYWQ4nzvYqFyMZW5G
         dfgHLm7OTyd6gaz9O+EuN94NnANFsUS8DeMlQXAcZPSd9Ak+VkLTzaCKND6S8qd3Hv2G
         YH/g==
X-Gm-Message-State: AOAM533M3dTNPpJai94IGOX/h9xkZg0Y3ekwSuGsQbEA8NfcmgP277Fy
        SF71DT5tBIlbgxCmiVSQ11Y39h9Xpe7YQw==
X-Google-Smtp-Source: ABdhPJwMoZCecQtF7TLhb8Cn3+56iDn9oKbU2FBCaA+XmeJ8vySvnJgozJCXofH78dnxSyXBQwb62Q==
X-Received: by 2002:a17:90b:438a:: with SMTP id in10mr1519646pjb.165.1614363127256;
        Fri, 26 Feb 2021 10:12:07 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:c167:1036:bbd0:fa6e])
        by smtp.gmail.com with ESMTPSA id e1sm9487494pjm.12.2021.02.26.10.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2021 10:12:06 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ] monitor: Add option to set fallback width
Date:   Fri, 26 Feb 2021 10:11:58 -0800
Message-Id: <20210226181158.6538-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sometimes we want to be able to pipe the output of btmon to a
non-terminal device. The current fallback width is usually not long
enough so this patch adds an option to specify the column width. This is
especially needed for text logs from bluetoothd.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>

---
 monitor/control.c |  4 ++--
 monitor/control.h |  2 +-
 monitor/display.c |  8 ++++++--
 monitor/display.h |  2 +-
 monitor/main.c    | 10 ++++++++--
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index d1ba97d37..00001bf1e 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1474,7 +1474,7 @@ bool control_writer(const char *path)
 	return !!btsnoop_file;
 }
 
-void control_reader(const char *path, bool pager)
+void control_reader(const char *path, bool pager, int column)
 {
 	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
 	uint16_t pktlen;
@@ -1500,7 +1500,7 @@ void control_reader(const char *path, bool pager)
 	}
 
 	if (pager)
-		open_pager();
+		open_pager(column);
 
 	switch (format) {
 	case BTSNOOP_FORMAT_HCI:
diff --git a/monitor/control.h b/monitor/control.h
index 29616c4f1..ad16358b1 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -12,7 +12,7 @@
 #include <stdint.h>
 
 bool control_writer(const char *path);
-void control_reader(const char *path, bool pager);
+void control_reader(const char *path, bool pager, int column);
 void control_server(const char *path);
 int control_tty(const char *path, unsigned int speed);
 int control_rtt(char *jlink, char *rtt);
diff --git a/monitor/display.c b/monitor/display.c
index b11b71d5d..598db8080 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -28,6 +28,7 @@
 #include "display.h"
 
 static pid_t pager_pid = 0;
+static int output_width = 0;
 
 bool use_color(void)
 {
@@ -48,7 +49,8 @@ int num_columns(void)
 
 		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
 								ws.ws_col == 0)
-			cached_num_columns = FALLBACK_TERMINAL_WIDTH;
+			cached_num_columns = output_width > 0 ?
+				output_width : FALLBACK_TERMINAL_WIDTH;
 		else
 			cached_num_columns = ws.ws_col;
 	}
@@ -81,12 +83,14 @@ static void wait_for_terminate(pid_t pid)
 	}
 }
 
-void open_pager(void)
+void open_pager(int column)
 {
 	const char *pager;
 	pid_t parent_pid;
 	int fd[2];
 
+	output_width = column;
+
 	if (pager_pid > 0)
 		return;
 
diff --git a/monitor/display.h b/monitor/display.h
index f3a614b81..70734d590 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -75,5 +75,5 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
 
 int num_columns(void);
 
-void open_pager(void);
+void open_pager(int column);
 void close_pager(void);
diff --git a/monitor/main.c b/monitor/main.c
index 0f5eb4a3b..5996eed40 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -67,6 +67,7 @@ static void usage(void)
 		"\t                       Read data from RTT\n"
 		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
 		"\t                       RTT control block parameters\n"
+		"\t-c, --column [width]   Output width if not a terminal\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -90,6 +91,7 @@ static const struct option main_options[] = {
 	{ "no-pager",  no_argument,       NULL, 'P' },
 	{ "jlink",     required_argument, NULL, 'J' },
 	{ "rtt",       required_argument, NULL, 'R' },
+	{ "column",    required_argument, NULL, 'c' },
 	{ "todo",      no_argument,       NULL, '#' },
 	{ "version",   no_argument,       NULL, 'v' },
 	{ "help",      no_argument,       NULL, 'h' },
@@ -110,6 +112,7 @@ int main(int argc, char *argv[])
 	const char *str;
 	char *jlink = NULL;
 	char *rtt = NULL;
+	int column = 0;
 	int exit_status;
 
 	mainloop_init();
@@ -121,7 +124,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:vh",
+					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:vhc:",
 					main_options, NULL);
 		if (opt < 0)
 			break;
@@ -205,6 +208,9 @@ int main(int argc, char *argv[])
 		case 'R':
 			rtt = optarg;
 			break;
+		case 'c':
+			column = atoi(optarg);
+			break;
 		case '#':
 			packet_todo();
 			lmp_todo();
@@ -245,7 +251,7 @@ int main(int argc, char *argv[])
 		if (ellisys_server)
 			ellisys_enable(ellisys_server, ellisys_port);
 
-		control_reader(reader_path, use_pager);
+		control_reader(reader_path, use_pager, column);
 		return EXIT_SUCCESS;
 	}
 
-- 
2.29.2

