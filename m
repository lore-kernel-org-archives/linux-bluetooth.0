Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AEFC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB46264E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhBWTEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:19070 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhBWTEn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:43 -0500
IronPort-SDR: B9FKbQOTczVCKoixq4vDOVPLZFLmgbOhD7DybFB9CJuEYkioS0PdmNB9N+0SiM43UjRKJ/5Iuv
 /crARGvQ7Gyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246336033"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246336033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:59 -0800
IronPort-SDR: 3blEaChH31oq3jHSBsbCwOFfN2bA7DZEl9V+TAwsXDIwj2Q2MEJ4d9RAoi3Hm6ga+/5z2Pfg/H
 M6yZQYzlYofQ==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831128"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:59 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 6/6] tools: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:52 -0800
Message-Id: <20210223190252.483784-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btsnoop.c      | 3 +--
 tools/create-image.c | 3 +--
 tools/hcidump.c      | 2 +-
 tools/rctest.c       | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 41baf6e3d..738027dfc 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -57,8 +57,7 @@ static int create_btsnoop(const char *path)
 	ssize_t written;
 	int fd;
 
-	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
-				S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
 	if (fd < 0) {
 		perror("failed to output file");
 		return -1;
diff --git a/tools/create-image.c b/tools/create-image.c
index 3f2cf03d8..aba940da7 100644
--- a/tools/create-image.c
+++ b/tools/create-image.c
@@ -53,8 +53,7 @@
 
 static unsigned int ino_cnt = 721;
 
-#define REG_EXE	S_IFREG | \
-		S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH
+#define REG_EXE	S_IFREG | 0555
 
 static const struct {
 	const char *source;
diff --git a/tools/hcidump.c b/tools/hcidump.c
index 2b08056ea..011864bc0 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -434,7 +434,7 @@ static int open_file(char *file, int mode, unsigned long flags)
 	else
 		open_flags = O_RDONLY;
 
-	fd = open(file, open_flags, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	fd = open(file, open_flags, 0644);
 	if (fd < 0) {
 		perror("Can't open dump file");
 		exit(1);
diff --git a/tools/rctest.c b/tools/rctest.c
index 494359a88..7d688691c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -631,8 +631,7 @@ static void automated_send_recv()
 			do_listen(recv_mode);
 		}
 
-		save_fd = open(savefile, O_CREAT | O_WRONLY,
-						S_IRUSR | S_IWUSR);
+		save_fd = open(savefile, O_CREAT | O_WRONLY, 0600);
 		if (save_fd < 0)
 			syslog(LOG_ERR, "Failed to open file to save data");
 
-- 
2.25.4

