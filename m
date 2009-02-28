Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bluetooth: add macros for cid channel numbers
Date: Sat, 28 Feb 2009 02:02:26 -0300
Message-Id: <1235797347-1816-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1235797347-1816-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1235797347-1816-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f566aa1..e7bf331 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -118,6 +118,13 @@ struct l2cap_conn_rsp {
 #define L2CAP_CS_AUTHEN_PEND  0x0001
 #define L2CAP_CS_AUTHOR_PEND  0x0002
 
+
+/* cid channel type */
+#define L2CAP_CID_SIGNALING	0x0001
+#define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_DYN_START	0x0040
+#define L2CAP_CID_DYN_END	0xffff
+
 struct l2cap_conf_req {
 	__le16     dcid;
 	__le16     flags;
-- 
1.6.0.6

