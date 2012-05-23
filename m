Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC] device: Ignore DUN if PAN is present
Date: Wed, 23 May 2012 14:51:25 +0200
Message-Id: <1337777485-23498-1-git-send-email-wagi@monom.org>
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
 serial/common.h |   24 ++++++++++++++++++++++++
 src/device.c    |   17 +++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 serial/common.h

diff --git a/serial/common.h b/serial/common.h
new file mode 100644
index 0000000..429bf65
--- /dev/null
+++ b/serial/common.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
diff --git a/src/device.c b/src/device.c
index 2695b16..7b7f9e2 100644
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
@@ -1521,6 +1523,21 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 
 		sdp_list_free(svcclass, free);
 	}
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

