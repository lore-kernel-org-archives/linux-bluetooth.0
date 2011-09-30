Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix Unref message after it was sent
Date: Fri, 30 Sep 2011 16:17:31 +0200
Message-Id: <1317392251-13576-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 19c7ee3..1a1c035 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -186,6 +186,7 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 
 	dbus_pending_call_set_notify(call, notify, dev, NULL);
 	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
 
 	return TRUE;
 }
-- 
1.7.1

