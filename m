Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56761C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 10:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297C76024A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 10:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDMKSj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhDMKSi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 06:18:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F88C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 03:18:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so2167307pgi.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scmFeOLatlsWwx9zvIynOi2Aa6pfPzDACmBGZYlRZL4=;
        b=ki82215krFdoHyRahX0DdBtc4C55v2rcpJJntwPfChuG4jxCjv8O/edPohu3wpzFYT
         WZJEwlcea4+7HLygymwxD5ulJJiPPWz1t18z1qCRkGfogTZxEBsnpxA5ht+k9nRMf/+F
         SYN4x/nBU9xGoQKitlqvCuxZdr15U8y9cHDY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scmFeOLatlsWwx9zvIynOi2Aa6pfPzDACmBGZYlRZL4=;
        b=d2TfufopzrV0CBaYgZHmAoDJ2FzOGREx8pX568xWtgF8ZfjBAkVqvS3tA9awzqDXdi
         q5qRqc23bf8neYIy4qBEsZtf3FXjBVCltsH7HFnqjU19td01JI5MpFjTJOAPl8Yuth8f
         F/PB94rU/NZyPjyWWxWHTtCcB1lWSlDO6gArXXSjgOWWH+cPMVAMhi4Q+aTxptuvY7Tz
         OzxhRIWjg0Lxg1+73IhwMbtT7S7XHHoVKgLPU98rSAcx6ux/HLSAqXBF2mBdrzLH+Roh
         /Xb8D3cuOlyygcgIZY7IG4sN4n3esZiyplYcbt8530XRP8KRiuSB26+pKA+AT9ir0Jah
         GsUQ==
X-Gm-Message-State: AOAM533ZbH7fxXsLWAcQ/gx08r4udxZcS/nA27HZaflZE+ledjiYQTPE
        p/rxLydTOyW4rEL1NBeXMuNmJr5ElVxxgQ==
X-Google-Smtp-Source: ABdhPJyojmaBZD9cOuzEP0sI8l9nCcebvpogGgoagAwDVWkt/cqE3OciM7gTdJlX/MlPUmeo1zuugw==
X-Received: by 2002:aa7:86c8:0:b029:249:3950:afff with SMTP id h8-20020aa786c80000b02902493950afffmr15295728pfo.79.1618309098802;
        Tue, 13 Apr 2021 03:18:18 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:b:99d4:3dd9:e3a7:45cf])
        by smtp.gmail.com with ESMTPSA id v11sm14020976pgg.68.2021.04.13.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:18:17 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btusb: support link statistics telemetry events
Date:   Tue, 13 Apr 2021 18:18:11 +0800
Message-Id: <20210413101812.323079-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
Intel controllers

To avoid the overhead, this debug feature is disabled by default.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- fix the long line in the commit message

Changes in v2:
- take care of intel_newgen as well as intel_new
- fix the long lines in mgmt.c

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btusb.c   | 18 ------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..de1dbdc01e5a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x01, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
 
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
 	kfree_skb(skb);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 192cb8c191bc..f29946f15f59 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2811,7 +2811,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2865,14 +2864,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -2911,7 +2902,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -2961,14 +2951,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
-- 
2.31.1.295.g9ea45b61b8-goog

