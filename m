Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09182C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B3A64FFA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCKSjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCKSi5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 13:38:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC40C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 10:36:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a8so4130202plp.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=BdVR68284gxJydNyFk5b5RvTyoIgTl6fYipG7tiLT6A=;
        b=h6qrwfxC2OVcWJf8Or4tz9zxI2jxPCqXgAFy1tarQRR9JhlCeUFfQlxBQZB9kW+nKb
         rojOHVIF99hug7Xrlh+94E6DMgpx48oLj2LfB6MECt12JxQegrYDRtQau8SwuSxLaibt
         MLFVyZcLM18P9LzE49juyj+DdVZDvU07Y1vz6CmLDnHlTQxj6Pu3GwEjb9zt1Zl4acIG
         QiUhpiRvc8MEsd3KDbq8t/b7+kgT3CB4j+/H077wo99vXLYC6/fA4DIJvBKhdMoRkScm
         Kr7JwGs65DkzIicKdRD81tBoqxcrQIZ0OHyEM5arukEN6o2Zy0lzTOjHQXA3eQxaX2DR
         Duqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=BdVR68284gxJydNyFk5b5RvTyoIgTl6fYipG7tiLT6A=;
        b=HnaQgdKm6ctYIFMOrwfQW+a9faZyqAn8mu4i4/zlYSteGjLbVFmk3OiQdcO6SW4XcG
         cqCMBdAf9o+Vl45ouDp2qyIty5TL/U8DYtIH6LxPy+KfVNuCMa8/RbHNRTXA/EueYPFu
         1TXkYOl2bvpfY6sRMx+VOG/d9r64njiyvYaBAjFcOw8nfOaryf7/9TfnnH3/1WZVtXhV
         WBS7+w7mdSAQsyN+ofCJh6zdoGidXcXh1RrzIm/aWeAUp9yJfQPDnrCZpe10AwHqml/w
         jr/o6RaCEQtC7jgyxfA/u0eIfS8Mnzj60RQs62N4vy3MFlgas08SOWfKS0uc6VYzuIas
         geAw==
X-Gm-Message-State: AOAM530fk66Plw0aYyRhDCpULFoRCo6b4Z3kgusU/MUSf1Eh5M5yyVYe
        jQHvUsS+FZFcoBS/aBe/OXNVlpFAoQY=
X-Google-Smtp-Source: ABdhPJwTuAq1g+lVFanB8HE25Go4Vrh8tMk3oQz0SBFKCa2BCMxS64tz4xxrMUvc4O2uJObcTILLjg==
X-Received: by 2002:a17:90a:bf15:: with SMTP id c21mr10169052pjs.160.1615487801666;
        Thu, 11 Mar 2021 10:36:41 -0800 (PST)
Received: from localhost.localdomain (76-14-108-251.rk.wavecable.com. [76.14.108.251])
        by smtp.gmail.com with ESMTPSA id r23sm3192094pje.38.2021.03.11.10.36.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:36:41 -0800 (PST)
From:   cdwhite13@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     chris.white@dolby.com, Keyur Parekh <kpare@dolby.com>
Subject: [PATCH BlueZ 1/1] emulator: Periodic Advertising Command
Date:   Thu, 11 Mar 2021 10:35:50 -0800
Message-Id: <20210311183550.11150-2-cdwhite13@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20210311183550.11150-1-cdwhite13@gmail.com>
References: <20210311183550.11150-1-cdwhite13@gmail.com>
Reply-To: chris.white@dolby.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Keyur Parekh <kpare@dolby.com>

This adds support for Periodic Advertising HCI
command in the emulator. These changes are the
first step in making the emulator useful for
testing the LE Audio Broadcast feature
---
 emulator/btdev.c | 50 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c824f48ff..749fbafa7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -141,6 +141,12 @@ struct btdev {
 	uint8_t  le_scan_own_addr_type;
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
+	uint8_t  le_periodic_adv_enable;
+	uint16_t le_periodic_adv_properties;
+	uint16_t le_periodic_min_interval;
+	uint16_t le_periodic_max_interval;
+	uint8_t  le_periodic_data_len;
+	uint8_t  le_periodic_data[31];
 	uint8_t  le_ltk[16];
 	struct {
 		struct bt_hci_cmd_le_set_cig_params params;
@@ -3934,22 +3940,54 @@ static int cmd_clear_adv_sets(struct btdev *dev, const void *data,
 static int cmd_set_per_adv_params(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_params *cmd = data;
+	uint8_t status;
+
+	if (dev->le_periodic_adv_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	} else {
+		status = BT_HCI_ERR_SUCCESS;
+		dev->le_periodic_adv_properties = le16_to_cpu(cmd->properties);
+		dev->le_periodic_min_interval = cmd->min_interval;
+		dev->le_periodic_max_interval = cmd->max_interval;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS, &status,
+							sizeof(status));
+	return 0;
 }
 
 static int cmd_set_per_adv_data(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_data *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	dev->le_periodic_data_len = cmd->data_len;
+	memcpy(dev->le_periodic_data, cmd->data, 31);
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA, &status,
+							sizeof(status));
+
+	return 0;
 }
 
 static int cmd_set_per_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	uint8_t status;
+
+	if (dev->le_periodic_adv_enable == cmd->enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+	} else {
+		dev->le_periodic_adv_enable = cmd->enable;
+		status = BT_HCI_ERR_SUCCESS;
+	}
+
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE, &status,
+							sizeof(status));
+
+	return 0;
 }
 
 static int cmd_set_ext_scan_params(struct btdev *dev, const void *data,
-- 
2.21.0 (Apple Git-122.2)

