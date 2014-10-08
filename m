Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] unit/test-avrcp: Add /TP/MPS/BI-02-C test
Date: Wed,  8 Oct 2014 15:31:49 +0300
Message-Id: <1412771509-7996-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
References: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Verify the SetBrowsedPlayer response issued by the TG when an invalid
player is requested.
---
 unit/test-avrcp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 18a8785..128ab00 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -607,13 +607,19 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 static int set_browsed(struct avrcp *session, uint8_t transaction,
 						uint16_t id, void *user_data)
 {
+	struct context *context = user_data;
 	const char *folders[1] = { "Filesystem" };
 
 	DBG("");
 
-	avrcp_set_browsed_player_rsp(session, transaction,
-					AVRCP_STATUS_SUCCESS, 0xabcd, 0, 1,
-					folders);
+	if (g_str_equal(context->data->test_name, "/TP/MPS/BI-02-C"))
+		avrcp_set_browsed_player_rsp(session, transaction,
+						AVRCP_STATUS_INVALID_PLAYER_ID,
+						0, 0, 0, NULL);
+	else
+		avrcp_set_browsed_player_rsp(session, transaction,
+						AVRCP_STATUS_SUCCESS,
+						0xabcd, 0, 1, folders);
 
 	return -EAGAIN;
 }
@@ -991,6 +997,13 @@ int main(int argc, char *argv[])
 				AVRCP_SET_ADDRESSED_PLAYER,
 				0x00, 0x00, 0x01, 0x11));
 
+	/* SetBrowsedPlayer - TG */
+	define_test("/TP/MPS/BI-02-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, 0x70, 0x00, 0x02,
+				0xab, 0xcd),
+			brs_pdu(0x02, 0x11, 0x0e, 0x70, 0x00, 0x01,
+				0x11));
+
 	/*
 	 * Media Content Navigation Commands and Notifications for Content
 	 * Browsing.
-- 
1.9.3

