Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 18/47] android/client: Add new API argument for scan()
Date: Tue,  4 Nov 2014 10:18:41 +0200
Message-Id: <1415089150-18798-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

New Android API has new argument transport.
---
 android/client/if-bt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 2d7ac79..306e237 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -609,11 +609,23 @@ static void cancel_discovery_p(int argc, const char **argv)
 static void create_bond_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	int transport;
+#endif
 
 	RETURN_IF_NULL(if_bluetooth);
 	VERIFY_ADDR_ARG(2, &addr);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_bluetooth->create_bond, &addr);
+#else
+	if (argc < 3)
+		transport = 0;
+	else
+		transport = atoi(argv[3]);
+
+	EXEC(if_bluetooth->create_bond, &addr, transport);
+#endif
 }
 
 /* Just addres to complete, use complete_addr_c */
-- 
1.9.1

