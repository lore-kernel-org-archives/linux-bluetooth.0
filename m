Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085F8C12002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 23:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF60B61377
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 23:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhGOABT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGOABT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 20:01:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1D8C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 16:58:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y4so3453843pfi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXbJfurgKICWNVQFX642RsimOUp1jbBIxlMZi53/Dow=;
        b=NXHp2E079OeHRNGpLjpZK1Qxt3ZkqoT3PYJzWP6KYrB6rQXNckPZ/NXyfGR1qlXYna
         pUetWUSDdpx9wVu0IJaz+1GsTTdLDxkQnQQiP7GuNNB+rI/NYRDiC7NHZ1pTYxW2WYH8
         ABL3DQv4QePBXm2EJwMJ380fC6pMwA7CB32Y1tsnOHuUjnRrL9wLkoimvI2vvn9/9Sxh
         1C05PR5vqCGWdrp/+BMVE+VAeaVNANHdcgkLTVwM7Lp359Ujfo4qXEJG3Mn5uF1G7IjV
         TVN/5WCjqDERv8t6dTwZsNu2tpsAsb1I85q2XFezgNVI3TzY4/s7EuVWuPnDoqK4uuTL
         XHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXbJfurgKICWNVQFX642RsimOUp1jbBIxlMZi53/Dow=;
        b=bdPqalEGv+zQotMYClekxdmSgMFZzMYe2FLgXhKWDq+YYF00bAWuKJzMkF4+SjX3xq
         PGe8VWg2nN+5chT0Fxn4l0rZDfZUs/NSVqQHMZ699caxlnqNAupCdgQoJN7w4dLwwCQr
         HIdLYHzM9kQhXVzJ5Wq5ebJrFrV4o1ufx9Z0VyYhP76N4GZo1oUFhpAvTxNIfBOQ4NpP
         Pd/iRVz/7W7cIeC+Q2jtZan/LTH1loRlPNj/Bu731IpyU7t4lq2fxTmh7DojIWtnZvXA
         qbWHv5uC7mGojI03vZ74Ua6Af/uL+zwVqJpoYCV5f1vc74uRkunUb+DPE/B/QkYiq6Zb
         Bz7Q==
X-Gm-Message-State: AOAM531yDk3hsKtAZ4BMrrZ1XSErPY28iRvlF/5rTHpjFjyDJffXDpTd
        v8i3jkw/sf9TaQb0lrh93ksw45EQLDTOhAKf
X-Google-Smtp-Source: ABdhPJyR6mrkED29y4CYoVNdQfgNCbrwETLjAfMi4YhJ32Lqs7GK72GCIMNqNHVoish/aW5JqnZWww==
X-Received: by 2002:a63:b48:: with SMTP id a8mr604421pgl.169.1626307105462;
        Wed, 14 Jul 2021 16:58:25 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b18sm6985241pji.39.2021.07.14.16.58.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:58:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] btdev: Add proper checks for own_addr_type for extended advertising
Date:   Wed, 14 Jul 2021 16:58:23 -0700
Message-Id: <20210714235824.2992460-1-luiz.dentz@gmail.com>
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

