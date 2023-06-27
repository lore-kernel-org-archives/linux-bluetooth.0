Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0449EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 18:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjF0Sf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjF0SfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 14:35:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A12D54
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 11:34:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7836e80b303so65322439f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687890888; x=1690482888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3DxDLP4ztWSHylATKMTFx64DJDNnIk64xtNy3EbVLc=;
        b=UjyPhxmxQsfnfoWIFHHuA5pctgniFaHZ/DOM1xzT76OYUvsJbaIwACxGFMOMC0G5YV
         Cut0HwgaI6MaePsnv2iZWZEg7w36imCtKzyB9Ews5S97qmvc6PMF79V4bsNnRepoW0DQ
         K6AxGzw/2k4U4IYRs1LOlj4xIxGvBNmlhHxH3ScksA5yjdZ++Qf8Zv7AYURpRhwRCjrL
         B+DZp8Bi9/iLhcH/pm8syECiJ7wndtl0N1T0hmnsKML5VxegTUvJ81D/I7RaFhdHm3mt
         ze7qxKsk6c+kyfo2aCwApFMbksbKoNFRpKAsA6GRmrrlG6XLA9NCHGUEnDJn0OtQTTMA
         lSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890888; x=1690482888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3DxDLP4ztWSHylATKMTFx64DJDNnIk64xtNy3EbVLc=;
        b=gWdjQh3pYiNRNnQNA35wMMIIO7TK8WRLnjrRDukve/0ybwi53iRhnGZkVpwXNHw+JU
         Le8M/nbsydPCNCHIFH5/Wrh4AHmpSpz+3JUzeu00vBpQByVL3PYvkraDcmmlvxzexXcn
         PiQQcrkrKwdqyhNc9rETA7qCuvOwI0fX0ejtA3RvE0GnHu2kpUIzFmLAcDnWXbuQmrVT
         1dSG0SsdGJiDcT6We0deZGSQfPAAFhEuXyLDEfEsRgrEaB1XE/LjezbK9meEUCHmzNf1
         5+4eT4t5pcSyfhbaM3n/Y4wVgxa3VUN2fhGqAAcrFrSw5v0lak4FXuP+q3gVabhPC6X8
         KcHA==
X-Gm-Message-State: AC+VfDyfhq+S+9n2Qv81H9xpr9CKLSGQflNW4O8ObsH6BGB62PTobbqW
        LCWCZLZ5SPCserEQ+RipLYhjx3f1iO0y9yjb
X-Google-Smtp-Source: ACHHUZ4OKDhZ8AbtU57Sw8w25Czk0R7PH/p9sbcsiA1ksPxV26WCbxkmrZ81i4n9CPx/Ma0u1vt0Aw==
X-Received: by 2002:a05:6602:22cd:b0:783:63f9:55b9 with SMTP id e13-20020a05660222cd00b0078363f955b9mr5118576ioe.16.1687890888400;
        Tue, 27 Jun 2023 11:34:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cf25000000b004266f6fa389sm2632106jar.175.2023.06.27.11.34.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:34:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix parsing of vendor specific codecs
Date:   Tue, 27 Jun 2023 11:34:46 -0700
Message-Id: <20230627183446.2488049-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While parsing vendor specific codecs cid and vid fields need to be
converted using le16_to_cpu.
---
 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 270f0fd645a2..55f61d91a3aa 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2953,6 +2953,11 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 			return;
 		}
 
+		if (p->codec.id == 0xff) {
+			p->codec.cid = le16_to_cpu(p->codec.cid);
+			p->codec.vid = le16_to_cpu(p->codec.vid);
+		}
+
 		pac = NULL;
 
 		if (!bap_print_cc(iov.iov_base, p->cc_len, bap->debug_func,
-- 
2.40.1

