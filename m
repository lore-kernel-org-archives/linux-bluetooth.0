Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 06/17] Bluetooth: AMP: Physical link struct and heplers
Date: Mon, 17 Sep 2012 16:24:23 +0300
Message-Id: <1347888274-30779-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define physical link structures. Physical links are represented by
hci_conn structure. For BR/EDR we use type ACL_LINK and for AMP
we use AMP_LINK.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/pal.h      |   26 +++++++++++++++++++++++
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |    1 +
 net/bluetooth/pal.c              |   43 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/pal.c

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1cb8b55..4c41b8c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -207,6 +207,7 @@ enum {
 #define ESCO_LINK	0x02
 /* Low Energy links do not have defined link type. Use invented one */
 #define LE_LINK		0x80
+#define AMP_LINK	0x81
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1174218..a1cda4d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -316,6 +316,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	__u8		remote_id;
 	bool		flush_key;
 
 	unsigned int	sent;
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
new file mode 100644
index 0000000..a0f441b
--- /dev/null
+++ b/include/net/bluetooth/pal.h
@@ -0,0 +1,26 @@
+/*
+   Copyright (c) 2011,2012 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#ifndef __PAL_H
+#define __PAL_H
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
+
+struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
+			     u8 remote_id);
+
+#endif /* __PAL_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index dea6a28..3f76fc2 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o
+	a2mp.o amp.o pal.o
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f04c441..ec0e9c3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -17,6 +17,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/amp.h>
+#include <net/bluetooth/pal.h>
 
 /* Global AMP Manager list */
 LIST_HEAD(amp_mgr_list);
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
new file mode 100644
index 0000000..9e4ea85
--- /dev/null
+++ b/net/bluetooth/pal.c
@@ -0,0 +1,43 @@
+/*
+   Copyright (c) 2011,2012 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#include <net/bluetooth/pal.h>
+
+/* Physical Link interface */
+static u8 __next_handle(struct amp_mgr *mgr)
+{
+	if (++mgr->handle == 0)
+		mgr->handle = 1;
+
+	return mgr->handle;
+}
+
+struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
+			     u8 remote_id)
+{
+	bdaddr_t *dst = mgr->l2cap_conn->dst;
+	struct hci_conn *hcon;
+
+	hcon = hci_conn_add(hdev, AMP_LINK, dst);
+	if (!hcon)
+		return NULL;
+
+	hcon->state = BT_CONNECT;
+	hcon->out = true;
+	hcon->attempt++;
+	hcon->handle = __next_handle(mgr);
+	hcon->remote_id = remote_id;
+	hcon->amp_mgr = mgr;
+
+	return hcon;
+}
-- 
1.7.9.5

