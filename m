Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Konrad=20Zapa=C5=82owicz?=
        <konrad.zapalowicz@canonical.com>
Subject: [PATCH] tester: fix inproper printout from cmd handler
Date: Fri, 16 Jun 2017 13:21:01 +0200
Message-Id: <1497612061-30334-1-git-send-email-bergo.torino@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>

---
 tools/hci-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 75d09f0..e900789 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -451,7 +451,7 @@ static void test_le_read_local_pk_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
+		tester_warn("Failed to send Read Local PK256 cmd (0x%02x)", status);
 		tester_test_failed();
 		return;
 	}
-- 
2.7.4

