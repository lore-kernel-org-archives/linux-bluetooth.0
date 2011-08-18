Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/7] Bluetooth: L2CAP extended feature mask update
Date: Thu, 18 Aug 2011 10:44:56 +0300
Message-Id: <1313653502-6303-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Update L2CAP extended feature mask to reflect recent BT spec.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6fa1140..9850cb5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -91,13 +91,17 @@ struct l2cap_conninfo {
 #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
 #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
 
-/* L2CAP feature mask */
+/* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
 #define L2CAP_FEAT_RETRANS	0x00000002
+#define L2CAP_FEAT_BIDIR_QOS	0x00000004
 #define L2CAP_FEAT_ERTM		0x00000008
 #define L2CAP_FEAT_STREAMING	0x00000010
 #define L2CAP_FEAT_FCS		0x00000020
+#define L2CAP_FEAT_EXT_FLOW	0x00000040
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080
+#define L2CAP_FEAT_EXT_WINDOW	0x00000100
+#define L2CAP_FEAT_UCD		0x00000200
 
 /* L2CAP checksum option */
 #define L2CAP_FCS_NONE		0x00
-- 
1.7.4.1

