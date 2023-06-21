Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F84EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjFUVi5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFUViy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 17:38:54 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA191988
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:38:50 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55e299e1d02so3768547eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687383529; x=1689975529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7vbYS2ToCosmjFXnjFg6iPNeVmbMl9Q6DWSa8U0smM=;
        b=m2OwKbK1kSmmzxxVaTW/Wc6tlsSdEWbtgOZUZ8nRKCT7ZMRVzLR/i+Lr/Mzc+3vuvu
         e51HdDv0Zw/OOP6aZc5DzsNMa/92BFQ+LApXXI9iGD4TJrJAYnODH/uqHbHY5ZRLn/he
         5Srn+2Og42ce1TiUCZprH03NZnBw8Qf1xORxmXhC2e6SrkQbX+HULSCtVeFFO4PInc76
         3DpSVeEztE2blJnnI9EK/aIfc4R7d+w3cXVG3Y9kh4lkJGhtLNo5gGnW3VCrugjbGBSj
         THta1hsJWn3ZFyo6nFw3SfxWJcyjCDU2Za3cA9Ke56ltOJt7xCa35MvpsfUm3zFEH4Ar
         tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383529; x=1689975529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7vbYS2ToCosmjFXnjFg6iPNeVmbMl9Q6DWSa8U0smM=;
        b=QWmyRs1XDF9Eb5FRTDkXl7GthVk8XobIO1t3OmJ2kziYJjaO7IR2I496QJ/Ftf/lNU
         qrmpxY8O0poG1XUGGRLRYDhJv8s06ygjm27eSqAd6pwfCVDx67DvYb6okak74xNf/2Fs
         /yn7MdAr6xL+9T9ECdjlE7PwfAF837hvPTPu3UFy09fxc/HBf/i6NSewjiFMEa/rDuqu
         4w7+qMH7eO+8WCpQ84GrDrvpTOX5/N31WXIqG3vTKc58IRoVM27dpNkZHofatWKj8nk4
         z6FxFdKIQxyxvsQwELXTJQBBT2OPNQmh6A+ty9j2jzdeCqy1QEjsu3xBLy5NOuVW1uqu
         qjGw==
X-Gm-Message-State: AC+VfDwyxGzPOt5SvLZuCluOgjqnPIu1U5P3zPdJP809SLvvKT1EzcS+
        fvw+6xVOvisAAm3XrCab9UuNBxLGTO6gmg==
X-Google-Smtp-Source: ACHHUZ7RxjRGxFpg2EHrJM9v+9Bpq4WlKn8lPRwo77v3lgNZMaZiMAIcj/0fghLsDKVbTMaa11+hkw==
X-Received: by 2002:a05:6359:2e99:b0:12b:d4a0:fab3 with SMTP id rp25-20020a0563592e9900b0012bd4a0fab3mr9547274rwb.3.1687383528794;
        Wed, 21 Jun 2023 14:38:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b0064d5b82f987sm3406643pfd.140.2023.06.21.14.38.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:38:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] btdev: Fix CIS Establish ISO Interval
Date:   Wed, 21 Jun 2023 14:38:45 -0700
Message-Id: <20230621213845.1021997-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621213845.1021997-1-luiz.dentz@gmail.com>
References: <20230621213845.1021997-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO Interval is actually using 1.25 ms slots so it needs to be properly
converted.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 462f352ea252..0a375febad68 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5977,7 +5977,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		evt.p_ft = 0x01;
 		evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
 		evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
-		evt.interval = le_cig->params.c_latency;
+		evt.interval = (le_cig->params.c_latency + 1) / 1.25;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
-- 
2.40.1

