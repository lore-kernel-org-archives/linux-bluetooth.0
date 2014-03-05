Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] unit/avrcp: Add /TP/PAS/BI-03-C test
Date: Wed,  5 Mar 2014 16:32:27 +0200
Message-Id: <1394029952-3319-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test verifies thst Get player application setting value text returns
error for invalid attribute value.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index f7550f7..3a26a06 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -698,5 +698,19 @@ int main(int argc, char *argv[])
 				AVRCP_LIST_PLAYER_VALUES,
 				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
 
+	/* Get player application setting value text invalid behavior - TG */
+	define_test("/TP/PAS/BI-03-C", test_server,
+			raw_pdu(0x00, 0x11, 0x0e, 0x01, 0x48, 0x00,
+				0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_VALUE_TEXT,
+				0x00, 0x00, 0x03, AVRCP_ATTRIBUTE_EQUALIZER,
+				0x01,
+				/* Invalid setting value */
+				0x7f),
+			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_REJECTED,
+				0x48, 0x00, 0x00, 0x19, 0x58,
+				AVRCP_GET_PLAYER_VALUE_TEXT,
+				0x00, 0x00, 0x01, AVRCP_STATUS_INVALID_PARAM));
+
 	return g_test_run();
 }
-- 
1.8.3.2

