Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 14/16] Bluetooth: EWS: define L2CAP header sizes
Date: Tue, 11 Oct 2011 13:37:54 +0300
Message-Id: <1318329476-30153-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds definitins for L2CAP header sizes to be uses when calculating
payload size instead of magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b3ae9ea..ebd6392 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -164,6 +164,12 @@ struct l2cap_hdr {
 	__le16     cid;
 } __packed;
 #define L2CAP_HDR_SIZE		4
+#define L2CAP_ENH_HDR_SIZE	6
+#define L2CAP_EXT_HDR_SIZE	8
+
+#define L2CAP_FCS_SIZE		2
+#define L2CAP_SDULEN_SIZE	2
+#define L2CAP_PSMLEN_SIZE	2
 
 struct l2cap_cmd_hdr {
 	__u8       code;
-- 
1.7.4.1

