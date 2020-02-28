Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48424C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC722469C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 16:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5jcmZEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB1Qjc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:39:32 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43275 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB1Qjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 11:39:32 -0500
Received: by mail-vs1-f68.google.com with SMTP id 7so2306299vsr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oxkss/h+D8tGHimDL1H8L67MCauGwi6R90+QYCsqKTU=;
        b=m5jcmZEyLWSnRF4Y1xmCri8+y+LR/mlnh0l8Idp+Tx3kbLpsKKxAsQ5SvXuxpgs8lM
         WEoao5gMhWMriPKXYIyGzu/98sN2oho2vB6+o89UAxI6VrPQbVuF4wtghx8VdcoIhuVa
         QY7VSdIRTMch3lizn2fMN+al7UfXCYnn5nThE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oxkss/h+D8tGHimDL1H8L67MCauGwi6R90+QYCsqKTU=;
        b=XSYN4mxcImfYX2sRe9Qs10obJO6spfHGFQ+PHAJDgh/kSW7W91WjYpLLx7pygBsd+F
         yAiIOLVHWG/wD2Zg4R3ogaBbsRJjPnmn5xSrjYkMG/5K1ib24Bwh0+QLEJahkaad4I/1
         eBROu68Gp2RbDHx6TJYbgMoSa5RMx+baUOUxc1m2/8gWj6ye0y2ndmUZoRBlFGY5Gqa9
         /t7mC7YFtj2Zx/3Aa2lUkliAWMBMrMTUVqD1Pv9bq7FuQtgDEB4ZtLhao8UCf7jXEa5e
         xWcWI6yS+B2pDbsmLOHUy7ZAtfI04xSsT2L3jWLG8+3KQAkERG8r0ipIemyuK7+FeG6+
         S68A==
X-Gm-Message-State: ANhLgQ1qth1QWU1LzjNdkOMJN8g0jpmgWDjzrF9y0m1wr6daa8/vn4x+
        jakbhZaeijBzO6OAbEQPJaeER7IhrK4=
X-Google-Smtp-Source: ADFU+vtWE5expFhV7tmSanBvbrwgDfLq+LN93Em6LJYJ0k6U1Oalm0bxZvkB9Vt9D7TYQYJevE2ZqA==
X-Received: by 2002:a67:ff14:: with SMTP id v20mr3024733vsp.114.1582907969088;
        Fri, 28 Feb 2020 08:39:29 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id m82sm3054133vke.30.2020.02.28.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:39:28 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth: Enable erroneous data reporting if wbs is supported
Date:   Fri, 28 Feb 2020 16:39:22 +0000
Message-Id: <20200228163922.87031-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will enable erroneous data reporting if wide band speech is
supported by the controller as indicated by the
HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED quirk.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci.h      | 13 ++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  3 ++
 net/bluetooth/hci_event.c        | 55 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  3 +-
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0b3ebd35681d..aa1654f9b579 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1095,6 +1095,19 @@ struct hci_rp_read_inq_rsp_tx_power {
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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..3becdce5457a 100644
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
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 591e7477e925..21fd1ebd9c6a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -901,6 +901,53 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
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
+
+	/* If the controller supports wide_band_speech, enable erroneous
+	 * data reporting.
+	 */
+	if (hdev->err_data_reporting != ERR_DATA_REPORTING_ENABLED &&
+	    (hdev->commands[18] & 0x04) &&
+	    test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED, &hdev->quirks)) {
+		struct hci_request req;
+		struct hci_cp_write_def_err_data_reporting cp = {};
+
+		hci_req_init(&req, hdev);
+		cp.err_data_reporting = ERR_DATA_REPORTING_ENABLED;
+
+		hci_req_add(&req, HCI_OP_WRITE_DEF_ERR_DATA_REPORTING,
+			    sizeof(cp), &cp);
+	}
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
@@ -3302,6 +3349,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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
index 1002c657768a..8827d942b2d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -764,7 +764,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_SECURE_CONN;
 
 		if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
-			     &hdev->quirks))
+			     &hdev->quirks) &&
+		    hdev->err_data_reporting == ERR_DATA_REPORTING_ENABLED)
 			settings |= MGMT_SETTING_WIDE_BAND_SPEECH;
 	}
 
-- 
2.25.1.481.gfbce0eb801-goog

