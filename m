Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] network: Fix not responding to Device.ConnectProfile
Date: Mon, 26 Nov 2012 15:09:19 +0200
Message-Id: <1353935362-8666-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The callback passed to connection_connect has to be used to respond when
the connection completes.
---
 profiles/network/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 231164b..912e5b4 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -417,6 +417,8 @@ int connection_connect(struct btd_device *device, uint16_t id,
 
 	nc->state = CONNECTING;
 	nc->owner = g_strdup(owner);
+	nc->cb = cb;
+	nc->cb_data = data;
 
 	if (owner)
 		nc->watch = g_dbus_add_disconnect_watch(
-- 
1.7.11.7

