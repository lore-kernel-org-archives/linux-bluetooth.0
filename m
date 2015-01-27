Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 3/3] tools/hciattach_ath3k: Remove dead code warnings
Date: Tue, 27 Jan 2015 14:23:20 +0530
Message-id: <1422348800-5668-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
References: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tools/hciattach_ath3k.c:848:3: warning: Value stored to 'err' is never read
                err = 0;
                ^     ~
tools/hciattach_ath3k.c:852:3: warning: Value stored to 'err' is never read
                err = 0;
                ^     ~
---
 tools/hciattach_ath3k.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 23208c6..d31732e 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -840,17 +840,8 @@ static int ath_ps_download(int fd)
 		goto download_cmplete;
 	}
 
-	/*
-	 * It is not necessary that Patch file be available,
-	 * continue with PS Operations if patch file is not available.
-	 */
-	if (patch_file[0] == '\0')
-		err = 0;
-
 	stream = fopen(patch_file, "r");
-	if (!stream)
-		err = 0;
-	else {
+	if(stream) {
 		patch_count = ps_patch_download(fd, stream);
 		fclose(stream);
 
-- 
1.9.1

