Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE33C2D0F1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CC520678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ui+D+d7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgDAKZE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:25:04 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:33482 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbgDAKZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:04 -0400
Received: by mail-lf1-f46.google.com with SMTP id x200so12816079lff.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r3KIKeOoCXTzCSOwCnlRZi5CXO6ooZd8wIikiuhvKRk=;
        b=ui+D+d7L3Gez0LsxDdnjkAllAvmleueRmEwwCFOCFvI5lNTuY/Cj0L4W3WIJMaH+oe
         r94JEBsUg7/Ok1DUcIHcv3ABe8YUY32wR713KCNpSS1cEVxYFQj/ibRntyYPgx7X6aLk
         lrxKnrRh31D2vdyr6rFvAtzkfwwXn7FbS3KGpwKLoWzM77/4lA/d+DRlbF9oywjMPlmA
         uu8czFgkQ35hKPfVOVh6F2V1CreQsoEkdxceZj/y6YunXcXMVIGBYAjbZZ7C1gEwuKkX
         V9oejSarf1g2xTmGfC52BUeWfudTHhjgbBf4H+U171DEXfrREFFmyZkHllmLbKc2EmK/
         ecMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3KIKeOoCXTzCSOwCnlRZi5CXO6ooZd8wIikiuhvKRk=;
        b=KaCZkJTxrsXsalVzq7ZOl8g2X0KUw9cmojcZbfPEjjSXWaz8ol4qK4A6XNOCXP1tZO
         mYkf0FLmv2WAp4BZm415b+bcx7giAP5Yh/GQkZmYZY+x4B2oDHZpBp8iKxr3MBU76RD2
         rzynqtCVCqdwQd2tQhQTUZvY0FjcNKMgO12Jwm8aXSwfNO35MimmiIHa/JgKjqgxqiCI
         7kw29UnPvA+umXjJ0EPZFofcwCu5gF67yAWJ3u2wwPAYbFkWun6+V6DPpf9KExcfaUd4
         JivRVAvKLktgRjzmrMbRSnjq/JQi2xDaYJdZZ6s8eSXrMl3KC8a1g6TojiszTiVKbbxK
         s4rw==
X-Gm-Message-State: AGi0PuZcstJDr5d2qz3mQzzqOqSMb2E28sDBOpq3BYPpuR/ImaVt20eQ
        LlUgE9r6cezAYDJBLYmtdQ9EYjeXo90=
X-Google-Smtp-Source: APiQypKiN+wvgVJIbOgtRkNMTrdl16j1UyX8eSwivDHbRiGAD+Q8ffr6nsIIk66ldit7lt3/B7zoWg==
X-Received: by 2002:ac2:4342:: with SMTP id o2mr14117163lfl.195.1585736701939;
        Wed, 01 Apr 2020 03:25:01 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r16sm922217ljj.40.2020.04.01.03.25.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:25:01 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] doc/mesh-api: OOB Information field is 16 bit, not 32
Date:   Wed,  1 Apr 2020 12:25:02 +0200
Message-Id: <20200401102502.746-7-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
References: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
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

