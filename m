Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F0BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5702D60EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 10:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhHEKDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbhHEKD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 06:03:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206AAC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 03:03:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so10274186pji.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uuijVLjMI307rqAOU9lNs1XGhdhuoUjU3iANzQVkPI=;
        b=KrZKjuuzXJGLk/Bv0kDC0DXmgCwo2yOeRG4zHVvP0Ng9bAXSrPSb7JR+q+pVvBOrbb
         sbjIRIMLgycpqntOa3MrY0pG4/riFy1l6cWjfuRgBeDKrt3xGFGzTXfF3fXXkX0TquP9
         LKc76ZIbnzfgxIRnIulJEjiGwVIqJ7ZdKYxto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uuijVLjMI307rqAOU9lNs1XGhdhuoUjU3iANzQVkPI=;
        b=pvLZsUXap+TZDHplSO40wFUvvCEeW+ZXDUmSIjZWOmlw/M1m9XdlvAG97Ha7K4mTxB
         n5wj4zYJbMPPgVnpObA+UF6HCAKTDx3o8ArXPBw11ru/iEfV8YwElFqVF/LCV7KnKYAC
         auvj9Th2VUhcJ8uP+bAQaZm8Fg3c29xnb7QlZ6fp6XMDPdqvUHp6sypXuoApyJWOSsy1
         M5dkDr23gJI5ZLkxR2JvOp8Qp+GO1LXu2LhzSMi645G+U4ibzcIzWVViIBWTnuf82vcr
         VE1eAGbAjwZENXOW++VnhN0mocFUnK+iNd58BoPt1Sn37RXAv+ukRAN6nMg9PCSBmkDb
         3J2Q==
X-Gm-Message-State: AOAM533oE2xWIoFJ4FhEByCXPKD1HoGOKWyZlQe+LGcDG4VNDL+qZKIL
        FQ4zhzBSN6z6xWPhrTfbiOQe3K/bRCLpoA==
X-Google-Smtp-Source: ABdhPJxSJOo7Hr5FpybwtLkJQkAd34wwRxE8ygYfOwSckTvNLxiFwcyF2eDypPXl2TAIqI4hRW9fMQ==
X-Received: by 2002:a65:6919:: with SMTP id s25mr2455377pgq.2.1628157791429;
        Thu, 05 Aug 2021 03:03:11 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:2c18:41ac:c6a8:ddfe])
        by smtp.gmail.com with ESMTPSA id jz24sm5436194pjb.9.2021.08.05.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:03:11 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] Bluetooth: set quality report callback for Intel
Date:   Thu,  5 Aug 2021 18:02:59 +0800
Message-Id: <20210805180227.v6.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

(no changes since v5)

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
index 30462de288c7..a7a57fe5d872 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2923,6 +2923,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -3010,6 +3013,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
@@ -4819,6 +4825,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->set_quality_report = btintel_set_quality_report;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4833,6 +4840,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->set_quality_report = btintel_set_quality_report;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-- 
2.32.0.554.ge1b32706d8-goog

