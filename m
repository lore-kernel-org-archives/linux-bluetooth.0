Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/2] tools: Fix comparison between signed and unsigned integer
Date: Sat, 27 Dec 2014 00:31:23 +0100
Message-Id: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

len is non-negative here, so we can safely cast it to size_t.
---
 tools/bluemoon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index c785472..0f32d63 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -767,7 +767,7 @@ static void analyze_firmware(const char *path)
 	printf("\n");
 
 
-	if (len != le32_to_cpu(css->size) * 4) {
+	if ((size_t) len != le32_to_cpu(css->size) * 4) {
 		fprintf(stderr, "CSS.size does not match file length\n");
 		goto done;
 	}
-- 
1.9.1

