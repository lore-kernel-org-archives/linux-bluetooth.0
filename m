Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/5] lib: Add flag to double L2CAP IMTU size used for SDP connection
Date: Mon, 20 Jan 2014 01:31:50 +0100
Message-Id: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to workaround Dualshock4 not respecting L2CAP MTU
size while sending SDP response.
---
 lib/sdp.c     | 22 ++++++++++++++++++++++
 lib/sdp_lib.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index 886e7cf..4d9a4bb 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4644,6 +4644,25 @@ static int sdp_connect_local(sdp_session_t *session)
 	return connect(session->sock, (struct sockaddr *) &sa, sizeof(sa));
 }
 
+static int double_l2cap_imtu(int sk)
+{
+	struct l2cap_options l2o;
+	socklen_t len;
+
+	memset(&l2o, 0, sizeof(l2o));
+	len = sizeof(l2o);
+
+	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0)
+		return -1;
+
+	l2o.imtu = 2 * l2o.imtu;
+
+	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o)) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int sdp_connect_l2cap(const bdaddr_t *src,
 		const bdaddr_t *dst, sdp_session_t *session)
 {
@@ -4678,6 +4697,9 @@ static int sdp_connect_l2cap(const bdaddr_t *src,
 		setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
 	}
 
+	if ((flags & SDP_DOUBLE_IMTU) && double_l2cap_imtu(sk) < 0)
+		return -1;
+
 	sa.l2_psm = htobs(SDP_PSM);
 	sa.l2_bdaddr = *dst;
 
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 6e1eb91..56ba2ea 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -81,6 +81,7 @@ static inline void sdp_list_foreach(sdp_list_t *list, sdp_list_func_t f, void *u
 #define SDP_RETRY_IF_BUSY	0x01
 #define SDP_WAIT_ON_CLOSE	0x02
 #define SDP_NON_BLOCKING	0x04
+#define SDP_DOUBLE_IMTU		0x08
 
 /*
  * a session with an SDP server
-- 
1.8.5.3

