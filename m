Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 1/5] lib: Add flag to force large MTU size used for SDP connection
Date: Mon, 20 Jan 2014 12:08:32 +0100
Message-Id: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This will allow to workaround Dualshock4 not respecting L2CAP MTU
size while sending SDP response. Use same L2CAP MTU value base on
RFCOMM.
---
 lib/sdp.c     | 27 +++++++++++++++++++++++++++
 lib/sdp_lib.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index 886e7cf..3b26ec3 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -67,6 +67,9 @@ static uint128_t bluetooth_base_uuid = {
 
 #define SDP_MAX_ATTR_LEN 65535
 
+/* match MTU used by RFCOMM */
+#define SDP_LARGE_L2CAP_MTU 1013
+
 static sdp_data_t *sdp_copy_seq(sdp_data_t *data);
 static int sdp_attr_add_new_with_length(sdp_record_t *rec,
 	uint16_t attr, uint8_t dtd, const void *value, uint32_t len);
@@ -4644,6 +4647,26 @@ static int sdp_connect_local(sdp_session_t *session)
 	return connect(session->sock, (struct sockaddr *) &sa, sizeof(sa));
 }
 
+static int set_l2cap_mtu(int sk, uint16_t mtu)
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
+	l2o.imtu = mtu;
+	l2o.omtu = mtu;
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
@@ -4678,6 +4701,10 @@ static int sdp_connect_l2cap(const bdaddr_t *src,
 		setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
 	}
 
+	if ((flags & SDP_LARGE_MTU) &&
+				set_l2cap_mtu(sk, SDP_LARGE_L2CAP_MTU) < 0)
+		return -1;
+
 	sa.l2_psm = htobs(SDP_PSM);
 	sa.l2_bdaddr = *dst;
 
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 6e1eb91..3ded393 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -81,6 +81,7 @@ static inline void sdp_list_foreach(sdp_list_t *list, sdp_list_func_t f, void *u
 #define SDP_RETRY_IF_BUSY	0x01
 #define SDP_WAIT_ON_CLOSE	0x02
 #define SDP_NON_BLOCKING	0x04
+#define SDP_LARGE_MTU		0x08
 
 /*
  * a session with an SDP server
-- 
1.8.3.2

