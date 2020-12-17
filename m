Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C6AC2BBCF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0459723A56
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 22:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgLQWz2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbgLQWz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 17:55:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB44C0617A7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 14:54:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id hk16so241952pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pX4/p0ajAVR2V3H5po7317NWmJXfT5ZtsIuTWx4ykXE=;
        b=UW3JZDeAgJB94y8VYny9htsdJS/3QwO6xIlcMTtpJTsXxc79KPHZnxu2NTdc+7SdwW
         bTKMwyLvgZUMCdMT8M6dbZFg3RCqyWA33UuXdhVgLQ8Gvu9fWLHBw6Ssj1ntU78tCEvZ
         MoGZtq+EU1cOnKI5KA1J9e3VO+5rp9G4M4owA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pX4/p0ajAVR2V3H5po7317NWmJXfT5ZtsIuTWx4ykXE=;
        b=G5YNEkEcxLELVlyMsl+SkLqKx58oUwLrS8DHnq1+n5iAwlU3N5PQjZx0tJTfYoxkN7
         ZQ3QPhjnVlJ4Q4AZ0l9sA5ZGKLMOr6bLIOr0CgO0+IeqQs43Eyld5cSWTktGRkHf9cpt
         0BFHI8Q3Jwl0wkTbP+8KLL8SZI1lZnGn9J8FmEUrO3NQ+2uBREIr4iZKFxS71HoPon/f
         /iKh8SdLX0UAeA2dWtelifiYRiYJnRdsqmHQNlnZjR72vV0tfW3oykRssTB9UAtL2nyd
         VrPksR8kqyfIBMKyZU1dTLNY95orVCAeffLSBPCpKGlQETkDJTHj6gh5SJ/DBZUvGr7X
         W5Mg==
X-Gm-Message-State: AOAM53300RBQIkFLDJgaX2lV3lDJARapyabPV412qPdOqmrQpOQg6lSz
        6xKGFHDHCmdAspEDnmcEi+5IDSQ5lft3Fw==
X-Google-Smtp-Source: ABdhPJzvKmNeRUa70WCUPTD0GN+SfqGb+b30Uoxnskq565xw5R6HRynaT3Q8A4bGT+DlFjP8XFG+DQ==
X-Received: by 2002:a17:902:7489:b029:da:5aed:8ebf with SMTP id h9-20020a1709027489b02900da5aed8ebfmr1382008pll.35.1608245685742;
        Thu, 17 Dec 2020 14:54:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id q11sm7167639pgh.16.2020.12.17.14.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:54:45 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: btrtl: Enable MSFT extension for RTL8822CE controller
Date:   Thu, 17 Dec 2020 14:53:21 -0800
Message-Id: <20201217145149.v2.4.I369d2fc751e660f78e2930743aa368e0fe1bfd53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Realtek RTL8822CE Bluetooth controller support Microsoft vendor
extension and it uses 0xFCF0 for VsMsftOpCode.

The following test step was performed.
- Boot the test device with RTL8822CE and verify the INFO print in
dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btrtl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index a4f7cace66b06..94df4e94999d5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -658,6 +658,12 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
+	/* RTL8822CE supports the Microsoft vendor extension and uses 0xFCF0
+	 * for VsMsftOpCode.
+	 */
+	if (lmp_subver == RTL_ROM_LMP_8822B)
+		hci_set_msft_opcode(hdev, 0xFCF0);
+
 	return btrtl_dev;
 
 err_free:
-- 
2.29.2.684.gfbc64c5ab5-goog

