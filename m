Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/19] android/avrcp-lib: Add SetAddressedPlayer structs
Date: Fri,  3 Oct 2014 15:32:52 +0300
Message-Id: <1412339579-8292-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
References: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 4a4b1d8..e113c96 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -197,6 +197,14 @@ struct set_volume_rsp {
 	uint8_t value;
 } __attribute__ ((packed));
 
+struct set_addressed_req {
+	uint16_t id;
+} __attribute__ ((packed));
+
+struct set_addressed_rsp {
+	uint8_t status;
+} __attribute__ ((packed));
+
 struct avrcp_control_handler {
 	uint8_t id;
 	uint8_t code;
@@ -2416,12 +2424,12 @@ done:
 int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id)
 {
 	struct iovec iov;
-	uint8_t pdu[2];
+	struct set_addressed_req req;
 
-	put_be16(player_id, pdu);
+	put_be16(player_id, &req.id);
 
-	iov.iov_base = pdu;
-	iov.iov_len = sizeof(pdu);
+	iov.iov_base = &req;
+	iov.iov_len = sizeof(req);
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
 					AVRCP_SET_ADDRESSED_PLAYER, &iov, 1,
-- 
1.9.3

