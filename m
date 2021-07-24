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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597DD60E95
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhGXGtw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhGXGtl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB5C061757
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso759391pjf.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbbmPw8vR3BBd6gB/L4mpzhjv7254V/N45lgT3oRR6s=;
        b=LmgDDHqwnATAXd70bTpDcwsTGEs/RYibRKlj+o7WF7vL3ENfdvK+357E/XUu/xfvp8
         zjPf2pXLQvpbDVvfLxsxJ+VSRBSHaET3qgZgzNeGDJxHmTqWiUVpRa8mQ34gkpYHlvfQ
         5+LlmXXZNXaxyVvMz8KCZfjgHeLMcVK9pfT0cixX4ncCJAJOTJ2O6hYxliu6gzJxKiwJ
         CE2oYL6vcYUU9iiA3hgCaH/ci7O6kXOkmlMgs64rqqwRiYPs3nnY95Nv3iTogn0Ya3CN
         MF1SATgNuSYaxvtArKcHHlaxEIm2o0T47ig+/0WaDq3aF96Zh812gvOxzWM5r52/bkg8
         R6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbbmPw8vR3BBd6gB/L4mpzhjv7254V/N45lgT3oRR6s=;
        b=SUQsMQTxfwrRRp0PJmz0kvuatKN3ZeGjVpgHZbbRTPpMkFE+I4QHKW2aOeLLFAtItl
         mm1F9yJJzhfIobstz6FFRCDRIBMRN1LDzEe5vzT+dRwSmjUGmsaBhEhYfzItnSLgL6Yk
         RVOSAOA1bTC7v7YMEAuGZNzGOhC1UZIs7zt2X2wYz+tIxAnv5TpwVV91jOTxmWSFyXcL
         woLFm//8UMtPwRcDWfokeIsSGw1NLEpyLBZ6XVZbdtaRWdZ3wcwC1mRXpZ3dwJL0zlSF
         9ItHXvrBoVyDO+TvmOH2jJ7QKyy7WR08JFhwd7LIK9ddYqu5XoKI/p8iNApwT1YHb+KB
         jrPQ==
X-Gm-Message-State: AOAM5336iU8TjYobPU1Q8S1MgvdvEzr8NndZDMRs9DC32KnCFrkFXsCU
        wpyiERw7ox09wJ4pL++4n0s5RMPr32Y=
X-Google-Smtp-Source: ABdhPJwau0KKxlcDbMZjUJvSjB6ID2QQhy3MY7B7KJGQQRXTVd2UgYM0w3Zg8xplveaDJ+hLz1FjhA==
X-Received: by 2002:a17:902:aa08:b029:12b:888b:1d7f with SMTP id be8-20020a170902aa08b029012b888b1d7fmr6637925plb.55.1627111813123;
        Sat, 24 Jul 2021 00:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:12 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 4/9] Bluetooth: btintel: Add btintel data struct
Date:   Sat, 24 Jul 2021 00:30:00 -0700
Message-Id: <20210724073005.714003-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210724073005.714003-1-hj.tedd.an@gmail.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
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
index cfef6d9879fe..5ad005dd6775 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1767,6 +1767,14 @@ int btintel_shutdown_combined(struct hci_dev *hdev)
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
index f19d438affcb..1ad066ef06f7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4118,7 +4118,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int i, err;
+	int i, err, priv_size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4204,6 +4204,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
+	priv_size = 0;
+
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
@@ -4213,7 +4215,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
-	hdev = hci_alloc_dev(0);
+	hdev = hci_alloc_dev(priv_size);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.26.3

