Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump] Correct HCI version according to assign numbers
Date: Thu,  7 Jun 2012 14:49:54 +0300
Message-Id: <1339069794-25843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Bluetooth specifies assigned number for 0x05 as following:
5 - Bluetooth Core Specification 3.0 + HS
http://www.bluetooth.org/Technical/AssignedNumbers/hci.htm
---
 lib/hci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.c b/lib/hci.c
index 269c021..0c1ef5e 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -647,7 +647,7 @@ static hci_map ver_map[] = {
 	{ "1.2",	0x02 },
 	{ "2.0",	0x03 },
 	{ "2.1",	0x04 },
-	{ "3.0",	0x05 },
+	{ "3.0 + HS",	0x05 },
 	{ "4.0",	0x06 },
 	{ NULL }
 };
-- 
1.7.9.5

