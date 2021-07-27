Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE2D60F6C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhG0Xvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhG0Xvo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D9C061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d1so500149pll.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poDdS+mjq55XVF8DCA6fkrxGqvX6sArB63dSvSdWPXk=;
        b=qS7nuSIQ9pV4QfpE2GkNAkKDj3w5ICnN7pSRBInufVMR3p98ycrGisY+qDTGm9ftfq
         4PFMBPpSx0xQBf7qaQWms+lnCRx9w+2wy2rlpdF0HxDG3G+JtwfpDRb51f+AfHP3Deln
         5trvVJt9g17Ktx8wM1g9vsgnqmOpm/9THL6sbd81gZQGuFxK1mKHQRaZxQq/NjpD4yRz
         zW8AeeeT1j2zTelYpBMsw5cVJpnjcpTqHsquI4toVvnd35Ws9gGFY7PjklLAvXvxItI3
         AaJgYtMP0plryjs3ga92Aj/kjHyorqyO93pmjrZX8raBVfM1KAU8JAo48E8TCJKwjnFG
         L+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poDdS+mjq55XVF8DCA6fkrxGqvX6sArB63dSvSdWPXk=;
        b=BNHUZ8E+ivxYMeo35ZTgvqna8Ziw6hnbTjltoQc6e9H5by52yveuPHtInZ/9mzbCqO
         qmxNekCDki5RTB/1Un43AGaFC6vaKx+GViVooI8jqneMo7cAwCgOcWwAduS5BJ3LwV9n
         JNFcgAVmXzP9hHxC8SMEEu9+B8mILY5LOuPgkOgUqNIznf6pbYEsa9fzNGvsVdXIdxZx
         mTe7dKhM6ihq1fXFJWqNWefmBAD1Msx4rIJAusu1OPyKEluH+5rPLfOJ5XGyzTbwRrFF
         w2lMonnkHibkztTWlOAyayo72SUDO3O+AgK+kY+Qf4j6tRw05BZH9RCWC0/qSw3CPvrz
         Essg==
X-Gm-Message-State: AOAM531M2fM3I9562BKW6/quwo8CixLFyHgdJeuVPTIHa9q06tKha3tv
        /uvTjzzePIyCrZCiIzs/s/lQE/iaozQ=
X-Google-Smtp-Source: ABdhPJyYNorwq6AY/PD2p9p2mgnfqF7cF7xTgT4POVEDkQiUauejEfecLsh73yk8p9i8K+mOiwS/jw==
X-Received: by 2002:a17:902:c64b:b029:12a:d8db:d0fe with SMTP id s11-20020a170902c64bb029012ad8dbd0femr20432956pls.11.1627429903108;
        Tue, 27 Jul 2021 16:51:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 04/11] Bluetooth: btintel: Add btintel data struct
Date:   Tue, 27 Jul 2021 16:51:20 -0700
Message-Id: <20210727235127.173149-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
index 3382d75b1969..4cd49a758bb0 100644
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
 
-	hdev = hci_alloc_dev(0);
+	hdev = hci_alloc_dev(priv_size);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.26.3

