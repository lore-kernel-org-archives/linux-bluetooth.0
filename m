Return-Path: <cyrus@holtmann.org>
From: Matthew Garrett <mjg@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-usb@vger.kernel.org, marcel@holtmann.org,
        Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/3] bluetooth: Take a runtime pm reference on hid connections
Date: Thu, 16 Sep 2010 13:58:13 -0400
Message-Id: <1284659895-27984-1-git-send-email-mjg@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth runtime PM interacts badly with input devices - the connection
will be dropped if the device becomes idle, resulting in noticable lag when
the user interacts with the input device again. Bump the pm runtime count
when the device is associated and release it when it's disassociated in
order to avoid this.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 net/bluetooth/hidp/core.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bfe641b..a4489a7 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -36,6 +36,7 @@
 #include <linux/file.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/pm_runtime.h>
 #include <net/sock.h>
 
 #include <linux/input.h>
@@ -622,6 +623,14 @@ static int hidp_session(void *arg)
 	return 0;
 }
 
+static struct hci_dev *hidp_get_hci(struct hidp_session *session)
+{
+	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
+	bdaddr_t *dst = &bt_sk(session->ctrl_sock->sk)->dst;
+
+	return hci_get_route(dst, src);
+}
+
 static struct device *hidp_get_device(struct hidp_session *session)
 {
 	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
@@ -819,6 +828,7 @@ fault:
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
+	struct hci_dev *hdev;
 	int err;
 
 	BT_DBG("");
@@ -889,6 +899,10 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 		hidp_input_event(session->input, EV_LED, 0, 0);
 	}
 
+	hdev = hidp_get_hci(session);
+	pm_runtime_get(hdev->parent);
+	hci_dev_put(hdev);
+
 	up_write(&hidp_session_sem);
 	return 0;
 
@@ -925,6 +939,7 @@ failed:
 int hidp_del_connection(struct hidp_conndel_req *req)
 {
 	struct hidp_session *session;
+	struct hci_dev *hdev;
 	int err = 0;
 
 	BT_DBG("");
@@ -952,6 +967,9 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 	} else
 		err = -ENOENT;
 
+	hdev = hidp_get_hci(session);
+	pm_runtime_put(hdev->parent);
+	hci_dev_put(hdev);
 	up_read(&hidp_session_sem);
 	return err;
 }
-- 
1.7.2.3
