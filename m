Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 5/9] unit/avrcp: Add /TP/BGN/BV-01-I TG test
Date: Wed, 12 Mar 2014 16:40:28 +0200
Message-Id: <1394635232-23774-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZL5hjJzaxsnXtrHTzJSHSKYjemUnUr=YRE4Zq9qCmoj0g@mail.gmail.com>
 <1394635232-23774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target responds to Next Group command.
---
 unit/test-avrcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 3714c1a..7351a34 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -280,11 +280,20 @@ static bool handle_select(struct avrcp *session, bool pressed, void *user_data)
 	return true;
 }
 
+static bool handle_vendor_uniq(struct avrcp *session, bool pressed,
+								void *user_data)
+{
+	DBG("");
+
+	return true;
+}
+
 static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ AVC_PLAY, handle_play },
 		{ AVC_VOLUME_UP, handle_volume_up },
 		{ AVC_CHANNEL_UP, handle_channel_up },
 		{ AVC_SELECT, handle_select },
+		{ AVC_VENDOR_UNIQUE, handle_vendor_uniq },
 		{ },
 };
 
@@ -1045,6 +1054,17 @@ int main(int argc, char *argv[])
 				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
 				0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
 
+	/* Next Group command transfer - TG */
+	define_test("/TP/BGN/BV-01-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
+				AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_NEXT_GROUP),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED,
+				0x48, AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_NEXT_GROUP));
+
 	/* Previous Group command transfer - CT */
 	define_test("/TP/BGN/BV-02-I", test_client,
 			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
-- 
1.8.3.2

