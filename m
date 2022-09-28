Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04450C04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 03:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI1D2L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiI1D2A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 23:28:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1401181FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 20:27:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d11so10719253pll.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=x9sO3/CY9VOIXkpyRGvn3O24mVqzex7XRK8SHA+k3AU=;
        b=mWfL0BYHR7WVjtCfv6jGvjjTzPKN5JASckjhufF00VskMPfLnH6pnLEp+4w9kSvYnL
         fVkevSpIX2Tj2/fMUP8EHp64NtGSmQJBskcX8JXocuIkCihvPuxCW3f4o5w/QqRN8nkf
         1TsWf0eX4pm2v9oy4oksdfyOGyNAvxlBolo21Hr8YM2N3p0B9PpfsVnDpTjIkrn9K9og
         EeXeYJupECi1jALsV0yMfF4UVHDJtIpWb2UXtkANtaZskVcXqqDjOQsxujfcZ9Q/gpT0
         5/uhRQUE5t6tM6APCQBH2FD7LaOyfn3I4d2PKytTXOY43ZqMVIaGuEA9uqZOyZ7gdCak
         joCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=x9sO3/CY9VOIXkpyRGvn3O24mVqzex7XRK8SHA+k3AU=;
        b=5fMJahv7yQQvImAgmv0C2yKF7+JFf8HYx5brtccWqRdBD1/tOGxv5LSVYf/clx+t1N
         RJNYaiICUnPtAjRmlVgtlK4iszyEuadVgVQCQwyRfPz6zmFJw111fToQoUbbA6bRNLO2
         yB9vvpEyUUXqBw8EUr6KqBLMG9AmXrdSYs/mjkVPGATWiifzdDZM4C6xjDNBhE6cJEtQ
         OW3qVINXKejswgqPxUMBluBbYjsJWy4YnsvgIuO/OEQfqJoSnBxr1Db9jicfeqVpmZ7b
         V6Gw8hTt172PNlgMSKozCUuju7qNYtUOlJ7+QwOuNfA4ohYqbJoqVvHR8s+P7USaU+5I
         gmTA==
X-Gm-Message-State: ACrzQf2SCNg2330XQpVDUDN+OH+S4uqAyFa1bXWtnmVYToOqLMpb+eYM
        uAmDhvzfhsBF5ZPjTcoEOkjLWGStnEE=
X-Google-Smtp-Source: AMsMyM5dyeKehSKnh7dCl9z3zcI1R/SK8d+PZssCMQLZboCAlsUplXKrbG0Nps+g89VDk8gX4TXjyg==
X-Received: by 2002:a17:90b:1e0f:b0:203:2308:2ae6 with SMTP id pg15-20020a17090b1e0f00b0020323082ae6mr8087502pjb.187.1664335676899;
        Tue, 27 Sep 2022 20:27:56 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:b354:2fc2:b868:bbb7])
        by smtp.gmail.com with ESMTPSA id w16-20020a63d750000000b00439dfe09770sm2311761pgi.12.2022.09.27.20.27.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 20:27:56 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] doc: test patch - DO NOT MERGE
Date:   Tue, 27 Sep 2022 20:27:55 -0700
Message-Id: <20220928032755.201516-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 3dc226ff1..6f6d8a417 100644
--- a/README
+++ b/README
@@ -5,6 +5,8 @@ Copyright (C) 2000-2001  Qualcomm Incorporated
 Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
 Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
 
+IGNORE THIS PATCH
+
 
 Compilation and installation
 ============================
-- 
2.34.1

