Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377DCD13CF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Sep 2023 17:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjIQR0B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Sep 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjIQRZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Sep 2023 13:25:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F612B
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 10:25:26 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 673A73F149
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694971525;
        bh=pgT3GambENkqLARXsJ0dek0HdDALPnm7Zj3avL9wRdg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=lwSTvTdGeTejadKUSutj6A9I1W424iFSWLlWykuTKjnr6HtzmJqDou/Hdw6G4OrTF
         SC631f1VeS1qnkt5lbjemjGoB23D9BYDb/qOqK5z/iL7FCQbcbdKp1tfxTPUcah1ft
         aKf6nVXEVkuUo72uSEnRKVQUxdYeEnFFx8trPAGZFf74c3d/Ep00ie+M1zXOoWGpbq
         TpXO+IWZ23hjmP1AFIdFRom4GqZ+UpY7k+nUChYKsphk0Saoc0Cnpn+HlnzyV3d2Uh
         X/LtRvwfgd/7bc5S68GURURE2vQBaF2Q9zINsNzamvO3EZNXe2Qmr5/0Wkzwwq4Qyy
         qQjd5Pp1brKtA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27474c64aa0so2468816a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 10:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971523; x=1695576323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgT3GambENkqLARXsJ0dek0HdDALPnm7Zj3avL9wRdg=;
        b=t2tviRT81t8VdjaXGKADccsotC9WSUkj/EEYQe4JUg3BEAN8ZGZbi4Np/3JwWZfuOR
         Exk1ZJYVK5/8jfJSLXrlIXfJsex0tt+hGpevhsLfvOyGt2jNwGVFV7a9jq7neTwHe03u
         WomKlgltBEkfJfA5IUNhmrHZhG6eJD9m9IHD+O5OKfVlH2MgyLhUEm8c0ZtJCxVxRdAX
         Zwt8SFDca/Hvlyc6o3KtfSrNi3r4uYiVCUzaQ2oL695GhBiWg1zYnjGfC8N2mKHZGGw5
         LO9IgCTEZ8CXDQj52QNjNbYrT1Z4hcoGrkLsqJXmIQwxTuHkv/y4rBdNX1Ggd/MZF325
         eKdw==
X-Gm-Message-State: AOJu0YzaqTe1N6o1VKpewLQnG05gklGb8fFr0bqALku7myGSLoQxntU8
        9RAAIWe7aOTklx/6nD9tyeETrSQzA24P5b7HqV+2LWX5ut89scjcii1d+zeBw6Z6+J7lTOxY+Bk
        T5f0w/UMi0v2A03OAmx/Gr7nENqZpg6uuxp4+gR/Djj28ygO7FtzY2g==
X-Received: by 2002:a17:90b:4d8a:b0:276:696b:1dd9 with SMTP id oj10-20020a17090b4d8a00b00276696b1dd9mr634187pjb.15.1694971523354;
        Sun, 17 Sep 2023 10:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7yWccIiUyMwgJzgYFtB5FfaAIfjqcgTlHxRkZ9DZ9A57RaOgjbDsqLuNMpXN/hAxdT8/Png==
X-Received: by 2002:a17:90b:4d8a:b0:276:696b:1dd9 with SMTP id oj10-20020a17090b4d8a00b00276696b1dd9mr634171pjb.15.1694971522986;
        Sun, 17 Sep 2023 10:25:22 -0700 (PDT)
Received: from canonical.com (125-228-206-109.hinet-ip.hinet.net. [125.228.206.109])
        by smtp.gmail.com with ESMTPSA id bv6-20020a632e06000000b0056001f43726sm5527897pgb.92.2023.09.17.10.25.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:25:21 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] [BlueZ V2] configure.ac: Add enable_btpclient and enable_mesh for internal ELL
Date:   Mon, 18 Sep 2023 01:25:20 +0800
Message-Id: <20230917172520.46145-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

when checking enable_external_ell != 'yes',
even enable_btpclient and enable_mesh are not enabled.
configure still prompt the error.
Then ELL must be installed to pass the configure.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
~~~
V2:
* correct the wrong-spelling
* add BlueZ tag
* rephrase the commit description
* change the '&&' to '||' condition.
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4186c3792..54a609ad2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -301,7 +301,8 @@ if (test "${enable_external_ell}" = "yes"); then
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
-if (test "${enable_external_ell}" != "yes"); then
+if (test "${enable_external_ell}" != "yes" &&
+		(test "${enable_btpclient}" = "yes" || test "${enable_mesh}" = "yes")); then
 	if (test ! -f ${srcdir}/ell/ell.h) &&
 			(test ! -f ${srcdir}/../ell/ell/ell.h); then
 				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)
-- 
2.34.1

