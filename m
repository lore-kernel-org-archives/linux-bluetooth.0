Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C9C48BD6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7B20843
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="dcDwEtwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfF0Hku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:40:50 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36220 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0Hku (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 03:40:50 -0400
Received: by mail-lf1-f50.google.com with SMTP id q26so881400lfc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrbnizIHqm0XAdDYCcHN6SLMKKIXYKONZz8BXIlwiHU=;
        b=dcDwEtwSsVgExMcdRsJuxHpGJWceUHWkBH5uVdT549nCEsU1u0PkjFpt9keFHVqqCx
         qKvHAUMuRIzbJqDJuUFtpQg8fiELEmMMgiI3EirCCUImwxA4Vg6PviEaCqK84fAFNFSF
         7yjogUvaCmFuBb9imBWYAngvUvQWz5YheZ68Rx49NIrdtu+RZGtzeyLvSQabo8l79zIC
         NBefKyODFLNleH4u7xDlqAi+2mqSTXvy5C1990J8N7iFSAqScCsI9CcHy7fmtCVQijXI
         jaq33jElychcuSaeO6k2pOOnS1Ah9LQcLKfjY81Hkc473ljHYJila1SCp3WsjrV71140
         zXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrbnizIHqm0XAdDYCcHN6SLMKKIXYKONZz8BXIlwiHU=;
        b=Li4OeZ6RriUWF0Boiwmm7RJx5zZHmNcteTgrCY9Wh025yqGC5YHCwR3aXagoN/mElR
         cikJ4njKPemR+RuWskkJ0H4KluMjjqAlVTt9UU5+akxXwtU4GvmIx+SolRBKYfSLv2yf
         h10viOqEHhprsxt4TgnAB8ME8EURGPqZeWK4P76UJGpjYePAWrvhhtBQwwP4rcP3YNzA
         mxP6Qzjevd+2aQ49CuTarhh86BFlvPjNfwDtzmODtliL2xWoFX4YBHuim8q1g4u8ZDrR
         6E8rDPY9vrPUBpwlq1ecoHRj5rgI3O0SeASJYOc3XivZbtGX+Z+JQ5chB5t9wpBOpvqF
         yEqw==
X-Gm-Message-State: APjAAAU5EFSoPrsqIQcw7zG6mitFcHleTjqNTP4Id8otkQ8TmtBkrtW8
        xxu3f5Dbg3CVnNatGHEUlmzyJRW8yWA=
X-Google-Smtp-Source: APXvYqxHS15DOW22H5gL1SmvZtddAPJeY/DcmXukd842XFqJW6Xu7Cq4nFQMc3id9B3m+Sym2OxMrA==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr1339032lfk.20.1561621247661;
        Thu, 27 Jun 2019 00:40:47 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm223775ljf.44.2019.06.27.00.40.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 00:40:46 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/2] mesh: Fix IV Index handling during IV Update
Date:   Thu, 27 Jun 2019 09:40:41 +0200
Message-Id: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset fixes handling of IV Index during IV Update procedure:
 - use incoming IV Index in both network and application/device nonce,
   according to incoming IVI field
 - use current IV Index when relaying packets, according to IV Update
   state

See Mesh Profile v1.0.1, section 3.10.5.

Michał Lowas-Rzechonek (2):
  mesh: Fixed handling of IVI flag in app layer
  mesh: Use current IV Index when relaying

 mesh/net-keys.c |  6 ------
 mesh/net.c      | 17 ++++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

-- 
2.19.1

