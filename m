Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] avctp: Retry control PDU if timeout
Date: Thu, 26 Oct 2017 15:02:23 +0300
Message-Id: <20171026120223.18492-3-luiz.dentz@gmail.com>
In-Reply-To: <20171026120223.18492-1-luiz.dentz@gmail.com>
References: <20171026120223.18492-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to resend a control PDU is not passthrough as the control
channel is considered unreliable packets may be lost.
---
 profiles/audio/avctp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 174f401d6..0d395814c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -157,6 +157,7 @@ struct avctp_pending_req {
 	struct avctp_channel *chan;
 	uint8_t transaction;
 	guint timeout;
+	bool retry;
 	int err;
 	avctp_process_cb process;
 	void *data;
@@ -775,9 +776,16 @@ static gboolean req_timeout(gpointer user_data)
 	struct avctp_channel *chan = user_data;
 	struct avctp_pending_req *p = chan->p;
 
-	DBG("transaction %u", p->transaction);
+	DBG("transaction %u retry %s", p->transaction, p->retry ? "true" :
+								"false");
 
 	p->timeout = 0;
+
+	if (p->retry) {
+		p->process(p->data);
+		return FALSE;
+	}
+
 	p->err = -ETIMEDOUT;
 
 	pending_destroy(p, NULL);
@@ -801,6 +809,9 @@ static int process_control(void *data)
 	if (ret < 0)
 		return ret;
 
+	if (req->op != AVC_OP_PASSTHROUGH)
+		p->retry = !p->retry;
+
 	p->timeout = g_timeout_add_seconds(CONTROL_TIMEOUT, req_timeout,
 								p->chan);
 
-- 
2.13.6

