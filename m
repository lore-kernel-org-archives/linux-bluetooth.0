Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/11] android/health: Add setting mcl callbacks for incoming connection
Date: Tue, 24 Jun 2014 15:12:02 +0300
Message-Id: <1403611922-26901-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For incoming connection NULL is passed as argument since application is
not known yet.
---
 android/health.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index df97848..7281dd5 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1020,6 +1020,9 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 
 	DBG("");
 
+	if (!channel)
+		return;
+
 	dev = channel->dev;
 	/* mdl == NULL means, delete all mdls */
 	if (!mdl) {
@@ -1540,12 +1543,30 @@ static const struct ipc_handler cmd_handlers[] = {
 
 static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 {
-	DBG("Not implemented");
+	GError *gerr = NULL;
+	bool ret;
+
+	DBG("");
+
+	ret = set_mcl_cb(mcl, NULL, &gerr);
+	if (!ret) {
+		error("health: error setting mcl callbacks: %s", gerr->message);
+		g_error_free(gerr);
+	}
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	DBG("Not implemented");
+	GError *gerr = NULL;
+	bool ret;
+
+	DBG("");
+
+	ret = set_mcl_cb(mcl, NULL, &gerr);
+	if (!ret) {
+		error("health: error setting mcl callbacks: %s", gerr->message);
+		g_error_free(gerr);
+	}
 }
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
-- 
1.8.3.2

