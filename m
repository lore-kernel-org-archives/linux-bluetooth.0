Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v1 1/7] Add Bluetooth address type in sockaddr_l2
Date: Thu,  5 Apr 2012 19:38:30 -0300
Message-Id: <1333665510-20520-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <20120405103011.GF32212@x220>
References: <20120405103011.GF32212@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the address type information to sockaddr_l2 structure,
allowing the userspace to inform the remote address type required for
LE Create Connection command.
---
 lib/bluetooth.h |    5 +++++
 lib/l2cap.h     |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0541842..0fc4508 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -222,6 +222,11 @@ typedef struct {
 	uint8_t b[6];
 } __attribute__((packed)) bdaddr_t;
 
+/* BD Address type */
+#define BDADDR_BREDR           0x00
+#define BDADDR_LE_PUBLIC       0x01
+#define BDADDR_LE_RANDOM       0x02
+
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 #define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 5806aaa..5ce94c4 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -43,6 +43,7 @@ struct sockaddr_l2 {
 	unsigned short	l2_psm;
 	bdaddr_t	l2_bdaddr;
 	unsigned short	l2_cid;
+	uint8_t		l2_bdaddr_type;
 };
 
 /* L2CAP socket options */
-- 
1.7.8.5

