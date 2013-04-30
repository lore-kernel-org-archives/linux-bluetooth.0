Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 14/14] Bluetooth: Mgmt Device Found Event
Date: Tue, 30 Apr 2013 15:29:40 -0300
Message-Id: <1367346580-6647-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We only want to send Mgmt Device Found Events if we are running the
Device Discovery procedure (started by the MGMT Start Discovery
Command). Inquiry or LE scanning triggered by HCI raw interface (e.g.
hcitool) or kernel internals should not send Mgmt Device Found Events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 83db6e8..8567764 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4159,6 +4159,9 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
 
+	if (!hci_discovery_active(hdev))
+		return -EPERM;
+
 	/* Leave 5 bytes for a potential CoD field */
 	if (sizeof(*ev) + eir_len + 5 > sizeof(buf))
 		return -EINVAL;
-- 
1.8.2.1

