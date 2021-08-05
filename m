Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F736104F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhHEAcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhHEAcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89597C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso6092895pjo.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8OAH8c1lLzjg78eC9p7DzWrbYJIHjZHpGhDs2C0+Smk=;
        b=YhaxkCG0AVRCoaxVt0s+upDcSwcMgcZWiHR4eEL43b2ntZfkRQdMl09bHbjnnH8eqi
         BHD4iUJpyJt823ADbt0rOq+PMsEKGlx904u+6u2uJ5kGBCMGdU2OUTNLNPgFv0FeC0Eg
         EfTcNWDhbHYg7YbHvzAazjh8g377YJC4vI39HaVrGRusxD1XgAXaY3VkM332Yw6WVr5j
         4mB6p02lKCaLe82rpuguDBM5rpVMkhj/WsKHwGAchiMEc3UpUcpy9IHoAwVNDdU1ReVq
         8q3I3LznxVcrcuz7wq93CauZ7E54/0FZOrxl64LkALjgJfYO1Jc+AESL37oWRGvZ9Mef
         hmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8OAH8c1lLzjg78eC9p7DzWrbYJIHjZHpGhDs2C0+Smk=;
        b=CzpVC+IC366ZzCqDjAgAtpvSh8rNLhz7cvlAD5ChnKwkCFYfI2dWkQoGHgK7dMDSCo
         qtJXBpr4de8Y7rlhCldpwGqLpKZEArUT3h7YgUxtm7GTPB62vG4TkduA9JVdwH2c77nH
         ociNIzoVpczBgcNXLL177FILozGDS529uVamYhKu86aOeugwBpzlYZ/f+MSA4GN0DeoB
         aGy1Q5CQGhw1yCSWrVwMBl4WAoV7aQwKyBzItltWza7iryizZCRQ+PruTAyjIX6mIVJ3
         QDmXsx7O8KWQlWtW7xNUdk4pOvxh+Lk6GMVlPDkyjkNz8rEj3RKEO3W0kQ0YyGLqN093
         twCw==
X-Gm-Message-State: AOAM530RjOI+Sc8U5CX6X29PCIcLgdS6rQRFVsyNIvfPCpzgyweUmprA
        UALV+zyaqm3ErA555tPZGp/NvU7T4aM=
X-Google-Smtp-Source: ABdhPJwvYUAvchmR9ImxsamDOcDBslWN6QNisOty8ISf8iPxR1lRfsHyNQKT7/Wrey6DrO+AafvTuA==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id b10-20020a056a000a8ab029030ca10b3e3fmr2021998pfl.40.1628123546928;
        Wed, 04 Aug 2021 17:32:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 04/12] Bluetooth: btintel: Add btintel data struct
Date:   Wed,  4 Aug 2021 17:32:11 -0700
Message-Id: <20210805003219.23221-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a data structure for btintel for btintel object, and the
definition of bootloder states. It also adds macros to set/test/clear
the flags.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.h | 40 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c   | 11 ++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 2c87fd029ddf..fb5e73ef71eb 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -138,6 +138,46 @@ struct intel_debug_features {
 #define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
 #define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
 
+enum {
+	INTEL_BOOTLOADER,
+	INTEL_DOWNLOADING,
+	INTEL_FIRMWARE_LOADED,
+	INTEL_FIRMWARE_FAILED,
+	INTEL_BOOTING,
+
+	__INTEL_NUM_FLAGS,
+};
+
+struct btintel_data {
+	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
+};
+
+#define btintel_set_flag(hdev, nr)					\
+	do {								\
+		struct btintel_data *intel = hci_get_priv((hdev));	\
+		set_bit((nr), intel->flags);				\
+	} while (0)
+
+#define btintel_clear_flag(hdev, nr)					\
+	do {								\
+		struct btintel_data *intel = hci_get_priv((hdev));	\
+		clear_bit((nr), intel->flags);				\
+	} while (0)
+
+#define btintel_wake_up_flag(hdev, nr)					\
+	do {								\
+		struct btintel_data *intel = hci_get_priv((hdev));	\
+		wake_up_bit(intel->flags, (nr));			\
+	} while (0)
+
+#define btintel_get_flag(hdev)						\
+	(((struct btintel_data *)hci_get_priv(hdev))->flags)
+
+#define btintel_test_flag(hdev, nr)	test_bit((nr), btintel_get_flag(hdev))
+#define btintel_test_and_clear_flag(hdev, nr) test_and_clear_bit((nr), btintel_get_flag(hdev))
+#define btintel_wait_on_flag_timeout(hdev, nr, m, to)			\
+		wait_on_bit_timeout(btintel_get_flag(hdev), (nr), m, to)
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ce05085ff158..887b8839e4b2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4299,7 +4299,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int i, err;
+	int i, err, priv_size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4385,6 +4385,13 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
+	priv_size = 0;
+
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		/* Allocate extra space for Intel device */
+		priv_size += sizeof(struct btintel_data);
+	}
+
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
@@ -4396,7 +4403,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_acl = hci_recv_frame;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.25.1

