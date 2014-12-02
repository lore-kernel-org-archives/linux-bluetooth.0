Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/13] core: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:31 +0100
Message-Id: <1417541318-24259-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10
---
 src/agent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 97daf71..73b2fdd 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -242,6 +242,10 @@ void agent_unref(struct agent *agent)
 			passkey_cb = agent->request->cb;
 			passkey_cb(agent, &err, 0, agent->request->user_data);
 			break;
+		case AGENT_REQUEST_CONFIRMATION:
+		case AGENT_REQUEST_AUTHORIZATION:
+		case AGENT_REQUEST_AUTHORIZE_SERVICE:
+		case AGENT_REQUEST_DISPLAY_PINCODE:
 		default:
 			cb = agent->request->cb;
 			cb(agent, &err, agent->request->user_data);
-- 
1.9.1

