Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 14/14] device: Ignore DUN if PAN is present
Date: Thu, 31 May 2012 15:43:38 +0200
Message-Id: <1338471818-20894-15-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Filtering DUN out at BlueZ level reduces the number of CPU cycles and
memory spend just to figure out that PAN is always preferred over DUN.

Doing this could on a the network manager level (e.g. ConnMan) or
at an intermediate daemon such as dundee which handles AT command
parsing and PPP setup is possible just more expensive.

Therefore, just ignore the DUN completely and do not even announce it.
---
 src/device.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/device.c b/src/device.c
index 39aa0cb..1b2f395 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1529,6 +1529,24 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 
 		sdp_list_free(svcclass, free);
 	}
+
+	if (!main_opts.prefer_pan)
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

