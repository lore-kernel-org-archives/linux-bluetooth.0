Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] mgmt: Fix error code passed to bonding_complete in disconnect_complete
Date: Mon, 1 Oct 2012 09:49:23 +0200
Message-ID: <1349077763-26830-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349077763-26830-1-git-send-email-szymon.janc@tieto.com>
References: <1349077763-26830-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bonding_complete expects mgmt status code not hci error code.

---
 src/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 2472173..e368b8a 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1166,7 +1166,7 @@ static void disconnect_complete(int sk, uint16_t index, uint8_t status,
 
 	btd_event_disconn_complete(&info->bdaddr, &rp->addr.bdaddr);
 
-	bonding_complete(info, &rp->addr.bdaddr, HCI_CONNECTION_TERMINATED);
+	bonding_complete(info, &rp->addr.bdaddr, MGMT_STATUS_DISCONNECTED);
 }
 
 static void pair_device_complete(int sk, uint16_t index, uint8_t status,
-- 
1.7.9.5

