Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] SAP: Remove not needed checks from disconnect_ind
Date: Fri, 25 May 2012 16:21:02 +0200
Message-ID: <1337955662-19016-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

disconnect_ind is an helper funtion and is always called with valid
connection and from valid state so there is no need to double check
that.
---
 sap/server.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 00c540e..c83e68a 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -274,18 +274,8 @@ static int disconnect_ind(void *sap_device, uint8_t disc_type)
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
 	size_t size = sizeof(struct sap_message);
 
-	if (!conn)
-		return -EINVAL;
-
 	DBG("data %p state %d disc_type 0x%02x", conn, conn->state, disc_type);
 
-	if (conn->state != SAP_STATE_GRACEFUL_DISCONNECT &&
-			conn->state != SAP_STATE_IMMEDIATE_DISCONNECT) {
-		error("Processing error (state %d pr 0x%02x)", conn->state,
-							conn->processing_req);
-		return -EPERM;
-	}
-
 	memset(buf, 0, sizeof(buf));
 	msg->id = SAP_DISCONNECT_IND;
 	msg->nparam = 0x01;
-- 
on behalf of ST-Ericsson

