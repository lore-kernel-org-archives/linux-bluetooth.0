Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] unit/avrcp: Add /TP/BGN/BV-02-I TG test
Date: Wed, 12 Mar 2014 12:54:33 +0200
Message-Id: <1394621673-13718-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZK6yEDvVwda3GBubgh2+J=SwE_Vmr5oEJ_hhqhOLd2CsA@mail.gmail.com>
 <1394621673-13718-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies that the Target responds to Prev Group command.
---
 unit/test-avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index ea421b0..31d17b9 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -1074,5 +1074,16 @@ int main(int argc, char *argv[])
 				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
 				0x58, 0x00, AVC_VENDOR_PREV_GROUP));
 
+	/* Previous Group command transfer - TG */
+	define_test("/TP/BGN/BV-02-I", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x00, 0x48,
+				AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_PREV_GROUP),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_ACCEPTED,
+				0x48, AVC_OP_PASSTHROUGH,
+				AVC_VENDOR_UNIQUE, 0x05, 0x00, 0x19,
+				0x58, 0x00, AVC_VENDOR_PREV_GROUP));
+
 	return g_test_run();
 }
-- 
1.8.3.2

