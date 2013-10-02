Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable -D__CHECK_ENDIAN__ for sparse by default
Date: Tue,  1 Oct 2013 23:06:47 -0700
Message-Id: <1380694007-7946-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth protocol and hardware is pretty much all little endian
and so when running sparse via "make C=2" for example, enable the
endian checks by default.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Makefile | 2 ++
 net/bluetooth/Makefile     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 4afae20..9fe8a87 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -30,3 +30,5 @@ hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
 hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-objs				:= $(hci_uart-y)
+
+ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index dea6a28..6a791e7 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
 	a2mp.o amp.o
+
+subdir-ccflags-y += -D__CHECK_ENDIAN__
-- 
1.8.3.1

