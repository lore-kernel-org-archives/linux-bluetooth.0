Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not waiting for POLLERR when disconnecting SCO
Date: Mon, 18 Apr 2011 09:57:26 +0300
Message-Id: <1303109846-8811-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

To make sure the SCO link is really disconnected we should wait for
POLLERR since POLLHUP does not necessarily means the link is
completely disconnected just that no further data can be sent/received.

Note that this depend on a fix of SCO socket shutdown in kernel to wait
for disconnect confimation to then kill/destroy the socket indicating
the err/reason using POLLERR.
---
 audio/headset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index c605e9d..819e0f8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2548,7 +2548,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		hs->sco_id = g_io_add_watch(hs->sco,
-					G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					G_IO_ERR | G_IO_NVAL,
 					(GIOFunc) sco_cb, dev);
 
 		g_dbus_emit_signal(dev->conn, dev->path,
-- 
1.7.1

