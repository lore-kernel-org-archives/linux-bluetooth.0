Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 08/12] Bluetooth: Add 'dst_type' field to struct hci_conn
Date: Fri,  6 May 2011 14:05:17 -0300
Message-Id: <1304701521-26459-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new field (dst_type) to the struct hci_conn which
holds the type of the destination address (bdaddr_t dst).

This approach is needed in order to use the struct hci_conn as an
abstraction of LE connections in HCI Layer.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b5c991..5e64d3f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -225,6 +225,7 @@ struct hci_conn {
 	spinlock_t	lock;
 
 	bdaddr_t	dst;
+	__u8            dst_type;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
-- 
1.7.1

