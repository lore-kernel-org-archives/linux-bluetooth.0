Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Michael Biebl <mbiebl@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] core: fix unbound watchdog-notify for timeouts <2s
Date: Sat, 13 Sep 2014 15:21:23 +0200
Message-Id: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If the watchdog timeout is below 2s, we end up with a timeout of 0s as
glib event source. This causes unbound watchdog notifications. Avoid this
by never using event-timeouts below 1s.

Reported by Michael Biebl.

---
 src/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index e6bac6e..da0bd12 100644
--- a/src/main.c
+++ b/src/main.c
@@ -596,9 +596,10 @@ int main(int argc, char *argv[])
 
 		seconds = atoi(watchdog_usec) / (1000 * 1000);
 		info("Watchdog timeout is %d seconds", seconds);
+		seconds = (seconds < 4) ? 1 : seconds / 2;
 
 		watchdog = g_timeout_add_seconds_full(G_PRIORITY_HIGH,
-							seconds / 2,
+							seconds,
 							watchdog_callback,
 							NULL, NULL);
 	} else
-- 
2.1.0
