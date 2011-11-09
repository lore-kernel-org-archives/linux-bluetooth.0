Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix consistency with u16 integer type in mgmt pending_cmd
Date: Wed,  9 Nov 2011 13:58:56 +0200
Message-Id: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For consistency the integer type should be u16 and not __u16.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 263fa27..a849428 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -36,7 +36,7 @@
 
 struct pending_cmd {
 	struct list_head list;
-	__u16 opcode;
+	u16 opcode;
 	int index;
 	void *param;
 	struct sock *sk;
-- 
1.7.7.1

