Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gianluca Anzolin <gianluca@sottospazio.it>,
	Alexander Holler <holler@ahsoftware.de>,
	Andrey Vihrov <andrey.vihrov@gmail.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 14/24] Bluetooth: Directly close dlc for not yet started RFCOMM session
Date: Sun,  9 Feb 2014 20:59:14 -0500
Message-Id: <1391997564-1805-15-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If the RFCOMM session has not yet been started (ie., session is
still in BT_BOUND state) when a dlc is closed, directly close and
unlink the dlc rather than sending a DISC frame that is never
sent.

This allows the dlci to be immediately reused rather than waiting
for a 20 second timeout.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 88f0edc..8e14df6 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -467,13 +467,19 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 
 	switch (d->state) {
 	case BT_CONNECT:
-	case BT_CONFIG:
-		/* Fall through */
-
 	case BT_CONNECTED:
 		__rfcomm_dlc_disconn(d);
 		break;
 
+	case BT_CONFIG:
+		if (s->state != BT_BOUND) {
+			__rfcomm_dlc_disconn(d);
+			break;
+		}
+		/* if closing a dlc in a session that hasn't been started,
+		 * just close and unlink the dlc
+		 */
+
 	default:
 		rfcomm_dlc_clear_timer(d);
 
-- 
1.8.1.2
