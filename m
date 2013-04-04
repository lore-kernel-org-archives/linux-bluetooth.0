Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 17/17] Bluetooth: Mgmt Device Found Event
Date: Thu,  4 Apr 2013 20:21:15 -0300
Message-Id: <1365117675-2202-18-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We only want to send Mgmt Device Found Events if we are running the
Device Discovery procedure (started by the MGMT Start Discovery
Command). Inquiry or LE scanning triggered by HCI raw interface (e.g.
hcitool) or kernel internals should not send Mgmt Device Found Events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fa726e..d322ca1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4116,6 +4116,9 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
 
+	if (!hci_discovery_active(hdev))
+		return -EPERM;
+
 	/* Leave 5 bytes for a potential CoD field */
 	if (sizeof(*ev) + eir_len + 5 > sizeof(buf))
 		return -EINVAL;
-- 
1.8.1.2

