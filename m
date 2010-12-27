Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix printing D-Bus errors when headset record could not be found
Date: Mon, 27 Dec 2010 14:27:21 +0200
Message-Id: <1293452841-7141-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When connection is started via headset_config_stream there is no D-Bus
message to reply to.
---
 audio/headset.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 72bf5b6..53a594d 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1445,7 +1445,8 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		error("Unable to get service record: %s (%d)",
 							strerror(-err), -err);
 		p->err = -err;
-		error_connect_failed(dev->conn, p->msg, p->err);
+		if (p->msg)
+			error_connect_failed(dev->conn, p->msg, p->err);
 		goto failed;
 	}
 
-- 
1.7.1

