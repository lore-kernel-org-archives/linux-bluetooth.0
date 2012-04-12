Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 09/19] agent: Fix double D-Bus message unref
Date: Thu, 12 Apr 2012 20:33:00 +0530
Message-id: <1334243001-17016-10-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inside the g_dbus_send_message() we are already doing the
D-BUS message unref.
---
 src/agent.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 363630e..8e3721c 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -692,7 +692,6 @@ int agent_display_passkey(struct agent *agent, struct btd_device *device,
 
 	if (!g_dbus_send_message(connection, message)) {
 		error("D-Bus send failed");
-		dbus_message_unref(message);
 		return -1;
 	}
 
-- 
1.7.4.1

