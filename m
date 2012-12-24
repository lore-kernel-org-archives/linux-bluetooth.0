Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH 2/2] lib: Use SOCK_CLOEXEC where needed
Date: Mon, 24 Dec 2012 13:44:47 -0300
Message-Id: <1356367487-1610-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Calling programs might fork().. execve() and we will end
up leaking fds.
---
 lib/hci.c |  8 ++++----
 lib/sdp.c | 13 ++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 66b2d5f..1f9058f 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -817,7 +817,7 @@ int hci_for_each_dev(int flag, int (*func)(int dd, int dev_id, long arg),
 	int dev_id = -1;
 	int i, sk, err = 0;
 
-	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	sk = socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);
 	if (sk < 0)
 		return -1;
 
@@ -909,7 +909,7 @@ int hci_devinfo(int dev_id, struct hci_dev_info *di)
 {
 	int dd, err, ret;
 
-	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	dd = socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);
 	if (dd < 0)
 		return dd;
 
@@ -965,7 +965,7 @@ int hci_inquiry(int dev_id, int len, int nrsp, const uint8_t *lap,
 		}
 	}
 
-	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	dd = socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);
 	if (dd < 0)
 		return dd;
 
@@ -1021,7 +1021,7 @@ int hci_open_dev(int dev_id)
 	int dd, err;
 
 	/* Create HCI socket */
-	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	dd = socket(AF_BLUETOOTH, SOCK_RAW|SOCK_CLOEXEC, BTPROTO_HCI);
 	if (dd < 0)
 		return dd;
 
diff --git a/lib/sdp.c b/lib/sdp.c
index e1e37ed..1ed4304 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4536,7 +4536,7 @@ static int sdp_connect_local(sdp_session_t *session)
 {
 	struct sockaddr_un sa;
 
-	session->sock = socket(PF_UNIX, SOCK_STREAM, 0);
+	session->sock = socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
 	if (session->sock < 0)
 		return -1;
 	session->local = 1;
@@ -4553,19 +4553,18 @@ static int sdp_connect_l2cap(const bdaddr_t *src,
 	uint32_t flags = session->flags;
 	struct sockaddr_l2 sa;
 	int sk;
+	int sockflags = SOCK_SEQPACKET | SOCK_CLOEXEC;
+	
+	if (flags & SDP_NON_BLOCKING)
+		sockflags |= SOCK_NONBLOCK;
 
-	session->sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	session->sock = socket(PF_BLUETOOTH, sockflags, BTPROTO_L2CAP);
 	if (session->sock < 0)
 		return -1;
 	session->local = 0;
 
 	sk = session->sock;
 
-	if (flags & SDP_NON_BLOCKING) {
-		long arg = fcntl(sk, F_GETFL, 0);
-		fcntl(sk, F_SETFL, arg | O_NONBLOCK);
-	}
-
 	memset(&sa, 0, sizeof(sa));
 
 	sa.l2_family = AF_BLUETOOTH;
-- 
1.8.0.2

