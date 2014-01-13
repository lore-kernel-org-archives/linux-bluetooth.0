Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mgmt error code for negative PIN response
Date: Mon, 13 Jan 2014 17:15:53 +0200
Message-Id: <1389626153-25740-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The NOT_PAIRED status is only really suitable for operations where being
paired is a pre-requisite. Using it e.g. for the mgmt_pair_device
command seems unintuitive. In the case that either the local or the
remote user responds with a negative PIN Code response the "PIN or Key
Missing" HCI status will be generated. This patch changes the mapping of
this status from the NOT_PAIRED mgmt status to the more intuitive
AUTH_FAILED mgmt status.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
I had trouble deciding whether we should use REJECTED or AUTH_FAILED
here, but eventually went with AUTH_FAILED. If someone thinks REJECTED
is better and has convincing reasons for it I can change it.

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4b6034fcc902..4ee07b432379 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -128,7 +128,7 @@ static u8 mgmt_status_table[] = {
 	MGMT_STATUS_FAILED,		/* Hardware Failure */
 	MGMT_STATUS_CONNECT_FAILED,	/* Page Timeout */
 	MGMT_STATUS_AUTH_FAILED,	/* Authentication Failed */
-	MGMT_STATUS_NOT_PAIRED,		/* PIN or Key Missing */
+	MGMT_STATUS_AUTH_FAILED,	/* PIN or Key Missing */
 	MGMT_STATUS_NO_RESOURCES,	/* Memory Full */
 	MGMT_STATUS_TIMEOUT,		/* Connection Timeout */
 	MGMT_STATUS_NO_RESOURCES,	/* Max Number of Connections */
-- 
1.8.4.2

