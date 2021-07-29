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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DE760F01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG2SgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhG2SgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06737C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so16992081pja.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYZCb66LvyPqthQDoGRZL0E7+3rchSKoHIQDv8QV2d4=;
        b=qPYps78EdDWlvFb9lOY/MHt9MA/ODAtNYh5sDSApcBP1eJj3PQa/MI8AOnCJvwF1ww
         7evLwBuB5/BOHhMY/BLqAqEh2tgoSnaTs8zxposq0ITcX8nkka9v/ydBpw2DXeuFO9Uq
         AKlEoumVCTKRf9OTt8y2oDRvdYRdar9Pkh2SS0/jN78M2SPdpwv5/g+jZSyDn+llFhgW
         zFroyI8611MlB0fRQru1/Zwa8EAXq1/FC+5ErEskyAF6qW7eXdmsgArYD/1sQXz3RpXf
         YY9hvDs6iVRTPl2fEkxqQrfNZ9C/Nbg1HoWM0PJ3znt+IepwX7xhcWtMQmpSFuHCjg0E
         5cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYZCb66LvyPqthQDoGRZL0E7+3rchSKoHIQDv8QV2d4=;
        b=KJrMxgqmWkt1E1o3nCpVCwQdASrQopbTyEuNK2vH1zM/Lyp1DwUfHL8sJIuUp1rr3T
         zJeNMadKdRN52W1rXKjDN2f9vFysijqnBi9sIXRw0UBjvb5a4u8F8JRSeiusPWo+2iXQ
         gN4yMQx4sftcU0mbzLy/pd2SSVPfOqwIU+dywOatTi8jLjbiHPwz1L2m5vP2k+vmVIcw
         Wi0LWkGUBr5jIXzrQV4N2bvOybLm6w/1lWksKQVOrbaU2WsU81asoae3EnDLckMWgZjU
         /lLMNdVWmNfIoqcc2leQKsl7wn4bSDEGc6wurfHWAsQySme2OiMSrZF4VojgEdGsCekx
         CXcw==
X-Gm-Message-State: AOAM532vfYqsruFXkSuh4fhvUCJkrD7JgPcgQrp+kV3aklV9YljneNMh
        Ndxr9iiXxYum3U6emG4ulzjvcjy+grY=
X-Google-Smtp-Source: ABdhPJxrsZnUqZ0GHWrGPwwsE4Aa4RyTmcOIFtzxifKMuanfJ3tBpMy+QTb0RxbPXTBv6HjzetwRGA==
X-Received: by 2002:a17:902:ed95:b029:ee:aa46:547a with SMTP id e21-20020a170902ed95b02900eeaa46547amr5824172plj.27.1627583770336;
        Thu, 29 Jul 2021 11:36:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:10 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 07/11] Bluetooth: btintel: Add combined set_diag functions
Date:   Thu, 29 Jul 2021 11:35:56 -0700
Message-Id: <20210729183600.281586-8-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a combined set_diag functions.
It also changes the btintel_set_diag_mfg() to static since it is no
longer used by others.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 23 +++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  5 +++--
 drivers/bluetooth/btusb.c   |  2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 4e72d806387c..24b79f449527 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -164,7 +164,7 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_diag);
 
-int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+static int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 {
 	int err, ret;
 
@@ -180,7 +180,25 @@ int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(btintel_set_diag_mfg);
+
+int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	int ret;
+
+	/* Legacy ROM device needs to be in the manufacturer mode to apply
+	 * diagnostic setting
+	 *
+	 * This flag is set after reading the Intel version.
+	 */
+	if (test_bit(INTEL_ROM_LEGACY, &intel->flags))
+		ret = btintel_set_diag_mfg(hdev, enable);
+	else
+		ret = btintel_set_diag(hdev, enable);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(btintel_set_diag_combined);
 
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
@@ -1723,6 +1741,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
+			set_bit(INTEL_ROM_LEGACY, &intel->flags);
 			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 4a35762c3220..abc438b9c62e 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -145,6 +145,7 @@ struct intel_debug_features {
 #define INTEL_BOOTING			4
 #define INTEL_BROKEN_READ_VERSION	5
 #define INTEL_BROKEN_LED		6
+#define INTEL_ROM_LEGACY		7
 
 struct btintel_data {
 	unsigned long flags;
@@ -157,7 +158,7 @@ int btintel_enter_mfg(struct hci_dev *hdev);
 int btintel_exit_mfg(struct hci_dev *hdev, bool reset, bool patched);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btintel_set_diag(struct hci_dev *hdev, bool enable);
-int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
+int btintel_set_diag_combined(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
@@ -217,7 +218,7 @@ static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+static inline int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f87c600d026..01ec2a2d0a1a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4322,7 +4322,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->manufacturer = 2;
 		hdev->setup = btintel_setup_combined;
 		hdev->shutdown = btintel_shutdown_combined;
-		hdev->set_diag = btintel_set_diag_mfg;
+		hdev->set_diag = btintel_set_diag_combined;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-- 
2.25.1

