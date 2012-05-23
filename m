Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/6] Bluetooth: Remove unnecessary headers include
Date: Wed, 23 May 2012 04:04:22 -0300
Message-Id: <1337756663-19805-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337756663-19805-4-git-send-email-gustavo@padovan.org>
References: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
 <1337756663-19805-2-git-send-email-gustavo@padovan.org>
 <1337756663-19805-3-git-send-email-gustavo@padovan.org>
 <1337756663-19805-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Most of the include were unnecessary or already included by some other
header.
Replace module.h by export.h where possible.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/bluetooth/btusb.c         |    8 --------
 include/net/bluetooth/bluetooth.h |    3 ---
 include/net/bluetooth/hci.h       |    1 -
 include/net/bluetooth/hci_core.h  |    1 -
 net/bluetooth/af_bluetooth.c      |   11 -----------
 net/bluetooth/bnep/core.c         |   17 -----------------
 net/bluetooth/bnep/netdev.c       |   10 +---------
 net/bluetooth/bnep/sock.c         |   18 +-----------------
 net/bluetooth/hci_conn.c          |   16 +---------------
 net/bluetooth/hci_core.c          |   23 ++---------------------
 net/bluetooth/hci_event.c         |   15 +--------------
 net/bluetooth/hci_sock.c          |   20 +-------------------
 net/bluetooth/hci_sysfs.c         |    4 ----
 net/bluetooth/hidp/core.c         |   19 -------------------
 net/bluetooth/hidp/sock.c         |   16 +---------------
 net/bluetooth/l2cap_core.c        |   19 -------------------
 net/bluetooth/l2cap_sock.c        |    1 -
 net/bluetooth/lib.c               |    7 +------
 net/bluetooth/mgmt.c              |    2 --
 net/bluetooth/rfcomm/core.c       |   14 --------------
 net/bluetooth/rfcomm/sock.c       |   21 +--------------------
 net/bluetooth/rfcomm/tty.c        |    5 -----
 net/bluetooth/sco.c               |   18 ------------------
 net/bluetooth/smp.c               |    7 ++++---
 24 files changed, 14 insertions(+), 262 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cb480f1..249dee3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -21,15 +21,7 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-
 #include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7a9f961..565d4be 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -25,9 +25,6 @@
 #ifndef __BLUETOOTH_H
 #define __BLUETOOTH_H
 
-#include <linux/types.h>
-#include <asm/byteorder.h>
-#include <linux/list.h>
 #include <linux/poll.h>
 #include <net/sock.h>
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1f18f2e..cbb47b1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1290,7 +1290,6 @@ struct hci_sco_hdr {
 	__u8	dlen;
 } __packed;
 
-#include <linux/skbuff.h>
 static inline struct hci_event_hdr *hci_event_hdr(const struct sk_buff *skb)
 {
 	return (struct hci_event_hdr *) skb->data;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56667f7..4ecc1d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -25,7 +25,6 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
-#include <linux/interrupt.h>
 #include <net/bluetooth/hci.h>
 
 /* HCI priority */
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index e31a20f..2517472 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -25,18 +25,7 @@
 /* Bluetooth address family and sockets. */
 
 #include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/skbuff.h>
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <net/sock.h>
 #include <asm/ioctls.h>
-#include <linux/kmod.h>
 
 #include <net/bluetooth/bluetooth.h>
 
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 4fcb798..b190b7e 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -26,26 +26,9 @@
 */
 
 #include <linux/module.h>
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/init.h>
-#include <linux/wait.h>
-#include <linux/freezer.h>
-#include <linux/errno.h>
-#include <linux/net.h>
-#include <linux/slab.h>
 #include <linux/kthread.h>
-#include <net/sock.h>
-
-#include <linux/socket.h>
 #include <linux/file.h>
-
-#include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index 46c9ece..98f86f9 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -25,16 +25,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include <linux/socket.h>
-#include <linux/netdevice.h>
+#include <linux/export.h>
 #include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/wait.h>
-
-#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 180bfc4..5e5f5b4 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -24,24 +24,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/skbuff.h>
-#include <linux/socket.h>
-#include <linux/ioctl.h>
+#include <linux/export.h>
 #include <linux/file.h>
-#include <linux/init.h>
-#include <linux/compat.h>
-#include <linux/gfp.h>
-#include <linux/uaccess.h>
-#include <net/sock.h>
-
 
 #include "bnep.h"
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fc39c02..6c03b25 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -24,21 +24,7 @@
 
 /* Bluetooth HCI connection handling. */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/interrupt.h>
-#include <net/sock.h>
-
-#include <linux/uaccess.h>
-#include <asm/unaligned.h>
+#include <linux/export.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 738d983..ba77576 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -25,28 +25,9 @@
 
 /* Bluetooth HCI core. */
 
-#include <linux/jiffies.h>
-#include <linux/module.h>
-#include <linux/kmod.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-#include <linux/rfkill.h>
-#include <linux/timer.h>
-#include <linux/crypto.h>
-#include <net/sock.h>
+#include <linux/export.h>
 
-#include <linux/uaccess.h>
-#include <asm/unaligned.h>
+#include <linux/rfkill.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 23f5353..8b63e70 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -24,20 +24,7 @@
 
 /* Bluetooth HCI event handling. */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/interrupt.h>
-#include <net/sock.h>
-
-#include <linux/uaccess.h>
+#include <linux/export.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9d8e1c3..a7f04de 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -24,25 +24,7 @@
 
 /* Bluetooth HCI sockets. */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/workqueue.h>
-#include <linux/interrupt.h>
-#include <linux/compat.h>
-#include <linux/socket.h>
-#include <linux/ioctl.h>
-#include <net/sock.h>
-
-#include <linux/uaccess.h>
+#include <linux/export.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ee8d9ea..a20e61c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -1,10 +1,6 @@
 /* Bluetooth HCI driver model support. */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
 #include <linux/module.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 4c51e96..41a0564 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -21,27 +21,8 @@
 */
 
 #include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/freezer.h>
-#include <linux/fcntl.h>
-#include <linux/skbuff.h>
-#include <linux/socket.h>
-#include <linux/ioctl.h>
 #include <linux/file.h>
-#include <linux/init.h>
-#include <linux/wait.h>
-#include <linux/mutex.h>
 #include <linux/kthread.h>
-#include <net/sock.h>
-
-#include <linux/input.h>
-#include <linux/hid.h>
 #include <linux/hidraw.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 73a32d7..18b3f68 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -20,22 +20,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/skbuff.h>
-#include <linux/socket.h>
-#include <linux/ioctl.h>
+#include <linux/export.h>
 #include <linux/file.h>
-#include <linux/init.h>
-#include <linux/compat.h>
-#include <linux/gfp.h>
-#include <net/sock.h>
 
 #include "hidp.h"
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b644f40..86b69b7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -30,27 +30,8 @@
 
 #include <linux/module.h>
 
-#include <linux/types.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/socket.h>
-#include <linux/skbuff.h>
-#include <linux/list.h>
-#include <linux/device.h>
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/uaccess.h>
 #include <linux/crc16.h>
-#include <net/sock.h>
-
-#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3bb1611..4d36605 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -27,7 +27,6 @@
 
 /* Bluetooth L2CAP sockets. */
 
-#include <linux/security.h>
 #include <linux/export.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 994bc3c..e1c9752 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -26,12 +26,7 @@
 
 #define pr_fmt(fmt) "Bluetooth: " fmt
 
-#include <linux/module.h>
-
-#include <linux/kernel.h>
-#include <linux/stddef.h>
-#include <linux/string.h>
-#include <linux/errno.h>
+#include <linux/export.h>
 
 #include <net/bluetooth/bluetooth.h>
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8400bc..a0200fa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -24,8 +24,6 @@
 
 /* Bluetooth HCI Management interface */
 
-#include <linux/kernel.h>
-#include <linux/uaccess.h>
 #include <linux/module.h>
 #include <asm/unaligned.h>
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 585d391..c75107e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -26,22 +26,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/init.h>
-#include <linux/wait.h>
-#include <linux/device.h>
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/net.h>
-#include <linux/mutex.h>
 #include <linux/kthread.h>
-#include <linux/slab.h>
-
-#include <net/sock.h>
-#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index e8707de..7e1e596 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -25,27 +25,8 @@
  * RFCOMM sockets.
  */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/socket.h>
-#include <linux/skbuff.h>
-#include <linux/list.h>
-#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/security.h>
-#include <net/sock.h>
-
-#include <linux/uaccess.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c91e233..fc4b361 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -31,11 +31,6 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 
-#include <linux/capability.h>
-#include <linux/slab.h>
-#include <linux/skbuff.h>
-#include <linux/workqueue.h>
-
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/rfcomm.h>
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6401cca..40bbe25 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -25,26 +25,8 @@
 /* Bluetooth SCO sockets. */
 
 #include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fcntl.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/socket.h>
-#include <linux/skbuff.h>
-#include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/list.h>
-#include <linux/security.h>
-#include <net/sock.h>
-
-#include <linux/uaccess.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6fc7c47..ff4835b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -20,14 +20,15 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/crypto.h>
+#include <linux/scatterlist.h>
+#include <crypto/b128ops.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/smp.h>
-#include <linux/crypto.h>
-#include <linux/scatterlist.h>
-#include <crypto/b128ops.h>
 
 #define SMP_TIMEOUT	msecs_to_jiffies(30000)
 
-- 
1.7.10.1

