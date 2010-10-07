Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Disable automatic notification/indication for Battery state level
Date: Thu,  7 Oct 2010 10:53:58 -0300
Message-Id: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reports of Battery state attribute in the Attribute sample server is
being disabled while a proper interface between the attribute server
and service implementation is not defined.
---
 TODO             |    7 -------
 attrib/example.c |    2 ++
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index 271fc45..a9f1339 100644
--- a/TODO
+++ b/TODO
@@ -18,13 +18,6 @@ Background
 ATT/GATT
 ========
 
-- Sample server shouldn't send any indications or notifications without
-  the client requesting them
-
-  Priority: Medium
-  Complexity: C2
-  Owner: Claudio Takahasi <claudio.takahasi@openbossa.org>
-
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
diff --git a/attrib/example.c b/attrib/example.c
index c29e1e4..aa249a8 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -70,7 +70,9 @@ static gboolean change_battery_state(gpointer user_data)
 	/* Battery state is being increased every 10 seconds. */
 	atval[0] = state++;
 	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
+#if 0
 	attrib_db_update(0x0110, &uuid, atval, 1);
+#endif
 
 	return TRUE;
 }
-- 
1.7.3.1

