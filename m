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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E995C4320E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3386361104
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhHDElA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhHDEk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965B0C061798
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d17so1631806plr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z8PSKvpjdNfTl8NDcEBh/UNS2fKZas5SGPxU9cVbZk=;
        b=Jg9VC5GnuUFh/1vkU+DSR7k0I4ILKYbY93qsc7LgIfLuFzQ79oNVnU4v3BoG4JYAPX
         7X/GE3gy1l/4rL85G1WgQokGrYlqc8Q+iUZXAB6CAXMMM+2TQzaaGLHQj0VjlLgPDLvo
         YM4dSJvLL2bNgfmN5xur64RXXAcnKKLBtp3RB7r7T4I5mNCcBoT6b7WI12KDzsu48+9U
         Cij6fVBQSDTl5JwpNKWfd3y8dozYO3xEiYTzXgF2lO1jsKCtVeIFl1M27OxX419M1EjC
         DTcO7006J/IrS+YkAY4KG/qIgM7Qn3lJGCDBvkAYErvJcmjgEnu4Qygnd+RozDTgBpOU
         Nyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z8PSKvpjdNfTl8NDcEBh/UNS2fKZas5SGPxU9cVbZk=;
        b=tekL0lYOoEOd1ItGMkvg9722PeSsq2h9C1zVPlnOvPEOkL3tS5Mv8v8Ktlqzm/ZORo
         WPfnCPDvWx1x6k2fZHdgLvzVgtwT1owE6uYUXzmhgeO0AHkpguUUN/XvHzHIp9mP7CMy
         KtQT4ZjSS68YhQATYBX1KLGYyGnwETNTIFM8uKGWMx0JFbFe3fveidUqWrucS5KeI9Ue
         o0asopEutSSLeaOd+zy9vQlXJjrTzAqO1gXWevBfYBja7aXI6Kxt00vdDMbGEVHsZxae
         tzFZC+7h0tejvZWvCWEwltYJU1BjCx6hyGIT5iX2kxPfRFTtzugvRqqAEkA1shpmmhEV
         o3eQ==
X-Gm-Message-State: AOAM532peubTLBv3zF1i4cEdVs1W3M+DAe0b0ycjliQCMdXkyXug9ZGM
        /akcBHm1wAolZj4knLu6weXBR9To+u0=
X-Google-Smtp-Source: ABdhPJzTc0hg7+GCnCApASRezZB70gA4N0EdRMNITCKO4ZVOfMLw1OgY3eEMIrvUiITSNDvDZDfk3w==
X-Received: by 2002:a17:902:e890:b029:12c:d32a:9fe8 with SMTP id w16-20020a170902e890b029012cd32a9fe8mr2245801plg.70.1628052042883;
        Tue, 03 Aug 2021 21:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 04/12] Bluetooth: btintel: Add btintel data struct
Date:   Tue,  3 Aug 2021 21:40:24 -0700
Message-Id: <20210804044032.59729-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
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
index 54a951ee00ce..53216274764a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4147,7 +4147,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int i, err;
+	int i, err, priv_size;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4233,6 +4233,13 @@ static int btusb_probe(struct usb_interface *intf,
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
@@ -4242,7 +4249,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(priv_size);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.25.1

