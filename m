Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C21AEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjFUViz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFUViy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 17:38:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D54E57
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:38:48 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b468ff042cso3887873a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687383527; x=1689975527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz8jKGn/UgtAe/IXfpfsKVZOYOi6LQ6S3GtkkLiODbU=;
        b=WML7FPV2rdEElgK65ydsmgI4x2UVmzK2+fjzopWNXJ/6WIofRqbdplPOTnx0rqF/5b
         6r0F0/azLAaWUpufGghubBe4Fd958oYlGGvxHbeG5FKy8e7GY8hRdJS6uakGtGWOuLsP
         lTs8XNMras9gnE6jaZ8iass5NqxOxQwWOm11Z6MlXc6WlYzsefmteBXGOyz8CSy62fxr
         H2DUECoN1ZrTGILpBO4uqtDpIBQ5YvjizQ3/fkwVExEdJTnlWZDDQlVFpwdBw5G750Eg
         //YZheFujsMcwQnwAsjYMKtLLzmIwMYuNLywBy4iT1dzchPzeYSNI/tuZuVmgIRz18IB
         8+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383527; x=1689975527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz8jKGn/UgtAe/IXfpfsKVZOYOi6LQ6S3GtkkLiODbU=;
        b=dJgSIybnnlddOMA/8l3Ojo1m7tEadkyrhlvgmmcitsLJLXki0oyUieJ/f5+do7lT0u
         qKaJm+DXnwTEZ9cLAIXUS5TcM3oEishlSH7fzkOg5BBRD2OWaozZMWb0ErQk1RFK4vkX
         ZaILhFPJzq9uNv+cseMGvMZl/Sl4s37L9TqlEEsZvxYvPSHHaHa9+/n20nyX1LfZJSFf
         E1+m5oybB1LuEjVWtynUuOjnfWGhM7q4EmxbkOdi1Xo79I43hUfW07xj4P/998RVnROS
         v+jm5yqvRzgjO020XwaGf7KNHd4ANTjVX66M9FMQD5Xzt55JA0ZSniDifGuUrABQg4jS
         SOWQ==
X-Gm-Message-State: AC+VfDxuQVd5Cs3HuaO/ppm/0xvFVCu9jP8cQRhaMG4ZIDzt0LyiGKg5
        RdcVtiqTDw7103yX0hkzuFyTp7wB3gGrdg==
X-Google-Smtp-Source: ACHHUZ4ZXjS+Z+4ydNxxMyq6qTw3JuyyFRaYdAAseRLIbRJjKxCWIAX4gemk7CyvzcN1Jq2nrr3ZRA==
X-Received: by 2002:a05:6359:296:b0:130:df98:c589 with SMTP id ek22-20020a056359029600b00130df98c589mr9512315rwb.23.1687383527131;
        Wed, 21 Jun 2023 14:38:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b0064d5b82f987sm3406643pfd.140.2023.06.21.14.38.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:38:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] monitor: Fix decoding of HCI CIS Established Event
Date:   Wed, 21 Jun 2023 14:38:44 -0700
Message-Id: <20230621213845.1021997-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The ISO Interval is actually using set using 1.25ms slots:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2304:

  Time = N * 1.25 ms
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4473fda29a46..cd567231449e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11557,7 +11557,7 @@ static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 	print_field("Peripheral to Central Flush Timeout: %u", evt->p_ft);
 	print_field("Central to Peripheral MTU: %u", le16_to_cpu(evt->c_mtu));
 	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
-	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
+	print_slot_125("ISO Interval", evt->interval);
 }
 
 static void le_req_cis_evt(struct timeval *tv, uint16_t index,
-- 
2.40.1

