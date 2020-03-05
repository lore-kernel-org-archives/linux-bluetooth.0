Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61114C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD562146E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l/rchry3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCEQPI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:15:08 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38476 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEQPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 11:15:08 -0500
Received: by mail-vk1-f196.google.com with SMTP id w4so1762609vkd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnFU4BY+mZDVhRyVdVMT2r6aT1KbZfe60GV9PTmkkpU=;
        b=l/rchry32cloXBCyfUNlTqZYX8MRQbqPpZ8l5ee3qUcdp2u23cJoTo07dfFxq9iVal
         A5PU9+M9x2Z0QQS9w2pIa7HyRjVNDhn8gwPrll9OTOiu2E4EtrKcbUP40Yb8S8trjfx1
         9Yy6gBgKkk7j3Yqc+IWzF7SH+bwdYx+NGl410=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnFU4BY+mZDVhRyVdVMT2r6aT1KbZfe60GV9PTmkkpU=;
        b=PtwuGr8laEEceYOual1CEqfAgcNFmm0+RD6K/+04TBcm2dk1sebCw3EAwy+WrBw7pW
         L4dBZBQuTHtDJY+KqBCVznTJQDg2JiX7WQevoXTXxKBVCWIreGnKHcQrkkpQa4VXiWMb
         kGlJG79a8Zr0526fwCO7a3Nmb2B5X4tpWguReXfLB4GTtcpOX0iMoJeY8mHDannAjeqQ
         KN2+yd7A+sCzK93lRscFF2noZnpCuMOXnDIq9AUJBba4umUrc0VjU4FhyxU+1xKPA6v4
         9dvwj1K84yef06imC8RWHA/7V+qZZLtiTk/dLzUIk0I3j4dn1yaFhGaVHK5kHWG+W6uy
         UJQQ==
X-Gm-Message-State: ANhLgQ0zeyLeoAV5m8dFrDm1HggEjRIuxMUjAXBlSTDMKQhXT16ZXQYL
        +WoKVscKtCvEsHp8nX5YRFt6sQPXkCvExw==
X-Google-Smtp-Source: ADFU+vvDcVL8hMPfid9DD9pSR3Jkgr2zDzYhFym7lRu1Ih74SOPtlWmEFL/BC8mToFlARwgDPET3kw==
X-Received: by 2002:a05:6122:489:: with SMTP id o9mr1242155vkn.9.1583424904469;
        Thu, 05 Mar 2020 08:15:04 -0800 (PST)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id c44sm6014006uad.16.2020.03.05.08.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:15:03 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v4] bluetooth: Enable erroneous data reporting if wbs is supported
Date:   Thu,  5 Mar 2020 16:14:59 +0000
Message-Id: <20200305161459.153606-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change introduces a wide band speech setting which allows higher
level clients to query the local controller support for wide band speech
as well as set the setting state when the radio is powered off.
Internally, this setting controls if erroneous data reporting is enabled
on the controller.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c        |  2 +-
 include/net/bluetooth/hci.h      | 16 +++++++-
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  4 +-
 net/bluetooth/hci_core.c         | 24 ++++++++++++
 net/bluetooth/hci_event.c        | 39 +++++++++++++++++++
 net/bluetooth/mgmt.c             | 66 +++++++++++++++++++++++++++++++-
 7 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 48e78fdc8e83..4b12c34f0b22 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3868,7 +3868,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->isoc = NULL;
 
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
-		set_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks);
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0b3ebd35681d..4e86f1bb7a87 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -213,7 +213,7 @@ enum {
 	 *
 	 * This quirk must be set before hci_register_dev is called.
 	 */
-	HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
+	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 };
 
 /* HCI device flags */
@@ -286,6 +286,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
+	HCI_WIDEBAND_SPEECH_ENABLED,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1095,6 +1096,19 @@ struct hci_rp_read_inq_rsp_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_READ_DEF_ERR_DATA_REPORTING	0x0c5a
+	#define ERR_DATA_REPORTING_DISABLED	0x00
+	#define ERR_DATA_REPORTING_ENABLED	0x01
+struct hci_rp_read_def_err_data_reporting {
+	__u8     status;
+	__u8     err_data_reporting;
+} __packed;
+
+#define HCI_OP_WRITE_DEF_ERR_DATA_REPORTING	0x0c5b
+struct hci_cp_write_def_err_data_reporting {
+	__u8     err_data_reporting;
+} __packed;
+
 #define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
 
 #define HCI_OP_READ_LOCATION_DATA	0x0c64
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dcc0dc6e2624..c498ac113930 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -260,6 +260,7 @@ struct hci_dev {
 	__u8		stored_num_keys;
 	__u8		io_capability;
 	__s8		inq_tx_power;
+	__u8		err_data_reporting;
 	__u16		page_scan_interval;
 	__u16		page_scan_window;
 	__u8		page_scan_type;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f69f88e8e109..f41cd87550dc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -102,7 +102,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
-#define MGMT_SETTING_WIDE_BAND_SPEECH	0x00020000
+#define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
 } __packed;
 #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
 
+#define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..ef1160c1f9d0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -603,6 +603,9 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[8] & 0x01)
 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
 
+	if (hdev->commands[18] & 0x02)
+		hci_req_add(req, HCI_OP_READ_DEF_ERR_DATA_REPORTING, 0, NULL);
+
 	/* Some older Broadcom based Bluetooth 1.2 controllers do not
 	 * support the Read Page Scan Type command. Check support for
 	 * this command in the bit mask of supported commands.
@@ -838,6 +841,27 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 			    sizeof(support), &support);
 	}
 
+	/* Set erroneous data reporting if supported to the wideband speech
+	 * setting value
+	 */
+	if (hdev->commands[18] & 0x04) {
+		bool enabled = hci_dev_test_flag(hdev,
+						 HCI_WIDEBAND_SPEECH_ENABLED);
+
+		if (enabled !=
+		    (hdev->err_data_reporting == ERR_DATA_REPORTING_ENABLED)) {
+			struct hci_cp_write_def_err_data_reporting cp = {};
+
+			cp.err_data_reporting =
+				enabled ?
+				ERR_DATA_REPORTING_ENABLED :
+				ERR_DATA_REPORTING_DISABLED;
+
+			hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
+				    sizeof(cp), &cp);
+		}
+	}
+
 	/* Set Suggested Default Data Length to maximum if supported */
 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 		struct hci_cp_le_write_def_data_len cp;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 591e7477e925..3772acddda93 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -901,6 +901,37 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 	hdev->inq_tx_power = rp->tx_power;
 }
 
+static void hci_cc_read_def_err_data_reporting(struct hci_dev *hdev,
+					       struct sk_buff *skb)
+{
+	struct hci_rp_read_def_err_data_reporting *rp = (void *)skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->err_data_reporting = rp->err_data_reporting;
+}
+
+static void hci_cc_write_def_err_data_reporting(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *)skb->data);
+	struct hci_cp_write_def_err_data_reporting *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING);
+	if (!cp)
+		return;
+
+	hdev->err_data_reporting = cp->err_data_reporting;
+}
+
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_pin_code_reply *rp = (void *) skb->data;
@@ -3302,6 +3333,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_inq_rsp_tx_power(hdev, skb);
 		break;
 
+	case HCI_OP_READ_DEF_ERR_DATA_REPORTING:
+		hci_cc_read_def_err_data_reporting(hdev, skb);
+		break;
+
+	case HCI_OP_WRITE_DEF_ERR_DATA_REPORTING:
+		hci_cc_write_def_err_data_reporting(hdev, skb);
+		break;
+
 	case HCI_OP_PIN_CODE_REPLY:
 		hci_cc_pin_code_reply(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1002c657768a..8fbbb225caf8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
+	MGMT_OP_SET_WIDEBAND_SPEECH,
 };
 
 static const u16 mgmt_events[] = {
@@ -763,9 +764,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		if (lmp_sc_capable(hdev))
 			settings |= MGMT_SETTING_SECURE_CONN;
 
-		if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
+		if (test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 			     &hdev->quirks))
-			settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
+			settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 	}
 
 	if (lmp_le_capable(hdev)) {
@@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_STATIC_ADDRESS;
 	}
 
+	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
+		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
+
 	return settings;
 }
 
@@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				err, NULL, 0);
 }
 
+static int set_wideband_speech(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+	bool changed = false;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!test_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_WIDEBAND_SPEECH,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_WIDEBAND_SPEECH,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (pending_find(MGMT_OP_SET_WIDEBAND_SPEECH, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_WIDEBAND_SPEECH,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (hdev_is_powered(hdev) &&
+	    !!cp->val != hci_dev_test_flag(hdev,
+					   HCI_WIDEBAND_SPEECH_ENABLED)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_WIDEBAND_SPEECH,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	if (cp->val)
+		changed = !hci_dev_test_and_set_flag(hdev,
+						   HCI_WIDEBAND_SPEECH_ENABLED);
+	else
+		changed = hci_dev_test_and_clear_flag(hdev,
+						   HCI_WIDEBAND_SPEECH_ENABLED);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_WIDEBAND_SPEECH, hdev);
+	if (err < 0)
+		goto unlock;
+
+	if (changed)
+		err = new_settings(hdev, sk);
+
+unlock:
+
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -6994,6 +7055,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.1.481.gfbce0eb801-goog

