Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5491C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 11:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7C1221EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 11:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHy1N9xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgIKLpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIKLol (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 07:44:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48DC0613ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 04:44:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so7130554pfd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q18azJC5D1cvYz5vDthfR7Zqd2AvwFwi9A+uqGSXyDA=;
        b=YHy1N9xUfGGLEnVGBdWUISlD/1FxSLOt3E6Q11tLVanuwc1jGIarlk8QgNV5DrXGMI
         ft9xm4bUkMDf+jMdUSU02c6ekDjYhTRcyktezNLLJ/A1iLl7wMMc/uvhX7Q0/a+Kx3RO
         vWLWtshEJbDl3DnBGeck5qsWqCHKSXsFKP15s06tG4Iv3gwzz6bxAprXeDQb3+SmSLw/
         BSjliDcJyoiUPQZIZ5L9iK0jpriewPfnFcNpuREVvCchna9umGgPOLBqGfZ6p6SVR9nE
         wCF9zf7Dhnc0GQqEjOWmkGB/AWJU/NXWQ+wh7oswWwQJbxXuF5Sg6ZfHBarHsR9UbJnT
         PSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q18azJC5D1cvYz5vDthfR7Zqd2AvwFwi9A+uqGSXyDA=;
        b=K+LF7mfmi/j3zD2fzf/DmeaBRIGjN3yYhfzwXVxZiZ/t0iiQXlSvPg+PHt72ICh0ll
         Wi+gSJRKXsLOruGB7Ufw07ioOUw44L3xOb0tB/S2fyqP4QJKWt9l9Erirt6QCKHtPM7x
         es+jQXU/cxrYZRBp15oGH3P+zm5gPMW1XYvkNjRmBNJhpODDiq1qkFQ3jg3RvBVbU0C+
         zC40m0GcbKpfOYpit5WRukfr3AfJUY+nzGeZKcEntpSMPMjQgzNInlyAXzTbU+/fVyg/
         6BqEYJjsW7YZ1yeKVrHmORPhCiCRbeaZXW7sbQjIaOhoNklh2CJq62FmZ+JzL9p/19v/
         naBQ==
X-Gm-Message-State: AOAM530ftGOtCA1GrhySGjBvwvdeLkDP0axrdUaF+hj8AkJx4I2Fc8GC
        InYZLgvpZFxiTc1JzZZrVKh8fAN2/8wvXA==
X-Google-Smtp-Source: ABdhPJxW6ZMhsCylqNveuw7p1QBeKZSsWPjz5InZC1C4uHadKORW/2z0Ssp9PtEVud3rtiCzHYId7g==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr1689277pln.3.1599824679776;
        Fri, 11 Sep 2020 04:44:39 -0700 (PDT)
Received: from localhost.localdomain ([122.171.170.126])
        by smtp.gmail.com with ESMTPSA id k2sm2135675pfi.169.2020.09.11.04.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:44:38 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     kiraank@gmail.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Refactor firmware download function
Date:   Fri, 11 Sep 2020 17:14:17 +0530
Message-Id: <1599824657-19464-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Split firmware download code into two functions - one to download
header and other to download payload. This patch enhances readability
and reusabiltiy of code

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5fa5be3..4ad0800 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -19,6 +19,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+#define RSA_HEADER_LEN	644
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -626,12 +627,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_boot_params);
 
-int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
-			      u32 *boot_param)
+static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
+					      const struct firmware *fw)
 {
 	int err;
-	const u8 *fw_ptr;
-	u32 frag_len;
 
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
@@ -660,8 +659,21 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 		goto done;
 	}
 
-	fw_ptr = fw->data + 644;
+done:
+	return err;
+}
+
+static int btintel_download_firmware_payload(struct hci_dev *hdev,
+					     const struct firmware *fw,
+					     u32 *boot_param, size_t offset)
+{
+	int err;
+	const u8 *fw_ptr;
+	u32 frag_len;
+
+	fw_ptr = fw->data + offset;
 	frag_len = 0;
+	err = -EINVAL;
 
 	while (fw_ptr - fw->data < fw->size) {
 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
@@ -707,6 +719,19 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 done:
 	return err;
 }
+
+int btintel_download_firmware(struct hci_dev *hdev,
+			      const struct firmware *fw,
+			      u32 *boot_param)
+{
+	int err;
+
+	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+	if (err)
+		return err;
+
+	return btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+}
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
-- 
2.7.4

