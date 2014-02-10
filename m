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
Subject: [PATCH 12/24] Bluetooth: Refactor deferred setup test in rfcomm_dlc_close()
Date: Sun,  9 Feb 2014 20:59:12 -0500
Message-Id: <1391997564-1805-13-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Prepare for directly closing dlc if the RFCOMM session has not
yet been started; refactor the deferred setup test for only those
dlc states to which the test applies. Retains functional
equivalence.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index b5a3785..797b7e1 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -442,11 +442,18 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 	switch (d->state) {
 	case BT_CONNECT:
 	case BT_CONFIG:
+	case BT_OPEN:
+	case BT_CONNECT2:
 		if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
 			rfcomm_schedule();
-			break;
+			return 0;
 		}
+	}
+
+	switch (d->state) {
+	case BT_CONNECT:
+	case BT_CONFIG:
 		/* Fall through */
 
 	case BT_CONNECTED:
@@ -460,15 +467,6 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 		}
 		break;
 
-	case BT_OPEN:
-	case BT_CONNECT2:
-		if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
-			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
-			rfcomm_schedule();
-			break;
-		}
-		/* Fall through */
-
 	default:
 		rfcomm_dlc_clear_timer(d);
 
-- 
1.8.1.2
