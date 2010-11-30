Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix interface name of modem states on maemo6 telephony driver
Date: Tue, 30 Nov 2010 14:26:13 +0200
Message-Id: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-maemo6.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 2e01fb1..0240957 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1963,7 +1963,7 @@ int telephony_init(void)
 	add_watch(NULL, NULL, CSD_CSNET_REGISTRATION, NULL);
 	add_watch(NULL, NULL, CSD_CSNET_OPERATOR, NULL);
 	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, NULL);
-	add_watch(NULL, NULL, CSD_CSNET_SIGNAL, "modem_state_changed_ind");
+	add_watch(NULL, NULL, SSC_DBUS_IFACE, "modem_state_changed_ind");
 
 	if (send_method_call(SSC_DBUS_NAME, SSC_DBUS_PATH, SSC_DBUS_IFACE,
 					"get_modem_state", modem_state_reply,
-- 
1.7.1

