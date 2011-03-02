Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Fix interactive gatttool crash when destination is not set
Date: Wed,  2 Mar 2011 15:07:01 -0300
Message-Id: <1299089221-6559-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 52edeac..a171833 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -698,7 +698,9 @@ int interactive(gchar *dst, int psm)
 
 	opt_sec_level = strdup("low");
 
-	opt_dst = strdup(dst);
+	if (dst)
+		opt_dst = strdup(dst);
+
 	opt_psm = psm;
 
 	prompt = g_string_new(NULL);
-- 
1.7.1

