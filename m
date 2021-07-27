Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FCFC4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8786760FA0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhG0Xvw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhG0Xvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B0C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a20so538339plm.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naa9yAoIxU7KV0k4nabBW+sJrEj5izmp7EoZzkTLf8I=;
        b=QPfKi4LP+XLYOHRgz2b5fNKPIoNndUo6FScqCzRpEyRAbeXHzSw1aM7mbWuI5sFu87
         4W0d2ubAl5W4HGydC+SYoUcAGSaKEOg0rd+x/1SVf0iih9Jokb1cV7qapn+K9qjkb9Y+
         FQA3l99JghJe9pqzPNhbGqgM2He6LFpCGoNQDnZnDUenY2EWsDbsneXEmXqflbtG5H8e
         t7BjrHfumVtLW0vGOcQKRpma0kTJDQ2NAsqC9MRNGwqeFiamLMFlBZht2o1Zn7b55Sie
         xCd3ZzG+WV/OJc1hlCQJ4uUW/TKPw2gwx5yOPwMHZIdXdgj9+zakcwip0wXUWrXD6FQl
         pQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naa9yAoIxU7KV0k4nabBW+sJrEj5izmp7EoZzkTLf8I=;
        b=SvjY1nVkkT5Ro1hm8IigCVL+oimns64cld3eoc6gBZ0fFxQQV9+/vfgBbXjlZOB8iW
         t2vQm8EjxgnP1QORxjhGOq3byL5FSIrl7ELowPZ5of0TgZ1p0w8h0P77cqOQhO+8LgQp
         f3YaNsQmn04ZSa8laN1MlleJFimije8ivl1kJGr8DTZo2yIrVIgZKaoVzoMCGi/g4VUO
         cUT0+kHf+2Y8X+y3OLWRuRDoXEPpI4RoLM2jrkpl9lD2ONXP+7KwcToP04Stmz/W35LC
         27tKsymU5Ji9uJUYiAC/howUbzIwOg3rovZVRhDNNCX+yqS4aBoz5xfZ8EAT1WfLUyNF
         sNZA==
X-Gm-Message-State: AOAM530+OHqCgJoBlgSXlmCh7tH2IMvILQbXA9qE8pH/NBRl815zoZjU
        7erhpsYZMzMFkvYBgo40VElyaDSDjww=
X-Google-Smtp-Source: ABdhPJz3AVkxz+ZU0xG+rpNlxAymh4zoFcavPaLb5NpBitfIOfT9lI2L/yDD41dQF3hiAWotGscUIg==
X-Received: by 2002:a62:7d16:0:b029:32d:cfc4:279c with SMTP id y22-20020a627d160000b029032dcfc4279cmr25384650pfc.8.1627429905502;
        Tue, 27 Jul 2021 16:51:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 07/11] Bluetooth: btintel: Add combined set_diag functions
Date:   Tue, 27 Jul 2021 16:51:23 -0700
Message-Id: <20210727235127.173149-8-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
index 542fe0196ac7..e83df93faed6 100644
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
2.26.3

