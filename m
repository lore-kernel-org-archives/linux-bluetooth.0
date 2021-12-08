Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8313CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhLHWnA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhLHWm7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:42:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226FC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso3349855pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHtvqOlxjrSQAoonBtovgk82HhNZYON71VU2buQr9lE=;
        b=ZHDFq75sGwYaiStVC6ilQ7i7LEnif/q5TCdGMIO7cWWmXUyMlyGPRCcNY/1iwWpFwJ
         4AeWMebaZaKWtw2lDeAA9Wu1bW76cMgYiJHZbtzyRmXWQFGf+VRK+EVveKLuYNdcTgaa
         bz5OtdJji86lRUmAGAvNl2QcejGILsmGtxkhwtDCnhUcXXvtou+WSX5b81z0g1sJprwF
         cNY9sm0raCrd1eaQz9iJp5mN8eA/MbL2UsB/XXLQq9/QpyU/tg+NG70m65Bvvy44zfLE
         TNyooePJn+NKCbpJxvaVW1nDlzMiLEB2LjDna0EKmSGypDJ3bh7Esgn0NEaob8UZTDDQ
         5ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHtvqOlxjrSQAoonBtovgk82HhNZYON71VU2buQr9lE=;
        b=nMb4LN6j62/JJBZ0ebSipTNekgwlcSgxsOlL5WVKs0TMoYbUABgapXm4ciDCx4mJLp
         sMyv9HGzcuMLOxon31fapvfCdLB1lDrq3354UXc1p+hGcK7is2evW3ebVS98i+HXiN+z
         mI1zOgQssLySRPT6Cb+c6KVmIzxqHyMF1KJZRPJC5eAXysYD++FxAXou8/pF79JFZ1TV
         CzaHDY3m9nqXNwdvwRFOaVvL1ovwu5NVFxD4yuEEdQqvgGnVPQEusgYBN/a2NGjtTJTm
         p1BhhOTvZNBCk/eaGjax3jZqFpZ+4+hWnXbFVcdD8Fn0JEd4vnQ+OFosytaD3uPKFuRV
         oXxw==
X-Gm-Message-State: AOAM531TQFphxOkn57lx0eqBdVouaLAxfbunZP22K5DGox0CUUpO9HrM
        ObqVpjBdpuGCm1FkkYDW3Klj3BRzvpc=
X-Google-Smtp-Source: ABdhPJw3neE9QAV8cVsU401t6aPOjk2/2UMY5jpSmf6jMYzpfDdTKy8rd+bN/RTTIEnQgqB90ts4rQ==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr10932375pjb.43.1639003166628;
        Wed, 08 Dec 2021 14:39:26 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:25 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ V2 PATCH 0/5] Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:18 -0800
Message-Id: <20211208223923.519664-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The Coverity scan reported (CWE-676):
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break.

This series of patch replaces the standard random number generation
function, rand(), to getrandom() syscall, which provides more secure
random number than the standard rand() function.

Tedd Ho-Jeong An (5):
  emulator: Replace random number generation function
  peripheral: Replace random number generation function
  tools/btgatt-server: Replace random number generation function
  plugins: Replace random number generation function
  profiles/health: Replace random number generation function

 emulator/le.c          | 11 +++++++++--
 emulator/phy.c         | 10 ++++++++--
 peripheral/main.c      | 11 ++++++-----
 plugins/autopair.c     |  8 +++++++-
 profiles/health/hdp.c  | 11 +++++++----
 profiles/health/mcap.c | 17 +++++++++++++++--
 tools/btgatt-server.c  |  7 ++++++-
 7 files changed, 58 insertions(+), 17 deletions(-)

-- 
2.25.1

