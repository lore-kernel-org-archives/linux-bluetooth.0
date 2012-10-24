Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Add flag for LE GAP Peripheral role
Date: Wed, 24 Oct 2012 21:12:02 +0300
Message-Id: <1351102323-4654-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
References: <1351102323-4654-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a flag to be used for LE GAP Peripheral role. In this
role undirected advertising will be enabled and operations not allowed
in Peripheral role (such as scanning and initiating connections) will be
disallowed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 348f4bf..6c414f4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -115,6 +115,7 @@ enum {
 	HCI_SSP_ENABLED,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
+	HCI_LE_PERIPHERAL,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
-- 
1.7.10.4

