Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [RFC 1/3] Bluetooth:  Add HCI feature bit definition for transparent SCO
Date: Thu, 22 Nov 2012 13:05:06 +0100
Message-Id: <1353585909-28400-2-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
References: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/net/bluetooth/hci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 45eee08..45ec1de 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -233,6 +233,7 @@ enum {
 #define LMP_CVSD	0x01
 #define LMP_PSCHEME	0x02
 #define LMP_PCONTROL	0x04
+#define LMP_TRSP_SCO	0x08
 
 #define LMP_RSSI_INQ	0x40
 #define LMP_ESCO	0x80
-- 
1.7.9.5

