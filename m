Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] unit/avrcp: Add /TP/PTT/BV-03-I test
Date: Tue, 25 Feb 2014 12:09:28 +0200
Message-Id: <1393322970-27451-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393322970-27451-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393322970-27451-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target reacts to the PASS THROUGH command in
category 3 from the Controller. The command chosen is CHANNEL_UP.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 7308443..d46f98c 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -263,9 +263,17 @@ static bool handle_volume_up(struct avrcp *session)
 	return true;
 }
 
+static bool handle_channel_up(struct avrcp *session)
+{
+	DBG("");
+
+	return true;
+}
+
 static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ AVC_PLAY, handle_play },
 		{ AVC_VOLUME_UP, handle_volume_up },
+		{ AVC_CHANNEL_UP, handle_channel_up },
 		{ },
 };
 
@@ -326,5 +334,11 @@ int main(int argc, char *argv[])
 			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
 				AVC_VOLUME_UP, 0x00));
 
+	define_test("/TP/PTT/BV-03-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48, 0x7c,
+				AVC_CHANNEL_UP, 0x00),
+			raw_pdu(0x02, 0x11, 0x0e, 0x09, 0x48, 0x7c,
+				AVC_CHANNEL_UP, 0x00));
+
 	return g_test_run();
 }
-- 
1.8.3.2

