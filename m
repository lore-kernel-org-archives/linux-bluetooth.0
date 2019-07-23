Return-Path: <SRS0=bMpm=VU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781BCC7618B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16C21BF6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="MK1GEsfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGWKGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:06:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39176 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfGWKGd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jul 2019 06:06:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so28886000lfa.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2019 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f89OPnLPUbWGKlMBFREnIalX5GwoWyr4HYutENXMEQs=;
        b=MK1GEsfljgyLzWmGxlgr6X9knJ3afXHkWniSKU784Bb79jYUEBI9OlCtHiwJVG6fGL
         4edd/k5gOojhLO2Z8MQHY4bZN1iN3+lh7Cv4n0SfCqmU1kBp6V4qBS2RzaG2uYg5S/Gu
         EQASatHnM5A1Lw6OgfhD6KGZ66o9QUWr5SegEN2vS5k13/iOl6tnbCe0L4BxhoWnftRA
         4oDdkymrnvUbaNmS6JFZBwSoPIrQXi2wm5tWoJ7amJ4tY9fx3m5huhoP5Vy47qwxr7mF
         mGWcKhakOXSIco9FVT30Vyb2FLSv0jZASSXDWBGhB3S0oyt/pqlmRIk2o51zmTNDOVrQ
         +nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f89OPnLPUbWGKlMBFREnIalX5GwoWyr4HYutENXMEQs=;
        b=Ml7UPuptFvt6hc26w2+lEK666CtxtU2h8CNNTQ9vFQURhJHPPpGyo/eVkDad9KGhFv
         c8A2WSD+n3lHgXi9qdgabjG2WoTvalTFE92FiGnl9hE7/czXdxDhRLZ3Ux5QQsGnWj8h
         A+Ft6blMb5jlEzPft9/PzR8VLDHmCSdXov0mOIvh3jdjWxv6G0yWD8ePBbdgmENzoRGC
         /sDnr4qLaFs2Ra0ANDUN7jBrM+/fxQ02OWqn4hAJResVinJNZj0lT9io34FVoHcGLvbT
         D/LthqDFWLC4B0zGIETtDO5SqPhjV1eDPt4bAz+LL954z7ZuxTZWCnvdBaSpZbC3VkU9
         9hOA==
X-Gm-Message-State: APjAAAVfO8AtSwvs5hi+aBjvoOpu5z31x3FT9I8tEJjovviak9ii500Q
        tFMClucDQCuwH7KqIAy5tst/rKQlfo8=
X-Google-Smtp-Source: APXvYqxvdiD6LPY26INIosAAj1+u882to9DKizlPEdvFve0PmrUW0eeg0mfUMDAQHaULfnZtLebs/A==
X-Received: by 2002:ac2:5690:: with SMTP id 16mr33650741lfr.43.1563876392120;
        Tue, 23 Jul 2019 03:06:32 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h129sm6395260lfd.74.2019.07.23.03.06.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:06:31 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/5] Use composition data to validate app against the node
Date:   Tue, 23 Jul 2019 12:06:18 +0200
Message-Id: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
 mesh/node.c      | 507 ++++++++++++++++++++++-------------------------
 2 files changed, 241 insertions(+), 268 deletions(-)

-- 
2.19.1

