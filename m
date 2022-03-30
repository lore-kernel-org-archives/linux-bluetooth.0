Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E89C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbiC3Wew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351654AbiC3Weu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 18:34:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD55BE54;
        Wed, 30 Mar 2022 15:33:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq24so22351089lfb.5;
        Wed, 30 Mar 2022 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wpHPCOr0X38MV4jr7efb3ekeDGpgOhqIRFxCBa8bq9Q=;
        b=kpUZJ2H8MZUEANPHklnuQalkHQFerq8JbC/ucgljPLlY895ErPh+C18WbHdYqVwu1A
         TpWovw8/KGKRvjQWjm3LcxgzVX8UOFD1MydEwlHBC+mignQ0EILS8vmgwY48WYs0+/vG
         Sr64qtlr4TVHZ1VjFXn6Lo/k61cB5hAKln84e7mCwWxBhhXnamlxK6gzkok/GRytHS9Q
         Exun6Ejp0wnv+RJQPKsLOOXoKz1aDn8GqXQwN6PMVxsg6VbI0fL9nVVEnm46/4m0qEVk
         cUjdVqxUTAThOQ7DJ08Ig/JCSm7FJ7fZXXlL0WSNQK4m/XGnVvwiWWgnM66C+8hgy1IT
         NdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wpHPCOr0X38MV4jr7efb3ekeDGpgOhqIRFxCBa8bq9Q=;
        b=uNx2DPRju08eA7zBVvaoEXyQ1QNIq7VBgh6xmgA8vw8zPomAY/UyvIZ9FUIzd1zYWw
         3oaQc8y5XWCxmfW/yCW0a0vDoTms4o2be4Ob15+gkblyKeQ36Tk7HaQwL55Do2enjUk0
         OlkOYVDgOt1YYMmTR5v2udeiJLWVX8wr1CZ3JcgVuUorgbGCdLxx2/Gy0/WFwS3Sb3Tr
         a+HkXF1zh/u8IWkVD3igi15ncG02gdCzM4SdWPljz852tIjIZ9xPvXo1CSfNCbDX7WeL
         wwaQeEDcAT8hdxUrgXsCjBHdFrkgYdf7iqx0JqjLmJTJ6b4kOokmGVAKiP2e3ykHJDmG
         HJ3A==
X-Gm-Message-State: AOAM5337fKV8tTk3642BLtFa41JoRxhSaYpFirgnvrrWfnbCU7RXUiv/
        h604R7UXQ5pR7uFogW/JnG8mVkfbrio=
X-Google-Smtp-Source: ABdhPJwbOsdqOG1cja8fBcL32H0bO36e8Gptnk++INAPv4Ut8o4HxuejCaOFIHp3MH35HTuk45ESSQ==
X-Received: by 2002:a05:6512:22d3:b0:44a:518d:c23b with SMTP id g19-20020a05651222d300b0044a518dc23bmr8524968lfu.21.1648679582528;
        Wed, 30 Mar 2022 15:33:02 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-188.NA.cust.bahnhof.se. [82.196.111.188])
        by smtp.gmail.com with ESMTPSA id bq5-20020a056512150500b004433c791651sm2471000lfb.69.2022.03.30.15.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:33:02 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] Bluetooth: btintel: Constify static struct regmap_bus
Date:   Thu, 31 Mar 2022 00:32:52 +0200
Message-Id: <20220330223252.42136-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The only usage of regmap_ibt is to (after the regmap_init() macro is
expanded), pass its address to __regmap_init(), which takes a pointer to
const struct regmap_bus as input. Make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06514ed66022..818681c89db8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -794,7 +794,7 @@ static void regmap_ibt_free_context(void *context)
 	kfree(context);
 }
 
-static struct regmap_bus regmap_ibt = {
+static const struct regmap_bus regmap_ibt = {
 	.read = regmap_ibt_read,
 	.write = regmap_ibt_write,
 	.gather_write = regmap_ibt_gather_write,
-- 
2.35.1

