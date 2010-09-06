Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Make use of ofono bus name when watching its signals
Date: Mon,  6 Sep 2010 13:26:22 +0300
Message-Id: <1283768782-4283-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1283768782-4283-1-git-send-email-luiz.dentz@gmail.com>
References: <1283768782-4283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 9c20112..693207c 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1069,13 +1069,13 @@ int telephony_init(void)
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
-	registration_watch = g_dbus_add_signal_watch(connection, NULL, NULL,
-					OFONO_NETWORKREG_INTERFACE,
+	registration_watch = g_dbus_add_signal_watch(connection, OFONO_BUS_NAME,
+					NULL, OFONO_NETWORKREG_INTERFACE,
 					"PropertyChanged",
 					handle_registration_property_changed,
 					NULL, NULL);
 
-	voice_watch = g_dbus_add_signal_watch(connection, NULL, NULL,
+	voice_watch = g_dbus_add_signal_watch(connection, OFONO_BUS_NAME, NULL,
 					OFONO_VCMANAGER_INTERFACE,
 					"PropertyChanged",
 					handle_vcmanager_property_changed,
-- 
1.7.0.4

