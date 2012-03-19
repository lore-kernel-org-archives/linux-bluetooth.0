Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Silence sparse warning
Date: Mon, 19 Mar 2012 13:26:38 +0200
Message-Id: <1332156398-25953-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Silence sparse warning by introducing tmp __le variable. Despite being
short constructions like "val = le32_to_cpu(val)" are sources of
unneeded warnings (shown below)
...
net/bluetooth/mgmt.c:448:15: warning: cast to restricted __le32
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8f9016..eb8cb66 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -435,6 +435,7 @@ static u8 bluetooth_base_uuid[] = {
 
 static u16 get_uuid16(u8 *uuid128)
 {
+	__le32 tmp;
 	u32 val;
 	int i;
 
@@ -443,9 +444,9 @@ static u16 get_uuid16(u8 *uuid128)
 			return 0;
 	}
 
-	memcpy(&val, &uuid128[12], 4);
+	memcpy(&tmp, &uuid128[12], 4);
 
-	val = le32_to_cpu(val);
+	val = le32_to_cpu(tmp);
 	if (val > 0xffff)
 		return 0;
 
-- 
1.7.9.1

