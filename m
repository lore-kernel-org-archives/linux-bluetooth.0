Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhLIUEZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhLIUEY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 15:04:24 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B43C061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 12:00:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g16so6077522pgi.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDEwuTZjHqekOo8wdieoZ8RAC3Iz36aYVeZnZooCtIA=;
        b=XCAgz5ZLvxH9H7iMEtGenw2ZL5vn20sBXqodeTo6tACuP8fpQV+qZZOrU402psjTEx
         hhBoikDw1W0iXCVCbcedOqzjoXqR6btbtWfasYWMjdHsxTt9Ea3aJDTSg9EA8FF6vQ1W
         BQGn9DE0Dg7Phm70B97LRD4+HAa0uP7IRZ+oqWx6RG1IzEsJSE3vBoPwknOB/2F7Ya3w
         uLgtIa1+UzkN3fJhfggF9iezMqzMYK/AEHTjM2ccJqJEIk4ZT/pajeILJmuqp/NEjwja
         Z4SaPqUsYjjgLoxUwRzuRFbcq2PZ+K7azHrNCUyviFZD1PkzZ3lKhiEcTp2gIxHKAKW0
         T9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDEwuTZjHqekOo8wdieoZ8RAC3Iz36aYVeZnZooCtIA=;
        b=gWcvtJDFS98EHAFLG3AQy4JyLFGzFUBrtoxpL8eo6k0uDkUhmuRE2Sb0KZB7BIDX+o
         BhLaPJIr9hjB9eUcfJR1qObJPQqXGTwbm5SVhW/kZCVNE6r+TZiGzism/D6/bDbrBhRM
         UrrCunPouj3EhO+06jvLKmHOxIKxaOLh2pumgkKFhjMqZhu7eyf0RphrwluJg2Rf8FXm
         TLKaV8lRWQDvElNBqoFgLzPpC1kghpdb+luQgkKqg2smQs4n6GVtNs7ArbYtuOKwhSlY
         hZJNvGRrH9/G1bJQABrI9akU4KQ9WeUGpfbjG4HiRVpfaFEV8yjfaQQgY39O7rmBSym3
         TzVQ==
X-Gm-Message-State: AOAM530RIG56I+hW4LH8nqo+w+s61KoKrwEVdERbSJSaOnjhALHWZZon
        SKc9QIeWa+ZjgmQToPWR+UXiIIeN7FM=
X-Google-Smtp-Source: ABdhPJyo0WfVweUjrosJpacUZvJeMsPOeYYXxPJ0Xyfps/7iAQ3Psk3/F9At5jVAIenXsyzsxEtsEg==
X-Received: by 2002:a05:6a00:181d:b0:4b0:4648:43bc with SMTP id y29-20020a056a00181d00b004b0464843bcmr4228178pfa.6.1639080050500;
        Thu, 09 Dec 2021 12:00:50 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:d0d6:ba5:fd1c:15de])
        by smtp.gmail.com with ESMTPSA id b2sm531440pfv.198.2021.12.09.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:00:49 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH DNM 3/3] Bluetooth: DO NOT MERGE: The Third Test Patch
Date:   Thu,  9 Dec 2021 12:00:42 -0800
Message-Id: <20211209200042.737140-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209200042.737140-1-hj.tedd.an@gmail.com>
References: <20211209200042.737140-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Test patch 3

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f35cdd382aa4..32ef9ef99362 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1174,7 +1174,8 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 			return -EINVAL;
 
 		/* Check if the CSS Header version is ECDSA(0x00020000) */
-		css_header_ver = get_unaligned_le32(fw->data + ECDSA_OFFSET + CSS_HEADER_OFFSET);
+		css_header_ver = get_unaligned_le32(
+				fw->data + ECDSA_OFFSET + CSS_HEADER_OFFSET);
 		if (css_header_ver != 0x00020000) {
 			bt_dev_err(hdev, "Invalid CSS Header version");
 			return -EINVAL;
@@ -1186,7 +1187,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
+					RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
 		} else if (sbe_type == 0x01) {
@@ -1195,7 +1196,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
+					RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
 		}
-- 
2.25.1

