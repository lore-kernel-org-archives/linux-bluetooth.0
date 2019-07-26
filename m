Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F72C7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A4218DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="F4K7vahH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGZGgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:36:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42414 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZGgP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 02:36:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so50366241lje.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Gmv70kqY+eqmILzTv0nN5dI1a+Vaw/XdXAUkFr7fOA=;
        b=F4K7vahHolEczcisajTjptIYdWs5MrL/jHOn1YaXAQfSVqICUU7iJSz7bHA//tPV0l
         e4bzdpXvo39VQFrPQ/tsXT9EOqphfWSxmNgZFxYu/y6mia/ZypZALpZgeb51tYHEqzwy
         eAg4rOE6De1qPfI5aIMZA3r6/Ag72DwH9Zt9LLNgey/tlKYZLSBnK3Xw2R3tp3W+RGIy
         qcrCOca/MiSz/+yiNW4bESAEm3oZE63cYtK93Icf9kbIXH+f+73Ki7ZAjmJfsoLtfKSy
         abtMnBVbYzkcPc/Ti9ZBUQTHruLjNaxGvMvtMJUoFEh1r/S43/e1MMLfMNeed9kysFwn
         ukOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Gmv70kqY+eqmILzTv0nN5dI1a+Vaw/XdXAUkFr7fOA=;
        b=RsuHfA8DSptnK6t25xL0hSA6lSApXPrhOYKF6NH88Aibxezy78lAbVCogDWt+XY5Hi
         S9pJsPCYu/d2chvvz1Fn4t3C4kPmstZn2ewsuwxiVFbTzYbPRzW4fwr4I6bDgK6ZLrU5
         7Owggs3ZY1wgPYtA+HcQbnn/KCkyoXdfhQpf3mPxSqSt+u6GU2lYdsJTDCGo5UpqEEB3
         nB88vuswW4VRf2T1AVG5Lj7nhakRgd3EcJy5a5I8bnX5fv9Ca/PCNxdAxLlHhILVscfw
         57g1nkQIBn4C4hY4fJwp7Siso1x67VAXCrlhosO1vt5SRAN3JDxIHJSzSn6NZzZW+JQn
         F26g==
X-Gm-Message-State: APjAAAUmlRzGBDA4fZ/FmymhyrP3nmIh2L/K/Ed+IGMZ0UClq82J7vzh
        kHrQtG2MccRDtUhUPZMZlLDvopT7WRQ=
X-Google-Smtp-Source: APXvYqxyBAYHPYbwKkHO+MoKwCWwBpYJwRS6hPelTN5K4mSxWcqHQz3CBKGsUWns+4zreTbc+DOYWA==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr11782616ljy.86.1564122973152;
        Thu, 25 Jul 2019 23:36:13 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm8039109lfq.76.2019.07.25.23.36.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 23:36:12 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 0/5] Use composition data to validate app against the
Date:   Fri, 26 Jul 2019 08:36:01 +0200
Message-Id: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for your patience :)

+ Fix brace style
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

Michał Lowas-Rzechonek (5):
  mesh: Convert void pointers to anonymous unions in managed_obj_request
  mesh: Validate application by comparing composition data
  mesh: Keep element and model lists sorted and unique
  mesh: Check that element indexes are consecutive
  mesh: Check that config server is present in primary element

 mesh/mesh-defs.h |   2 +
 mesh/node.c      | 556 ++++++++++++++++++++++++-----------------------
 2 files changed, 290 insertions(+), 268 deletions(-)

-- 
2.19.1

