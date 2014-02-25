Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] unit/avrcp: Add /TP/PTT/BV-02-I test
Date: Tue, 25 Feb 2014 12:09:27 +0200
Message-Id: <1393322970-27451-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target reacts to the PASS THROUGH command in
category 2 from the Controller. The command chosen is VOLUME_UP.
---
 unit/test-avrcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9bd27da..7308443 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -251,11 +251,21 @@ static void execute_context(struct context *context)
 
 static bool handle_play(struct avrcp *session)
 {
+	DBG("");
+
+	return true;
+}
+
+static bool handle_volume_up(struct avrcp *session)
+{
+	DBG("");
+
 	return true;
 }
 
 static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ AVC_PLAY, handle_play },
+		{ AVC_VOLUME_UP, handle_volume_up },
 		{ },
 };
 
@@ -310,5 +320,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
 				0x44, 0x00));
 
+	define_test("/TP/PTT/BV-02-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
+				AVC_VOLUME_UP, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
+				AVC_VOLUME_UP, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

