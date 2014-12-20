Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add skeleton functions for debugfs creation
Date: Sat, 20 Dec 2014 16:05:13 +0100
Message-Id: <1419087916-8968-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The debugfs file creation has been part of the core initialization
handling of controllers. With the introduction of Bluetooth 4.2 core
specification, the number of debugfs files is increasing even further.

To avoid cluttering the core controller handling, create a separate
file hci_debugfs.c to centralize all debugfs file creation. For now
leave the current files in the core, but in the future all debugfs
file creation will be moved.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Makefile      |  2 +-
 net/bluetooth/hci_core.c    |  7 +++++++
 net/bluetooth/hci_debugfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_debugfs.h | 25 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 net/bluetooth/hci_debugfs.c
 create mode 100644 net/bluetooth/hci_debugfs.h

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 0a176fc9e291..364cff1ad4b1 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,6 +13,6 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o ecc.o hci_request.o
+	a2mp.o amp.o ecc.o hci_request.o hci_debugfs.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 91dca121dbb6..b3ab2bfb3f86 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -38,6 +38,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
+#include "hci_debugfs.h"
 #include "smp.h"
 
 static void hci_rx_work(struct work_struct *work);
@@ -1865,6 +1866,8 @@ static int __hci_init(struct hci_dev *hdev)
 	debugfs_create_file("conn_info_max_age", 0644, hdev->debugfs, hdev,
 			    &conn_info_max_age_fops);
 
+	hci_debugfs_create_common(hdev);
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
@@ -1874,6 +1877,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &dev_class_fops);
 		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
 				    hdev, &voice_setting_fops);
+
+		hci_debugfs_create_bredr(hdev);
 	}
 
 	if (lmp_ssp_capable(hdev)) {
@@ -1944,6 +1949,8 @@ static int __hci_init(struct hci_dev *hdev)
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
 
+		hci_debugfs_create_le(hdev);
+
 		smp_register(hdev);
 	}
 
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
new file mode 100644
index 000000000000..b8cf0734cc3d
--- /dev/null
+++ b/net/bluetooth/hci_debugfs.c
@@ -0,0 +1,41 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2014 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#include <linux/debugfs.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_debugfs.h"
+
+void hci_debugfs_create_common(struct hci_dev *hdev)
+{
+}
+
+void hci_debugfs_create_bredr(struct hci_dev *hdev)
+{
+}
+
+void hci_debugfs_create_le(struct hci_dev *hdev)
+{
+}
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
new file mode 100644
index 000000000000..f191100b50c5
--- /dev/null
+++ b/net/bluetooth/hci_debugfs.h
@@ -0,0 +1,25 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2014 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+void hci_debugfs_create_common(struct hci_dev *hdev);
+void hci_debugfs_create_bredr(struct hci_dev *hdev);
+void hci_debugfs_create_le(struct hci_dev *hdev);
-- 
2.1.0

