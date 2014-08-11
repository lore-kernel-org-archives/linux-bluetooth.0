Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 08/10] proximity: Fix use after free
Date: Mon, 11 Aug 2014 10:50:43 +0300
Message-Id: <1407743445-1329-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First remove object from the list and then remove it.
---
 profiles/proximity/monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index f2e0739..b05cdd7 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -606,13 +606,13 @@ static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 
+	monitors = g_slist_remove(monitors, monitor);
+
 	btd_device_unref(monitor->device);
 	g_free(monitor->linklosslevel);
 	g_free(monitor->immediatelevel);
 	g_free(monitor->signallevel);
 	g_free(monitor);
-
-	monitors = g_slist_remove(monitors, monitor);
 }
 
 static struct monitor *register_monitor(struct btd_device *device)
-- 
1.9.1

