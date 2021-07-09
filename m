Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E543C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 23:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF4C613C2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGIXpc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhGIXpc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 19:45:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FAC0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 16:42:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso6968830pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GcsXNey5JPTZzzwym+kQ939mpw9C0mM8fDY+uip8xg=;
        b=bwB9EqypKX/0W6yj9guvkRc0Dodx3Z+ibz7DlwH+bp0gR1yn2utF/PJNUS/ki34P7G
         CJYYeLjJxo6FprXxE4uSIIAbmGhzuSGcrWIZQfWg/1ZxTjD7JNYBRzXtJoXwCcVRXQCm
         QKexo4nCQzlTel0FiXMokc7TJpn7uqEOO1TAnL4QhTIkp4D7dbQxbnfSnEuvmYCq4KgJ
         Drzz3HL/987R8TUn+e+PPe/FcEsgy3vYNeDqIc58BoD21YXKgxb5B4Zd7Jy7hK8PfA3B
         Xz2nd07YAgm42hMRoQkFitAxc3V0qE06NWl7RiNLP+cM3zKL4rQiP+SjzSF09A2q6Hsd
         FhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GcsXNey5JPTZzzwym+kQ939mpw9C0mM8fDY+uip8xg=;
        b=QHLIzjRvqyqECQpnghm/eE2RPE6Lxv64f8HvadQ13gMYDB63GJvA0rN11LXEBf0D1r
         lus99FqnDftHobrsX/CcDFgfps+w4rDyKsCHoeEjWaxTo3kehWJ5MDWj3riFbUDF6Jfp
         EPyKASBTFNCIdbuaXKiOhTb9qUvBQADERrSY+jClk3/ZycLVBlm17z3FY85a4nUkOaaG
         UzB5AZQf9rNBLXjorDgZVYKADDZlVA2Kwp8vmJ32Y2E/A0coIdp/J5/EcehnoAa342lA
         zKre6lzeMUSWQtXvy8NECZtIYlTpiTukL4xY//f4anFB2x+k4GUMqhGVyTPbvFPSPeDP
         iaGQ==
X-Gm-Message-State: AOAM533CM+/yltbvcQS5kd93QOzyZrtIEXqUbUqIrNE406Oo9AONV68G
        5M0eycP61FrZFriXpfonXr69P8/wcdS+FQ==
X-Google-Smtp-Source: ABdhPJynC6IFlOsPI0lrc8x382vhIExy214gXnoEhuoag3YV1epol5VCaiXkU91q2QW9ti98bmuHQA==
X-Received: by 2002:a17:903:4049:b029:129:dda6:cbf3 with SMTP id n9-20020a1709034049b0290129dda6cbf3mr9181881pla.6.1625874166513;
        Fri, 09 Jul 2021 16:42:46 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f18sm13519974pjq.48.2021.07.09.16.42.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:42:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Add proper checks for own_addr_type for extended advertising
Date:   Fri,  9 Jul 2021 16:42:42 -0700
Message-Id: <20210709234242.1646501-1-luiz.dentz@gmail.com>
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
 emulator/btdev.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1567713d2..f1c3a0a84 100644
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
@@ -4576,6 +4590,37 @@ static int cmd_set_ext_adv_enable(struct btdev *dev, const void *data,
 			goto exit_complete;
 		}
 
+		if ((ext_adv->own_addr_type == 0x01 ||
+				ext_adv->own_addr_type == 0x03)) {
+			uint8_t none[6];
+
+			memset(none, 0, sizeof(none));
+
+			/* If the advertising set's Own_Address_Type parameter
+			 * is set to 0x01 (or 0x03) and the random address for
+			 * the advertising set has not been initialized, the
+			 * Controller shall return the error code Invalid HCI
+			 * Command Parameters (0x12).
+			 */
+			if (!memcmp(ext_adv->random_addr, none, sizeof(none))) {
+				status = BT_HCI_ERR_INVALID_PARAMETERS;
+				goto exit_complete;
+			}
+
+			/* If the advertising set's Own_Address_Type parameter
+			 * is set to 0x03, the controller's resolving list did
+			 * not contain a matching entry, the Controller shall
+			 * return the error code Invalid HCI Command
+			 * Parameters (0x12).
+			 */
+			if (ext_adv->own_addr_type == 0x03 &&
+					!rl_find(dev, ext_adv->direct_addr_type,
+							ext_adv->direct_addr)) {
+				status = BT_HCI_ERR_INVALID_PARAMETERS;
+				goto exit_complete;
+			}
+		}
+
 		ext_adv->enable = cmd->enable;
 
 		if (!cmd->enable)
-- 
2.31.1

