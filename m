Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 2/2] android/client: Change adapter to bluetooth
Date: Tue, 5 Nov 2013 10:56:22 +0100
Message-ID: <1383645382-3372-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383645382-3372-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383645382-3372-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes all places where adapter should be changed to
bluetooth.
---
 android/client/haltest.c |    6 +++---
 android/client/if-main.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index bbe8693..f511025 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -141,9 +141,9 @@ static void help_p(int argc, const char **argv)
 
 		terminal_print("\nTo get help on methods for each interface type:\n");
 		terminal_print("\n\thelp <inerface>\n");
-		terminal_print("\nBasic scenario:\n\tadapter init\n");
-		terminal_print("\tadapter enable\n\tadapter start_discovery\n");
-		terminal_print("\tadapter get_profile_interface handsfree\n");
+		terminal_print("\nBasic scenario:\n\tbluetooth init\n");
+		terminal_print("\tbluetooth enable\n\tbluetooth start_discovery\n");
+		terminal_print("\tbluetooth get_profile_interface handsfree\n");
 		terminal_print("\thandsfree init\n\n");
 		return;
 	}
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 0c59054..f638b91 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -61,7 +61,7 @@ extern const btgatt_client_interface_t *if_gatt_client;
 
 /*
  * Structure defines top level interfaces that can be used in test tool
- * this will contain values as: adapter, av, gatt, sock, pan...
+ * this will contain values as: bluetooth, av, gatt, socket, pan...
  */
 struct interface {
 	const char *name; /* interface name */
-- 
1.7.9.5

