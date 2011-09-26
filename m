Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 12/16] Phone Alert: listen to Ringer State changes
Date: Mon, 26 Sep 2011 15:13:38 -0400
Message-Id: <1317064422-1654-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Incoming and answered calls are monitored to update Ringer State field.
The bit field is set to 1 when on a incoming call and it is set to 0
when the call is answered.
---
 test/phone-agent.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/test/phone-agent.py b/test/phone-agent.py
index 927fdb1..b3b19a8 100755
--- a/test/phone-agent.py
+++ b/test/phone-agent.py
@@ -6,6 +6,7 @@ import dbus.mainloop.glib
 import gobject
 
 StateIncoming = 0
+StateActive = 3
 StateEnded = 6
 
 ALERT_RINGER_STATE = 1 << 0
@@ -55,8 +56,10 @@ def call_state_changed(*args, **kwargs):
             continue
         if item["state"] == StateIncoming:
             on_call = True
-        elif item["state"] == StateEnded:
+            set_alert_status()
+        elif item["state"] in [StateActive, StateEnded]:
             on_call = False
+            set_alert_status()
             if not silent_mode:
                 restore_ringer()
 
-- 
1.7.0.4

