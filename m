Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
Subject: [PATCH 1/3] Checkpatch.pl: Fixup hci_conn.c
Date: Mon,  9 Mar 2009 20:55:27 +0100
Message-Id: <1236628529-23819-2-git-send-email-erik.andren@gmail.com>
In-Reply-To: <1236628529-23819-1-git-send-email-erik.andren@gmail.com>
References: <1>
 <1236628529-23819-1-git-send-email-erik.andren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Erik Andrén <erik.andren@gmail.com>
---
 net/bluetooth/hci_conn.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1181db0..437da1e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -36,10 +36,10 @@
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -66,7 +66,8 @@ void hci_acl_connect(struct hci_conn *conn)
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst))) {
+	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+	if (ie) {
 		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
 			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
 			cp.pscan_mode     = ie->data.pscan_mode;
@@ -341,8 +342,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
-	if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
-		if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
+	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
+	if (!acl) {
+		acl = hci_conn_add(hdev, ACL_LINK, dst)
+		if (!acl)
 			return NULL;
 	}
 
@@ -357,8 +360,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	if (type == ACL_LINK)
 		return acl;
 
-	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
-		if (!(sco = hci_conn_add(hdev, type, dst))) {
+	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
+	if (!sco) {
+		sco = hci_conn_add(hdev, type, dst);
+		if (!sco) {
 			hci_conn_put(acl);
 			return NULL;
 		}
@@ -599,10 +604,12 @@ int hci_get_conn_list(void __user *arg)
 
 	size = sizeof(req) + req.conn_num * sizeof(*ci);
 
-	if (!(cl = kmalloc(size, GFP_KERNEL)))
+	cl = kmalloc(size, GFP_KERNEL);
+	if (!cl)
 		return -ENOMEM;
 
-	if (!(hdev = hci_dev_get(req.dev_id))) {
+	hdev = hci_dev_get(req.dev_id);
+	if (!hdev) {
 		kfree(cl);
 		return -ENODEV;
 	}
-- 
1.5.6.3

