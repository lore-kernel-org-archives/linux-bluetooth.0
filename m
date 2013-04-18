Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 2/2] device: Fix the wrong order of UUIDs PropertyChanged
Date: Thu, 18 Apr 2013 14:50:24 -0300
Message-Id: <1366307424-19825-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code goes to great length to make sure that the Service Discovery
is finished before sending the NewConnection() message to external
profiles.  In some situations this effort is wasted because the UUIDs
signal is emitted after NewConnection() is sent.

This patch fixes it by making sure that all the properties for that
object are updated before sending the NewConnection() call.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index ee17514..9f9dba3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2806,6 +2806,8 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 send_reply:
 	device_svc_resolved(device, err);
 
+	g_dbus_flush_properties(dbus_conn, req->device->path);
+
 	if (!device->temporary)
 		store_device_info(device);
 
-- 
1.8.2.1

