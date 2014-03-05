Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/11] unit/test-hfp: Add /hfp/test_register_5
Date: Wed,  5 Mar 2014 20:22:54 +0100
Message-Id: <1394047376-11495-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 85d3a60..546a239 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -289,6 +289,11 @@ int main(int argc, char *argv[])
 									'\r'),
 			type_pdu(HFP_GW_CMD_TYPE_TEST, 0),
 			data_end());
+	define_test("/hfp/test_register_5", test_register,
+			raw_pdu('D', '\0'),
+			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '5', '\r'),
+			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

