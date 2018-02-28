Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9] tools/btpclient: Add btp disconnect handler
Date: Wed, 28 Feb 2018 13:41:24 +0100
Message-Id: <20180228124129.25851-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds btp disconnect handler to btp client.
---
 tools/btpclient.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 3d9e449ce..4097c05d0 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -2892,6 +2892,12 @@ static void client_disconnected(struct l_dbus *dbus, void *user_data)
 	l_main_quit();
 }
 
+static void btp_disconnect_handler(struct btp *btp, void *user_data)
+{
+	l_info("btp disconnected");
+	l_main_quit();
+}
+
 static void client_ready(struct l_dbus_client *client, void *user_data)
 {
 	l_info("D-Bus client ready, connecting BTP");
@@ -2903,6 +2909,8 @@ static void client_ready(struct l_dbus_client *client, void *user_data)
 		return;
 	}
 
+	btp_set_disconnect_handler(btp, btp_disconnect_handler, NULL, NULL);
+
 	register_core_service();
 
 	btp_send(btp, BTP_CORE_SERVICE, BTP_EV_CORE_READY,
-- 
2.13.6

