Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/3] Bluetooth: Validate data size before accessing mgmt commands
Date: Wed, 23 Feb 2011 16:50:40 +0100
Message-ID: <1298476240-18124-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1298476240-18124-1-git-send-email-szymon.janc@tieto.com>
References: <1298476240-18124-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Crafted (too small) data buffer could result in reading data outside of buffer.
Validate buffer size and return EINVAL if size is wrong..

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98c92ae..64d6927 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -302,6 +302,9 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_POWERED, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_POWERED, ENODEV);
@@ -351,6 +354,9 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENODEV);
@@ -409,6 +415,9 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENODEV);
@@ -499,6 +508,9 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, ENODEV);
@@ -569,6 +581,9 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_ADD_UUID, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
@@ -611,6 +626,9 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
@@ -663,6 +681,9 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("request for hci%u", index);
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, ENODEV);
@@ -692,6 +713,10 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
+									EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
@@ -726,6 +751,10 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	int i;
 
 	cp = (void *) data;
+
+	if (len < sizeof(*cp))
+		return -EINVAL;
+
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
@@ -775,6 +804,9 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, ENODEV);
@@ -821,6 +853,9 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_DISCONNECT, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_DISCONNECT, ENODEV);
@@ -931,6 +966,9 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENODEV);
@@ -975,6 +1013,10 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
+									EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
@@ -1017,6 +1059,10 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
+									EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
@@ -1107,6 +1153,9 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	cp = (void *) data;
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, EINVAL);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);
@@ -1170,6 +1219,10 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("");
 
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_REPLY,
+									EINVAL);
+
 	if (success) {
 		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
 		hci_op = HCI_OP_USER_CONFIRM_REPLY;
-- 
1.7.0.4
on behalf of ST-Ericsson
