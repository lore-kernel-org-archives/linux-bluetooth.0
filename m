Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CDEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 19:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197346198C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhCWS7s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhCWS7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8DC061763
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h3so15273058pfr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mMJy1yhZReHkY2zk7BhuHTjzHoiiHD3MzV3UKZsessU=;
        b=LkAW2oTK/5McVOBC1oKMc/NjDZWWy+l6UA7fVcMQAEJ6aoxEG6+t9atdEHsb9/gy+Q
         SvjxBp7wDyobINLBlCVSk6mooN4wDFFNHhWTVZPfq87tG722ElaALQ/WNfpgvq+t9+/I
         xWDtqrCbv66xqQTvyalmYULjt+ybuuEH7TOcBOgNw1QCXIMpcrgD2yjbSdezHreNLLud
         KBSZGRKeNvo8voVCjY1Cd1/2oHCxdbEwj57RhtLKytonzFTH/ZbuM+WVzVAfRDpCu4cR
         VHdYGxxArqPxVeYokc/sZb7QyNn4RtHEiAM2aWCkbOKWgKsqMO4SuCaH/oG7wuMu8nb5
         CNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMJy1yhZReHkY2zk7BhuHTjzHoiiHD3MzV3UKZsessU=;
        b=FX6NT+3pTJ2HZQULo19rXb5t/0SM7SnXQrWNzvrP+h2DpaxoUJiPe+IMmxHiqSuIBM
         1YbWYxGXac9sFerRAVHnt+n78PPqzJdf10HMv6CiZN+q+Wik2hp7iN66E3tlv7CoB5vv
         l4ltOZ6tRld1c71Z2HFbA3ZdYUo5SiZ7F8DyGD7BTn4XKz10yX9gtWoqQSRx3XDSJjIv
         sxFhwosMD0iAbJqbGQaf/96PnBTu8PcMUYtTs78cBoczSPba5OsNi12X1IJHOaxmhO0q
         bJf0IOTZ5OS+7NjoZq7d4VkBxNznhA+db8XRd5yWmm9glADmCzIsCmPigPFxJlc6sZk6
         nrtQ==
X-Gm-Message-State: AOAM533xJnd4ZE7arN3uPLh/mPkJX1P/ZEy+VNWGycjCGkfY+oURP/1b
        NrAd2f7TbPmPdWo9edL3dcses9ojRTJeJw==
X-Google-Smtp-Source: ABdhPJy/R7E86K84H51qYkof8Lsb6pNWVRmT7qqyQ8P3V8CguXjq5TD0wGYb+JiJV9UGlOEw/998+g==
X-Received: by 2002:a63:fe56:: with SMTP id x22mr5172437pgj.329.1616525952158;
        Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 8/9] Bluetooth: btintel: Collect tlv based active firmware build info in FW mode
Date:   Tue, 23 Mar 2021 11:59:03 -0700
Message-Id: <20210323185904.3372987-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Lokendra Singh <lokendra.singh@intel.com>

In Operational firmware mode, 'Minimum FW version' TLV ID is not available.
So, we cannot fetch already running firmware info for comparison against
another build. However, It can be collected using a combination of other
TLV ID's information.

Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
---
 drivers/bluetooth/btintel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 4ddbf895c382..6442acba76d1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -537,12 +537,23 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 			version->img_type = tlv->val[0];
 			break;
 		case INTEL_TLV_TIME_STAMP:
+			/* If image type is Operational firmware (0x03), then
+			 * running FW Calendar Week and Year information can
+			 * be extracted from Timestamp information
+			 */
+			version->min_fw_build_cw = tlv->val[0];
+			version->min_fw_build_yy = tlv->val[1];
 			version->timestamp = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_BUILD_TYPE:
 			version->build_type = tlv->val[0];
 			break;
 		case INTEL_TLV_BUILD_NUM:
+			/* If image type is Operational firmware (0x03), then
+			 * running FW build number can be extracted from the
+			 * Build information
+			 */
+			version->min_fw_build_nn = tlv->val[0];
 			version->build_num = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_SECURE_BOOT:
-- 
2.30.2

