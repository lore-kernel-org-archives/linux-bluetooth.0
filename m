Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] serial: fix DBus message reply
Date: Tue, 13 Sep 2011 15:16:04 -0300
Message-Id: <1315937765-32168-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

If reply is NULL we have a crash.
---
 serial/port.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index d011084..a931ebd 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -368,10 +368,8 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
-	if (!port->listener_id) {
-		reply = NULL;
-		goto failed;
-	}
+	if (!port->listener_id)
+		return;
 
 	if (err < 0) {
 		error("Unable to get service record: %s (%d)", strerror(-err),
-- 
1.7.6.2

