Return-Path: <paulmcquad@gmail.com>
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Use tabs where possible
Date: Mon, 19 Mar 2018 11:32:20 +0000
Message-Id: <20180319113222.6725-2-paulmcquad@gmail.com>
In-Reply-To: <20180319113222.6725-1-paulmcquad@gmail.com>
References: <20180319113222.6725-1-paulmcquad@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

code indent should use tabs where possible

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
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
2.16.2
