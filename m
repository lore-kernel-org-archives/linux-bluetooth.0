Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump] Change maximum pkt size for High Speed max pkt
Date: Wed, 31 Oct 2012 15:16:41 +0200
Message-Id: <1351689401-3650-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For AMP, L2CAP packets might be of bigger size, up to 1492 bytes.
Without the change hcidump cuts AMP data packets.
---
 lib/hci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index 7eacca5..d424e80 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -34,7 +34,7 @@ extern "C" {
 
 #define HCI_MAX_DEV	16
 
-#define HCI_MAX_ACL_SIZE	1024
+#define HCI_MAX_ACL_SIZE	(1492 + 4)
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
-- 
1.7.9.5

