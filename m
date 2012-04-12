Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 03/19] agent: Free the agent request properly
Date: Thu, 12 Apr 2012 20:32:54 +0530
Message-id: <1334243001-17016-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the case of error, Unref the req->msg which is allocated inside the
pincode_request_new()
---
 src/agent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 9b942e8..363630e 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -456,7 +456,7 @@ int agent_request_pincode(struct agent *agent, struct btd_device *device,
 	return 0;
 
 failed:
-	g_free(req);
+	agent_request_free(req, FALSE);
 	return err;
 }
 
-- 
1.7.4.1

