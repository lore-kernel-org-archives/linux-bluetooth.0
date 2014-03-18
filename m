Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] unit/test-avrcp: Fix using empty response to /TP/PAS/BV-04-C
Date: Tue, 18 Mar 2014 14:05:22 +0200
Message-Id: <1395144323-12283-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
References: <1395144323-12283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The purpose of unit tests is to exercise the code as much as possible so
make the test request a valid number of attributes and return them when
testing avrcp_get_player_attribute_text_rsp.
---
 unit/test-avrcp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index dc22708..a2b3195 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -317,10 +317,12 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
 					void *user_data)
 {
+	const char *text[] = { "equalizer" };
+
 	DBG("");
 
-	avrcp_get_player_attribute_text_rsp(session, transaction, 0, NULL,
-									NULL);
+	avrcp_get_player_attribute_text_rsp(session, transaction, number, attrs,
+									text);
 
 	return -EAGAIN;
 }
@@ -666,11 +668,13 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
-				0x00, 0x00, 0x01, 0x00),
+				0x00, 0x00, 0x02, 0x01, 0x01),
 			raw_pdu(0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00,
 				0x00, 0x19, 0x58,
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
-				0x00, 0x00, 0x01, 0x00));
+				0x00, 0x00, 0x0e, 0x01, 0x01, 0x00,
+				0x6a, 0x09, 0x65, 0x71, 0x75, 0x61,
+				0x6c, 0x69, 0x7a, 0x65, 0x72));
 
 	define_test("/TP/PAS/BV-06-C", test_server,
 			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
-- 
1.8.5.3

