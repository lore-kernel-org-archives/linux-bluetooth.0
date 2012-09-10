Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: marcel <marcel@holtmann.org>, albert.o.ho@intel.com
Subject: [RFC 2/3] Bluetooth: Implement Intel specific device initialization
Date: Mon, 10 Sep 2012 15:35:33 -0700
Message-ID: <3077360.7vSV2RfWaT@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch implements the Intel specific device initialization:
- Enable the device configuration mode
- Read the FW version of the device
- Open the patch file, if exists.
- Send the patch data via HCI command
- Once done, disable the device configuation mode

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb_intel.c |  322 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 321 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_intel.c b/drivers/bluetooth/btusb_intel.c
index 51c019d..d45ddb9 100644
--- a/drivers/bluetooth/btusb_intel.c
+++ b/drivers/bluetooth/btusb_intel.c
@@ -21,12 +21,38 @@
  *
  */
 #include <linux/module.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
 #include <linux/errno.h>
+#include <linux/timer.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
 #include "btusb.h"
 
+/* Intel specific HCI cmd opcodes */
+#define INTEL_HCI_MFG_MODE		0xfc11
+#define INTEL_HCI_GET_VER		0xfc05
+
+/* Intel specific HCI cmd parameter for patch reset */
+#define INTEL_HCI_PATCH_SKIP		0x00
+#define INTEL_HCI_PATCH_DISABLE		0x01
+#define INTEL_HCI_PATCH_ENABLE		0x02
+
+/* Intel specific HCI event status - success */
+#define INTEL_EV_STATUS_SUCCESS		0x00
+
+/* Intel specific patch file location and file extension */
+#define INTEL_PATCH_DIR			"intel/"
+#define INTEL_PATCH_EXT			".bseq"
+
+/* Patch entry type flag */
+#define INTEL_PATCH_TYPE_CMD		0x01
+#define INTEL_PATCH_TYPE_EVT		0x02
+
+/* Maximum length of one patch entry */
+#define INTEL_PATCH_MAX_LEN		260
+
 /* patch state */
 enum intel_patch_state {
 	INTEL_PATCH_PRE,
@@ -42,11 +68,165 @@ struct intel_patch_data {
 	struct hci_dev		*hdev;
 
 	int			state;
+	u8			patch_reset;
+
+	struct completion	wait_patch_completion;
+
+	char			device_ver[32];
+	const struct firmware	*fw;
+	const u8		*patch_curr;
+	unsigned int		patch_read;
 };
 
+static int intel_send_mfg_cmd(struct hci_dev *hdev, u8 mode, u8 reset)
+{
+	u8 param[2];
+
+	param[0] = mode;
+	param[1] = reset;
+
+	BT_DBG("mfg mode: %02x reset: %02x", mode, reset);
+
+	return hci_send_cmd(hdev, INTEL_HCI_MFG_MODE, 2, param);
+}
+
+static int intel_send_patch_cmd(struct intel_patch_data *data)
+{
+	const u8 *ptr;
+	u8 param[INTEL_PATCH_MAX_LEN];
+	u16 opcode;
+	struct hci_command_hdr *hdr;
+
+	ptr = data->patch_curr;
+	if (*ptr != INTEL_PATCH_TYPE_CMD) {
+		BT_ERR("invalid patch cmd sequence: %02x", *ptr);
+		return -EILSEQ;
+	}
+	ptr++;
+
+	hdr = (void *)ptr;
+	opcode = le16_to_cpu(hdr->opcode);
+
+	ptr += sizeof(*hdr);
+
+	/* update the data before sending the command */
+	data->patch_curr = ptr + hdr->plen;
+	data->patch_read += hdr->plen + 4;
+
+	memcpy(param, ptr, hdr->plen);
+
+	if (hci_send_cmd(data->hdev, opcode, hdr->plen, param) < 0) {
+		BT_ERR("failed to send patch cmd: %04x", opcode);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int intel_verify_cc_evt(struct sk_buff *skb, u16 opcode)
+{
+	u8 status;
+	u16 opc;
+	struct hci_ev_cmd_complete *cc;
+	struct hci_event_hdr *hdr;
+
+	hdr = (void *)skb->data;
+	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
+		BT_ERR("invalid event code: %02x", hdr->evt);
+		return -1;
+	}
+	skb_pull(skb, sizeof(*hdr));
+
+	cc = (void *)skb->data;
+	opc = le16_to_cpu(cc->opcode);
+	if (opc != opcode) {
+		BT_ERR("invalid opcode: %04x", opc);
+		return -1;
+	}
+	skb_pull(skb, sizeof(*cc));
+
+	status = *((u8 *) skb->data);
+	if (status != INTEL_EV_STATUS_SUCCESS) {
+		BT_ERR("event status failed: %02x", status);
+		return -1;
+	}
+	skb_pull(skb, 1);
+
+	return 0;
+}
+
+static int intel_verify_ver_cc_evt(struct sk_buff *skb,
+				   struct intel_patch_data *data)
+{
+	int i;
+	if (intel_verify_cc_evt(skb, INTEL_HCI_GET_VER) < 0)
+		return -1;
+
+	for (i = 0; i < skb->len; i++)
+		sprintf(&data->device_ver[i*2], "%02x", skb->data[i]);
+
+	return 0;
+}
+
+static int intel_verify_patch_evt(struct sk_buff *skb,
+				  struct intel_patch_data *data)
+{
+	const u8 *ptr;
+	struct hci_event_hdr *s_hdr;
+	struct hci_event_hdr *p_hdr;
+
+	ptr = data->patch_curr;
+	if (INTEL_PATCH_TYPE_EVT != *ptr) {
+		BT_ERR("invalid patch evt sequence: %02x", *ptr);
+		return -EILSEQ;
+	}
+	ptr++;
+
+	p_hdr = (void *)ptr;
+	s_hdr = (void *)skb->data;
+
+	if (p_hdr->evt != s_hdr->evt || p_hdr->plen != s_hdr->plen) {
+		BT_ERR("mismatch evt hdr: %02x %02x", s_hdr->evt, s_hdr->plen);
+		return -1;
+	}
+
+	ptr += sizeof(*p_hdr);
+	skb_pull(skb, sizeof(*s_hdr));
+
+	data->patch_curr = ptr + p_hdr->plen;
+	data->patch_read += p_hdr->plen + 3;
+
+	if (memcmp(ptr, skb->data, s_hdr->plen)) {
+		BT_ERR("mismatch evt data");
+	}
+
+	return 0;
+}
+
+static int intel_prepare_patch_file(struct intel_patch_data *data)
+{
+	char file[120];
+
+	snprintf(file, 120, "%s%s%s", INTEL_PATCH_DIR, data->device_ver,
+		 INTEL_PATCH_EXT);
+	BT_DBG("patch file: %s", file);
+
+	if (request_firmware(&data->fw, file, &data->hdev->dev) < 0) {
+		BT_ERR("failed to open patch file: %s", file);
+		return -1;
+	}
+
+	data->patch_read = 0;
+	data->patch_curr = data->fw->data;
+
+	return 0;
+}
+
 int btusb_intel_init(struct hci_dev *hdev)
 {
+	int ret;
 	struct intel_patch_data *data;
+	int cont = 1;
 
 	BT_INFO("Intel BT USB: device initialization - patching device");
 
@@ -61,9 +241,93 @@ int btusb_intel_init(struct hci_dev *hdev)
 	data->hdev = hdev;
 	data->state = INTEL_PATCH_PRE;
 
+	init_completion(&data->wait_patch_completion);
+
+	while (cont) {
+		BT_DBG("patch state: %d", data->state);
+		switch (data->state) {
+		case INTEL_PATCH_PRE:
+			/* send cmd to enable the device configuration mode */
+			ret = intel_send_mfg_cmd(hdev, 0x01, 0x00);
+			if (ret < 0) {
+				BT_ERR("failed to send cmd: enter mfg %d", ret);
+				goto exit_error;
+			}
+			break;
+
+		case INTEL_PATCH_VER:
+			/* send cmd to get the device's version */
+			ret = hci_send_cmd(hdev, INTEL_HCI_GET_VER, 0, NULL);
+			if (ret < 0) {
+				BT_ERR("failed to send cmd: get ver %d", ret);
+				goto exit_error;
+			}
+			break;
+
+		case INTEL_PATCH_PREP_PATCH:
+			/* open the patch file if it is available */
+			ret = intel_prepare_patch_file(data);
+			if (ret < 0) {
+				BT_ERR("failed to prepare patch file %d", ret);
+				data->state = INTEL_PATCH_POST;
+				data->patch_reset = INTEL_HCI_PATCH_SKIP;
+			} else {
+				BT_DBG("patch data is setup");
+				data->state = INTEL_PATCH_PATCHING;
+			}
+			/* this is the only state that doesn't expect any evt */
+			goto skip_wait;
+
+		case INTEL_PATCH_PATCHING:
+			/* send patch entry in patch data. one at a time */
+			ret = intel_send_patch_cmd(data);
+			if (ret < 0) {
+				BT_ERR("failed to send cmd: patch cmd %d", ret);
+				goto exit_error;
+			}
+			break;
+
+		case INTEL_PATCH_POST:
+			/* exit the device configuration mode */
+			ret = intel_send_mfg_cmd(hdev, 0x00, data->patch_reset);
+			if (ret < 0) {
+				BT_ERR("failed to send cmd: exit mfg: %d", ret);
+				goto exit_error;
+			}
+			break;
+
+		default:
+			BT_ERR("unknown patch state: %d", data->state);
+			ret = -EILSEQ;
+			goto exit_error;
+		}
+
+		/* waiting for event */
+		ret = wait_for_completion_interruptible(
+				&data->wait_patch_completion);
+		if (ret < 0) {
+			BT_ERR("patch completion error: %d", ret);
+			goto exit_error;
+		}
+
+skip_wait:
+		if (data->state == INTEL_PATCH_ERROR) {
+			BT_ERR("patch error");
+			ret = -EILSEQ;
+			goto exit_error;
+		}
+
+		if (data->state == INTEL_PATCH_COMPLETED) {
+			BT_INFO("patch completed");
+			cont = 0;
+		}
+	}
+
+exit_error:
+	release_firmware(data->fw);
 	kfree(data);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(btusb_intel_init);
 
@@ -73,9 +337,65 @@ void btusb_intel_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("Intel BT USB: HCI event handler state=%d", data->state);
 
+	switch (data->state) {
+	case INTEL_PATCH_PRE:
+		if (intel_verify_cc_evt(skb, INTEL_HCI_MFG_MODE) < 0) {
+			BT_ERR("cmd failed: enter mfg mode");
+			data->state = INTEL_PATCH_ERROR;
+		} else {
+			BT_DBG("cmd success: enter mfg mode");
+			data->state = INTEL_PATCH_VER;
+		}
+		break;
+
+	case INTEL_PATCH_VER:
+		if (intel_verify_ver_cc_evt(skb, data) < 0) {
+			BT_ERR("cmd failed: get version");
+			data->patch_reset = INTEL_HCI_PATCH_SKIP;
+			data->state = INTEL_PATCH_POST;
+		} else {
+			BT_DBG("cmd success: get version");
+			data->state = INTEL_PATCH_PREP_PATCH;
+		}
+		break;
+
+	case INTEL_PATCH_PATCHING:
+		if (intel_verify_patch_evt(skb, data) < 0) {
+			BT_ERR("cmd failed: patch");
+			data->patch_reset = INTEL_HCI_PATCH_DISABLE;
+			data->state = INTEL_PATCH_POST;
+		} else {
+			BT_DBG("cmd success: patch");
+			if (data->patch_read == data->fw->size) {
+				BT_DBG("no more patch to send");
+				data->patch_reset = INTEL_HCI_PATCH_ENABLE;
+				data->state = INTEL_PATCH_POST;
+			} else {
+				BT_DBG("more patch to send");
+			}
+		}
+		break;
+
+	case INTEL_PATCH_POST:
+		if (intel_verify_cc_evt(skb, INTEL_HCI_MFG_MODE) < 0) {
+			BT_ERR("cmd failed: exit mfg mode");
+			data->state = INTEL_PATCH_ERROR;
+		} else {
+			BT_DBG("cmd success: exit mfg mode");
+			data->state = INTEL_PATCH_COMPLETED;
+		}
+		break;
+
+	default:
+		BT_ERR("unknown patch state: %d", data->state);
+		data->state = INTEL_PATCH_ERROR;
+		break;
+	}
+
 	del_timer(&hdev->cmd_timer);
 	atomic_set(&hdev->cmd_cnt, 1);
 	kfree_skb(skb);
+	complete(&data->wait_patch_completion);
 	return;
 }
 EXPORT_SYMBOL_GPL(btusb_intel_event);
-- 
1.7.9.5


