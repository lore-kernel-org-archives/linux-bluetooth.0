Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDDC2BB9A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73FA23715
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Dec 2020 07:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLQHTU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 02:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgLQHTQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 02:19:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2220C0617A7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be12so1595656plb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Dec 2020 23:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6D4li/EoV9+RBhAhlhd47010lIB1udrd5aMVBy+LBG0=;
        b=LQKMSNnkir22KpN1Z0gP+35Flb1r2VQnAy78yipBX7LE/zlA1cl3HahIPeD6SyNV+h
         XAPSmIFx/4SkHjBFvjk80ViJf080m1PYDShks/JjkLMyKWeCX65fbIlQOa/Q0jwNxkSA
         uh0OpWOF8LaUh7W9uTAWqq7F5WKWhcPVbFrCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6D4li/EoV9+RBhAhlhd47010lIB1udrd5aMVBy+LBG0=;
        b=U5FhxlNQSnojPrSwFcBcXsdfuEXeupVNf3KDkfjWRNarCPgOSnSvrec+SQlpKWzRls
         8fLuGYqx0KJHZRsyUzD5EBAVVaiB4DZ/f89y9Hp40TqpOH38jQSq8HKD5FrllwqnSNvt
         bJ3pdtCE2P0yidSfmvu6i5ZpGTH4s7KO0WNwvNpTpxZpAq9iEK5j3kLZgSMHdH6S9epi
         9vYDldbPz2N1RVLC2Zfyc6zIkkYHNTwl0HhW/O5MvC7drybouhUB0vgwfmz5qNfZ3DNY
         0dlTU103rRlQYdyg9Iwxq+FXE118U0z8MyL+q15N+IlnTfubNfK6RTT9zqdto4bm1H5Y
         73OA==
X-Gm-Message-State: AOAM533R5Vyyv6N0gWg3cebn1z84dAdxbXRIesbqerk4V5X+KZjKLApX
        faLFtzV/z9ZzZ0vC/2yWBvcTJceCrl60rg==
X-Google-Smtp-Source: ABdhPJx4FdO8HNL2nqQo6pdpiTMfzYzzioJPDCoFKkhK9Zu46xCKhqMAe4FYENnsa2pIlHgFIX1S/w==
X-Received: by 2002:a17:902:302:b029:db:fa52:2dd2 with SMTP id 2-20020a1709020302b02900dbfa522dd2mr18603623pld.62.1608189515924;
        Wed, 16 Dec 2020 23:18:35 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id na6sm3555779pjb.12.2020.12.16.23.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:18:35 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] Bluetooth: btrtl: Enable MSFT extension for RTL8822CE controller
Date:   Wed, 16 Dec 2020 23:17:33 -0800
Message-Id: <20201216231652.v1.4.I369d2fc751e660f78e2930743aa368e0fe1bfd53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
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

