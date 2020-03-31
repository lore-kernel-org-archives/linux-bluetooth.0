Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FBC2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB8F214DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KF3KmpYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgCaI2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:13 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40911 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgCaI2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:11 -0400
Received: by mail-wm1-f52.google.com with SMTP id a81so1534075wmf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r3KIKeOoCXTzCSOwCnlRZi5CXO6ooZd8wIikiuhvKRk=;
        b=KF3KmpYY0aCnLJOtMWTfnVz0Lun85v9ES/c/hZVm7j5TF17DS6KuQLCiDuh+p4rIE5
         Ig9FCUkFHCPxH8J9LLG5apgVdb3sRQ9YRDC87RpTbduAr7WM74Q7wM8bgKsqVy0DsVox
         m6bvM3+OoD2LNxV9njzDhM377bz491aeZra4ZX5oTdyEpG+aZGX+O6rpcIhY6sWEcLCE
         pJb/exYVqUlc4ni3Md4lS+84VJcMGFI2LX7oQ2mceqKVGiFl2vYui/48ZeSUIfOF9u6Q
         gT62bBx1OIybAwm7Boyzjs2EzpVjMBNxWR/v5PfQimkNOkdVxv8FxeHz150GMKpNI53o
         APfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3KIKeOoCXTzCSOwCnlRZi5CXO6ooZd8wIikiuhvKRk=;
        b=t6F63zq8huN2e27OWNWYwhNNf7eXnvBQuT6ygtXAIgMsESjjHXJux7FPw+uyT43UuS
         3r8rN9+zxuTHhy+tt6cntv9UuPRsqIVQHoSMqCa4mTSBxbkW8j8ml5cTKZwN9EiFD/HX
         BKeWRcGDjVDX27Gsw+Su9dyiLA9FU/Pb2HrL2dg3p0o08oK570xa6UtQ2Za3W1MwMFdr
         Us/+494GdSEe19brDT4b8kVZSuYaVxpAhLl0FHHn3L1rJYjcQEtXAWu6Ze8zIIEZZgSt
         FHmdk4FmgRz8pHezQApruWT/vHKk4a0fWKMWJsTOFnaElhKVe8EYcQ2zf6vf4JUmUg0S
         0a0w==
X-Gm-Message-State: ANhLgQ0hSyAYLQyiVKgvBBogFUR0eVrs9Hy7kFzn79RmrTxwatte5EG/
        1PmPwlhWiysL/IXsVwqJJIZDUm8gnmVqPQ==
X-Google-Smtp-Source: ADFU+vsCaCxk39ZoF8JK/STztDkFqYzGHUrALeAGa4HQrJkaVGSSQ1YjE8KgwDQ5bbLotawuefM3bw==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr2277580wmj.111.1585643289984;
        Tue, 31 Mar 2020 01:28:09 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:09 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] doc/mesh-api: OOB Information field is 16 bit, not 32
Date:   Tue, 31 Mar 2020 10:28:10 +0200
Message-Id: <20200331082810.10856-7-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 848106335..513b021d8 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -950,7 +950,7 @@ Object path	freely definable
 
 		The data parameter is a variable length byte array, that may
 		have 1, 2 or 3 distinct fields contained in it including the 16
-		byte remote device UUID (always), a 32 bit mask of OOB
+		byte remote device UUID (always), a 16 bit mask of OOB
 		authentication flags (optional), and a 32 bit URI hash (if URI
 		bit set in OOB mask). Whether these fields exist or not is a
 		decision of the remote device.
-- 
2.20.1

