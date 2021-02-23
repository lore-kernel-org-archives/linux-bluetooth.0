Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3535C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B8764E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBWTEW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:19052 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233352AbhBWTEV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:21 -0500
IronPort-SDR: 5dyNPeNeiDh+ny1OOEaogwMh1JsUMsk95ajEr4vNcze94TQBB7wDhdc+F6N7fu1XLqekIacnyc
 3+t2jkYgBBpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246335916"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246335916"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:40 -0800
IronPort-SDR: DuhUuLPg/N8fX5crkXtfXR9VnMQNjuPLLJ72gIKb50Foine9f+XJRcRayh/e4mFwN8Eh3jtRHJ
 MVB3gJAbqIYw==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831041"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:39 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 2/6] obexd: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:48 -0800
Message-Id: <20210223190252.483784-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 obexd/plugins/filesystem.c | 18 +++++++++---------
 obexd/plugins/ftp.c        |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 8e53c181c..09bff8ad0 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -116,15 +116,15 @@ static char *file_stat_line(char *filename, struct stat *fstat,
 
 	snprintf(perm, 50, "user-perm=\"%s%s%s\" group-perm=\"%s%s%s\" "
 			"other-perm=\"%s%s%s\"",
-			(fstat->st_mode & S_IRUSR ? "R" : ""),
-			(fstat->st_mode & S_IWUSR ? "W" : ""),
-			(dstat->st_mode & S_IWUSR ? "D" : ""),
-			(fstat->st_mode & S_IRGRP ? "R" : ""),
-			(fstat->st_mode & S_IWGRP ? "W" : ""),
-			(dstat->st_mode & S_IWGRP ? "D" : ""),
-			(fstat->st_mode & S_IROTH ? "R" : ""),
-			(fstat->st_mode & S_IWOTH ? "W" : ""),
-			(dstat->st_mode & S_IWOTH ? "D" : ""));
+			(fstat->st_mode & 0400 ? "R" : ""),
+			(fstat->st_mode & 0200 ? "W" : ""),
+			(dstat->st_mode & 0200 ? "D" : ""),
+			(fstat->st_mode & 0040 ? "R" : ""),
+			(fstat->st_mode & 0020 ? "W" : ""),
+			(dstat->st_mode & 0020 ? "D" : ""),
+			(fstat->st_mode & 0004 ? "R" : ""),
+			(fstat->st_mode & 0002 ? "W" : ""),
+			(dstat->st_mode & 0002 ? "D" : ""));
 
 	strftime(atime, 17, "%Y%m%dT%H%M%SZ", gmtime(&fstat->st_atime));
 	strftime(ctime, 17, "%Y%m%dT%H%M%SZ", gmtime(&fstat->st_ctime));
diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index f60cf143d..259bfcae2 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -284,8 +284,8 @@ int ftp_setpath(struct obex_session *os, void *user_data)
 		goto done;
 	}
 
-	if (S_ISDIR(dstat.st_mode) && (dstat.st_mode & S_IRUSR) &&
-						(dstat.st_mode & S_IXUSR)) {
+	if (S_ISDIR(dstat.st_mode) && (dstat.st_mode & 0400) &&
+						(dstat.st_mode & 0100)) {
 		set_folder(ftp, fullname);
 		goto done;
 	}
-- 
2.25.4

