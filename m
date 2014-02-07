Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] avdtp: Fix passing NULL pointer to memcpy
Date: Fri,  7 Feb 2014 14:11:16 +0200
Message-Id: <1391775078-25010-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

send_request can be called as
send_request(session, FALSE, NULL, AVDTP_DISCOVER, NULL, 0) with NULL
pointer which is passed to memcpy().
---
 profiles/audio/avdtp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index fbf61f0..da10ab4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2731,11 +2731,14 @@ static int send_request(struct avdtp *session, gboolean priority,
 
 	req = g_new0(struct pending_req, 1);
 	req->signal_id = signal_id;
-	req->data = g_malloc(size);
-	memcpy(req->data, buffer, size);
-	req->data_size = size;
 	req->stream = stream;
 
+	if (buffer && size) {
+		req->data = g_malloc(size);
+		memcpy(req->data, buffer, size);
+		req->data_size = size;
+	}
+
 	return send_req(session, priority, req);
 }
 
-- 
1.8.3.2

