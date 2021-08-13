Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F821C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500A06103A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhHMQx0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhHMQwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 12:52:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5FC06129E
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 09:52:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so6218477pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRvPMogZyng7WSp5jJKMfniiyUGdH1MlfgsiYSR0FQU=;
        b=WBDPH7gY9YmkZEW4xNb3aYpfp9pTEjn31PM1uOOT0LiwCrQSNQ1HwSvL+wTo7YzPYt
         4o6sC30lEIQXjmAwJJ185ZJJwxXqMjst16OoMFvRzRvg2XYSQVKo0n3X3P8o0G60RUnb
         obEkTo9jypUd/JZJAUb5suDMHuVVFUmA4INeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRvPMogZyng7WSp5jJKMfniiyUGdH1MlfgsiYSR0FQU=;
        b=WSBeEafDgAYFZx//vg8vj1d6LzIGrIDgYpRAAiaS9s+WTXXVIo6DJACB8BYIrJPzbU
         PLJBfln/3GJ0xe1kIKANVAPLG6do7vQt1+uc5a9vQBUIT9/dOB0o2ld84lvvXE633ebT
         RWffuWroNp7qMWoiw0tG6mazFGPui5CAFmc7eUFM8/luEC1RhZVEvbLCKirQY+PQTHU1
         QeluV7qAxziyryE8U3UVa7hmlVim/WVSKK84UsTo0XDQH5lIW1EllzltILfa0LMeiSIp
         LGjl6keVzjVdpQROvodO/RCRO3BkvMByJ4jvv80WnC3i9GFca8LL9alMdTzHOGnKg37T
         TtGw==
X-Gm-Message-State: AOAM532vgfdZWQDUKGKu3RXnhCAND/LCV5HTPffo53OWK2n23UhpIhh5
        v2Jz9HsHeULpDU06gpM8ArWlhXmI7P2EcA==
X-Google-Smtp-Source: ABdhPJzI6FSlPP77AQQUfn7J94xV6S8JgX20riMZLC8+bcpVUJdv3vpdb7PzhyeKvJmIzy3GijD4Xg==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id bg8-20020a1709028e88b029011eb70383f1mr2707847plb.79.1628873524734;
        Fri, 13 Aug 2021 09:52:04 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:755d:cdee:3203:71c5])
        by smtp.gmail.com with ESMTPSA id w3sm2907407pfn.96.2021.08.13.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:52:04 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/5] Bluetooth: set quality report callback for Intel
Date:   Sat, 14 Aug 2021 00:51:48 +0800
Message-Id: <20210814005024.v8.5.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210814005024.v8.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210814005024.v8.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

Changes in v8:
- Removed the unsuitable debug messages.

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

Changes in v5:
- Removed CONFIG_BT_FEATURE_QUALITY_REPORT since there was no
  large size impact.

 drivers/bluetooth/btintel.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  6 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 643e2194ca01..778d803159f3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1291,8 +1291,10 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
-	if (!features)
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
 		return -EINVAL;
+	}
 
 	if (!(features->page1[0] & 0x3f)) {
 		bt_dev_info(hdev, "Telemetry exception format not supported");
@@ -1323,9 +1325,77 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	}
 	kfree_skb(skb);
 
+	bt_dev_info(hdev, "set debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
 	return 0;
 }
 
+static int btintel_reset_debug_features(struct hci_dev *hdev,
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
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
@@ -1951,6 +2021,8 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &new_ver);
 	if (err)
@@ -2132,6 +2204,8 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &new_ver);
 	if (err)
@@ -2230,6 +2304,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 
+	/* Set up the quality report callback for Intel devices */
+	hdev->set_quality_report = btintel_set_quality_report;
+
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index aa64072bbe68..fe02cb9ac96c 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -204,6 +204,7 @@ int btintel_configure_setup(struct hci_dev *hdev);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -294,4 +295,9 @@ static inline void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len)
 {
 }
+
+static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	return -ENODEV;
+}
 #endif
-- 
2.33.0.rc1.237.g0d66db33f3-goog

