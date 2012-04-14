Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: chanyeol.park@samsung.com
Subject: [PATCH 1/1] Add DBG() calls to authorization logic
Date: Sat, 14 Apr 2012 14:16:39 +0900
Message-id: <1334380599-17052-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Sometimes BlueZ Agent is disappear suddenly or not registered
because of agent problem. but Bluez just prints "Operation Not
permiited"

This will help debugging.
---
 audio/manager.c |    2 +-
 src/adapter.c   |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index aa2547c..20453e6 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -604,7 +604,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	perr = audio_device_request_authorization(device, server_uuid,
 						gateway_auth_cb, device);
 	if (perr < 0) {
-		DBG("Authorization denied!");
+		DBG("Authorization denied: %s", strerror(-perr));
 		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
 	}
 
diff --git a/src/adapter.c b/src/adapter.c
index d10db10..15d502f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3107,6 +3107,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 
 	agent = device_get_agent(device);
 	if (!agent) {
+		DBG("Can't find device agent");
 		g_free(auth);
 		return -EPERM;
 	}
-- 
1.7.5.4

