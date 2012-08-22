Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 8/8] scan: Avoid discover if scan handle is known
Date: Wed, 22 Aug 2012 16:45:23 -0300
Message-Id: <1345664723-30814-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch avoids the characteristic discovery for Scan Interval Window
if the attribute value handle was discovered on a previous interaction.
---
 profiles/scanparam/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index f292eb1..788f183 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -206,11 +206,16 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	struct scan *scan = user_data;
 	bt_uuid_t iwin_uuid, refresh_uuid;
 
+	scan->attrib = g_attrib_ref(attrib);
+
+	if (scan->iwhandle) {
+		write_scan_params(scan->attrib, scan->iwhandle);
+		return;
+	}
+
 	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
 	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
 
-	scan->attrib = g_attrib_ref(attrib);
-
 	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
 					&iwin_uuid, iwin_discovered_cb, scan);
 
-- 
1.7.12

