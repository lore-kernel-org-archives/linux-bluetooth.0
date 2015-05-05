Return-Path: <cyrus@holtmann.org>
From: Leo Yan <leo.yan@linaro.org>
To: linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@ti.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] Bluetooth: btwilink: remove DEBUG define
Date: Tue,  5 May 2015 15:09:17 +0800
Message-Id: <1430809757-23282-1-git-send-email-leo.yan@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the DEBUG define as the debug code; so can remove mass debug info
from log buffer when using dmesg.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/bluetooth/btwilink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 55c135b..7a722df 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -22,7 +22,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#define DEBUG
+
 #include <linux/platform_device.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
-- 
1.9.1
