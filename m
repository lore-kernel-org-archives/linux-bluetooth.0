Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH 1/2] Fix crash when disconnecting the a2dp
Date: Thu, 11 Aug 2011 00:14:46 +0530
Message-Id: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we disconnect the a2dp Headset by immediate power off and soon if we
initiate a disconnection from our side, a crash is occurring. This is
happening because of the disconnect_timeout coming after freeing the session.
---
 audio/avdtp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 76526b6..d8d9d7e 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -690,7 +690,7 @@ static void set_disconnect_timer(struct avdtp *session)
 		remove_disconnect_timer(session);
 
 	if (session->device_disconnect) {
-		g_idle_add(disconnect_timeout, session);
+		session->dc_timer = g_idle_add(disconnect_timeout, session);
 		return;
 	}
 
-- 
1.7.4.1

