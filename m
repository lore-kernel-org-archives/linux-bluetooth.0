Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE042C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 18:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiLESj3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiLESjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 13:39:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3BE0AF
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 10:32:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 140so12232572pfz.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 10:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbCff7rUx9TJgmqCOLIH71AfBuR9ItgTDRsc79Fw93U=;
        b=BiQa8t0/mZMe57eR0Dv0HcEbi8hDPVjoNBVEXxeERc4pgLhFp39SIXMKfcqQGVqDLK
         blGdnk6aKFpNsFG/i3tNyWHksrg5pwY/pAiJOoZE99oHB/xVvodGXQTm6pjSIWWsCs4P
         s/qYbttkbaBPkNlnwa6fl/8x8zoBSNlagxsq1xfZM9tfAqZzaMd19SCIiDwpGwWYaLpu
         5Y0u+QedgHTTWTjRRuWyKMaB03VMtH7pBYlAnziXvYRl4t4sHLSfRqLe5Dei/FZYzAyM
         sZ6q2/UY9cdSPP+Tig3vxC4UMRVe3zdf56Aiqg3l17bRDwhp55wwl3wnNe/8S0BguOZ0
         vucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbCff7rUx9TJgmqCOLIH71AfBuR9ItgTDRsc79Fw93U=;
        b=YVSL10H+gW4jsIjWUEJjy2kIdknR15WpLWSBgiW2r34BEos4qZfQj081UYStBthdgj
         80uoNtncyn+GqFZDj877+QcqQPC9Gw4475wuXQB5yn+yVpkyLcQBPmqRp7L+gj5tZdy5
         PC4MFZKT0BPNUXAsLodRz/DcQVpzLfAmu+GWngMQNNpfe33HQe6ReMyrvuFTExGtCZuI
         cUazAjdkRvI1sx1+9lQ2q7r/fy9+1GVvkmWEN+CUsfee+KwcwSNhJSnhTGHDqjK+rcu8
         z6k7QP6pDfJrRupguNgygXFjU2VHxg6ezSict/jsCUMMKyz3V8/vWMtg3rdhdVeT4XIy
         tlVg==
X-Gm-Message-State: ANoB5plqJYBuKzXbfvCO7YIvRa05cg/4KRE/rCOxXRwKoJIHbrOa8YBX
        MFdYbuPcIFk7AYdUqeZ2I2z1ljg3ZJqmrhOE
X-Google-Smtp-Source: AA0mqf7onyUsFGOuzWgTrphrPmjueG6jaROggmr0U6rJVvnnWCbCUwQqNj7I8orS6wZKkwBWdxmDsw==
X-Received: by 2002:a05:6a00:2183:b0:574:2104:5657 with SMTP id h3-20020a056a00218300b0057421045657mr63689363pfi.58.1670265165996;
        Mon, 05 Dec 2022 10:32:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l124-20020a622582000000b00573eb4a9a66sm10204079pfl.2.2022.12.05.10.32.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:32:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btintel: Fix existing sparce warnings
Date:   Mon,  5 Dec 2022 10:32:36 -0800
Message-Id: <20221205183236.3460924-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221205183236.3460924-1-luiz.dentz@gmail.com>
References: <20221205183236.3460924-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following warnings detect with make W=1 C=1:

drivers/bluetooth/btintel.c:1041:38: warning: cast to restricted __le32
drivers/bluetooth/btintel.c:1786:25: warning: cast to restricted __le16
drivers/bluetooth/btintel.c:1795:25: warning: cast to restricted __le16
drivers/bluetooth/btintel.c:1796:25: warning: cast to restricted __le16
drivers/bluetooth/btintel.c:1797:25: warning: cast to restricted __le16

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..7e9a0e52949f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -26,7 +26,7 @@
 
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
-	u32 boot_addr;
+	__le32 boot_addr;
 	u8  fw_build_num;
 	u8  fw_build_ww;
 	u8  fw_build_yy;
@@ -1783,19 +1783,19 @@ static int btintel_get_fw_name(struct intel_version *ver,
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
 		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(params->dev_revid),
-			suffix);
+			 ver->hw_variant,
+			 le16_to_cpu(params->dev_revid),
+			 suffix);
 		break;
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
 	case 0x14:	/* CcP */
 		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(ver->hw_revision),
-			le16_to_cpu(ver->fw_revision),
-			suffix);
+			 ver->hw_variant,
+			 ver->hw_revision,
+			 ver->fw_revision,
+			 suffix);
 		break;
 	default:
 		return -EINVAL;
-- 
2.37.3

