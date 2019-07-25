Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7A4C7618B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC5A22BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Nt9IZajW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbfGYIOe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37370 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfGYIOe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so33819986lfh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QK6Z4RfAz2t++26opWLcEAB3MJHzW+7POBWdF/vUYnQ=;
        b=Nt9IZajWuMd0QOC33zvzhfbPhR7Z1+IXI5WdJ7nH+gNcUI4pQf5tVUGgFv1kMbCde1
         1pIyNhfSceBKAdDDffozSR74sYnTXQjxRU4NgNXveB7EKCIHnuoL05VVVXtunsbNF1bM
         j/ksZMeyxaf32IHJmByHzrEOI820l622jfE1/BIxPHKDDv/jlSeJgzToTkIe3KoYCmZ8
         UtKlnM45sDyJUmXS8VgQrSVkiur/p+HPJ6ofGM5jnjUlLpCXbb1U7sxRh8Lb6esaY6Tb
         QNdJmDDRP1A/zj1IiSQoZqly1eh5685aKXC5RO7iM8MmfYmK563+bTECjALPhUUyKn2z
         eK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QK6Z4RfAz2t++26opWLcEAB3MJHzW+7POBWdF/vUYnQ=;
        b=K8qVi1Hbqas5zhO81gxGSDBXuuI9ggpr1KafPTCleVef0Um7atAez5EGR/7sx/7U+3
         7NZbSd93CJFLTOVBpCV7wGBTfXGOPXFEPiBzg8RzK0+MgaOcBBDhCUqlSezVQGMgzDcK
         PerHBzIE0xMzX2Jn9XMa2S/N9gmNjX/E4JIGt++bXAQikEPbprhsYrcI5NDYfOJzRQEr
         XN8Q67Nq3dqZmg8iFbKRo/nFUmXgxVqJdJmnULerLWfLVtIm3sYCjSiwrzAxg7ewSLLJ
         g75AZWUYelj4El6jEz5aKKeVlq0t6Skt68PJVQBqAnONqE/X24KR/KrL135MkB2HnIhW
         HRIw==
X-Gm-Message-State: APjAAAUD8t/1BnQr07EHlgGd+2Izo1pR5camS6BggVMGIHTHRIAoOihH
        KYkTCcY6UvzdrdiEruS0OlkR8fIORwk=
X-Google-Smtp-Source: APXvYqzE3uveoDwryT/3AFeK/3Ia6QLgdSplRnaI3Pk0ZLH0n7aqUBOUDPXirK+f4VtKtgmDABsPEQ==
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr41963939lfb.67.1564042471266;
        Thu, 25 Jul 2019 01:14:31 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm9015251ljf.44.2019.07.25.01.14.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:14:29 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/5] Use composition data to validate app against the node
Date:   Thu, 25 Jul 2019 10:14:19 +0200
Message-Id: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Fix typo CompanyID property validation
+ Added comments about temporary node usage during Attach()
+ Keep element's Location property optional according to API
  documentation

---

This patchset streamlines app validation by creating a temporary node
during Attach, Join and CreateNetwork calls, then validating its
composition data to:
 - fit in Config Model Composition Data Get message
 - declare mandatory models on primary element
 - declare consecutive element indexes

During Attach call, temporary composition data is also compared with
data generated for existing node, guaranteeing immutablity required by
the specification.

Michał Lowas-Rzechonek (5):
  mesh: Convert void pointers to anonymous unions in managed_obj_request
  mesh: Validate application by comparing composition data
  mesh: Keep element and model lists sorted and unique
  mesh: Check that element indexes are consecutive
  mesh: Check that config server is present in primary element

 mesh/mesh-defs.h |   2 +
 mesh/node.c      | 547 ++++++++++++++++++++++++-----------------------
 2 files changed, 284 insertions(+), 265 deletions(-)

-- 
2.19.1

