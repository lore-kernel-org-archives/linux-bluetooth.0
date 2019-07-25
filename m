Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A5C76190
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA37A218EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="mB5smMOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGYTtn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:49:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42271 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfGYTtn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 15:49:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so35394576lfb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuOXRP3/MzD3IO3WpGZZ3CFEeQA2VCyVLjzGYMbAM/E=;
        b=mB5smMODfjEyoI0cwNjfIdjgzSAyGBVYuluYuvGLw5OGxcHjOlUtMMmX2Tq+FOQVpT
         ahykHftUDOazpWsfHG7kv74EuKqVikb7cAH7dPA1yZAuZdpHtFsNnW1oJU+dfKgUjD8e
         yatZLjAavQXDtYvs0SviVUAyZRlpcwO+v0Mi/nI7bMvp0TIg4oJWYdy0d8FiWP9MQnRb
         erGFGnVuH7XiCw+eFyxVLA1L1KxQr6FLiuc9gbXuz66+5AAI/EBPy2D2C/L0C2042xsx
         OHZq+u04hlbIv7x0B2lw2X0VbJKI8dc0uOPY9jtp7T8rwx8iKMIkkUD+Wm+SIKuH/D2a
         xnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuOXRP3/MzD3IO3WpGZZ3CFEeQA2VCyVLjzGYMbAM/E=;
        b=MeKOA7LP4N5sP1jv40oen3vBH6bfpKmMUqcbqTxkziAn9Sdp9MLhvJ6SCV19j/LOgW
         K3SL+CXcf4kYxBM1Tt+/eOxpyxzVQnKv69lzsvz9efv7FD9GAohBVvJHBlnTF8fFwM1J
         w7JNZgfLsoiyylUnFNoM/x7k6ymNBKaKH/M5llkv4oR74TiRfXHb4kms6L9R5e/Wdq1k
         RTzbC0S5YKaIqO2BkNBgTDX2GY4waJH/wVPMWPehzrtHP+jorXf9M0klPxQ3UCjxju7S
         Zj0CMZ8DdmECae03cZTjfdThQilvmJj0AUJZKhmchnLIAy5zr+Ea6x8mZ4mXF2YXHcAh
         rkuQ==
X-Gm-Message-State: APjAAAVxeJlVhGNh0cPs4Bln24RxUaxGJTNtBNYuyjoxsBDdZXTedLkn
        CqRAJfWh4y8YclzBhOb9ZRO46saP60c=
X-Google-Smtp-Source: APXvYqyRAsw3jYaYYZMl7MerDWo/lDTUrcaqzYos30DOstallxj4yh39X78W3xbr2LAZ2/37CK38Xg==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr42228536lft.79.1564084180632;
        Thu, 25 Jul 2019 12:49:40 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id e62sm9327693ljf.82.2019.07.25.12.49.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:49:39 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/5] Use composition data to validate app against the node
Date:   Thu, 25 Jul 2019 21:49:28 +0200
Message-Id: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Fix setting app_path and owner during Attach()
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
 mesh/node.c      | 558 ++++++++++++++++++++++++-----------------------
 2 files changed, 292 insertions(+), 268 deletions(-)

-- 
2.22.0

