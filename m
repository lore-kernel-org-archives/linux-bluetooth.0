Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A9C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD9D217F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6H4C9M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgCDRWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:22:16 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37169 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgCDRWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 12:22:16 -0500
Received: by mail-vs1-f67.google.com with SMTP id h5so1686597vsc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRYJYrva9ZWmX+0/fMm1gWAHOurrTJzpJtxxLoOxAas=;
        b=j6H4C9M37fRrF1FXj4lfSCIsmoerG8jPT4siXaZIhtQ3PSXSQXv0fLY71sNZ3PnpGw
         M2WMF6sBY3OO5F1B7i9ltucIik/0hK/DwZKmB9+fU3yM/MrFOnbcP8VKNFF5+o/Xqa/t
         nXzeIiZsjy0PqQbRCmvJkFpt9S1YBxIdDTnDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRYJYrva9ZWmX+0/fMm1gWAHOurrTJzpJtxxLoOxAas=;
        b=IJdFOTfn7E4IGK4XP6+rDP6k3+BlFlFbFiUuE3oVXR4YmTu6mOE37mFaA4N3Cv8j3D
         rx+CdGy29HLDVHHeDvX5RSzlwleTVKYmYlLss86+1R33o2qNUAQbX8Qa7FyhBMxQ8REk
         Zxh01iT4ZzPMNwK414QfamcTGXoNZ1XY9GK9OMWlXNAmMMnG+wUID6XqZh7zhvf8N3yO
         Y4CBT8a4Wzfu6uUdu2ShSHIqVwWIvtJdSsP67pdXUYMYlf4M1RmNoAa5Y1SNsFbIxZKR
         ETHkKX/+OKdQx9f7I8vbrRmuBLjrLremMqBPXyeFnMvdGhUNZEDKVCDNx1VbId5uhSK6
         7TWQ==
X-Gm-Message-State: ANhLgQ2vUrrvLBKUDpvigWOCiX4PpCdDrw7mAZVnSMz0VVy3CZYwQqGN
        GdVjPu27soELZyh2cFgi1KE98YLjwVk=
X-Google-Smtp-Source: ADFU+vvYFupEj9KeGs1OOW/IQGnKdQeEyX+SmVG9BiksPBTfsaLkRSDktQzYMNo+6YQuI2DgHLgloA==
X-Received: by 2002:a67:8803:: with SMTP id k3mr2380517vsd.36.1583342532289;
        Wed, 04 Mar 2020 09:22:12 -0800 (PST)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id b19sm7600772vka.48.2020.03.04.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:22:11 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3] bluetooth: Enable erroneous data reporting if wbs is supported
Date:   Wed,  4 Mar 2020 17:22:07 +0000
Message-Id: <20200304172207.58963-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change intruduces a wide band speech setting which allows higher
level clients to query the local controller support for wide band speech
as well as set the setting state when the radio is powered off.
Internally, this setting controls if erroneous data reporting is enabled
on the controller.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci.h      | 14 ++++++++
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  2 ++
 net/bluetooth/hci_core.c         | 21 +++++++++++
 net/bluetooth/hci_event.c        | 39 ++++++++++++++++++++
 net/bluetooth/mgmt.c             | 62 ++++++++++++++++++++++++++++++++
 6 files changed, 139 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0b3ebd35681d..d66648e9ff13 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -286,6 +286,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
+	HCI_WIDE_BAND_SPEECH_ENABLED,
 
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
index f69f88e8e109..b203df07e7fc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -672,6 +672,8 @@ struct mgmt_cp_set_blocked_keys {
 } __packed;
 #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
 
+#define MGMT_OP_SET_WIDE_BAND_SPEECH	0x0047
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..d526d7568396 100644
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
@@ -838,6 +841,24 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 			    sizeof(support), &support);
 	}
 
+	/* Set erroneous data reporting if supported to the wideband speech
+	 * setting value
+	 */
+	if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks) &&
+	    (hdev->commands[18] & 0x04) &&
+	    hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) !=
+	     (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED)) {
+		struct hci_cp_write_def_err_data_reporting cp = {};
+
+		cp.err_data_reporting =
+			hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED) ?
+			ERR_DATA_REPORTING_ENABLED :
+			ERR_DATA_REPORTING_DISABLED;
+
+		hci_req_add(req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
+			    sizeof(cp), &cp);
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
index 1002c657768a..a648241c8973 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
+	MGMT_OP_SET_WIDE_BAND_SPEECH,
 };
 
 static const u16 mgmt_events[] = {
@@ -850,6 +851,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_STATIC_ADDRESS;
 	}
 
+	if (hci_dev_test_flag(hdev, HCI_WIDE_BAND_SPEECH_ENABLED))
+		settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
+
 	return settings;
 }
 
@@ -3593,6 +3597,63 @@ static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				err, NULL, 0);
 }
 
+static int set_wide_band_speech(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+	bool changed = false;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_WIDE_BAND_SPEECH,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_WIDE_BAND_SPEECH,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (pending_find(MGMT_OP_SET_WIDE_BAND_SPEECH, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_WIDE_BAND_SPEECH,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (hdev_is_powered(hdev) &&
+	    !!cp->val != hci_dev_test_flag(hdev,
+					   HCI_WIDE_BAND_SPEECH_ENABLED)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_WIDE_BAND_SPEECH,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	if (cp->val)
+		changed = !hci_dev_test_and_set_flag(hdev,
+						  HCI_WIDE_BAND_SPEECH_ENABLED);
+	else
+		changed = hci_dev_test_and_clear_flag(hdev,
+						  HCI_WIDE_BAND_SPEECH_ENABLED);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_WIDE_BAND_SPEECH, hdev);
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
+	{ set_wide_band_speech,	   MGMT_SETTING_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.1.481.gfbce0eb801-goog

