Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix crash in get_profile_interface
Date: Thu, 31 Oct 2013 11:56:26 +0100
Message-ID: <1383216986-302-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes crash due to uncheck input from user.
---
 android/client/if-bt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index a3d6286..9e01d65 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -804,11 +804,16 @@ static void get_profile_interface_c(int argc, const char **argv,
 
 static void get_profile_interface_p(int argc, const char **argv)
 {
-	const char *id = argv[2];
+	const char *id;
 	const void **pif = NULL;
 	const void *dummy = NULL;
 
 	RETURN_IF_NULL(if_bluetooth);
+	if (argc <= 2) {
+		haltest_error("No interface specified\n");
+		return;
+	}
+	id = argv[2];
 
 	if (strcmp(BT_PROFILE_HANDSFREE_ID, id) == 0)
 		pif = (const void **) &if_hf;
-- 
1.7.9.5

