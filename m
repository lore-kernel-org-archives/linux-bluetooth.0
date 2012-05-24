Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1 3/3] device: Ignore DUN if PAN is present
Date: Thu, 24 May 2012 12:00:18 +0200
Message-Id: <1337853618-7261-4-git-send-email-wagi@monom.org>
In-Reply-To: <1337853618-7261-1-git-send-email-wagi@monom.org>
References: <1337853618-7261-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Filtering DUN out at BlueZ level reduces the number of CPU cycles and
memory spend just to figure out that PAN is always preferred over DUN.

Doing this could on a the network manager level (e.g. ConnMan) or
at an intermediate daemon such as dundee which handles AT command
parsing and PPP setup is possible just more expensive.

Thereforem just ignore the DUN completely and do not even announce it.
---
 src/device.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/device.c b/src/device.c
index 2695b16..7bc427b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -63,6 +63,8 @@
 #include "btio.h"
 #include "attrib-server.h"
 #include "attrib/client.h"
+#include "network/common.h"
+#include "serial/common.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
@@ -1521,6 +1523,24 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 
 		sdp_list_free(svcclass, free);
 	}
+
+	if (!main_opts.ignore_dun)
+		return;
+
+	if (g_slist_find_custom(req->profiles_added, NAP_UUID,
+					(GCompareFunc) strcmp) != NULL) {
+		GSList *l;
+
+		l = g_slist_find_custom(req->profiles_added,
+							DUN_GW_UUID,
+							(GCompareFunc) strcmp);
+		if (l != NULL) {
+			DBG("Skipping DUN entry because PAN was found.");
+			g_free(l->data);
+			req->profiles_added = g_slist_remove_link(
+							req->profiles_added, l);
+		}
+	}
 }
 
 static void store_profiles(struct btd_device *device)
-- 
1.7.10.130.g36e6c

