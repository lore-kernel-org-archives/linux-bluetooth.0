Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 22:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF32B64F2D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351211AbhCBWf0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbhCBAlI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 19:41:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856EC061756
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Mar 2021 16:40:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s16so10978023plr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 16:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaWQ9ofDP5pUPPuiyfJHoupQKH7hrKU1Fz/HCg3Dn8M=;
        b=Q3+zPq+P+ToAILo0WMvsQs7AjNtPfHAzLS/kqKlGiHK240YRNo5UDNnSLHK8vhYAqZ
         Aay6390sivV/0bopsh9exMsUw6ev89y2YoW8W/KumnPS/PJGx/1W2vhTouCZNd9epWs+
         n5mEpSzPYgy73uB/Lhzc6eEELtyLAtenURNPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaWQ9ofDP5pUPPuiyfJHoupQKH7hrKU1Fz/HCg3Dn8M=;
        b=o4IJ2H1kXZPLe5NJp4F2nBntr1stFOnNrQOX/fgR8sHm3Fyh5OlZ5LcD02dljuzcak
         Cjc4YEsHmd1lCJN2fSjlhSOKDLULhgex2kl0fe6ICZ4XlSNeHOe8mXObNhy5DGV4W+97
         rf+2nwt9RjYkhUIIupeEAN31NStjS3Efg5GihpvQY2zWlY/AUzbeeJiy9P2O/YpP84NQ
         4ef3er9JKQBTIbkYsXQGGB13rnFkbE5DJEGijlqmb648HcOeZM+uqGF93I2bgpr4F57/
         f4rfIQ3kdTpQrCUdFfnp3ehmOzKwXncxMuqICK5owHvvaUEySv64eReFn/dlLv228Qax
         +Vvg==
X-Gm-Message-State: AOAM5318cPrU9UB6e0D8BziZlT7xeEaRcxJmsGP7xiuvx9ne2GbZd+lK
        +Z7e0X6Lh7OmauQSAX/NB92ruffKWVlqPQ==
X-Google-Smtp-Source: ABdhPJwmkh2LfAaTpb1HYT/nbMVd1OOuoY/3etz1vdDfXIhMeSvlQPrNmn4KFXcPyuhgk/09pYqkjw==
X-Received: by 2002:a17:90a:e97:: with SMTP id 23mr1546274pjx.136.1614645627547;
        Mon, 01 Mar 2021 16:40:27 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:6d7e:f36e:c2fc:82cb])
        by smtp.gmail.com with ESMTPSA id m4sm17119286pgu.4.2021.03.01.16.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 16:40:26 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Subject: [PATCH BlueZ v4] monitor: Add option to set fallback width
Date:   Mon,  1 Mar 2021 16:40:19 -0800
Message-Id: <20210302004019.7150-1-sonnysasaka@chromium.org>
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
 monitor/display.c | 8 +++++++-
 monitor/display.h | 1 +
 monitor/main.c    | 8 +++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/monitor/display.c b/monitor/display.c
index b11b71d5d..4e5693b04 100644
--- a/monitor/display.c
+++ b/monitor/display.c
@@ -28,6 +28,7 @@
 #include "display.h"
 
 static pid_t pager_pid = 0;
+int default_pager_num_columns = FALLBACK_TERMINAL_WIDTH;
 
 bool use_color(void)
 {
@@ -39,6 +40,11 @@ bool use_color(void)
 	return cached_use_color;
 }
 
+void set_default_pager_num_columns(int num_columns)
+{
+	default_pager_num_columns = num_columns;
+}
+
 int num_columns(void)
 {
 	static int cached_num_columns = -1;
@@ -48,7 +54,7 @@ int num_columns(void)
 
 		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
 								ws.ws_col == 0)
-			cached_num_columns = FALLBACK_TERMINAL_WIDTH;
+			cached_num_columns = default_pager_num_columns;
 		else
 			cached_num_columns = ws.ws_col;
 	}
diff --git a/monitor/display.h b/monitor/display.h
index f3a614b81..cba39ec7f 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -73,6 +73,7 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
 	return mask;
 }
 
+void set_default_pager_num_columns(int num_columns);
 int num_columns(void);
 
 void open_pager(void);
diff --git a/monitor/main.c b/monitor/main.c
index 0f5eb4a3b..969c88103 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -30,6 +30,7 @@
 #include "analyze.h"
 #include "ellisys.h"
 #include "control.h"
+#include "display.h"
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -67,6 +68,7 @@ static void usage(void)
 		"\t                       Read data from RTT\n"
 		"\t-R  --rtt [<address>],[<area>],[<name>]\n"
 		"\t                       RTT control block parameters\n"
+		"\t-C, --columns [width]  Output width if not a terminal\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -90,6 +92,7 @@ static const struct option main_options[] = {
 	{ "no-pager",  no_argument,       NULL, 'P' },
 	{ "jlink",     required_argument, NULL, 'J' },
 	{ "rtt",       required_argument, NULL, 'R' },
+	{ "columns",   required_argument, NULL, 'C' },
 	{ "todo",      no_argument,       NULL, '#' },
 	{ "version",   no_argument,       NULL, 'v' },
 	{ "help",      no_argument,       NULL, 'h' },
@@ -121,7 +124,7 @@ int main(int argc, char *argv[])
 		struct sockaddr_un addr;
 
 		opt = getopt_long(argc, argv,
-					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:vh",
+					"r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:vh",
 					main_options, NULL);
 		if (opt < 0)
 			break;
@@ -205,6 +208,9 @@ int main(int argc, char *argv[])
 		case 'R':
 			rtt = optarg;
 			break;
+		case 'C':
+			set_default_pager_num_columns(atoi(optarg));
+			break;
 		case '#':
 			packet_todo();
 			lmp_todo();
-- 
2.29.2

