Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D18F60F38
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 17:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbhIPRKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:10:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54310
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345213AbhIPRI2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3C06C40295
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811931;
        bh=LNYgyUdmOLuXkjD9g2BDNjy4wJVnJNKR41YhWEm7EZw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YmLGLmSyWzQVyehHmg+s+kW7r1UPUVn1muJE3vznlcEt9ZsB7Bu/YM8uazw6+ZW2b
         NTdnMOquYCsTujRh7KE+DHKAAwK83KU2f5B1k79yDDNGgy2CE5vEeQvUt8nTFNQ1la
         GFLT5kyUQsxP0B/G9y4haKs7p5GkOTWHUQLLkd55c+n3j4qZnyXu6q9WfD76KOWFgJ
         y6SNK6/G3aBVIsrmTGy0RL53yEkarBY2x0q61Y599g6zQoFX3Kefds3kc5sySCXlzB
         rePOyYp6NebuLD8Q/5fhVbxSXk1+lLgM+wB0cU/0EtwWFipgpj+26NLA6OKwUwCFvN
         LsFU7GHP5BTBA==
Received: by mail-wm1-f69.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso2810099wms.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 10:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNYgyUdmOLuXkjD9g2BDNjy4wJVnJNKR41YhWEm7EZw=;
        b=KAwjHRbOR2Cfn1m4J7+VwQI6ghKsn5PLpsIs3pmkbR2Eo0drVEZ2+WhbecKeaU72e6
         H6R9VyphnFD98qiG4VdLVPX5n9rJ9rbMhapADc2FPqHKg+hC57PB+I+9tY7mI5fLTGBE
         ZVmRf6U7vBwvbk8QEHS0R82O6gW4gew1Jy2sxFrj+Ja/zsE3ugbCzKHwGyVAm9+mluZF
         2Z5tdbeprr3GsixW9DS9xixP1oEKHNnI0dU+Crox3SVnYEE4FwmssUfLkwTkLrzhvlCL
         ylGsoUPvnWDQssN+GE8ojRAsebJZPK6lJGB6dDoBs919qu3Xet+q3wfDe2Zim9gVfrQt
         6l7w==
X-Gm-Message-State: AOAM530FjyxTLW35sFB5TR3J65JAdjo4Q0zs43fvBUmxlKLZ3IodgCJ0
        chQLY+J5FcbICOsA8zuBILDi+E41ACxiWUXMQYRuDVp2A7TUCUWAc/dvyAa4T0bzaRibcaEnR+b
        m7jcXq02n4tk5+DTgyjWZBQC4wvo8FwEQvve7Li8ZIyAInQ==
X-Received: by 2002:adf:b319:: with SMTP id j25mr7420828wrd.256.1631811930824;
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuWdr3LHYQAlkhUF2LhdnvbqjpaHH/IYbTuQZ8JReG2xn2D6IRAY1c2YETkzuaX7analAfAw==
X-Received: by 2002:adf:b319:: with SMTP id j25mr7420800wrd.256.1631811930645;
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u13sm4153069wrt.41.2021.09.16.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
Date:   Thu, 16 Sep 2021 19:05:28 +0200
Message-Id: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

brcm,bcm4330-bt is already on the list.

Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bluetooth/hci_bcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ef54afa29357..7852abf15ddf 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1508,7 +1508,6 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm4334-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
-	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
-- 
2.30.2

