Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B3EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 22:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFTWoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTWn6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 18:43:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8A10FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668709767b1so2228892b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687301037; x=1689893037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz8jKGn/UgtAe/IXfpfsKVZOYOi6LQ6S3GtkkLiODbU=;
        b=MELpqJTYl4r6V6OvbuKGKIFuVVbSVArDl6LWQJ4iM9u2pFtaFh1a6lOBPH3mvJhHPz
         +TygfrDUKNpzxhNRPcRhVMb8dQinpkBu3OvUxbKanM0aZQKBei4+Cxdue4Uosr/SUwG/
         R9FrQaPaey4NpXjL2IAU4YZjqAPZMpOjOmOOllXs9ZcsVrHt4wMGvdaALTqnqgwkcF+R
         aJbSATO7hewYU3xWqFuRW7B8zuiTzXPEQomxjdtSt0kGGH2Wn+KsG7GpEJx4QkstXcYD
         PGlP5+cj5HnwkjMMK0QLhfzTK/StlDtcqFgze4ZFfo4SOGbCPzGBf9Musnc9bHvFyUBE
         fODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687301037; x=1689893037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz8jKGn/UgtAe/IXfpfsKVZOYOi6LQ6S3GtkkLiODbU=;
        b=HJ+st50NrhOKyO5i6YbP8E9ZRbqN+hlqhUPw9oZ2hZteoRQBQ1Uuzm5LT75X7PXWkD
         Ho7BDCs55NrXlEtgk852r0zxuGLUlZOAhaTv01DdU6OSakW0SfaFlgzy3ivFRVIceqIR
         Yh4qbQOMoUqfn2m+HQ030b8NrNDxz9KCI/Khx3W7+jgEMZ39WGm6rd65OsmUCSSM4Pxe
         lkoEHZYewNhzdrkep8I+GoV2DOTBBEta8tW7pO726DB/pc17oCxzb8wD9gWbqSD4hnBL
         wa7sJ1B8UbI6msZJx63+apeFISU+56zJtj0gZPN//TDhP2DwasZd0WfPSRHVKwzjvu6R
         DiEQ==
X-Gm-Message-State: AC+VfDyhppD1wYb2a7k2vG1PvITlO06lw5EqBNIjFMDWVZv6PewAD4np
        llq5pDLKHDBuVOzIxr2u5MgvLSDQhESaHA==
X-Google-Smtp-Source: ACHHUZ7HMJrWxLr9Z2MvfRbbTE0P6QRLI3tQ1rMBfWi+R6fKKGjmvIVmMsAowJ8sifDzZD67P+MYmQ==
X-Received: by 2002:aa7:8894:0:b0:653:609:7e2b with SMTP id z20-20020aa78894000000b0065306097e2bmr14174017pfe.2.1687301036645;
        Tue, 20 Jun 2023 15:43:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0062cf75a9e6bsm1734532pfm.131.2023.06.20.15.43.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:43:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Fix decoding of HCI CIS Established Event
Date:   Tue, 20 Jun 2023 15:43:53 -0700
Message-Id: <20230620224354.729781-1-luiz.dentz@gmail.com>
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

