Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE484C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C7F61075
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhKMCmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 21:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKMCmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 21:42:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B9C061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:39:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h24so8218428pjq.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=RY41Ii+/I8/NLNh0NryqIlGecXdevIXGiU40gf25+kf7zM9EPKDjcSUoO12kgpzyYp
         3agRjvIObE4c3q8QugGC1YugnEmc8UoEB5I96b7bYzbZhE7ITqU+TRCqIUyZ12A+ywC4
         HANFgcmb1sJk0w8tlwBYATb9btkym5rWC5gprcrnXIQjTzPYxjdrarSCOw4j8bWqGiJp
         n64GS6DNitJV3g9QXsGBCure5Opakpfa5KDIc7z/4Pv1TGLDgJDdnyK+KCnk3nF0i1sk
         DksF2vapar24C/mCJiRBy0xtzFKGvqObwikBokvgCUkEoZm8TRsFzW8SLTc7myL7Qm1Z
         6d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Evc8LcD4TtrYEx4kHuvGKjEcl3Q5NYJf75iDzkjNm9w=;
        b=pJ3a2ww1VsYy8N3D42fmlBj2OTv5flg8FEekveIG2qjhScRqTYOeLevSYXlJeDzEHF
         jNtnnoIAgUle/4ZBu6UNABOkqQnsb+veHIX3uUvCMZoQRNen1Xd7B0Lym+Gy9OmIs17y
         axXXNdaI5kbZ6BHx6mrHlvHmNmpSho36unEHzauujm+SZIcRBp8VQmZ3NyyCx+/7TE7X
         eUelDzlP6C9ip16RLvSXgRlx8NNfW15pxSC1SYmYUxT+A+H9wvTCFZq/Rae4RT5SkpAV
         WFV23lVeU11c6D2rwyiN80HRJHBYDfa7OzEobjOtG2Kkx86EsHBPwcf/OWkVm+BUS8nG
         EOSA==
X-Gm-Message-State: AOAM530lLCL8QjAUqbSqVldg22p5tnt/eKo8YGIui9qKF1AyPUicSDZX
        +cePoa/C/l8DmZtzYOtt8qN1uNhWQw4=
X-Google-Smtp-Source: ABdhPJwBkqvVpKvsH9ycwsS6p5N8MwbwMnudAzyYF6hYSLQBvkEaEhR/PaFCtEBoODBwLvFL5eKzwA==
X-Received: by 2002:a17:902:c3cc:b0:141:be17:405e with SMTP id j12-20020a170902c3cc00b00141be17405emr13576838plj.76.1636771191708;
        Fri, 12 Nov 2021 18:39:51 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5c5a:3570:def6:e3d5])
        by smtp.gmail.com with ESMTPSA id w5sm8159742pfu.219.2021.11.12.18.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 18:39:51 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v4] Bluetooth: Build: Test patch - Do Not Merge
Date:   Fri, 12 Nov 2021 18:39:48 -0800
Message-Id: <20211113023948.213873-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Do Not Merge this path.
This is a test patch to trigger the CI test.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..514f2d6a9de9 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+
+
 Linux kernel
 ============
 
-- 
2.25.1

