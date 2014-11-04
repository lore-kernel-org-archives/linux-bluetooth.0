Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] android/client: Add new API argument for create_bond()
Date: Tue,  4 Nov 2014 14:24:48 +0200
Message-Id: <1415103890-24375-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

New Android API has new argument transport.
---
 android/client/if-bt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 2d7ac79..a25d7bc 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -19,6 +19,7 @@
 
 #include "if-main.h"
 #include "terminal.h"
+#include "../hal-msg.h"
 #include "../hal-utils.h"
 
 const bt_interface_t *if_bluetooth;
@@ -609,11 +610,23 @@ static void cancel_discovery_p(int argc, const char **argv)
 static void create_bond_p(int argc, const char **argv)
 {
 	bt_bdaddr_t addr;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	int transport;
+#endif
 
 	RETURN_IF_NULL(if_bluetooth);
 	VERIFY_ADDR_ARG(2, &addr);
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	if (argc < 3)
+		transport = BT_TRANSPORT_UNKNOWN;
+	else
+		transport = atoi(argv[3]);
+
+	EXEC(if_bluetooth->create_bond, &addr, transport);
+#else
 	EXEC(if_bluetooth->create_bond, &addr);
+#endif
 }
 
 /* Just addres to complete, use complete_addr_c */
-- 
1.9.1

