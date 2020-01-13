Return-Path: <SRS0=UJar=3C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C3C33CAD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5782081E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 12:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="pjPpjHqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgAMMbS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:31:18 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40285 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAMMbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jan 2020 07:31:18 -0500
Received: by mail-lj1-f179.google.com with SMTP id u1so9821804ljk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2020 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2yPxHvW/cIak5cWaOcPQ6zS827qJ14ng52XujG53BU=;
        b=pjPpjHqRqIWdZJ5u7j/JFl8oYjyp6AnRuXJgfotuNxxnJR0+T167+gEe1v3Aqd/boe
         3O51SWdChuUxZDq38LW+FSEBMJqcg9vC96+LN72TnzvmROpfP1eAhnNk6dKyPzD9CSb8
         QyKX8+UVLXkhkruC1EzQIAr4jSguyD90lJZAin0w8T+yLPnLB22FMzrhDALdCNOZspEo
         ZNx1KzpH0X0biMaDAQ9RO5Z5sBKkBDqAR1kCrBKyazY+jMr9i0s7FtZLg1ewWbzJv/tK
         ySo01FpnmTp/800idogy7tBGSLtF8CjQj/5ueJyWblwpRplm+F8CUIJCV6AHaRb0dYJa
         0+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2yPxHvW/cIak5cWaOcPQ6zS827qJ14ng52XujG53BU=;
        b=t+6bXBqMQFbZbkPFDfaFdihKSqj6c3iDfPra9/PMk26eGNDvXjBuv3QxwP+M1+KeZm
         EAXP7yhYuARBZPiw+M8JxZPAdQHNGzKEsYxffjcKs1KTbfdEHg5JWxhq1Y3Lj3m0z7Su
         +NtYWPIlRT0YwHgTx57QeW4wZk3W8lLC/ZVhSbqJ8NXQKW7eTc9eVEykemk9qCazCBZf
         XbX55+kv9nEMkO27T4pVRhL+lbqjB6bf1k9p22eia2aomYE0SNtnz5v1OL0ihMqxyXPO
         UYzWC67205TxbNqBBD5eaNpE9y6PY5UvWtmKjs4l4XUglmZedcJEeSUP+3wqmnN2KElv
         wU4w==
X-Gm-Message-State: APjAAAUeiQlyWWMqHYmMg5a0Np2rF6/dBq31xs8KX2rCa1aKBxaf7k/p
        /1J97dYpSL5UmGiGiaPALkYdr7mwkdQ=
X-Google-Smtp-Source: APXvYqymn6MgW+Hswjzm++8i1TRzR1hXLOzIyJs3Gvl9DRAg2guZM7T7z4q5pvR45zdiRrXBr/yx7A==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr10642107ljo.41.1578918675778;
        Mon, 13 Jan 2020 04:31:15 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 144sm5735372lfi.67.2020.01.13.04.31.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:31:15 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH RESEND BlueZ v3 0/1] mesh: Streamline crypto functions
Date:   Mon, 13 Jan 2020 13:31:09 +0100
Message-Id: <20200113123110.2209-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a followup to commits 79fd24af1 45beec16b and 37bbe30c9,
continuing a cleanup of mesh/crypto.

This version works with unit tests added in 06cf0fd1c.

Michał Lowas-Rzechonek (1):
  mesh: Refactor mesh/crypto

 mesh/crypto.c           | 481 ++++++++++++++++------------------------
 mesh/crypto.h           |  50 +----
 mesh/net-keys.c         |   2 +-
 unit/test-mesh-crypto.c | 205 ++++++++---------
 4 files changed, 291 insertions(+), 447 deletions(-)

-- 
2.20.1

