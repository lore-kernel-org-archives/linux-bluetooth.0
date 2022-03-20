Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6462EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Mar 2022 22:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiCTWbV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCTWbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 18:31:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6686B13CEE
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 15:29:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q5so17699218ljb.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4k9/eGxp1ngP7ZHfwyFoqk+ptJEwhUWytl73UTJLaA=;
        b=NMeCFoI+ZBV05Jqj4iIt1RNA8jy0nAxBY7tq/F1Cd3YiYCvyuKP+cCJs3QTHpNvGJU
         cCM8Tfyxgu+SR/pncd1RAIFd933mdtOyjTTf5cPZVL4QqaDfLj2FXFafpZ7kTgNp9aQ7
         9o9gEiOIdNhHMCRcPWhOyCvWt/V4Mfxy7hxedZdh4co3kfpqWfMLOVWi2CcPSp+rL+mr
         u4OyYNAkCao4G40/eY5GEMxICW2ufTt2BPLErDNTa+HX+EoPm3u971vgdJlIc3aYflVN
         DZ/9GXKKZWycd3jZpV7Y1+gS9dX/Usmm7dyZHdjVXm8sBfbDLWHfwC3Wh2kALgIYfq5P
         uJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4k9/eGxp1ngP7ZHfwyFoqk+ptJEwhUWytl73UTJLaA=;
        b=Ow3Dn8UWmdnkCNtlB98+3ZgHuY3dBtHO5ABWlyOKvYrPSIyKidRwIEepk1T3Emm/6U
         n9Kvs3LpPWCj7xbc5o2ZfXv/zpImsNO80et+3TFUCtPId8m2HTm8FmODaWBom7E/8PuH
         dz7rRPsj3WAkyu/nQ/NAUJIZp4v9xtRpkmP0PLcceVuxajYNoFwnyNYKKKpVLqpry2gg
         KXPASHLpiNywHmwuO+FsVYhmoSBoEf5mg0JVf7SALAXI+c+0kZ35v7HzFTEya660PWnm
         7oFW5cUBmR9pmFhuIfEVBZKq0QWwdf2Ynvpe/KEk0nJOgGDdbyBwX2YYO3EXoJoNdoyc
         0big==
X-Gm-Message-State: AOAM530aDOBacgx95ER1RotcIe4dokBdDDrnS/we2MWeWJtIcaKXd64q
        cKJMySMSDWG7eFrjXu43gnFGsQ==
X-Google-Smtp-Source: ABdhPJz+SheIZfRowJFaEw24BF6RWxAKhEnEwNwXjKQgVkKv4k5OFZ6mvX/gcBPoUJpsqhw3aAQUqQ==
X-Received: by 2002:a2e:a7ce:0:b0:249:862b:503 with SMTP id x14-20020a2ea7ce000000b00249862b0503mr1013537ljp.369.1647815394625;
        Sun, 20 Mar 2022 15:29:54 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y34-20020a0565123f2200b0044899dd2048sm1646053lfa.48.2022.03.20.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 15:29:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2] Bluetooth: btbcm: Support per-board firmware variants
Date:   Sun, 20 Mar 2022 23:27:49 +0100
Message-Id: <20220320222749.1502856-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Put the ifdeffery inside the btbcm_get_board_name()
  function instead of having a separate function for the
  else clause.
- Drop pointless NULL assignment to board_name
  variable.
---
 drivers/bluetooth/btbcm.c | 52 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d9ceca7a7935..92a2b7e81757 100644
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
 
@@ -476,6 +477,42 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
 	{ }
 };
 
+/*
+ * This currently only looks up the device tree board appendix,
+ * but can be expanded to other mechanisms.
+ */
+static const char *btbcm_get_board_name(struct device *dev)
+{
+#ifdef CONFIG_OF
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
+#else
+	return NULL;
+#endif
+}
+
 int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 {
 	u16 subver, rev, pid, vid;
@@ -483,12 +520,15 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
 	struct hci_rp_read_local_version *ver;
 	const struct bcm_subver_table *bcm_subver_table;
 	const char *hw_name = NULL;
+	const char *board_name;
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
@@ -549,11 +589,21 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done)
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

