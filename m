Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 04/11] unit/test-hfp: Add /hfp/test_cmd_handler_2
Date: Wed,  5 Mar 2014 20:22:49 +0100
Message-Id: <1394047376-11495-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 5e16378..1a22298 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -215,6 +215,10 @@ int main(int argc, char *argv[])
 			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\r'),
 			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F'),
 			data_end());
+	define_test("/hfp/test_cmd_handler_2", test_command_handler,
+			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '\r'),
+			raw_pdu('A', 'T', 'D', '1', '2', '3', '4'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

