Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add debugfs support for max SMP key size
Date: Tue,  9 Jun 2015 12:09:50 +0300
Message-Id: <1433840990-17722-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a debugfs control to set a different maximum SMP
encryption key size. This is useful for testing that implementation of
the encryption key size handling is behaving correctly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3921cba056d3..4d5e24ec570e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -33,6 +33,9 @@
 #include "ecc.h"
 #include "smp.h"
 
+#define SMP_DEV(hdev) \
+	((struct smp_dev *)((struct l2cap_chan *)((hdev)->smp_data))->data)
+
 /* Low-level debug macros to be used for stuff that we don't want
  * accidentially in dmesg, i.e. the values of the various crypto keys
  * and the inputs & outputs of crypto functions.
@@ -81,6 +84,8 @@ struct smp_dev {
 	u8			local_rand[16];
 	bool			debug_key;
 
+	u8			max_key_size;
+
 	struct crypto_blkcipher	*tfm_aes;
 	struct crypto_hash	*tfm_cmac;
 };
@@ -708,7 +713,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = oob_flag;
-		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
+		req->max_key_size = SMP_DEV(hdev)->max_key_size;
 		req->init_key_dist = local_dist;
 		req->resp_key_dist = remote_dist;
 		req->auth_req = (authreq & AUTH_REQ_MASK(hdev));
@@ -719,7 +724,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = oob_flag;
-	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
+	rsp->max_key_size = SMP_DEV(hdev)->max_key_size;
 	rsp->init_key_dist = req->init_key_dist & remote_dist;
 	rsp->resp_key_dist = req->resp_key_dist & local_dist;
 	rsp->auth_req = (authreq & AUTH_REQ_MASK(hdev));
@@ -730,10 +735,11 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 {
 	struct l2cap_chan *chan = conn->smp;
+	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp = chan->data;
 
-	if ((max_key_size > SMP_MAX_ENC_KEY_SIZE) ||
-	    (max_key_size < SMP_MIN_ENC_KEY_SIZE))
+	if (max_key_size > SMP_DEV(hdev)->max_key_size ||
+	    max_key_size < SMP_MIN_ENC_KEY_SIZE)
 		return SMP_ENC_KEY_SIZE;
 
 	smp->enc_key_size = max_key_size;
@@ -1691,7 +1697,7 @@ static void build_bredr_pairing_cmd(struct smp_chan *smp,
 
 		req->init_key_dist   = local_dist;
 		req->resp_key_dist   = remote_dist;
-		req->max_key_size    = SMP_MAX_ENC_KEY_SIZE;
+		req->max_key_size    = SMP_DEV(hdev)->max_key_size;
 
 		smp->remote_key_dist = remote_dist;
 
@@ -1700,7 +1706,7 @@ static void build_bredr_pairing_cmd(struct smp_chan *smp,
 
 	memset(rsp, 0, sizeof(*rsp));
 
-	rsp->max_key_size    = SMP_MAX_ENC_KEY_SIZE;
+	rsp->max_key_size    = SMP_DEV(hdev)->max_key_size;
 	rsp->init_key_dist   = req->init_key_dist & remote_dist;
 	rsp->resp_key_dist   = req->resp_key_dist & local_dist;
 
@@ -3123,6 +3129,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	smp->tfm_aes = tfm_aes;
 	smp->tfm_cmac = tfm_cmac;
+	smp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 
 create_chan:
 	chan = l2cap_chan_create();
@@ -3245,6 +3252,49 @@ static const struct file_operations force_bredr_smp_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t smp_max_key_size_read(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[4];
+
+	snprintf(buf, sizeof(buf), "%2u\n", SMP_DEV(hdev)->max_key_size);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t smp_max_key_size_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf) - 1));
+	u8 key_size;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+
+	sscanf(buf, "%hhu", &key_size);
+
+	if (key_size > SMP_MAX_ENC_KEY_SIZE || key_size < SMP_MIN_ENC_KEY_SIZE)
+		return -EINVAL;
+
+	SMP_DEV(hdev)->max_key_size = key_size;
+
+	return count;
+}
+
+static const struct file_operations smp_max_key_size_fops = {
+	.open		= simple_open,
+	.read		= smp_max_key_size_read,
+	.write		= smp_max_key_size_write,
+	.llseek		= default_llseek,
+};
+
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -3269,6 +3319,9 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
+	debugfs_create_file("smp_max_key_size", 0644, hdev->debugfs,
+			    hdev, &smp_max_key_size_fops);
+
 	/* If the controller does not support BR/EDR Secure Connections
 	 * feature, then the BR/EDR SMP channel shall not be present.
 	 *
-- 
2.4.2

