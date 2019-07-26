Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C44C7618F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6914E22C7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="sUUwBeva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfGZEap (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:30:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39159 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZEap (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 00:30:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so36075869lfa.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 21:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACfgQaEoy4CgZpD8wmGkk40/Dsamo7U+POiuGsyWjWs=;
        b=sUUwBeva/z4TmCZiumrNBQ1fTpC98jD0T/UamfuMBDu1L1AMfSxN73sDNEqWWLZG2y
         woHsGpyIVhQUAmwFLh6+HErZ1gO++D/5nXMkUTPjNoc6NHVQGH27ALKPPf1sCDdD0APb
         ubxM5xEjGxy13e6btfXDFS0qwXvuOlQbXuDQKC1t5sOtqV69/ndAQAzBghuxbl24IzK2
         51E8vEtIWn0Wyyz3DzLYfUCKzm/1CWAozVwPya0Z0XVXi3oETodTYR6bp8yz6ELE5IKK
         x//FyOYZlXDCNMw2jMZSJWSuoQl9nhopXuYgc+uS01/ravmCrOkk1kf0EsSrlalLmQja
         GvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACfgQaEoy4CgZpD8wmGkk40/Dsamo7U+POiuGsyWjWs=;
        b=ge1BYjI64kR+JogPO4t43SLyVlnHSKhFlejESXkELJYFa7q6JNsoDg3ige1bv4ou33
         1b/LT/gmFe65ChjwZNkbTq/4nL2rnRw7+53CYShkHh7lO1yoz3BZU/y9qYFY0KMUbtuk
         rm3iAlBBd9FpyJt8MvtkdxKrCubigqi5qQSrwvnGjSR73673rf6DyCHdccrDmeHTdMlR
         SBgr1mJ3qhCKW6Ug+HRoWIRU6V0Ply0/6AmRz0E1kbHsncmpH97CkvGYNPUgkZ0gB7Qq
         ythL5dBj9L4G6beIn56Cb1NPGVVx339DRayN+ypT/x2Z/Ph8bWQeQQVH4w/R/WQSSETE
         ClgA==
X-Gm-Message-State: APjAAAX2DGfmMF/r/J4Vj5ZJQHsKEQjSxvr8U2qLVkNyV34XBfXuoDEM
        CjrNhz0kbP4ne37Avr5lgVu+y2gl5po=
X-Google-Smtp-Source: APXvYqyzQd27ff4tpmWJuWVI8qtB1QBBY6qoLk0jp1o57VFCw716JPE6ew+J5CSdo7AlocneswnPXw==
X-Received: by 2002:ac2:4891:: with SMTP id x17mr44419632lfc.60.1564115443050;
        Thu, 25 Jul 2019 21:30:43 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id g5sm9792735ljj.69.2019.07.25.21.30.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:30:41 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/5] Use composition data to validate app against the node
Date:   Fri, 26 Jul 2019 06:30:30 +0200
Message-Id: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Fix comment style
+ Fix typo when assigning element paths in attach_req_node
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
*** BLURB HERE ***

Michał Lowas-Rzechonek (5):
  mesh: Convert void pointers to anonymous unions in managed_obj_request
  mesh: Validate application by comparing composition data
  mesh: Keep element and model lists sorted and unique
  mesh: Check that element indexes are consecutive
  mesh: Check that config server is present in primary element

 mesh/mesh-defs.h |   2 +
 mesh/node.c      | 557 ++++++++++++++++++++++++-----------------------
 2 files changed, 291 insertions(+), 268 deletions(-)

-- 
2.22.0

