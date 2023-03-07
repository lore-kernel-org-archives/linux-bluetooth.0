Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D4C6FD1E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCGWZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjCGWY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:24:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0393E3A
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so155192pjp.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhvXbrbfD2QqHIchqkMG4mmNdrbycE8pNBVZPDJ9Syc=;
        b=dIjwniVUyzj6EF5r1L2m8YX0787Sk63pWSkxnhtHIP/lCw7bR6OCq6y1tndqhuksml
         pRA8PcoqRZhp+eIMzzxh9pWuju1WkCu5Czr7/34/sL+hJj+S84ZjfHZ/b0szizor9Dij
         ZhYRbV5ylqXt5pzfVRdJJqniaNlggibTwsSP6xFkfvdpHeMc6Nbm+RvrV3gshKgUlqkG
         e2EjEzbh7am/WHV50JrMEQh+CU1FffS6LYe1htgupQgIu9Kxp6cseZHJ4oJPGCDQyFdG
         EdDEEP+m/nUrBOP/uq/Vn8udVpguOG90FOdIlvfettNLPb+/xXA2BHyNbAi8P1R3H3SN
         8m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhvXbrbfD2QqHIchqkMG4mmNdrbycE8pNBVZPDJ9Syc=;
        b=hOR5xIj65RmdSE6jM6YVD6pQMQs7FS0FBjWOxo4LjaZtFkM5jtLV5qb1ggCeSChJZB
         lWDrXI74KaqJOCT9Y30rik/MaWUy2P8FOMo7EtPwgXfVg2MW0e8+OE3vg7le8Wki+sKs
         Tx8c/vkkAf+DmBlnGMa5Sqc/DJhNDDYYmt3D+IM3g9u4j67MuRB+BHdli+UPt1XiFBIC
         iRylNu7HiUUeMiZW6VfIMcqoSRwsvg02tQJTTacuhDXXthkPY1B1Xhi+NuC95kG7ohBl
         rS5ieisfKzlLh3UWhXREg9BJWOgwiadlNv2ZK1DRUqKyIVvrJbtxOarfwebnQsBmevsd
         uYCg==
X-Gm-Message-State: AO0yUKV/rhFuNUG9QuftpuFvQQhfJ3Jyya3MmMrR0TnL5D14eAiApSgy
        WuJHHzyPJEWnaj2UjOADW40L2Nesk9M=
X-Google-Smtp-Source: AK7set+7+PvaQXntd743PTv6jQBPjup75YV9K8WHowda29XTnL4NRuFNB2sX/bOcQ60P3ZhROQAw8w==
X-Received: by 2002:a17:902:c10c:b0:19a:bbd0:c5ca with SMTP id 12-20020a170902c10c00b0019abbd0c5camr14792156pli.48.1678227865302;
        Tue, 07 Mar 2023 14:24:25 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 02/12] shared/ad: Add RSI data type
Date:   Tue,  7 Mar 2023 14:24:12 -0800
Message-Id: <20230307222422.2608483-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_AD_CSIP_RSI advertising data type.
---
 src/shared/ad.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/ad.h b/src/shared/ad.h
index feb712f508cf..b100a6796109 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -57,6 +57,7 @@
 #define BT_AD_MESH_PROV			0x29
 #define BT_AD_MESH_DATA			0x2a
 #define BT_AD_MESH_BEACON		0x2b
+#define BT_AD_CSIP_RSI			0x2e
 #define BT_AD_3D_INFO_DATA		0x3d
 #define BT_AD_MANUFACTURER_DATA		0xff
 
-- 
2.39.2

