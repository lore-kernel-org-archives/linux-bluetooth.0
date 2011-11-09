Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <ulrik.lauren@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] Bluetooth: Fix race condition between RFCOMM and L2CAP
Date: Wed, 9 Nov 2011 14:12:20 +0100
Message-ID: <1320844340-1966-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes when RFCOMM creates underlying L2CAP socket it happens that
rfcomm_security_cfm is called before DLC is linked to session thus
reference count for session struct is 0. As a result rfcomm_session_put
will close session and connection will not be completed.

__rfcomm_dlc_open will now hold reference to rfcomm_session until DLC
is linked to session to prevent the above from happening.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/rfcomm/core.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8743f36..461ce08 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -406,13 +406,17 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 		s = rfcomm_session_create(src, dst, d->sec_level, &err);
 		if (!s)
 			return err;
+	} else {
+		rfcomm_session_hold(s);
 	}
 
 	dlci = __dlci(!s->initiator, channel);
 
 	/* Check if DLCI already exists */
-	if (rfcomm_dlc_get(s, dlci))
+	if (rfcomm_dlc_get(s, dlci)) {
+		rfcomm_session_put(s);
 		return -EBUSY;
+	}
 
 	rfcomm_dlc_clear_state(d);
 
@@ -428,6 +432,9 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 	d->mtu = s->mtu;
 	d->cfc = (s->cfc == RFCOMM_CFC_UNKNOWN) ? 0 : s->cfc;
 
+	/* Release internal reference to session */
+	rfcomm_session_put(s);
+
 	if (s->state == BT_CONNECTED) {
 		if (rfcomm_check_security(d))
 			rfcomm_send_pn(s, 1, d);
@@ -720,6 +727,8 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 		goto failed;
 	}
 
+	rfcomm_session_hold(s);
+
 	s->initiator = 1;
 
 	bacpy(&addr.l2_bdaddr, dst);
-- 
on behalf of ST-Ericsson

