Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] audio: Fix signature type for transport Volume
Date: Fri, 25 May 2012 18:02:46 +0300
Message-Id: <1337958168-9875-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signature is now uint16 instead of byte
---
 audio/transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 4ad8608..ac9d358 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -77,7 +77,7 @@ struct media_transport {
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;		/* Transport delay (a2dp only) */
 	unsigned int		nrec_id;	/* Transport nrec watch (headset only) */
-	uint8_t			volume;		/* Transport volume */
+	uint16_t		volume;		/* Transport volume */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -1076,5 +1076,5 @@ void media_transport_update_volume(struct media_transport *transport,
 
 	emit_property_changed(transport->conn, transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Volume",
-				DBUS_TYPE_BYTE, &transport->volume);
+				DBUS_TYPE_UINT16, &transport->volume);
 }
-- 
1.7.7.6

