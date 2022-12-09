Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 04:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLIEzJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLIEzA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 23:55:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3AB94181
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 20:54:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so3776447pjo.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 20:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=O4L+SV+rNlZQcTg60ErV5UvcvyLBOpmld0Dxu9aMvu52ynQ6a4am+N1gYs5MZP/YBy
         IDHeebxn47jI68l9OZ3F+6oY88ofzNHSfdagEXkjJG2a3XgoGxg/7ZP/FVbtbGNWKzON
         EpeDFGJYWF0+uFKS2GPNZNxRWxvOzGwPl5wP6fIcCcoRNyplL+cRM+Pvf5GPBlC9/7AO
         a1GszcKjDGR9ZWtpPvuRUucw9N+c+itdv3MDIHosO/o7hA9YJy+BU8+cXYkI9EPUHGn3
         Ru+liBEbrnDWd0GHmtVLb9sm3sMaG5avlTueGkt77Q2IdFInf1XKIRAruml6wE/yahyO
         JR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=0qvIMrdu8fEB5OrjWCZc1sBsEgZ/Z/3HnMuIErkLLzzysysLOCpCqalmtgPCcVHRpm
         2BuXdWEoKk8guxcsKxatQhldZPWR5wMfBvquPF9qljU7+zKUZJyxJgQ9lQgq3ip551XM
         DublISxkmMdFJjoG29Fbd/RCZbLusdeLiyR3AJ5WNfY0VfuqzwJPmcKEEkZVyxZWYJjr
         U7Cc5MR91tNi2GTNgCUbP4QsF2Z8UQMT5jw3pvJSFMXIyCJ6C6rCnzNF6RPcVLYuA39K
         nUWS7nk2N42dcHI9GlwEYgfKdYDDgBO0YkeG+rcmVGLY4+laEx2nJOJ0vDB47XvHP5ko
         XKpA==
X-Gm-Message-State: ANoB5plHs7ITkepCKzjU33Jo8RI3j0a7HJFDG+lIQHdidVXPpqJC92Ew
        1oNQvNZLYOczl6sRIayTlYSt35JW174=
X-Google-Smtp-Source: AA0mqf6tyKyop5maqDsWMv8izloMHzQCATbty5Y5L5Eu4uZMLOL4nWOiwiZW3Qe0YVa2todvauxvuA==
X-Received: by 2002:a17:90a:8b92:b0:218:12e7:3f8f with SMTP id z18-20020a17090a8b9200b0021812e73f8fmr4400889pjn.9.1670561692500;
        Thu, 08 Dec 2022 20:54:52 -0800 (PST)
Received: from han1-NUC8i7BEH.. ([2601:1c0:6a80:cc40:5d55:98a0:fbd2:cfd7])
        by smtp.gmail.com with ESMTPSA id nk20-20020a17090b195400b00218a7808ec9sm310643pjb.8.2022.12.08.20.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 20:54:52 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v4] Bluetooth: doc: test patch - DO NOT MERGE
Date:   Thu,  8 Dec 2022 20:54:49 -0800
Message-Id: <20221209045449.953699-1-hj.tedd.an@gmail.com>
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
 COPYING | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/COPYING b/COPYING
index a635a38ef940..9960087a95d8 100644
--- a/COPYING
+++ b/COPYING
@@ -18,3 +18,5 @@ In addition, other licenses may also apply. Please see:
 for more details.
 
 All contributions to the Linux Kernel are subject to this COPYING file.
+
+TEST LINE. DO NOT MERGE
-- 
2.34.1

