Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] gatttool: Fix handle parsing in cmd_char_write()
Date: Wed, 25 Apr 2012 17:25:19 +0200
Message-ID: <1335367519-16361-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

errno is not set to 0 before call to strtoll() so cmd_char_write() can fail
even with proper data. Use strtohandle() helper function instead.
---
 attrib/interactive.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 0064ba2..073e3f7 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -601,8 +601,8 @@ static void cmd_char_write(int argcp, char **argvp)
 		return;
 	}
 
-	handle = strtoll(argvp[1], NULL, 16);
-	if (errno != 0 || handle <= 0) {
+	handle = strtohandle(argvp[1]);
+	if (handle <= 0) {
 		printf("A valid handle is required\n");
 		return;
 	}
-- 
1.7.9.5

