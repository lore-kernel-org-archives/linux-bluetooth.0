Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] btio: Add BtIOMode enum to be used with BT_IO_OPT_MODE
Date: Thu,  2 Feb 2012 13:57:05 -0800
Message-Id: <1328219827-2611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 btio/btio.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/btio/btio.h b/btio/btio.h
index 126d5d9..429e8c0 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -77,6 +77,14 @@ typedef enum {
 	BT_IO_SEC_HIGH,
 } BtIOSecLevel;
 
+typedef enum {
+	BT_IO_MODE_BASIC = 0,
+	BT_IO_MODE_RETRANS,
+	BT_IO_MODE_FLOWCTL,
+	BT_IO_MODE_ERTM,
+	BT_IO_MODE_STREAMING
+} BtIOMode;
+
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
 
 typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_data);
-- 
1.7.7.6

