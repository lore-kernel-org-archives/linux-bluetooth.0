Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/11] unit/test-hfp: Add /hfp/test_register_3
Date: Wed,  5 Mar 2014 20:22:52 +0100
Message-Id: <1394047376-11495-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index cb422d4..a5fe436 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -278,6 +278,11 @@ int main(int argc, char *argv[])
 			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '=', '\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
+	define_test("/hfp/test_register_3", test_register,
+			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '?', '\r'),
+			type_pdu(HFP_GW_CMD_TYPE_READ, 0),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

