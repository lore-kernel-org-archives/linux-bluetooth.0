Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] avctp: Fix dead assignment in control_response
Date: Tue, 13 Nov 2012 15:21:06 +0200
Message-Id: <1352812880-7306-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Value stored to req is never read before writing it again.
---
 audio/avctp.c | 2 +-
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
1.7.11.7

