Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] audio: Fix signature type for transport Volume
Date: Thu, 24 May 2012 16:22:49 +0300
Message-Id: <1337865771-11777-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
References: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signature is now uint16 instead of byte
---
 audio/transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 4ad8608..6ed5d21 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -1076,5 +1076,5 @@ void media_transport_update_volume(struct media_transport *transport,
 
 	emit_property_changed(transport->conn, transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Volume",
-				DBUS_TYPE_BYTE, &transport->volume);
+				DBUS_TYPE_UINT16, &transport->volume);
 }
-- 
1.7.7.6

