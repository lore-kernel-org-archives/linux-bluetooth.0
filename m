Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/17] unit/test-avrcp: Fix test /TP/MPS/BV-02-C
Date: Mon, 17 Mar 2014 15:07:49 +0200
Message-Id: <1395061683-17206-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The correct status should 0x04 not 0x00.
---
 unit/test-avrcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9fdbe6d..ed0c3fc 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -435,7 +435,10 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
-	return 1;
+	avrcp_set_addressed_player_rsp(session, transaction,
+							AVRCP_STATUS_SUCCESS);
+
+	return -EAGAIN;
 }
 
 static const struct avrcp_control_ind control_ind = {
@@ -547,7 +550,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
 				0x48, 0x00, 0x00, 0x19, 0x58,
 				AVRCP_SET_ADDRESSED_PLAYER,
-				0x00, 0x00, 0x01, 0x00));
+				0x00, 0x00, 0x01, 0x04));
 
 	/* Connection Establishment for Control tests */
 
-- 
1.8.5.3

