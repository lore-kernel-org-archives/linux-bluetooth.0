Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mario Lang <mlang@delysid.org>
To: linux-bluetooth@vger.kernel.org
Cc: Mario Lang <mlang@delysid.org>
Subject: [PATCH BlueZ] Use STOPPING=1 when shutting down
Date: Fri,  7 Apr 2017 21:57:02 +0200
Message-Id: <20170407195702.9990-1-mlang@delysid.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Quoting sd_notify(3):

STOPPING=1
    Tells the service manager that the service is beginning its shutdown.
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index bcc1e6f..122b028 100644
--- a/src/main.c
+++ b/src/main.c
@@ -707,7 +707,7 @@ int main(int argc, char *argv[])
 
 	g_main_loop_run(event_loop);
 
-	sd_notify(0, "STATUS=Quitting");
+	sd_notify(0, "STOPPING=1\nSTATUS=Quitting");
 
 	g_source_remove(signal);
 
-- 
2.9.3

