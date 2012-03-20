Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Silence sparse warning
Date: Tue, 20 Mar 2012 18:08:14 +0200
Message-Id: <1332259694-9199-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Silence sparse warning shown below:
...
net/bluetooth/mgmt.c:448:15: warning: cast to restricted __le32
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8f9016..913c6d2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -443,9 +443,7 @@ static u16 get_uuid16(u8 *uuid128)
 			return 0;
 	}
 
-	memcpy(&val, &uuid128[12], 4);
-
-	val = le32_to_cpu(val);
+	val = get_unaligned_le32(uuid128 + 12);
 	if (val > 0xffff)
 		return 0;
 
-- 
1.7.9.1

