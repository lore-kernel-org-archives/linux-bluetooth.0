Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 1/2] Bluetooth: Add more HCI error codes
Date: Wed,  8 Aug 2012 09:42:32 +0200
Message-Id: <1344411753-10124-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add more HCI error codes as defined in the specification.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 include/net/bluetooth/hci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f19556..7253bdd 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -302,8 +302,11 @@ enum {
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
+#define HCI_ERROR_CONNECTION_TIMEOUT	0x08
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
+#define HCI_ERROR_REMOTE_LOW_RESOURCES	0x14
+#define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
 
-- 
1.7.7.6

