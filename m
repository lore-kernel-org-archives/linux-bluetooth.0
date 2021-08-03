Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9586C43214
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A710F6103C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 15:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhHCP1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhHCP1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 11:27:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CFC061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 08:27:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so5191239pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NMDLRvCd8Q/Sr5vCBPPnUG/lOK2F47kcAWNHlgBnNo=;
        b=lf6lLXzT0+v5MPDgFLkljZAOcR52vQKJHTUUAW4AUs//Upt6/iYEpa8dPMTH6FOH1t
         Nt30zcrcpgM6X7P94U1bf7tyegZqnoF4t0hqtUTagSBRKHCIQz2DFUz0XQIKoeZk5nWG
         belIoiekv78wi+AjUewGnkWA6HOjrDAug/o7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NMDLRvCd8Q/Sr5vCBPPnUG/lOK2F47kcAWNHlgBnNo=;
        b=K4oBC1fQMzgDH1XBQaT2PTQgMp970+ewArI2frPylwJHKqnMdS6xkP7oB1w+Pcg6lP
         p0/jZDxwXWhzOx5RoWYb5B2pbXVeYo2kWiCX2ON/yGVO48QL1BHfSBfruig6m391yBuV
         NKoRHVKbRGP1ofM11dzHdfSRRE44B/IJgsFCp5Ef2jKosje4efBdl2b0TOycuh515Hgy
         wGugyeabs2jhIEIG2FqRV/PADlofe4LgfhoGCp/N/PUbHhorI16tk6sTndEhqKln74hO
         M94nhuXZagqiFUuCmNjuKeAHpE9/ChtIUNT/rLYX5MVhCsyetEI/dHdl76V1sSamErS2
         49Gw==
X-Gm-Message-State: AOAM533rr+SjgJnEbj72T8z2C31RD7WkdnIW0dWKpJ3My0sHe2CltwSS
        bN8uOCFuAldnkcW1Z//nemD2EzJF0YWDog==
X-Google-Smtp-Source: ABdhPJxcfI7a2tWXvVwm3JsMHUYHwLCtTDYBp2zo9xGJs/Aff8Uf6urdv9RaxQDWhoNUr/yF30dp+Q==
X-Received: by 2002:a05:6a00:16d6:b029:32a:ffe9:76a with SMTP id l22-20020a056a0016d6b029032affe9076amr22990851pfc.60.1628004453262;
        Tue, 03 Aug 2021 08:27:33 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:7cf5:7e9:5266:c8ba])
        by smtp.gmail.com with ESMTPSA id v30sm14922493pgk.25.2021.08.03.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:27:32 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] Bluetooth: set quality report callback for Intel
Date:   Tue,  3 Aug 2021 23:27:18 +0800
Message-Id: <20210803232539.v5.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803232539.v5.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210803232539.v5.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch sets up set_quality_report callback for Intel to
set and reset the debug features.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v5:
- Removed CONFIG_BT_FEATURE_QUALITY_REPORT since there was no
  large size impact.

 drivers/bluetooth/btintel.c | 73 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  9 +++++
 drivers/bluetooth/btusb.c   |  8 ++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fd21ddb76928..28ca51227453 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1254,8 +1254,10 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
-	if (!features)
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
 		return -EINVAL;
+	}
 
 	if (!(features->page1[0] & 0x3f)) {
 		bt_dev_info(hdev, "Telemetry exception format not supported");
@@ -1286,10 +1288,79 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	}
 	kfree_skb(skb);
 
+	bt_dev_info(hdev, "set debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+int btintel_reset_debug_features(struct hci_dev *hdev,
+				 const struct intel_debug_features *features)
+{
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00 };
+	u8 trace_enable = 0x00;
+	struct sk_buff *skb;
+
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
+		return -EINVAL;
+	}
+
+	if (!(features->page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemetry exception format not supported");
+		return 0;
+	}
+
+	/* Should stop the trace before writing ddc event mask. */
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Stop tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	bt_dev_info(hdev, "reset debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_reset_debug_features);
+
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	struct intel_debug_features features;
+	int err;
+
+	bt_dev_dbg(hdev, "enable %d", enable);
+
+	/* Read the Intel supported features and if new exception formats
+	 * supported, need to load the additional DDC config to enable.
+	 */
+	err = btintel_read_debug_features(hdev, &features);
+	if (err)
+		return err;
+
+	/* Set or reset the debug features. */
+	if (enable)
+		err = btintel_set_debug_features(hdev, &features);
+	else
+		err = btintel_reset_debug_features(hdev, &features);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_set_quality_report);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..0926b8196021 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -175,6 +175,9 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_reset_debug_features(struct hci_dev *hdev,
+			       const struct intel_debug_features *features);
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -307,4 +310,10 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_reset_debug_features(struct hci_dev *hdev,
+					       const struct intel_debug_features *features)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 97414746c029..9a860e4d8777 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2918,6 +2918,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -3005,6 +3008,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
@@ -4665,6 +4671,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->set_quality_report = btintel_set_quality_report;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4679,6 +4686,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->set_quality_report = btintel_set_quality_report;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-- 
2.32.0.554.ge1b32706d8-goog

