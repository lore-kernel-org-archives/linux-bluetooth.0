Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFBC7618B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35971206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nGY4gl4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfG2Nkz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:40:55 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:44601 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfG2Nkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 09:40:55 -0400
Received: by mail-lj1-f170.google.com with SMTP id k18so58604827ljc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2CQfungpKNvjxTzrQ0gyFVifkmACYxQ+/C8OQL8ClM=;
        b=nGY4gl4j6JueS0nVUl+7b87IoCIgNr55zaS8hU9KKOyQLOFovYnA1900RFzHt9jnUM
         la8h+VJc1HwxKDi5ukzLXI7oUVKmU4mTjx+qijwgvO6bb3IJIgzl0gOgaxnr237fzwy+
         8HH2ODoGi82jNaoGBkkbZ3AZSr9RLS+cQgVfFc3IUJ9JiqnAEaYGFseWZoEW3sLwrCgA
         c0J3WAC8tVbObIHgWmGtlmSIVxKEPPQSxiKDP23fo2hPRG9kGJyDSEhXFAMCEuniINza
         VGu/Vlnno5J4mP9o5XIGUxqWu5k8qOLGY92f24K4U+jxeBtjS6rRDKzCCw7wRX0KY/mh
         ahYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2CQfungpKNvjxTzrQ0gyFVifkmACYxQ+/C8OQL8ClM=;
        b=TtOwoX3vJm4HyvtEuD/ySxkGC8AogiqbybeCS5iLY12CNJ/WOKOIosmnbS4WxjzOdM
         LP+cbIb7+QEWObOlYJ67OYP5B+oVnLlMkCe37374/bNLpWC3/rUH8VV4nS4RqIHCGoj8
         FTk6HVO4fo9/sIKTg1rukrTNkhP37I7T2I4rzpDzpuhJnsGvFbGpzSPRGmLiIm5b7UXo
         kZCQAuQfMwBNDl3JjSRNkuUyRuINrvkexqaznf6L7MhWTjVlcR/Rqkl0+yLYVC7Aw5yM
         0Vpt2UR5ftJZJOWnw++7FPMaZad7fxCtOv2rhq/X+3Jt5QcJuJ8MJQm4S6hD4+T6kNQ1
         MTwQ==
X-Gm-Message-State: APjAAAXK9fIgnX8GOHb9I39sWAYIrZhvPPPV/RfZ9wqTs7ENciJuLX4y
        99Brfg33K5HPlbeZ+Lx5EHuF3H7dqpY=
X-Google-Smtp-Source: APXvYqy+26RomZeL9Ta5dOB0ZoXicS0Z5lBDcEuwj7X3oa0BvygnU7IZkdnp9573Yb13CneyahoUiQ==
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr58150027lje.240.1564407653643;
        Mon, 29 Jul 2019 06:40:53 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h84sm12762220ljf.42.2019.07.29.06.40.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:40:52 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 0/3] Implement org.bluez.mesh.Network1.Import() D-Bus API
Date:   Mon, 29 Jul 2019 15:40:44 +0200
Message-Id: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Reworked the API to new signature
+ Removed dependencies on mesh-config

Jakub Witowski (1):
  mesh: Extract read_* functions in mesh-config-json

Michał Lowas-Rzechonek (2):
  mesh: Add documentation for Import() D-Bus API
  mesh: Implement Import() D-Bus API of org.bluez.mesh.Network1
    interface

 doc/mesh-api.txt        |  57 ++++++++++++++------
 mesh/mesh-config-json.c |  68 +++++++++++++++++-------
 mesh/mesh.c             | 115 +++++++++++++++++++++++++++++++++++++++-
 mesh/node.c             |  87 +++++++++++++++++++++++++++++-
 mesh/node.h             |   5 ++
 5 files changed, 295 insertions(+), 37 deletions(-)

-- 
2.19.1

