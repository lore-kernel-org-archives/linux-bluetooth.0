Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Allow mgmt_device_found events for kernel-side scanning
Date: Wed,  2 Jul 2014 22:42:01 +0300
Message-Id: <1404330122-18770-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
References: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the kernel is doing LE scanning because of one or more devices
added with action 0x00 through the Add Device command we do want to let
mgmt_device_found() to proceed with sending an event. This kind of
devices are tracked with hdev->pend_le_reports, so check this value
before bailing out from the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1a78d26b0049..189cf0a7fbb2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6401,8 +6401,16 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	struct smp_irk *irk;
 	size_t ev_size;
 
-	if (!hci_discovery_active(hdev))
-		return;
+	/* Don't send events for a non-kernel initiated discovery. With
+	 * LE one exception is if we have pend_le_reports > 0 in which
+	 * case we're doing passive scanning and want these events.
+	 */
+	if (!hci_discovery_active(hdev)) {
+		if (link_type == ACL_LINK)
+			return;
+		if (link_type == LE_LINK && !hdev->pend_le_reports)
+			return;
+	}
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
 	 * are for the potential CoD field.
-- 
1.9.3

