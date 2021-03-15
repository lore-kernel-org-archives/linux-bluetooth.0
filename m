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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188DC43332
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67DF64F17
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCORk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhCORkL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A531C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 30so11106574ple.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mMJy1yhZReHkY2zk7BhuHTjzHoiiHD3MzV3UKZsessU=;
        b=AxsDYTWylhHht7N/A4aTPZQze/JRSnHqYOwfTfvg4MZd5atscTpFYSXvin22xcl0qv
         bADk7UjR9zIxa9IJVhZI3nhBEEWe//P/TRkE7nEUV1qSmRrxkWMghESlCl4pA/ZGzDwB
         uvdGdDIP9e1whtiWgPJaFpyU9W7EZTXbaPl4xdt6TgcYw5zpg+BrrbX1XJusYcGoO83j
         +DEJqkG06pSYPieF7oJuDLkAlQX6f+r4AhUa/Uiroa0N/owmq3WJyW3aA06GLAq9h4Nv
         DvTQ8I5NX+EYxIgIc+eTTRYHLlB+sdYkItDqEa2FoXSzRMvgbYqV9HWWH2h7ilCaYUuO
         5K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMJy1yhZReHkY2zk7BhuHTjzHoiiHD3MzV3UKZsessU=;
        b=ZPJBfgActXeLwQywoVFWYIw1YM22TJhvuAGpoypHJst/JqaghhMMGBuh2NH01T8Pb0
         AQujUN3c0LBwq4Rv/z0a7BCO6zbuunySjHduYEWNwPR+j3lvp91crEPI8Fk6P7hX1ico
         j4ZS+oYreK84cNuJypw/n1y3p9sX0D7ITP7jLW7CSzz3SmzGs+HJ2f4bqDzYCjpT1AJZ
         nabZKzSJIq4TOLlrIeCH55oPAePF16NZhHug1Fy2YCIlr4ov4z/xkh8Uk72+LY3bkKQu
         U3EXs477W2M4W1s4SXsKs9lNQRemqkr2s+eiVSBGraQt7Sf2sb/0Kv/bIjWG+xarAXKl
         7hIw==
X-Gm-Message-State: AOAM5321pAAzCckSCkiRNNsSsI4eTaqwC0Xx6JDDmLWcUY5eUwHfk8f0
        qoyt2Zms73ORxuB3HoppfQ+beUciyte72A==
X-Google-Smtp-Source: ABdhPJxchqDX2x2yv5neUGWJigFr5kLurepzus8GASaimSaaucG1EM/omYcY21+oedchq75oySb5eQ==
X-Received: by 2002:a17:90a:70c2:: with SMTP id a2mr186944pjm.63.1615830010631;
        Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 8/9] Bluetooth: btintel: Collect tlv based active firmware build info in FW mode
Date:   Mon, 15 Mar 2021 10:40:01 -0700
Message-Id: <20210315174002.1778447-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
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

