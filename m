Return-Path: <SRS0=g45L=XO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B2C49ED7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37F4218AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBJjdoMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfISOYU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:24:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39462 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403900AbfISOYT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Sep 2019 10:24:19 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so8155311ioc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2019 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MlCKJ5ABjmfSB9xQTK4W/Cgx1fT+hQbHYEqrURarNug=;
        b=PBJjdoMDpnBwvCQJENyS+33qAEvr3szJR6LLqvJDpXTbPRgOSAjNzlDZ8PwgblMmhs
         Yuh14WVv9HeVnPgP/pkoJ91XNNxpolJ2RaNIndrG88V9s8+Kwu7MIPtLZEdWpGeVeDW+
         PIyhFyGAqNcB1OomOIysb5jyuWJsG5xuUAJnsdcHA25HQkiRgpcexsmawudMrQssrM1N
         lpdSuaIR2o6rOlYwFAsBcN4Ye8Pvj8pBs54KFHCFXfqLs4euiy9Boj3NUPELz5gsCjUe
         uqOyXsvNpborUGMCRVCInByFWUzCj0Kux8+0eEuB0T3Wmm/gwaLQarWZ233tj0tvS8Z5
         o7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MlCKJ5ABjmfSB9xQTK4W/Cgx1fT+hQbHYEqrURarNug=;
        b=SRRzG5VzUlmz5s0tCugAC/UonBbcvqvCdhI1MPsKWII6U/DqH6vH2Vp40SWP+V98Yr
         5nSJmvEK8HWJGqjaQo+cn6vrmfgFi+ddUoUSif6M8tYjVsI+hwcHTnu8mdpMYicmhzSI
         1+gm//EfL7juKsQe08NIWBJBub36dpZRCD12ny5PyMYsC/AEv2daNcqqG6yJHWwkzzE2
         /bbjWHYsnGg7NAbs/dl+exIjUkDV0rhfmfw97WlsIzQhHZvljKk5M8PNhoP5mQ4jmENw
         ogk1kmenttmCSFtJbSEDv/Fcv8d6rXfiwqnqwPArl7XigNIyXEDBjfAZy8UsviTWQSf3
         tPnA==
X-Gm-Message-State: APjAAAV/pLeAcP+DugGY4uu3oRV13AJEUiKmkDZrLXeT3hQWbpgGmOYL
        31LwN4jii5Qya9jbmDn1/S+WdiU0
X-Google-Smtp-Source: APXvYqyxLJLIjF+KlAsvg+ASl5z2GmFv2jfJiqhVKwvC6FSRpMnfjx185pF3c+3oDq9bPOFEkP8PyQ==
X-Received: by 2002:a5d:9314:: with SMTP id l20mr11922527ion.298.1568903057874;
        Thu, 19 Sep 2019 07:24:17 -0700 (PDT)
Received: from pvent01-dev-01.Geotab.local ([72.138.33.126])
        by smtp.gmail.com with ESMTPSA id f5sm7517445ioh.87.2019.09.19.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:24:17 -0700 (PDT)
From:   Pieter Venter <pietventer@gmail.com>
X-Google-Original-From: Pieter Venter <pieterventer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pieter Venter <pieterventer@gmail.com>
Subject: [PATCH BlueZ] doc: Fix grammar
Date:   Thu, 19 Sep 2019 10:23:43 -0400
Message-Id: <20190919142343.1416-1-pieterventer@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We don't use an before u, if it has a [j] sound.
---
 doc/gatt-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 98fe7487c..9cceef9c0 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -13,7 +13,7 @@ Object Manager at its root that is solely responsible for the objects that
 belong to that service.
 
 Releasing a registered GATT service is not defined yet. Any API extension
-should avoid breaking the defined API, and if possible keep an unified GATT
+should avoid breaking the defined API, and if possible keep a unified GATT
 remote and local services representation.
 
 Service hierarchy
-- 
2.17.1

