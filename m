Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] unit/test-avrcp: Add /TP/MPS/BI-01-C test
Date: Wed,  8 Oct 2014 15:31:48 +0300
Message-Id: <1412771509-7996-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the SetAddressedPlayer response issued by the TG when an
invalid player is requested.
---
 unit/test-avrcp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index a0cb685..18a8785 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -589,11 +589,17 @@ static int set_volume(struct avrcp *session, uint8_t transaction,
 static int set_addressed(struct avrcp *session, uint8_t transaction,
 						uint16_t id, void *user_data)
 {
+	struct context *context = user_data;
+	uint8_t status;
+
 	DBG("");
 
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BI-01-C"))
+		status = AVRCP_STATUS_INVALID_PLAYER_ID;
+	else
+		status = AVRCP_STATUS_SUCCESS;
 
-	avrcp_set_addressed_player_rsp(session, transaction,
-							AVRCP_STATUS_SUCCESS);
+	avrcp_set_addressed_player_rsp(session, transaction, status);
 
 	return -EAGAIN;
 }
@@ -975,6 +981,16 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x05, 0x04, 0xab, 0xcd, 0x00, 0x00));
 
+	/* SetAddressedPlayer - TG */
+	define_test("/TP/MPS/BI-01-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x00,
+				0x00, 0x19, 0x58, AVRCP_SET_ADDRESSED_PLAYER,
+				0x00, 0x00, 0x02, 0xab, 0xcd),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_STABLE,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_SET_ADDRESSED_PLAYER,
+				0x00, 0x00, 0x01, 0x11));
+
 	/*
 	 * Media Content Navigation Commands and Notifications for Content
 	 * Browsing.
-- 
1.9.3

