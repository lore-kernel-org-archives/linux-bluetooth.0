Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BC4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiKVOET (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiKVOER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 09:04:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF251FF83
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 06:03:17 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B45573F128
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669125794;
        bh=MmX49LWmqBGT8gmV2EsghBdLKDSPXDw+pVh33IsMCLc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sklCOcZu0nfeT0omn9SClODu+suFKvXN/cdPhRkEULdkbpgIYGU6PC28oSLFZh9Bo
         6lCUicO7KAd0DXFw2gmEhLPynVy7CLVSBONavGiXAy3KArL0CHEGr0qb+tbgDB/om9
         Q7islizTPVqbzC0UCNTDUMe9qA08eNInch+bG/Oaw++W8viOKPek5iIcifg8QljgdW
         y47rMCwuFZ67rEF5tIUK+t7QHdmGNXG5SHmAmIkTdYBuYaGSDkFFtNF33RPhN9agaW
         JU92p7J3Dubi/T5a2cMga62MU50r46Nvp8JWOXDrNLCvZuvRyqSHB2lcvTbIDnvvdd
         QSZFTD9X8/AmQ==
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso8117044wmh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 06:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmX49LWmqBGT8gmV2EsghBdLKDSPXDw+pVh33IsMCLc=;
        b=oD3holYBjCxIl5vuO6J48B6ApVBd9xtAsNEkp2a0srjpStNCSds8kw0H2XW0Lhsntq
         AQzOrULlupHj1B/lbbTmM1eqfi+OZVsalOtJgrGGhogpmIa08VAmP5z0GnDk+Ee39DrQ
         eYaHehPizFdUg6/iB5rVM8EP4va4rPFLtCrLMsCR0XpVZBhaz1aFy/skKlSPI9g3zYJ2
         YpZeRvoSa6BdJ/fZjMnN9GVK2URJjH+ex1aAWuLf/Dtmi/LaXSUzevXJVhScFUzQTn/d
         YfA2lZbfhA7DZlgC/JwsvQLrqivC5k0i2dET5BXF3v41fM01H/r4l1+l7EiEaGIamL0g
         PNxA==
X-Gm-Message-State: ANoB5pn7lCKQ+AxognjSCoM0LKgPqizY8rPYodmOUVh5pXjY8VgJhwPx
        pcsnIrmdrduKnXHyWuCU5rpHdM/pKRp31apzuCFcKW4L7nfkv7ALvBVZwbkV6gyDx36bIZs/zjJ
        qg/AI164Dk0amnzb1Sye2dZCZOlVBNynF4BvWIoEpUHHHQg==
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr11902781wrw.387.1669125793879;
        Tue, 22 Nov 2022 06:03:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6itCxbOSfPPcAiL47OVea+GeSvLP64Yp86nrlqnW+Dypb4W+pn3NIa/J+w8XPmI/i0f5DWZQ==
X-Received: by 2002:a5d:6ac7:0:b0:241:bf95:c9a2 with SMTP id u7-20020a5d6ac7000000b00241bf95c9a2mr11902547wrw.387.1669125790435;
        Tue, 22 Nov 2022 06:03:10 -0800 (PST)
Received: from localhost ([137.220.91.195])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003cfd64b6be1sm28849313wmq.27.2022.11.22.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:03:09 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] Bluetooth: btintel: Correctly declare all module firmware files
Date:   Tue, 22 Nov 2022 14:02:22 +0000
Message-Id: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14, 0x17-0x1b hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---

Notes:
    Changes since v4:
    - Add missing "intel/" prefix for 0x17+ firmware
    - Add Cc stable for v4.15+ kernels
    
    Changes since v3:
    - Hopefully pacify trailing whitespace from GitLint in this optional
      portion of the commit.
    
    Changes since v2:
    - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
    - rebase on top of latest rc tag
    
    Changes since v1:
    - encode strict patterns of supported firmware files for each of the
      supported hw_variant generations.

 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..d0e22fe09567 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
+/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
-- 
2.34.1

