Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 01/16] Bluetooth: clean up spaces in L2CAP header
Date: Tue, 11 Oct 2011 13:37:41 +0300
Message-Id: <1318329476-30153-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Spaces converted to tabs

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index aea083c..08ad40b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -134,10 +134,9 @@ struct l2cap_conninfo {
 #define L2CAP_SDU_CONTINUE          0xC000
 
 /* L2CAP Command rej. reasons */
-#define L2CAP_REJ_NOT_UNDERSTOOD      0x0000
-#define L2CAP_REJ_MTU_EXCEEDED        0x0001
-#define L2CAP_REJ_INVALID_CID         0x0002
-
+#define L2CAP_REJ_NOT_UNDERSTOOD	0x0000
+#define L2CAP_REJ_MTU_EXCEEDED		0x0001
+#define L2CAP_REJ_INVALID_CID		0x0002
 
 /* L2CAP structures */
 struct l2cap_hdr {
@@ -273,13 +272,13 @@ struct l2cap_info_rsp {
 } __packed;
 
 /* info type */
-#define L2CAP_IT_CL_MTU     0x0001
-#define L2CAP_IT_FEAT_MASK  0x0002
-#define L2CAP_IT_FIXED_CHAN 0x0003
+#define L2CAP_IT_CL_MTU		0x0001
+#define L2CAP_IT_FEAT_MASK	0x0002
+#define L2CAP_IT_FIXED_CHAN	0x0003
 
 /* info result */
-#define L2CAP_IR_SUCCESS    0x0000
-#define L2CAP_IR_NOTSUPP    0x0001
+#define L2CAP_IR_SUCCESS	0x0000
+#define L2CAP_IR_NOTSUPP	0x0001
 
 struct l2cap_conn_param_update_req {
 	__le16      min;
-- 
1.7.4.1

