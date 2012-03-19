Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix timeout type
Date: Mon, 19 Mar 2012 09:42:31 +0200
Message-Id: <1332142951-20703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Silence sparse warnings:
net/bluetooth/mgmt.c:865:19: warning: cast to restricted __le16

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/mgmt.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 53b8a32..23fd054 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -117,7 +117,7 @@ struct mgmt_mode {
 #define MGMT_OP_SET_DISCOVERABLE	0x0006
 struct mgmt_cp_set_discoverable {
 	__u8	val;
-	__u16	timeout;
+	__le16	timeout;
 } __packed;
 #define MGMT_SET_DISCOVERABLE_SIZE	3
 
-- 
1.7.9.1

