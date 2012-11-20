Return-Path: <cyrus@holtmann.org>
Message-id: <50AB934C.4000203@samsung.com>
Date: Tue, 20 Nov 2012 15:27:24 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [RFC]  Bluetooth:  Provide mgmt API for reading list of supported
 codecs
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide an API for allowing user space to read the list of codecs
supported by a given controller.  For now the list is hardwired in
hci_core but later devices that support the appropriate HCI command
will read out the actual list during controller initialisation.

The intention is that this should be used together with the socket
options that I mailed out a diff for earlier.

Comments?

Specifically, I wonder if it is too much to embed the codecs buffer
in the structure since most of the time very little of it will be
used.

Maybe this needs to be split into multiple diffs, but for now here
it is in one go.

-m.

---
  include/net/bluetooth/hci.h      |    9 +++++++++
  include/net/bluetooth/hci_core.h |    2 ++
  include/net/bluetooth/mgmt.h     |    7 +++++++
  net/bluetooth/hci_core.c         |    5 +++++
  net/bluetooth/mgmt.c             |   36 
++++++++++++++++++++++++++++++++++++
  5 files changed, 59 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 45eee08..9455cbe 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -283,6 +283,15 @@ enum {
  #define HCI_LM_RELIABLE	0x0010
  #define HCI_LM_SECURE	0x0020

+/* Coding Format */
+#define HCI_FORMAT_ULAW		0x00
+#define HCI_FORMAT_ALAW		0x01
+#define HCI_FORMAT_CVSD		0x02
+#define HCI_FORMAT_TRANSPARENT	0x03
+#define HCI_FORMAT_PCM		0x04
+#define HCI_FORMAT_MSBC		0x05
+#define HCI_FORMAT_VENDOR	0xff
+
  /* Authentication types */
  #define HCI_AT_NO_BONDING		0x00
  #define HCI_AT_NO_BONDING_MITM		0x01
diff --git a/include/net/bluetooth/hci_core.h 
b/include/net/bluetooth/hci_core.h
index ef5b85d..79fe128 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -153,6 +153,8 @@ struct hci_dev {
  	__u8		features[8];
  	__u8		host_features[8];
  	__u8		commands[64];
+	__u8		codecs;
+	__u8		codec[255];
  	__u8		hci_ver;
  	__u16		hci_rev;
  	__u8		lmp_ver;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 22980a7..523dc58 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -350,6 +350,13 @@ struct mgmt_cp_set_device_id {
  } __packed;
  #define MGMT_SET_DEVICE_ID_SIZE		8

+#define MGMT_OP_READ_CODECS		0x0029
+#define MGMT_READ_CODECS_SIZE		0
+struct mgmt_rp_read_codecs {
+	__u8	count;
+	__u8	codec[0];
+} __packed;
+
  #define MGMT_EV_CMD_COMPLETE		0x0001
  struct mgmt_ev_cmd_complete {
  	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3a49db..cbc7c62 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1706,6 +1706,11 @@ struct hci_dev *hci_alloc_dev(void)
  	hdev->sniff_max_interval = 800;
  	hdev->sniff_min_interval = 80;

+	hdev->codecs = 3;
+	hdev->codec[0] = HCI_FORMAT_CVSD;
+	hdev->codec[1] = HCI_FORMAT_PCM;
+	hdev->codec[2] = HCI_FORMAT_TRANSPARENT;
+
  	mutex_init(&hdev->lock);
  	mutex_init(&hdev->req_lock);

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dedbb1d..a47fda2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -76,6 +76,7 @@ static const u16 mgmt_commands[] = {
  	MGMT_OP_BLOCK_DEVICE,
  	MGMT_OP_UNBLOCK_DEVICE,
  	MGMT_OP_SET_DEVICE_ID,
+	MGMT_OP_READ_CODECS,
  };

  static const u16 mgmt_events[] = {
@@ -319,6 +320,40 @@ static int read_commands(struct sock *sk, struct 
hci_dev *hdev, void *data,
  	return err;
  }

+static int read_codecs(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 len)
+{
+	struct mgmt_rp_read_codecs *rp;
+	int err;
+	size_t rp_size;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	hci_dev_lock(hdev);
+
+	rp_size = sizeof(*rp) + hdev->codecs;
+
+	rp = kmalloc(rp_size, GFP_KERNEL);
+	if (!rp) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	memset(rp, 0, sizeof(rp));
+
+	rp->count = hdev->codecs;
+	memcpy(rp->codec, hdev->codec, hdev->codecs);
+
+	hci_dev_unlock(hdev);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_READ_CODECS, 0, rp,
+			    rp_size);
+
+	kfree(rp);
+
+	return err;
+}
+
  static int read_index_list(struct sock *sk, struct hci_dev *hdev, void 
*data,
  			   u16 data_len)
  {
@@ -2748,6 +2783,7 @@ static const struct mgmt_handler {
  	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
  	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
  	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ read_codecs,            true,  MGMT_READ_CODECS_SIZE },
  };


-- 
1.7.9.5
