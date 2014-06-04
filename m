Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] unit/test-hfp: Add test for parsing empty string
Date: Wed,  4 Jun 2014 19:41:07 +0200
Message-Id: <1401903668-27548-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test if parser is properly handling single '\r'.
---
 unit/test-hfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 20aa0b5..a8801b0 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -465,6 +465,9 @@ int main(int argc, char *argv[])
 									'\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
+	define_test("/hfp/test_empty", test_fragmented, NULL,
+			raw_pdu('\r'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.9.3

