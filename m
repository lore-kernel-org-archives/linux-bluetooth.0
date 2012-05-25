Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] SAP: Remove not needed NULL pointer check in check_msg
Date: Fri, 25 May 2012 16:20:53 +0200
Message-ID: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Buffer passed to check_msg() is always valid.
---
 sap/server.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index e44fa08..776bf36 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -129,9 +129,6 @@ static int is_reset_sim_req_allowed(uint8_t processing_req)
 
 static int check_msg(struct sap_message *msg)
 {
-	if (!msg)
-		return -EINVAL;
-
 	switch (msg->id) {
 	case SAP_CONNECT_REQ:
 		if (msg->nparam != 0x01)
-- 
on behalf of ST-Ericsson

