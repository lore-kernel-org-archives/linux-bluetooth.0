Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1286FC07E95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 00:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71FA61370
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 00:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhGNAZR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhGNAZR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 20:25:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCAEC0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 17:22:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p9so178817pjl.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXbJfurgKICWNVQFX642RsimOUp1jbBIxlMZi53/Dow=;
        b=ajypaVSJuF2HuJVoSwN5C31vCHiRxT45MdAXl0Y45/WyQ3cF4T1Q3TtkJ1/U726X44
         7y+8g/BvGrbpBTm0jIzKwrW1+Uns8oSkyas0+4J4I4x8J1WAa4dSacOd0hj8VjO2nxK+
         hdPe1+S4a2bwcEihxacrlGdxQJ+uq/9XYbCjJqX82i4oPjIgkFugqEwrNZyfsLBog4+G
         WHDPWjgvEMp4RZBEeqAIv22Rf2hgzHCfAzkwOSyH4L3fWc59nYcHl11Ojnlo9aYS85x/
         2LJd3N0OPuORIs14umZHBU/90s8w/1LIQ50Nki1gW+Z99efk8bzUmyXQsCnHF2J8Knwg
         b5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXbJfurgKICWNVQFX642RsimOUp1jbBIxlMZi53/Dow=;
        b=Hr3uLYq3JorxlF+wwiPchWCdV+U+tIOjRM8njMIygHUQasqxCZGnT7DM8UPJtzKfuG
         4vz4GaR4stZiuza5NBi6CseMJSeekl13kb803TLirgC8jaGazzQQ2jHS/L66Xr33u8tO
         BzQ4c4u7RjHCnU6Uo7ee4+tMo6O6Jj6761p6+lvXzxSsbenvA0n8NqLLBqslnoVnvYah
         u59wYkwjch8yPQ4RDjE/y6xMuh8xbMwf6VQj9Yl9jaMVtIehmOsS4M67AoRWa8UDqtuN
         fvvBEBLZSTXrn7IcVoW+IrIVxqAFvWsmghNpVh1wzfmxTkkxcMLuaSW6QMP+fQXeYLmF
         LWVA==
X-Gm-Message-State: AOAM530gynOt/m1W06ilvja2qISHNE6SRmTqif7UOM2VHK9YFgzSuxsI
        rvIrHwgdgRqRlY2YnEHFc8uV2MfT9V3NwA==
X-Google-Smtp-Source: ABdhPJwJBG4NbLQV1FdK4Qdr1E1YJc64GQyOx8BgAYlNUqByJmmyuetbdYU5LTpQyrOfUbIU2oMyKA==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr898713pjo.172.1626222146235;
        Tue, 13 Jul 2021 17:22:26 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s15sm307818pfw.207.2021.07.13.17.22.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:22:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] btdev: Add proper checks for own_addr_type for extended advertising
Date:   Tue, 13 Jul 2021 17:22:24 -0700
Message-Id: <20210714002224.2632842-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

own_addr_type 0x01 and 0x03 shall check that a random address has
properly been set and in case of 0x03 the resolving list actually
contains the irk of the identity address:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2596

  'If the advertising set's Own_Address_Type parameter is set to 0x01
  and the random address for the advertising set has not been
  initialized, the Controller shall return the error code Invalid HCI
  Command Parameters (0x12).'

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2597

  'If the advertising set's Own_Address_Type parameter is set to 0x03,
  the controller's resolving list did not contain a matching entry, and
  the random address for the advertising set has not been initialized,
  the Controller shall return the error code Invalid HCI Command
  Parameters (0x12).'
---
v2: Fix checks for Own_Address_Type when is to 0x03 since it can work with
both resolving list _and_ when a random address is set.

 emulator/btdev.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1567713d2..b6142f176 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4538,6 +4538,20 @@ static bool ext_adv_timeout(void *user_data)
 	return false;
 }
 
+static struct btdev_rl *rl_find(struct btdev *dev, uint8_t type, uint8_t *addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->le_rl); i++) {
+		struct btdev_rl *rl = &dev->le_rl[i];
+
+		if (RL_ADDR_EQUAL(rl, type, addr))
+			return rl;
+	}
+
+	return NULL;
+}
+
 static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -4561,6 +4575,7 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 	for (i = 0; i < cmd->num_of_sets; i++) {
 		const struct bt_hci_cmd_ext_adv_set *eas;
 		struct le_ext_adv *ext_adv;
+		bool random_addr;
 
 		eas = data + sizeof(*cmd) + (sizeof(*eas) * i);
 
@@ -4576,6 +4591,35 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 			goto exit_complete;
 		}
 
+		random_addr = bacmp((bdaddr_t *)ext_adv->random_addr,
+							BDADDR_ANY);
+
+		/* If the advertising set's Own_Address_Type parameter
+		 * is set to 0x01 and the random address for
+		 * the advertising set has not been initialized, the
+		 * Controller shall return the error code Invalid HCI
+		 * Command Parameters (0x12).
+		 */
+		if (ext_adv->own_addr_type == 0x01 && !random_addr) {
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+			goto exit_complete;
+		}
+
+		/* If the advertising set's Own_Address_Type parameter is set
+		 * to 0x03, the controller's resolving list did not contain a
+		 * matching entry, and the random address for the advertising
+		 * set has not been initialized, the Controller shall return the
+		 * error code Invalid HCI Command Parameters (0x12).
+		 */
+		if (ext_adv->own_addr_type == 0x03 && !random_addr) {
+			if (!dev->le_rl_enable ||
+					!rl_find(dev, ext_adv->direct_addr_type,
+					ext_adv->direct_addr)) {
+				status = BT_HCI_ERR_INVALID_PARAMETERS;
+				goto exit_complete;
+			}
+		}
+
 		ext_adv->enable = cmd->enable;
 
 		if (!cmd->enable)
-- 
2.31.1

