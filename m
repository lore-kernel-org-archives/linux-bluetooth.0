Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v6 1/6] Add initial support for Out of Band (OOB) association model
Date: Thu, 24 Mar 2011 14:47:34 +0100
Message-ID: <1300974459-24076-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am       |    3 ++-
 plugins/hciops.c  |   31 +++++++++++++++++++++++++++++++
 plugins/mgmtops.c |   31 +++++++++++++++++++++++++++++++
 src/adapter.c     |   18 ++++++++++++++++++
 src/adapter.h     |   12 ++++++++++++
 src/oob.c         |   43 +++++++++++++++++++++++++++++++++++++++++++
 src/oob.h         |   30 ++++++++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 1 deletions(-)
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h

diff --git a/Makefile.am b/Makefile.am
index 2994bf9..0ed2acf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -259,7 +259,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/event.h src/event.c
+			src/event.h src/event.c \
+			src/oob.h src/oob.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 69627eb..3dbb381 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3555,6 +3555,34 @@ static int hciops_cancel_bonding(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hciops_read_local_oob_data (int index)
+{
+	DBG("hci%d", index);
+
+	return -ENOSYS;
+}
+
+static int hciops_add_remote_oob_data (int index, bdaddr_t *bdaddr,
+					uint8_t *hash, uint8_t *randomizer)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("hci%d bdaddr %s", index, addr);
+
+	return -ENOSYS;
+}
+
+static int hciops_remove_remote_oob_data (int index, bdaddr_t *bdaddr)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("hci%d bdaddr %s", index, addr);
+
+	return -ENOSYS;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -3594,6 +3622,9 @@ static struct btd_adapter_ops hci_ops = {
 	.set_io_capability = hciops_set_io_capability,
 	.create_bonding = hciops_create_bonding,
 	.cancel_bonding = hciops_cancel_bonding,
+	.read_local_oob_data = hciops_read_local_oob_data,
+	.add_remote_oob_data = hciops_add_remote_oob_data,
+	.remove_remote_oob_data = hciops_remove_remote_oob_data,
 };
 
 static int hciops_init(void)
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 0c376f7..c8e8f14 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1748,6 +1748,34 @@ static int mgmt_cancel_bonding(int index, bdaddr_t *bdaddr)
 	return -ENOSYS;
 }
 
+static int mgmt_read_local_oob_data (int index)
+{
+	DBG("hci%d", index);
+
+	return -ENOSYS;
+}
+
+static int mgmt_add_remote_oob_data (int index, bdaddr_t *bdaddr,
+					uint8_t *hash, uint8_t *randomizer)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("hci%d bdaddr %s", index, addr);
+
+	return -ENOSYS;
+}
+
+static int mgmt_remove_remote_oob_data (int index, bdaddr_t *bdaddr)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("hci%d bdaddr %s", index, addr);
+
+	return -ENOSYS;
+}
+
 static struct btd_adapter_ops mgmt_ops = {
 	.setup = mgmt_setup,
 	.cleanup = mgmt_cleanup,
@@ -1787,6 +1815,9 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_io_capability = mgmt_set_io_capability,
 	.create_bonding = mgmt_create_bonding,
 	.cancel_bonding = mgmt_cancel_bonding,
+	.read_local_oob_data = mgmt_read_local_oob_data,
+	.add_remote_oob_data = mgmt_add_remote_oob_data,
+	.remove_remote_oob_data = mgmt_remove_remote_oob_data,
 };
 
 static int mgmt_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 691b963..ffd3bf4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3729,3 +3729,21 @@ int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 {
 	return adapter_ops->cancel_bonding(adapter->dev_id, bdaddr);
 }
+
+int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
+{
+	return adapter_ops->read_local_oob_data(adapter->dev_id);
+}
+
+int btd_adapter_add_remote_oob_data (struct btd_adapter *adapter,
+			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer)
+{
+	return adapter_ops->add_remote_oob_data(adapter->dev_id, bdaddr, hash,
+								randomizer);
+}
+
+int btd_adapter_remove_remote_oob_data (struct btd_adapter *adapter,
+							bdaddr_t *bdaddr)
+{
+	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 8bc687d..377908b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -237,6 +237,10 @@ struct btd_adapter_ops {
 	int (*set_io_capability) (int index, uint8_t io_capability);
 	int (*create_bonding) (int index, bdaddr_t *bdaddr, uint8_t io_cap);
 	int (*cancel_bonding) (int index, bdaddr_t *bdaddr);
+	int (*read_local_oob_data) (int index);
+	int (*add_remote_oob_data) (int index, bdaddr_t *bdaddr, uint8_t *hash,
+							uint8_t *randomizer);
+	int (*remove_remote_oob_data) (int index, bdaddr_t *bdaddr);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
@@ -288,3 +292,11 @@ int adapter_create_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							uint8_t io_cap);
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
+
+int btd_adapter_read_local_oob_data (struct btd_adapter *adapter);
+
+int btd_adapter_add_remote_oob_data (struct btd_adapter *adapter,
+			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer);
+
+int btd_adapter_remove_remote_oob_data (struct btd_adapter *adapter,
+							bdaddr_t *bdaddr);
diff --git a/src/oob.c b/src/oob.c
new file mode 100644
index 0000000..56b76ec
--- /dev/null
+++ b/src/oob.c
@@ -0,0 +1,43 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  ST-Ericsson SA
+ *
+ *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "adapter.h"
+#include "oob.h"
+
+static void (*local_oob_read_cb)(struct btd_adapter *adapter, uint8_t *hash,
+		uint8_t *randomizer) = NULL;
+
+void oob_register_cb( void (*cb)(struct btd_adapter *adapter, uint8_t *hash,
+							uint8_t *randomizer))
+{
+	local_oob_read_cb = cb;
+}
+
+void oob_local_data_read(struct btd_adapter *adapter, uint8_t *hash,
+							uint8_t *randomizer)
+{
+	if (local_oob_read_cb)
+		local_oob_read_cb(adapter, hash, randomizer);
+}
diff --git a/src/oob.h b/src/oob.h
new file mode 100644
index 0000000..975cb71
--- /dev/null
+++ b/src/oob.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  ST-Ericsson SA
+ *
+ *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+void oob_register_cb( void (*cb)(struct btd_adapter *adapter, uint8_t *hash,
+							uint8_t *randomizer));
+
+void oob_local_data_read(struct btd_adapter *adapter, uint8_t *hash,
+							uint8_t *randomizer);
-- 
1.7.0.4

