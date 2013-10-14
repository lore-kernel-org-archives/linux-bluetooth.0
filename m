Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/AVCTP: Fix sending requests with same transaction id
Date: Mon, 14 Oct 2013 15:46:03 +0300
Message-Id: <1381754763-27278-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a request is outstanding in the processed list its transaction shall
not be reused as it can cause the wrong callback to be called.

This can be reproduced in very rare occasions where e.g. a notification
using the same transaction of the current request arrives before the
response itself.
---
 profiles/audio/avctp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 845027f..dac7a66 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1480,7 +1480,28 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
 						GDestroyNotify destroy)
 {
 	struct avctp_pending_req *p;
+	GSList *l, *tmp;
 
+	if (!chan->processed)
+		goto done;
+
+	tmp = g_slist_copy(chan->processed);
+
+	/* Find first unused transaction id */
+	for (l = tmp; l; l = l->next) {
+		struct avctp_pending_req *req = l->data;
+
+		if (req->transaction == chan->transaction) {
+			chan->transaction++;
+			chan->transaction %= 16;
+			tmp = g_slist_delete_link(tmp, l);
+			l = tmp;
+		}
+	}
+
+	g_slist_free(tmp);
+
+done:
 	p = g_new0(struct avctp_pending_req, 1);
 	p->chan = chan;
 	p->transaction = chan->transaction;
-- 
1.8.3.1

