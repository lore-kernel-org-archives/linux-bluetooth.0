Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/8] Manage watcher's disconnections from the bus
Date: Thu, 20 Oct 2011 11:46:50 +0200
Message-Id: <1319104011-27747-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1319104011-27747-7-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
 <1319104011-27747-2-git-send-email-sancane@gmail.com>
 <1319104011-27747-3-git-send-email-sancane@gmail.com>
 <1319104011-27747-4-git-send-email-sancane@gmail.com>
 <1319104011-27747-5-git-send-email-sancane@gmail.com>
 <1319104011-27747-6-git-send-email-sancane@gmail.com>
 <1319104011-27747-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 9b14e6f..4a2b9c8 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -560,7 +560,16 @@ static void disable_final_measurement(struct thermometer *t)
 
 static void watcher_exit(DBusConnection *conn, void *user_data)
 {
-	/* TODO: Watcher disconnected */
+	struct watcher *watcher = user_data;
+	struct thermometer *t = watcher->t;
+
+	DBG("Thermometer watcher %s disconnected", watcher->path);
+
+	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
+	watcher->id = 0;
+
+	if (g_slist_length(t->fwatchers) == 0)
+		disable_final_measurement(t);
 }
 
 static struct watcher *find_watcher(struct thermometer *t, const gchar *sender,
-- 
1.7.6.1

