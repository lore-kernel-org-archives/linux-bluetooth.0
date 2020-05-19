Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725E220849
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe2d0p4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgESUDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgESUDx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:03:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3FC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id n18so418259pfa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3vOmxRIz18xqHnh7KqZs026Bkg3/EflDmf6PCja04AI=;
        b=qe2d0p4DqcsqJuwAZaKUbbEpw4CWfY5iH8qCEk+3OfXYoKHSE3mEeMP3/4vpPnSOq/
         qYjn3Vj6hf1b/e2ibUMJ1mAvW6yfrqOGThwb1Da3T7vYF2xl2USA6UrN4dYPCes+HMBu
         S6/mgXigmCvpGoJZXl03pLi/6UzWkOoJH9E7U9KKcC6LkZATPZ1Koc6LxViw9QtiYOrx
         ItBQTRZcHxPGZ/J/b2QP6da1euh4E3f7tV5shsvMkCQPFyPDDTwCbFwAS22YZUyxDGaO
         P+gnz/KLz4t+sKRXb1mRMAoeGQN51A56iuNpC8nK7T729UkeowhTwoA+T1QGIVSoY2Q4
         e0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vOmxRIz18xqHnh7KqZs026Bkg3/EflDmf6PCja04AI=;
        b=meVVTQ/W21EtLtx6/dBDEDyU9ypEfWYuJfKidQGJnbgN7dh1/XLZTTAi6/Bejlw3cT
         r5ggggyTOMMYnjjtv+kVUGMcNuq4rPJ0mt3rgsKDGFePye44yJslHmoG94jYpwLpsfwE
         r81GPDFuyz+cUUmYiBSKTFhtRAnto6drKoJgvuZT1UUCyqKnN4+JEkIBGRl3zjk3vObE
         t9WGsdyqRVpe7BoFFkE74lb+Nb+57J01GNJkkSELzHtfaClaxgjsxmvWczK6vDGJITfa
         oyrcYvY5plqy4PjcbxSRmzHcZT8L+vjwnIjQY9qtkXSyn7OPFcjLDlWJeW+hDMMMfrRq
         Nncw==
X-Gm-Message-State: AOAM533Ue3+x1hWqasvtUZEcNAvS5WiPCHoZan2Q66XulL6N3kd/mz8q
        PNAd3VtmUBx05pvMo+zTBcXxVWn0
X-Google-Smtp-Source: ABdhPJz4DLCXwmAWF1gocd/W3quyXkdhNyZOKB3W9U6Ygfh9HO4TJl2iP6U3ucYoSZ1iXGlFsYG6uw==
X-Received: by 2002:a63:f015:: with SMTP id k21mr868327pgh.248.1589918632118;
        Tue, 19 May 2020 13:03:52 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i98sm302003pje.37.2020.05.19.13.03.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:03:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] doc/settings-storage: Update documentation of Endpoints
Date:   Tue, 19 May 2020 13:03:45 -0700
Message-Id: <20200519200345.217345-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519200345.217345-1-luiz.dentz@gmail.com>
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add documentation of DelayReporting storage as that has been added to
the cache.
---
 doc/settings-storage.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 5f6d25141..d21150f09 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -218,9 +218,10 @@ Sample Attributes section:
 
 [Endpoints] group contains:
 
-	<xx>:<xx>:<xxxxxxxx...>	String	First field is the endpoint type,
-					followed by codec type and its
-					capabilies as hexadecimal encoded
+	<xx>:<xx>:<xx>::<xx...> String	First field is the endpoint type,
+					followed by codec type and delay
+					reporting and its
+					capabilities as hexadecimal encoded
 					string.
 	LastUsed:<xx>:<xx>	String	LastUsed has two fields which are the
 					local and remote seids as hexadecimal
-- 
2.25.3

