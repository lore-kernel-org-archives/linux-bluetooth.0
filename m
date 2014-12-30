Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] tools/bluemoon: Remove dead code
Date: Tue, 30 Dec 2014 11:57:48 +0530
Message-id: <1419920868-4637-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

return statement never get executed after goto.
---
 tools/bluemoon.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 1fd516a..663d1f9 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -776,7 +776,6 @@ static void analyze_firmware(const char *path)
 	if (len != st.st_size) {
 		fprintf(stderr, "Failed to read complete firmware file\n");
 		goto done;
-		return;
 	}
 
 	if ((size_t) len < sizeof(*css)) {
-- 
1.7.9.5

