Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] avctp: Fix dead assignment in control_response
Date: Tue, 13 Nov 2012 13:52:38 +0100
Message-ID: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Value stored to req is never read before writing it again.

---
 audio/avctp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 6ba25e4..29756f6 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -577,7 +577,7 @@ static void control_response(struct avctp_channel *control,
 					size_t operand_count)
 {
 	struct avctp_pending_req *p = control->p;
-	struct avctp_control_req *req = p->data;
+	struct avctp_control_req *req;
 	GSList *l;
 
 	if (p && p->transaction == avctp->transaction) {
-- 
1.7.9.5

