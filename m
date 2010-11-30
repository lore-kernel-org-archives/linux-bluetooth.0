Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Use specific members in D-Bus match rules on telephony maemo6 driver
Date: Tue, 30 Nov 2010 14:26:14 +0200
Message-Id: <1291119975-9460-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
References: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This reduces the amount of unnecessary wake-ups without breaking anything
---
 audio/telephony-maemo6.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0240957..7853bae 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1960,9 +1960,9 @@ int telephony_init(void)
 	add_watch(NULL, NULL, CSD_CALL_INTERFACE, NULL);
 	add_watch(NULL, NULL, CSD_CALL_INSTANCE, NULL);
 	add_watch(NULL, NULL, CSD_CALL_CONFERENCE, NULL);
-	add_watch(NULL, NULL, CSD_CSNET_REGISTRATION, NULL);
-	add_watch(NULL, NULL, CSD_CSNET_OPERATOR, NULL);
-	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, NULL);
+	add_watch(NULL, NULL, CSD_CSNET_REGISTRATION, "RegistrationChanged");
+	add_watch(NULL, NULL, CSD_CSNET_OPERATOR, "OperatorNameChanged");
+	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, "SignalBarsChanged");
 	add_watch(NULL, NULL, SSC_DBUS_IFACE, "modem_state_changed_ind");
 
 	if (send_method_call(SSC_DBUS_NAME, SSC_DBUS_PATH, SSC_DBUS_IFACE,
-- 
1.7.1

