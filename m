Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 5/6] Fix reference count issue in incoming connections
Date: Tue,  6 Sep 2011 15:55:52 +0200
Message-Id: <1315317353-14412-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1315317353-14412-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of incoming RFCOMM connection, manager
calls gateway_connect_rfcomm which already take
reference to GIOChannel, hence no need to take
another one.
---
 audio/gateway.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 945477e..f3e6c6a 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -325,7 +325,8 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 
 	sk = g_io_channel_unix_get_fd(chan);
 
-	gw->rfcomm = g_io_channel_ref(chan);
+	if (gw->rfcomm == NULL)
+		gw->rfcomm = g_io_channel_ref(chan);
 
 	ret = agent_sendfd(gw->agent, sk, newconnection_reply, dev);
 
-- 
1.7.1

