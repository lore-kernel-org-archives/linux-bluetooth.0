Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB4C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 03:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiI1Dbo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiI1DbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 23:31:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF15E674
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 20:30:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so561495pjf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HwestEX78EVZWySyknmdp9DODm6MZTMTuWTcSGcPQKQ=;
        b=WujRc2u+K0V5t3hbTWth+rqH16BfK4Ii2aGpRWY7AbPTxd3UTz+qcX4OQ58ue6fwDu
         F3+CNdXWtGfRpoI2XYaN9F2AyaWPxEM7ym+e9WlbQoAHLgxVEvAcp2KyxSnEYf0Rmd/T
         TerlOqNhG39l3PnBp8ZE6Hw0fJpYwiXd2EUT8KeWCKGEZbFEU+wU+1w+AoVrG/2F49vR
         DENCp9XOYSqUkfcfRriJw6ARxw1xqxADG6MAMkpCoXV9CCjIrBdHLiaFODau0uq5KGzr
         OMXZxacZBG55gcW5eUkWJp89cTqtr/j3KEns8+AW+ZCdqcdDyo+kyJXowEzAeVtbTNt7
         APyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HwestEX78EVZWySyknmdp9DODm6MZTMTuWTcSGcPQKQ=;
        b=bCADrGYs44B4uS/FnAGExn9uR69gYbihpWP3D7T44jwLeBtIUA25Ztm92h+BLftW4H
         qt8VgaPwJZ8OH2/bcQY1UnHn77RgMy6leceGVhG60Mlu6PUdoTz8cKdlrA+elADVQpbx
         6yca4TzUKay7Gaangit2N54PcvFQezwL9jFE0uNrquCDQn7vphAE+/SEd1dCQJjleKvM
         yvKfFfjP4HbP3o1sRv7CjOWPXjgYyYtYvbxaEfHs3xKBCIuSYf5qzUvZ4iCe245dSaGM
         SoS5b5X+3DaHS1b7MreHeyLj0WpjEi5omOekJ3n5NAx/uXEU5D4vfLaJqX439BtH60yj
         bm+g==
X-Gm-Message-State: ACrzQf3jGIp8w2Rn7GNegxUS4lWTnLC+gwNEKenmmXaBfg+/kqc0bsgH
        dXw6Zyz3Dr5gFeRJ8l5ODhPXwG94aZE=
X-Google-Smtp-Source: AMsMyM7Ivns4Jaq1d7exuvQCFWMIXy0G+Q31Ld+gxdKqcrtKXwc4IbU3bkPQyr46xbXRqFAy5iN8oA==
X-Received: by 2002:a17:902:d2c5:b0:176:d0b0:bf53 with SMTP id n5-20020a170902d2c500b00176d0b0bf53mr30508642plc.88.1664335855921;
        Tue, 27 Sep 2022 20:30:55 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:b354:2fc2:b868:bbb7])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090a784b00b00205f2a54815sm216294pjl.25.2022.09.27.20.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 20:30:55 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] doc: test patch - DO NOT MERGE
Date:   Tue, 27 Sep 2022 20:30:53 -0700
Message-Id: <20220928033053.202032-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..9bed96411fa0 100644
--- a/README
+++ b/README
@@ -1,6 +1,8 @@
 Linux kernel
 ============
 
+IGNORE THIS PATCH AND DO NOT MERGE
+
 There are several guides for kernel developers and users. These guides can
 be rendered in a number of formats, like HTML and PDF. Please read
 Documentation/admin-guide/README.rst first.
-- 
2.34.1

