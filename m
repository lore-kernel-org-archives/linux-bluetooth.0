Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, marcel@holtmann.org,
        Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH] Bluetooth: Check result code for l2cap info rsp
Date: Wed,  4 Aug 2010 09:43:33 +0300
Message-Id: <1280904213-2097-1-git-send-email-ville.tervo@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Check result code in l2cap information response. Othervise
the response code would read invalid feature mask and access
invalid memory.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/l2cap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0f34e12..3e3cd9d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3348,6 +3348,15 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 
 	del_timer(&conn->info_timer);
 
+	if (result != L2CAP_IR_SUCCESS) {
+		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
+		conn->info_ident = 0;
+
+		l2cap_conn_start(conn);
+
+		return 0;
+	}
+
 	if (type == L2CAP_IT_FEAT_MASK) {
 		conn->feat_mask = get_unaligned_le32(rsp->data);
 
-- 
1.7.1
