Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [RFC 3/3] Bluetooth:  Provide mgmt API for reading list of supported codecs
Date: Thu, 22 Nov 2012 13:05:08 +0100
Message-Id: <1353585909-28400-4-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
References: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide an API for allowing user space to read the list of codecs
supported by a given controller.  For now, hardwire PCM support,
but construct initial list of supported codecs by inspecting the
relevant bits of the local supported features bit mask.  Later,
devices that support the appropriate HCI command will read out the
actual list during controller initialisation.
---
 include/net/bluetooth/hci_core.h |    2 ++
 include/net/bluetooth/mgmt.h     |    7 +++++++
 net/bluetooth/hci_core.c         |    3 +++
 net/bluetooth/hci_event.c        |   21 +++++++++++++++++++++
 net/bluetooth/mgmt.c             |   36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
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
index 81f4bac..9b0e974 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1708,6 +1708,9 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
+	hdev->codecs = 1;
+	hdev->codec[0] = HCI_FORMAT_PCM;
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9f5c5f2..b110aaf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -779,6 +779,27 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 	if (hdev->features[5] & LMP_EDR_3S_ESCO)
 		hdev->esco_type |= (ESCO_2EV5 | ESCO_3EV5);
 
+	/* Initialise codec list */
+	if (hdev->features[1] & LMP_ULAW) {
+		hdev->codec[hdev->codecs] = HCI_FORMAT_ULAW;
+		hdev->codecs++;
+	}
+
+	if (hdev->features[1] & LMP_ALAW) {
+		hdev->codec[hdev->codecs] = HCI_FORMAT_ALAW;
+		hdev->codecs++;
+	}
+
+	if (hdev->features[2] & LMP_CVSD) {
+		hdev->codec[hdev->codecs] = HCI_FORMAT_CVSD;
+		hdev->codecs++;
+	}
+
+	if (hdev->features[2] & LMP_TRSP_SCO) {
+		hdev->codec[hdev->codecs] = HCI_FORMAT_TRANSPARENT;
+		hdev->codecs++;
+	}
+
 	BT_DBG("%s features 0x%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x", hdev->name,
 	       hdev->features[0], hdev->features[1],
 	       hdev->features[2], hdev->features[3],
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
@@ -319,6 +320,40 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
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
 static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
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

