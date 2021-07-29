Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2050C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C89F6023B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhG2SgN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhG2SgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23CC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so17019070pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFGNSD2fgND53iuk77WsQIDwpkOWFBj0YGwQ6b3jbG4=;
        b=nk76JhwFtg81VIU6sv30GVWqNb7Nn2jkAUbXl5KsW/PVwpXOco1ausMNa7oix1QFnb
         0LtfD50E5czL/FoVmU1s7r4pN1Y0VQFItN6kb837jAxs3xwJ3MEfhNVqr5u0tyKpA9D/
         FnAWLUjkzzrQrg3/pebftkWxUQKlaO6nWeKXHbsjv29UiGkpIenlNTuBbZOs+rDR1G09
         hj1GkJBMdovhVjRzA1Cu8KC6gYg+umVE3u1ty1+A6e7nr2sIUEJHWai9Jxfu3ml2TU/9
         J8hs30kOMH/rroj5xVJAJ32CRNHTe4xxGC16dWdS/ITYSFAK8RQGU4u5b7bbVgvCMoIW
         5D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFGNSD2fgND53iuk77WsQIDwpkOWFBj0YGwQ6b3jbG4=;
        b=WKmk1EW7DF+VJvjrD9e1q/7UO4OQ0jGyIlnEqj+xWtekkU7hiDDXpNttzPFlMp807Z
         S1EuQHSQa5vr8gJJGuIZKUT6ETA3zQUcdaX2YbO9RzIcxfthst4yJMZfHImxQt0Evhgu
         l0O9iviDOBzQgfs3h+5LHsd0/cum7XfGmaIi57Qy7sLrXqa7EmybGKWZwG8qFUvJ8roA
         ACyaQVMRocfx/VuScr0pjqhRv9bFe1XYJZNMEejVBTJVJS6bRG7zvZ1zEoDOU07b8tIH
         dtnAON/zR/zTlDRR8OJv2APWBMjkIyQqo/B87gBdlS+KL12deeLRXkm3dLXLYxp/hqiH
         fkfQ==
X-Gm-Message-State: AOAM5301PKadPn43jBDaShFucHY06ukhzp+/TwE45ju5e0dgI8PWCWDt
        ad38Hq+nPMa/BZOIt/TfuSuinE7+QYI=
X-Google-Smtp-Source: ABdhPJy+n5xF6+U794v+2co0qRrkxiZXVpJLjalv9eK/8yqm7pGAhI4rLxvtE85nUv5H5+RH9tCrkA==
X-Received: by 2002:a05:6a00:1806:b029:33f:9525:5911 with SMTP id y6-20020a056a001806b029033f95255911mr6226329pfa.80.1627583767977;
        Thu, 29 Jul 2021 11:36:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 04/11] Bluetooth: btintel: Add btintel data struct
Date:   Thu, 29 Jul 2021 11:35:53 -0700
Message-Id: <20210729183600.281586-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a data structure for btintel for btintel object, and the
definition of bootloder states.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c |  8 ++++++++
 drivers/bluetooth/btintel.h | 15 +++++++++++++++
 drivers/bluetooth/btusb.c   |  6 ++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cfc097694b53..bf0ad05b80fe 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1753,6 +1753,14 @@ int btintel_shutdown_combined(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
 
+void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+
+	set_bit(flag, &intel->flags);
+}
+EXPORT_SYMBOL_GPL(btintel_set_flags);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 68ffa84fa87a..df7aa30142b4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -138,6 +138,16 @@ struct intel_debug_features {
 #define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
 #define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
 
+#define INTEL_BOOTLOADER		0
+#define INTEL_DOWNLOADING		1
+#define INTEL_FIRMWARE_LOADED		2
+#define INTEL_FIRMWARE_FAILED		3
+#define INTEL_BOOTING			4
+
+struct btintel_data {
+	unsigned long flags;
+};
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -167,6 +177,7 @@ int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
 int btintel_setup_combined(struct hci_dev *hdev);
 int btintel_shutdown_combined(struct hci_dev *hdev);
+void btintel_set_flags(struct hci_dev *hdev, unsigned int flag);
 int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				     struct intel_version_tlv *ver,
 				     const struct firmware *fw,
@@ -295,6 +306,10 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
 	return -EOPNOTSUPP;
 }
 
+static inline void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
+{
+}
+
 static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
 						   const struct firmware *fw,
 						   u32 *boot_param,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 42f7176a6c70..8c54ab03ee63 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4133,7 +4133,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int i, err;
+	int i, err, priv_size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4219,6 +4219,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
+	priv_size = 0;
+
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
@@ -4228,7 +4230,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.25.1

