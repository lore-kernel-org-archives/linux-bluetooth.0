Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] avctp: Reintroduce a timeout for the browsing channel
Date: Thu, 26 Oct 2017 15:02:22 +0300
Message-Id: <20171026120223.18492-2-luiz.dentz@gmail.com>
In-Reply-To: <20171026120223.18492-1-luiz.dentz@gmail.com>
References: <20171026120223.18492-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec suggests to rely on the link supervision timeout to detect
when the remote is not responding but this ignores the fact that due
to a bug or bad implementation stacks may ignore the request causing
the whole request queue to stall.
---
 profiles/audio/avctp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index f8ec19c9c..174f401d6 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -62,6 +62,7 @@
 #define AVC_PRESS_TIMEOUT	2
 
 #define CONTROL_TIMEOUT		AVC_PRESS_TIMEOUT
+#define BROWSING_TIMEOUT	10
 
 #define QUIRK_NO_RELEASE 1 << 0
 
@@ -810,9 +811,17 @@ static int process_browsing(void *data)
 {
 	struct avctp_browsing_req *req = data;
 	struct avctp_pending_req *p = req->p;
+	int ret;
 
-	return avctp_browsing_send(p->chan, p->transaction, AVCTP_COMMAND,
+	ret = avctp_browsing_send(p->chan, p->transaction, AVCTP_COMMAND,
 					req->operands, req->operand_count);
+	if (ret < 0)
+		return ret;
+
+	p->timeout = g_timeout_add_seconds(BROWSING_TIMEOUT, req_timeout,
+								p->chan);
+
+	return 0;
 }
 
 static gboolean process_queue(void *user_data)
-- 
2.13.6

