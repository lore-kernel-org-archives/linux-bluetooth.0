Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10 v2] Bluetooth: Check for valid key->authenticated value for LTKs
Date: Sun, 20 Jan 2013 14:27:17 +0200
Message-Id: <1358684842-4441-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds necessary checks for the two allowed values of the
authenticated parameter of each Long Term Key, i.e. 0x00 and 0x01. If
any other value is encountered the valid response is to return invalid
params to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cd75899..bc04c44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2703,6 +2703,8 @@ done:
 
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
+	if (key->authenticated != 0x00 && key->authenticated != 0x01)
+		return false;
 	if (key->master != 0x00 && key->master != 0x01)
 		return false;
 	return true;
-- 
1.7.10.4

