Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [BlueZ 2/3] tools: fix misleading test output
Date: Sun,  5 Apr 2015 20:39:24 +0200
Message-Id: <1428259165-10021-2-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428259165-10021-1-git-send-email-fgrandel@gmail.com>
References: <1428259165-10021-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The setup_add_advertising() function claimed to add an advertising
instance while unpowered although it actually adds the instance while
powered. This patch fixes the tester output accordingly.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6a9b527..174c3b7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4894,7 +4894,7 @@ static void setup_add_advertising(const void *test_data)
 	unsigned char adv_param[sizeof(*cp) + 6];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	tester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	memset(cp, 0, sizeof(*cp));
-- 
1.9.1

