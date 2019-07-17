Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCAC76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B0020818
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wt2umrdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGQIhB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:37:01 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33267 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIhB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:37:01 -0400
Received: by mail-lj1-f182.google.com with SMTP id h10so22770584ljg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDwriGaa4a6Q2b2kFcxdsb6C0VuAKO7goCmdkOPNBn0=;
        b=wt2umrdtXeH3JwsjHEUfMs518Jh6/ICAIBUXLiO2W8pS+pa4Z98+Z35Cq7KVTz94ih
         CDMkL36cxqE4Kxa4LIudMQLpwJz6djlJzw4z45c2HTPmFbNw9Y0RDIH7w2uKYwQU7I16
         KtINIaAS+cd1ho83+BKuVGqKyWEzio5TgU6R0O1+OapQwuDMW0WzEccsKLzCmcSK1xEo
         /7708NrixDRJRH273TrbaxpIP7SIRQe11NnxR3bxbCA3X5aBARV5irfkC0jBWlOt7DOr
         ysUOVDAav5njcGbPjFJ0fGKqCsFr36mus4WOVfHPQSuzwZUSaaIg8Cd8GUOVb0MM9VbR
         c81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDwriGaa4a6Q2b2kFcxdsb6C0VuAKO7goCmdkOPNBn0=;
        b=il/LugzKx4t35H+JP1nMxfXJE7Spf0ZT/v8wMPCyxByzbtFn/5KnEmd6NBozJBwHCw
         8F8Tdujpmm65KnqCUe4Nist9pOYXADWK5SLEC8XHOwqeqPBPwpsDuKApv7ne0lDo5KNY
         s4NDLeLnwf+jJwWjcrwQNqs/6M6MssDnE9yafLMh1e1GoBLv8EtqW4BltOb3lz/pfV+0
         G4yAGPOl+boGidvHnqtg9qjgOxU988r7MNG12JZXU3V2Ht8XtrL4s4Mq6A9xRKSkZoK7
         PdcKZLJxCySciK9K6cQhkvJnDSswCI2bFZwAHpoD773Fs9VzEryRIfGBd1H9bH2d+eGI
         EruQ==
X-Gm-Message-State: APjAAAUtEi3WfQ7y7BCjhzSktK6fTKaI1YF6lX7qZcqdUm0iaeaTZGIu
        UrVPAxNnEGoUUzIVXQ+Z9BTu9tOJCo4=
X-Google-Smtp-Source: APXvYqwxRvPQFTGLm421NM8kaX9SBLMs+LYSGaiwpW7EsZ8GhqlpZ0cRVR53PXsHWhcglVIuCv+zMw==
X-Received: by 2002:a2e:b167:: with SMTP id a7mr20679077ljm.26.1563352618661;
        Wed, 17 Jul 2019 01:36:58 -0700 (PDT)
Received: from localhost.localdomain ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id v202sm3338708lfa.28.2019.07.17.01.36.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:36:58 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/4] Implement ImportLocalNode D-Bus API
Date:   Wed, 17 Jul 2019 10:36:46 +0200
Message-Id: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+rebased after mesh-config refactoring
+updated documentation
+removed import_req
+added patch to remove void pointers from managed_obj_request

Jakub Witowski (2):
  mesh: Add ImportLocalNode API documentation
  mesh: Extract read_* functions in mesh-config-json

Michał Lowas-Rzechonek (2):
  mesh: Implement ImportLocalNode() method
  mesh: Convert void pointers to anonymous unions in
    managed_obj_request:wq

 doc/mesh-api.txt        |  52 ++++++++++---
 mesh/mesh-config-json.c | 161 +++++++++++++++++++++++++++++++++++-----
 mesh/mesh-config.h      |  10 +++
 mesh/mesh-defs.h        |   3 +
 mesh/mesh.c             |  90 +++++++++++++++++++++-
 mesh/net.h              |   2 -
 mesh/node.c             | 151 ++++++++++++++++++++++++++-----------
 mesh/node.h             |   5 ++
 8 files changed, 399 insertions(+), 75 deletions(-)

-- 
2.19.1

