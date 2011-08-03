Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/7] Write Link Loss alert if the service is enabled
Date: Wed,  3 Aug 2011 15:41:43 -0300
Message-Id: <1312396907-14524-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verifies if the Link Loss service is enabled before writting the Link
Loss Alert Level in the Proximity Reporter.
---
 proximity/monitor.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index ba1982e..1bba4cd 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -159,7 +159,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	struct monitor *monitor = user_data;
 
 	monitor->attrib = g_attrib_ref(attrib);
-	write_alert_level(monitor);
+
+	if (monitor->enabled.linkloss)
+		write_alert_level(monitor);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.6

