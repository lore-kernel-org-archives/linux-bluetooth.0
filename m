Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] core: Make exit sequence consistent with init
Date: Thu, 15 Nov 2012 16:05:22 +0200
Message-Id: <1352988325-10782-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
References: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

manager_cleanup should be called after plugin_cleanup on exit as
manager_init is called before plugin_init on the init sequence.
---
 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 9ea12df..414849a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -545,12 +545,12 @@ int main(int argc, char *argv[])
 
 	g_source_remove(signal);
 
+	plugin_cleanup();
+
 	manager_cleanup("/");
 
 	rfkill_exit();
 
-	plugin_cleanup();
-
 	stop_sdp_server();
 
 	g_main_loop_unref(event_loop);
-- 
1.7.11.7

