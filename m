Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
Date: Fri,  9 Aug 2013 17:42:55 +0200
Message-Id: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kernel interface has evolved in between.
---
 tools/sco-tester.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 70b8a5d..1e8351f 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -237,7 +237,7 @@ static const struct sco_client_data connect_success = {
 };
 
 static const struct sco_client_data connect_failure = {
-	.expect_err = ECONNABORTED
+	.expect_err = EOPNOTSUPP
 };
 
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
-- 
1.7.9.5

