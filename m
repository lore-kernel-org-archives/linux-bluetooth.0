Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove check for valid LTK authenticated parameter
Date: Fri, 31 Jan 2014 18:42:16 -0800
Message-Id: <1391222538-34065-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LTK authenticated parameter is the key type of the LTK and similar
to link keys there is no need to check the currently supported values.

For possible future improvements, the kernel will only use key types
it knows about and just ignore all the other ones.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 70a3a7e917b7..8030eeb44382 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4146,8 +4146,6 @@ unlock:
 
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
-	if (key->authenticated != 0x00 && key->authenticated != 0x01)
-		return false;
 	if (key->master != 0x00 && key->master != 0x01)
 		return false;
 	if (!bdaddr_type_is_le(key->addr.type))
-- 
1.8.5.3

