Return-Path: <SRS0=g45L=XO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C1C3A5A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EF0217D6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Sep 2019 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVh0F5sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbfISUUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:20:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39948 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfISUUE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Sep 2019 16:20:04 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so10855771iof.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2019 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=USqQhkyl7LuSygeZ2mO4OfIFHPVy6/sF5weOEbVJZq0=;
        b=XVh0F5sDBkxGU6ToODV1r5HVcmCKXN4IrtwCkeA1lHmhWrobiL3B8uGKzjsSpnPwDu
         tmLLEqV38Txg2Wh6J5tOkCcsl+0rBA1D1z+JoCto6bURkSm/pRD9GCN3TvQTGBgb9oTc
         sO0sO3TlZHaZxxc457K3o6x2mamtChqtE3AGj1yp2yVWjVdaA95LTVy5t9clGGDFu9vS
         2uLpNZgSUXOcVsk0Fs8Otsal9+RKkHsD4x9t5afCTfjNZDP7TF6mHaK5Un15LMg3+eUW
         BC+X4ZVS4IOwGguswQ/KjkxgX2cKQm+iJpGlCAYM/jMq4cTL7IxB2XIswkZdbYe6d9D/
         KqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=USqQhkyl7LuSygeZ2mO4OfIFHPVy6/sF5weOEbVJZq0=;
        b=poYCZJi35k2e2FZOQ6jDlSrpTfADxbcL84t+mFOtFOUmnCTXRiAM1yRAEQMiHmLwtk
         uVwsST+gRSPTgat6ueHE6dEztz++FR2PHjlyq43FAjqFShIuTpx2qwwMTXfZnSKK9z7e
         hDJQh3ae1bTU/wZWKE1yUStI+ewA762WCpLXspn3p/5ukRyEzUOiTo1revPMx/xMd4FL
         TfPVy6pXwHddVx4N6KYtJUM3Ju6qbNfEvgzYQ1dHJZmgLtz1ux8yk5fHVw3B+rC3DJNc
         2ZTR932Aopm0qVE2Y6mYlEURjEk4UjSLD59xqbfVCQ65i8xUCbH7E0/Xn+VJP5qm4D7Z
         REMA==
X-Gm-Message-State: APjAAAUuiKc5HITd2Bj/CUEaW1QArM86PRzRM7suPnje6yhdgapmOORM
        usxWkdtN2TibOEy0BGHbIzWwzpHa
X-Google-Smtp-Source: APXvYqxiy6tNN2V4jh+1LF8izVtmOwBhkEBW7hi7mJMLVBZbUPO4k5FSPWszn9UlKXCTU9zs+2wGBQ==
X-Received: by 2002:a5e:9247:: with SMTP id z7mr12693921iop.76.1568924403690;
        Thu, 19 Sep 2019 13:20:03 -0700 (PDT)
Received: from pvent01-dev-01.Geotab.local ([72.138.33.126])
        by smtp.gmail.com with ESMTPSA id s24sm2461140iog.26.2019.09.19.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:20:02 -0700 (PDT)
From:   Pieter Venter <pietventer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pieter Venter <pietventer@gmail.com>
Subject: [PATCH BlueZ] doc: Fix grammar
Date:   Thu, 19 Sep 2019 16:19:33 -0400
Message-Id: <20190919201933.28066-1-pietventer@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We don't use an before u, if it has a [j] sound.
Sending this again, previous author email was incorrect (sorry!)
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

