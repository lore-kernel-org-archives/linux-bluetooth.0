Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/client: Fix argument count in create_bond()
Date: Mon, 10 Nov 2014 11:04:48 +0200
Message-Id: <1415610288-2035-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415610288-2035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415610288-2035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 48aff1b..7325242 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -628,7 +628,7 @@ static void create_bond_p(int argc, const char **argv)
 	VERIFY_ADDR_ARG(2, &addr);
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-	if (argc < 3)
+	if (argc < 4)
 		transport = BT_TRANSPORT_UNKNOWN;
 	else
 		transport = atoi(argv[3]);
-- 
1.9.1

