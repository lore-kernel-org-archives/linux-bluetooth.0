Return-Path: <cyrus@holtmann.org>
From: dean_jenkins@mentor.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org
Subject: [PATCH 6/6] Bluetooth: Remove redundant RFCOMM BT_CLOSED settings
Date: Mon, 25 Feb 2013 16:38:37 +0000
Message-Id: <1361810317-4005-7-git-send-email-dean_jenkins@mentor.com>
In-Reply-To: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
References: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dean Jenkins <Dean_Jenkins@mentor.com>

rfcomm_session_close() sets the RFCOMM session state to BT_CLOSED.
However, in multiple places immediately before the function is
called, the RFCOMM session is set to BT_CLOSED. Therefore,
remove these unnecessary state settings.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/rfcomm/core.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 3bdaf2e..2e82b60 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -659,10 +659,10 @@ static struct rfcomm_session *rfcomm_session_close(struct rfcomm_session *s,
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
 
-	BT_DBG("session %p state %ld err %d", s, s->state, err);
-
 	s->state = BT_CLOSED;
 
+	BT_DBG("session %p state %ld err %d", s, s->state, err);
+
 	/* Close all dlcs */
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
@@ -1188,7 +1188,6 @@ static struct rfcomm_session *rfcomm_recv_dm(struct rfcomm_session *s, u8 dlci)
 		else
 			err = ECONNRESET;
 
-		s->state = BT_CLOSED;
 		s = rfcomm_session_close(s, err);
 	}
 	return s;
@@ -1224,7 +1223,6 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 		else
 			err = ECONNRESET;
 
-		s->state = BT_CLOSED;
 		s = rfcomm_session_close(s, err);
 	}
 	return s;
@@ -1921,7 +1919,6 @@ static struct rfcomm_session *rfcomm_check_connection(struct rfcomm_session *s)
 		break;
 
 	case BT_CLOSED:
-		s->state = BT_CLOSED;
 		s = rfcomm_session_close(s, sk->sk_err);
 		break;
 	}
-- 
1.7.10.1
