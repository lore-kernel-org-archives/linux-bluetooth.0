Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 14/18] mgmt: Use bt_get_* helper functions to access unaligned memory
Date: Tue, 4 Sep 2012 16:41:33 +0200
Message-ID: <1346769697-9930-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/mgmt.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 45a5c90..c64eb68 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -100,7 +100,7 @@ static void read_version_complete(int sk, void *buf, size_t len)
 		abort();
 	}
 
-	mgmt_revision = btohs(bt_get_unaligned(&rp->revision));
+	mgmt_revision = bt_get_le16(&rp->revision);
 	mgmt_version = rp->version;
 
 	DBG("version %u revision %u", mgmt_version, mgmt_revision);
@@ -923,7 +923,7 @@ static void read_index_list_complete(int sk, void *buf, size_t len)
 		return;
 	}
 
-	num = btohs(bt_get_unaligned(&rp->num_controllers));
+	num = bt_get_le16(&rp->num_controllers);
 
 	if (num * sizeof(uint16_t) + sizeof(*rp) != len) {
 		error("Incorrect packet size for index list event");
@@ -933,7 +933,7 @@ static void read_index_list_complete(int sk, void *buf, size_t len)
 	for (i = 0; i < num; i++) {
 		uint16_t index;
 
-		index = btohs(bt_get_unaligned(&rp->index[i]));
+		index = bt_get_le16(&rp->index);
 
 		add_controller(index);
 		read_info(sk, index);
@@ -1033,7 +1033,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	bacpy(&info->bdaddr, &rp->bdaddr);
 	info->version = rp->version;
-	info->manufacturer = btohs(bt_get_unaligned(&rp->manufacturer));
+	info->manufacturer = bt_get_le16(&rp->manufacturer);
 
 	memcpy(&info->supported_settings, &rp->supported_settings,
 					sizeof(info->supported_settings));
@@ -1365,7 +1365,7 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		return;
 	}
 
-	opcode = btohs(bt_get_unaligned(&ev->opcode));
+	opcode = bt_get_le16(&ev->opcode);
 
 	len -= sizeof(*ev);
 
@@ -1498,7 +1498,7 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 		return;
 	}
 
-	opcode = btohs(bt_get_unaligned(&ev->opcode));
+	opcode = bt_get_le16(&ev->opcode);
 
 	if (!ev->status) {
 		DBG("%s (0x%04x) cmd_status %u", mgmt_opstr(opcode), opcode,
@@ -1824,9 +1824,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 		return TRUE;
 	}
 
-	opcode = btohs(bt_get_unaligned(&hdr->opcode));
-	len = btohs(bt_get_unaligned(&hdr->len));
-	index = btohs(bt_get_unaligned(&hdr->index));
+	opcode = bt_get_le16(&hdr->opcode);
+	len = bt_get_le16(&hdr->len);
+	index = bt_get_le16(&hdr->index);
 
 	if (ret != MGMT_HDR_SIZE + len) {
 		error("Packet length mismatch. ret %zd len %u", ret, len);
-- 
1.7.9.5

