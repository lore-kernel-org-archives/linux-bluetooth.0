Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] serial: fix DBus message reply
Date: Tue, 13 Sep 2011 00:46:21 -0300
Message-Id: <1315885582-20027-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

If reply is NULL we have a crash.
---
 serial/port.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index d011084..2cdead4 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -369,7 +369,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	GError *gerr = NULL;
 
 	if (!port->listener_id) {
-		reply = NULL;
+		reply = btd_error_failed(port->msg, "No listening application");
 		goto failed;
 	}
 
-- 
1.7.6.2

