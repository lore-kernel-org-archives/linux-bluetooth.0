Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/2] agent: Remove not used enum value
Date: Sat, 18 Jan 2014 13:51:24 +0100
Message-Id: <1390049485-23503-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only user of AGENT_REQUEST_CONFIRM_MODE is already removed.
---
 src/agent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/agent.c b/src/agent.c
index 4c63cb9..6887bc1 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -66,7 +66,6 @@ typedef enum {
 	AGENT_REQUEST_AUTHORIZATION,
 	AGENT_REQUEST_PINCODE,
 	AGENT_REQUEST_AUTHORIZE_SERVICE,
-	AGENT_REQUEST_CONFIRM_MODE,
 	AGENT_REQUEST_DISPLAY_PINCODE,
 } agent_request_type_t;
 
-- 
1.8.5.3

