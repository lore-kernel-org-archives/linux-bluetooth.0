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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CEDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC96D60E95
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhGXGuD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhGXGtm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B5AC06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so5705159plr.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oS4zyXwkKzlV7BHgukdVYjQlHtxq+306pU78M8tJwAw=;
        b=GNZw90kRXTwOq23iG5bJvaVXXj7kQxxbNiNzVlOm1jhjir3PjZaA9A4Ix5YAj9DUDk
         79nGsy223KwdZNU5+xMiEli2pbLpBgMgx/6Pl53gudX5Xi94p88rvHSHY/ap0KAYpmU+
         mmkqf7J2DzolmjLnPlZW3FbF6TILV0p4fzGlsDbwxnpI9VM8Gb9VR1lgidzFEZAoY4Bs
         X9YteZyxxm91+cP779Jy+/or2mdGus2fU8Yb0FVcBmyt1p2N50RTVWKn9j0OsFInpcrg
         RurY7glc3pvaXsL9BMn4+ihtehcNJodNlWq2eg1BH+g6vA6oaRX3v77dnSWQsu0xyYz3
         jXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oS4zyXwkKzlV7BHgukdVYjQlHtxq+306pU78M8tJwAw=;
        b=KIvAeO2OJhDhBE+qc8pcErOWNVUP82YksDrJui1uouP3swQRQQbdKY3mFYfotX6ukV
         vkclacww6byN8EhwQYzNUZ/CqeYTlNEKvZwMOzH7kPznNf+vVWbFQ1mJI+xujgeS3wUn
         tz7nqgJnfeK+JPy8X4xehKzRvN3gm267hgEl7deKEe2/UsWsCw194k3jwwIVOGkbgok4
         I9uf/V/CEd6wCnjw8G+tjtvCXrqm+9kEU7wi45kVy3lAH04UxLvUTJ3sREtMz3/MPqqk
         CDpXe/29+70co7NTN78B7HP/nqMSEyYUV/ORj9p6s/nYSnxDlJDQqoZDLvCkw6i0b3fo
         tQRw==
X-Gm-Message-State: AOAM533Z2ffI842AAU3YI+DCEYb7RrjWklkoXQwrFk+cA8QzzWqsvViO
        +oRL+rS2s5Z4Vs2v7vjgAyzdAcHgPpM=
X-Google-Smtp-Source: ABdhPJzsFkuMnTqEj6GIyB5pKn84LaNEnohKq8qoQcoPpoUTcCejUg9bHp9JeGd7QsaqaG5MBt8NXA==
X-Received: by 2002:a17:90a:564a:: with SMTP id d10mr7924031pji.120.1627111814727;
        Sat, 24 Jul 2021 00:30:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:14 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 6/9] Bluetooth: btintel: Add combined set_diag functions
Date:   Sat, 24 Jul 2021 00:30:02 -0700
Message-Id: <20210724073005.714003-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210724073005.714003-1-hj.tedd.an@gmail.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
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
index dd319306ebb0..7a58bd29fba8 100644
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
index 29b678364a79..d41b14208192 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -144,6 +144,7 @@ struct intel_debug_features {
 #define INTEL_FIRMWARE_FAILED		3
 #define INTEL_BOOTING			4
 #define INTEL_BROKEN_READ_VERSION	5
+#define INTEL_ROM_LEGACY		6
 
 struct btintel_data {
 	unsigned long flags;
@@ -156,7 +157,7 @@ int btintel_enter_mfg(struct hci_dev *hdev);
 int btintel_exit_mfg(struct hci_dev *hdev, bool reset, bool patched);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btintel_set_diag(struct hci_dev *hdev, bool enable);
-int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
+int btintel_set_diag_combined(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
@@ -216,7 +217,7 @@ static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+static inline int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 53bfe831b7bc..2d93c3612043 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4303,7 +4303,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->manufacturer = 2;
 		hdev->setup = btintel_setup_combined;
 		hdev->shutdown = btintel_shutdown_combined;
-		hdev->set_diag = btintel_set_diag_mfg;
+		hdev->set_diag = btintel_set_diag_combined;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-- 
2.26.3

