Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 5/9] f duplicate test
Date: Fri, 13 Feb 2015 11:06:04 +0200
Message-Id: <1423818368-15899-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index b6ab72c..60eea7a 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -814,7 +814,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x00));
 	define_test("/TP/SIG/SMG/BV-06-C-SEID-2", test_server_seid_duplicate,
 			raw_pdu(0x00, 0x01),
-			raw_pdu(0x02, 0x01, 0x08, 0x08, 0x08, 0x08));
+			raw_pdu(0x02, 0x01, 0x08, 0x08, 0x0c, 0x08));
 	define_test("/TP/SIG/SMG/BV-05-C", test_client,
 			raw_pdu(0x00, 0x01));
 	define_test("/TP/SIG/SMG/BV-06-C", test_server,
-- 
2.1.0

