Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: bnep: Handle BNEP connection setup request
Date: Tue, 31 Mar 2015 16:56:01 +0200
Message-Id: <1427813761-32123-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427813761-32123-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427813761-32123-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch kernel will be able to handle setup request. This is
needed if we would like to handle control mesages with extension
headers. User space will be only resposible for reading setup data and
checking if scenario is conformance to specification (dst and src device
bnep role). In case of new user space, setup data must be leaved(peek
msg) on queue. New bnep session will be responsible for handling this
data.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 net/bluetooth/bnep/bnep.h |  5 +++++
 net/bluetooth/bnep/core.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index 12d2c84..0b88f92 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -83,6 +83,11 @@
 /* Features */
 #define BNEP_SETUP_RSP_SUPPORT	0
 
+/* Session flags */
+enum {
+	BNEP_SETUP_RSP_SENT,
+};
+
 struct bnep_setup_conn_req {
 	__u8 type;
 	__u8 ctrl;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 77ae725..aa0966a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -231,7 +231,15 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 
 	case BNEP_SETUP_CONN_REQ:
-		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+		/* Successful response should be sent only once */
+		if (!test_bit(BNEP_SETUP_RSP_SENT, &s->flags)) {
+			set_bit(BNEP_SETUP_RSP_SENT, &s->flags);
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_SUCCESS);
+		} else {
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_CONN_NOT_ALLOWED);
+		}
 		break;
 
 	default: {
-- 
2.1.0

