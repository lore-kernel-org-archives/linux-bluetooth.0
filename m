Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Add helper functions for testing bdaddr types
Date: Fri, 18 Jan 2013 15:25:54 +0200
Message-Id: <1358515558-17861-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds two helper functions to test for valid bdaddr type
values. These will be particularely useful in the mgmt code to check
that user space has passed valid values to the kernel.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2554b3f..9531bee 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -166,6 +166,29 @@ typedef struct {
 #define BDADDR_LE_PUBLIC	0x01
 #define BDADDR_LE_RANDOM	0x02
 
+static inline bool bdaddr_type_is_valid(__u8 type)
+{
+	switch (type) {
+	case BDADDR_BREDR:
+	case BDADDR_LE_PUBLIC:
+	case BDADDR_LE_RANDOM:
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool bdaddr_type_is_le(__u8 type)
+{
+	switch (type) {
+	case BDADDR_LE_PUBLIC:
+	case BDADDR_LE_RANDOM:
+		return true;
+	}
+
+	return false;
+}
+
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0} })
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff} })
 
-- 
1.7.10.4

