Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E99C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 00:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbiCKAUy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244627AbiCKAUx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 19:20:53 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E319DEB7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 16:19:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l12so9997021ljh.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 16:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4N04DytqF3AnJ8zYie/C8QgJqUWJ24FtotOohZp3nIw=;
        b=V3wQO3LqJVxk691OVNtpXmCvjHZkS6S1YSaHrNcYUvJZxoLMSYgh2CfhiVsdX4Y4D5
         8zFVYH66/MItEsnhh9VUPoM1NnbmUao9a5nF/izI6QQCBp8cb8JFVufvEE8nFi9taq62
         ZsecFvdQD+cQO4GYke5TjyhCmv3hAZf25U5xja3uv+HuHKji2D0Jtmxmi5ErEZxbyJXj
         h8Z1WtLSbbGXMsrTLBXUsIKE0JtpHVqpTPskaMpCXhBSu8J5HSwY/uImz5Z91198xhvM
         EwhlkNo8U1g6QAjniVbhr1LfEYEqtMLLBqLD0idLTOVjTvDJ1zylrW5y9FnBV6GDgj7k
         qw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4N04DytqF3AnJ8zYie/C8QgJqUWJ24FtotOohZp3nIw=;
        b=q3bXM0KYT045RBXE3stJt9J/ozT7jI1RPxLDVFyWLcdoPWeq5sGt8ahiIPmoSFioRa
         P7R9ol1Vq7x5gyYtlwwLCthQvTMoLLBmOSjJfn9N+Mgj1Xp9Rv54fXhQyuxfUSLzDucV
         7ezIR8y/B6cvdeQb/RyrjFwqEvz2QhyA7lkY6Jdxpt0xSPEOzaDm31EpWOXPkNwizNGf
         pKbDxqG1BexuyKzzgwrkVKMbMmyQd9mOhT77YNPUSb+UIyuZn3bcATWuKULZPfPOoTOG
         mVgcU30C7c1l+AXiW2sb+6VKyIH74RNgIh3FtsiRMFeGTXMj7Uup8qBn4elmynw2AhPx
         bduw==
X-Gm-Message-State: AOAM530XfKI4bwk4GEGP1f/aHnznbc2ZOm6DnawMgfQvWk2IgGpuTCoH
        OYgTAUhYQdKE8LMyaToVrrBafA==
X-Google-Smtp-Source: ABdhPJxLEJ5e0pS7eU5hFSz30yqNvsSesv2kNr5/nAbCOdwAeXZUdZMcH2oAnZA0MyBzMU736H9uRw==
X-Received: by 2002:a2e:5459:0:b0:246:42f0:9d78 with SMTP id y25-20020a2e5459000000b0024642f09d78mr4646440ljd.192.1646957989281;
        Thu, 10 Mar 2022 16:19:49 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512092e00b004423570c03asm1255081lft.287.2022.03.10.16.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 16:19:48 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] Bluetooth: btbcm: Support per-board firmware variants
Date:   Fri, 11 Mar 2022 01:17:46 +0100
Message-Id: <20220311001746.480163-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are provedly different firmware variants for the different
phones using some of these chips. These were extracted from a few
Samsung phones:

37446 BCM4334B0.samsung,codina-tmo.hcd
37366 BCM4334B0.samsung,golden.hcd
37403 BCM4334B0.samsung,kyle.hcd
37366 BCM4334B0.samsung,skomer.hcd

This patch supports the above naming schedule with inserting
[.board_name] between the firmware name and ".hcd". This scheme
is the same as used by the companion BRCM wireless chips
as can be seen in
drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
or just by looking at the firmwares in linux-firmware/brcm.

Currently we only support board variants using the device
tree compatible string as board type, but other schemes are
possible.

This makes it possible to successfully load a few unique
firmware variants for some Samsung phones.

Cc: phone-devel@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/bluetooth/btbcm.c | 55 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d9ceca7a7935..9d1a8d80a8cd 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/dmi.h>
+#include <linux/of.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -29,7 +30,7 @@
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
 
 #define BCM_FW_NAME_LEN			64
-#define BCM_FW_NAME_COUNT_MAX		2
+#define BCM_FW_NAME_COUNT_MAX		4
 /* For kmalloc-ing the fw-name array instead of putting it on the stack */
 typedef char bcm_fw_name[BCM_FW_NAME_LEN];
 
@@ -476,6 +477,45 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
 	{ }
 };
 
+/*
+ * This currently only looks up the device tree board appendix,
+ * but can be expanded to other mechanisms.
+ */
+#ifdef CONFIG_OF
+static const char *btbcm_get_board_name(struct device *dev)
+{
+	struct device_node *root;
+	char *board_type;
+	const char *tmp;
+	int len;
+	int i;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return NULL;
+
+	if (of_property_read_string_index(root, "compatible", 0, &tmp))
+		return NULL;
+
+	/* get rid of any '/' in the compatible string */
+	len = strlen(tmp) + 1;
+	board_type = devm_kzalloc(dev, len, GFP_KERNEL);
+	strscpy(board_type, tmp, len);
+	for (i = 0; i < board_type[i]; i++) {
+		if (board_type[i] == '/')
+			board_type[i] = '-';
+	}
+	of_node_put(root);
+
+	return board_type;
+}
+#else
+static const char *btbcm_get_board_name(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 {
 	u16 subver, rev, pid, vid;
@@ -483,12 +523,15 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 	struct hci_rp_read_local_version *ver;
 	const struct bcm_subver_table *bcm_subver_table;
 	const char *hw_name = NULL;
+	const char *board_name = NULL;
 	char postfix[16] = "";
 	int fw_name_count = 0;
 	bcm_fw_name *fw_name;
 	const struct firmware *fw;
 	int i, err;
 
+	board_name = btbcm_get_board_name(&hdev->dev);
+
 	/* Reset */
 	err = btbcm_reset(hdev);
 	if (err)
@@ -549,11 +592,21 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 		return -ENOMEM;
 
 	if (hw_name) {
+		if (board_name) {
+			snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
+				 "brcm/%s%s.%s.hcd", hw_name, postfix, board_name);
+			fw_name_count++;
+		}
 		snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
 			 "brcm/%s%s.hcd", hw_name, postfix);
 		fw_name_count++;
 	}
 
+	if (board_name) {
+		snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
+			 "brcm/BCM%s.%s.hcd", postfix, board_name);
+		fw_name_count++;
+	}
 	snprintf(fw_name[fw_name_count], BCM_FW_NAME_LEN,
 		 "brcm/BCM%s.hcd", postfix);
 	fw_name_count++;
-- 
2.35.1

