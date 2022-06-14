Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A2CCA47A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiFNV4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiFNV4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 17:56:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3062B19F
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 14:56:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l3so5799369qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6T2S4hfFD2xREDyL6cndCDUIOdoiywfBXL+HAGS8mRY=;
        b=TSiPp52y4viYQi03Uow0XbSRqNlAN73YjxF5fJjuuCiJQCqDJFtYzN7vIgNFvrooow
         TpngZc1hzDx+gVlLz+ePWy/rPuNGM00Q4gCMHWWVvzSipZ0tfG94imUJTOXAB03CuO/3
         3f9xwzNQ6vrXB40EwRfnfwE/id8yYRYQ1n4xyc1H7kd3KH94lecBwbrQqI9BvUxBK01R
         OhQ9WsGk7sfoad2QRHAlpfPLwseRAQJ7KMSYAzpK9d7C/eCXIxfK/Jr+iJ14Posa85S9
         YCRR7ywnmXAks+OHBjazRbHIIXzLpVDH/wA6RgBs9CJlhE6x4qPPifeQErWITHTLJP+a
         3Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6T2S4hfFD2xREDyL6cndCDUIOdoiywfBXL+HAGS8mRY=;
        b=Nmlxo6pI66XzMbskoELtdzcPaQELVwuXYOEpIXETt0EW24501AaYZMh7sThay+Nfph
         6K65nlv/uUjVGesNrXg1fuR5meYEu1fqffWiYoR2nrLdqFNqwT0J8kJHv34mDG69WEkd
         n1xtpYLzFdJWx2v66kk7E5mKCD3eB8Czt1sePP60n2r7zGVqD8DtKQoU3UbkOFWDOiNZ
         Z4Hr+/BL9b9BqdfGl84MRXC69Kp6co47ELlAEWdDEIMwO8NoU029Lovlyn56zy6ZMWWj
         t2tulGBBlf7A7f64UFhJj+/XKVJSgts54krPdALXPOqw0k+6QfLuoyqnukLLUzo0eLfl
         4wEA==
X-Gm-Message-State: AOAM533ZwAttYuFQdrT3cfHEbs6yioeDdAeULPQ46U9EbFaCjOkKrMiA
        7lemH+wGFrfmyc8JOAO+e0Pd9caL6I0=
X-Google-Smtp-Source: ABdhPJyZ033++/LPK4RRSYsXSgGE+Nnfz34Ak0ppcR5hyPkg/WR9NZuVXLcXYRnBW6J26pXKyoVCzQ==
X-Received: by 2002:a05:622a:248:b0:305:fa0:1294 with SMTP id c8-20020a05622a024800b003050fa01294mr6048007qtx.564.1655243773719;
        Tue, 14 Jun 2022 14:56:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006a780aa9fc4sm8446126qkp.96.2022.06.14.14.56.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:56:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] bluetoothd.rst: Document -K/--kernel option
Date:   Tue, 14 Jun 2022 14:56:09 -0700
Message-Id: <20220614215609.596687-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614215609.596687-1-luiz.dentz@gmail.com>
References: <20220614215609.596687-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents -K/--kernel experimental features options.
---
 src/bluetoothd.rst.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/bluetoothd.rst.in b/src/bluetoothd.rst.in
index 6bce349ef..7a0fa1b24 100644
--- a/src/bluetoothd.rst.in
+++ b/src/bluetoothd.rst.in
@@ -67,6 +67,10 @@ OPTIONS
 -E, --experimental  Enable experimental interfaces. Those interfaces are not
                     guaranteed to be compatible or present in future releases.
 
+-K, --kernel=<uuid1>,<uuid2>,...
+    Enable Kernel experimental features. Kernel experimental features are
+    considered unstable and may be removed from future kernel releases.
+
 FILES
 =====
 
-- 
2.35.3

