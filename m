Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] audio/AVRCP: Connect browsing channel in case of GetCapabilities response
Date: Mon, 29 Jul 2013 17:04:37 +0300
Message-Id: <1375106679-14645-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remote stack respond to GetCapabilities before connecting to
browsing channel connect it immediatelly as some events might depend on
it to work properly.

The spec actually recommends the browsing channel to be connected
immediatelly after the control channel:

AVRCP 1.5 - Page 23

"4.1.1 Connection establishment
...
If a browsing channel is supported by both devices it shall be
established after control channel establishment. It is recommended that
the browsing channel is established immediately after the control
channel is established and released immediately before the control
channel is released to avoid unsatisfactory latency when a browsing
command is sent."
---
 profiles/audio/avrcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8c39d96..9f164e4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3195,6 +3195,13 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	if (pdu == NULL || pdu->params[0] != CAP_EVENTS_SUPPORTED)
 		return FALSE;
 
+	/* Connect browsing if pending */
+	if (session->browsing_timer > 0) {
+		g_source_remove(session->browsing_timer);
+		session->browsing_timer = 0;
+		avctp_connect_browsing(session->conn);
+	}
+
 	count = pdu->params[1];
 
 	for (; count > 0; count--) {
-- 
1.8.3.1

