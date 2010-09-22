Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/2] Add BT read clock and get conn handle to hciops
Date: Tue, 21 Sep 2010 22:22:25 -0300
Message-Id: <1285118546-29558-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c    |   25 +++++++++++++++++++++++++
 src/adapter.h    |    9 +++++++++
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index f1e9f69..faac4ce 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -748,6 +748,48 @@ static int hciops_fast_connectable(int index, gboolean enable)
 	return err;
 }
 
+static int hciops_read_clock(int index, int handle, int which, int timeout,
+				uint32_t *clock, uint16_t *accuracy)
+{
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	if (hci_read_clock(dd, handle, which, clock, accuracy, timeout))
+		err = errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
+static int hciops_conn_handle(int index, const bdaddr_t *bdaddr, int *handle)
+{
+	struct hci_conn_info_req *cr;
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	cr = g_malloc0(sizeof(*cr) + sizeof(struct hci_conn_info));
+	bacpy(&cr->bdaddr, bdaddr);
+	cr->type = ACL_LINK;
+
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr))
+		err = errno;
+
+	if (!err)
+		*handle = htobs(cr->conn_info->handle);
+
+	hci_close_dev(dd);
+	g_free(cr);
+
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -765,6 +807,8 @@ static struct btd_adapter_ops hci_ops = {
 	.read_name = hciops_read_name,
 	.set_class = hciops_set_class,
 	.set_fast_connectable = hciops_fast_connectable,
+	.read_clock = hciops_read_clock,
+	.get_conn_handle = hciops_conn_handle,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 670b8bd..9121c20 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3519,3 +3519,28 @@ int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 
 	return adapter_ops->set_fast_connectable(adapter->dev_id, enable);
 }
+
+int btd_adapter_read_clock(struct btd_adapter *adapter, int handle, int which,
+			int timeout, uint32_t *clock, uint16_t *accuracy)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->read_clock(adapter->dev_id, handle, which,
+						timeout, clock, accuracy);
+}
+
+int btd_adapter_get_conn_handle(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, int *handle)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->get_conn_handle(adapter->dev_id, bdaddr, handle);
+}
diff --git a/src/adapter.h b/src/adapter.h
index fb52b34..5eceaee 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -187,6 +187,9 @@ struct btd_adapter_ops {
 	int (*read_name) (int index);
 	int (*set_class) (int index, uint32_t class);
 	int (*set_fast_connectable) (int index, gboolean enable);
+	int (*read_clock) (int index, int handle, int which, int timeout,
+				 uint32_t *clock, uint16_t *accuracy);
+	int (*get_conn_handle) (int index, const bdaddr_t *bdaddr, int *handle);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
@@ -205,3 +208,9 @@ void btd_adapter_unregister_powered_callback(struct btd_adapter *adapter,
  * type to default values. Valid for both connectable and discoverable modes. */
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable);
+
+int btd_adapter_read_clock(struct btd_adapter *adapter, int handle, int which,
+						int timeout, uint32_t *clock,
+						uint16_t *accuracy);
+int btd_adapter_get_conn_handle(struct btd_adapter *adapter,
+				const bdaddr_t *bdaddr, int *handle);
-- 
1.7.0.4

