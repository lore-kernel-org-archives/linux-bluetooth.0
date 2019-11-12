Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E0C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 15:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0483B2067B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 15:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bOpbHrlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLPBB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:01:01 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33997 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKLPBB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 10:01:01 -0500
Received: by mail-lj1-f177.google.com with SMTP id 139so18181254ljf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 07:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkUwbEEa+Fdg1AndYkreKAEh1zlCI7+zTgcRzFEJqOo=;
        b=bOpbHrlkSVVugdHhPOvOj1gywlpI4cdPY03BFIzvYtyf2nlBHv+Bn4+0j7jJe0jpjy
         oYo2N+ZWnwDxQDPwUB62cFkuCuO/dNqadd0nEsMUbWjZl1elJa9L+7C7o5AwBlTj6hlU
         iKRD9T/PcofcjXoxjwLRPP+TrN9eb34dVmPm6ItWSt8BQTaeJcVtFnHv59F0xREKur7/
         ibCy+NsYTg2ToYfkkpnjTDP5KXrpI+SRqOKlAZOA5GQ0NQXhf5nWg6ACI3u3QOBbAzL4
         Nv5I72yh33uQcBI3JjZSD1zjqxONkEJRde6a1LTZ1YyIlDOynhaKa23h6hRvW+tosW9q
         cnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkUwbEEa+Fdg1AndYkreKAEh1zlCI7+zTgcRzFEJqOo=;
        b=BsX34/kO/hkNUZDtfBtZGdyAx0gUaaiY8YpH5lVZGKP11+YgKcXDhYjXjrpSsg4Xjn
         jcoWd8bhE+8sXuuVOsbBxCdCQuilsbk8c62I8FDEr430p4AIXytsyRaRhWZROPcJc0Wo
         d1jqRqwnJtiqUUXqjjVNhRniC06yFzQ0M4Q3mY423bJzRUvDpWEMGKEjpwytBou7n5l5
         n095+1w/xwNQtfev6fbA+NS0qz0To+zhwGErZFB3E2xxSqrrnkKDBdTmRKZrTsU/bq4D
         UVg9IbTB8ufacKY3nYC2j34tgsuzS5jIAutaAqfj4jEF39gY3nNsg1k9JgvvPlfM0Pb1
         wP4w==
X-Gm-Message-State: APjAAAWlGSDvnvkxrQReJo741s5xr2bZAnvKxG0fZu6/0GDrOiTk8ZGa
        9xeV/n2CFOhDGkaMuIvgiTnKX2z2F/0sew==
X-Google-Smtp-Source: APXvYqwgLBzbLqmyF8ehs5QWIMWTAhnQfyiYeheumDxyaGmrjnkCVL3lKfP+Eqs8Hqd8PaQnoVWQWw==
X-Received: by 2002:a2e:547:: with SMTP id 68mr20452922ljf.150.1573570858848;
        Tue, 12 Nov 2019 07:00:58 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 4sm9179536lfa.95.2019.11.12.07.00.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:00:58 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/1] mesh: Streamline crypto functions
Date:   Tue, 12 Nov 2019 15:58:16 +0100
Message-Id: <20191112145817.6692-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
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
  mesh: Remove redundant code from mesh/crypto

 mesh/crypto.c           | 481 ++++++++++++++++------------------------
 mesh/crypto.h           |  50 +----
 mesh/net-keys.c         |   2 +-
 unit/test-mesh-crypto.c | 205 ++++++++---------
 4 files changed, 291 insertions(+), 447 deletions(-)

-- 
2.19.1

