Return-Path: <nunziomeli5@gmail.com>
From: Nunzio Meli <nunziomeli5@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Nunzio Meli <nunzio.meli@shazam.com>
Subject: [PATCH] substitute spaces with tabs
Date: Thu, 12 Apr 2018 23:54:33 +0100
Message-Id: <20180412225433.57726-1-nunzio.meli@shazam.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 drivers/bluetooth/hci_intel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 7c166e3b308b..2a7bdc0bad92 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -609,12 +609,12 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-        /* Check for supported iBT hardware variants of this firmware
-         * loading method.
-         *
-         * This check has been put in place to ensure correct forward
-         * compatibility options when newer hardware variants come along.
-         */
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
 	switch (ver.hw_variant) {
 	case 0x0b:	/* LnP */
 	case 0x0c:	/* WsP */
-- 
2.15.1 (Apple Git-101)
