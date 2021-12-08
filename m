Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04615C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhLHA6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLHA6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE998C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so3017687pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdaJi/n7cNsW/h+LgznMVT64T9BVpA7i0YhuQ61DUQY=;
        b=SQAvr2ANQO52+k0BuoFrin+5dKnadvpgY33NFXRCKchN3rI/Oh+mLxizYIYr0iT0lV
         hrK36ELjopAaFHCH3Du/YVDqWRhCQ59Kj8GgELa1J0rT/oNjTmkOvBij18N92I0aOqk7
         n8MkuDrDixPR/h6bPHlwKFmrv1I8zKvOTCbkyEd872fvkEFrMvJ7XLI0869d7+9CV8G6
         h1/dfUqdQf8elCN6+0Fps0AN7GbNHGQhUrxU01RZEMo3Vq4flbtLWAJYJrKmW7ndrBoE
         Kw3avp01/4EyxhTkhyyzUPiVszK5/qvQ0gqFw2XP5UI2uaGChfdBvkEHD2CXYArrcwVA
         svdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdaJi/n7cNsW/h+LgznMVT64T9BVpA7i0YhuQ61DUQY=;
        b=CrWsPIq5OTg8FF7JcxMGDB0YLo8x67uuj6MW8Lq8r/szn8UFtYKC9VIThPYxVrk5Qt
         F54vzUVu0WRs5wV8AhNXcPBtuuKeWn2zl7orI1/Wkbu7vyEzU8l9vorn9Jk7LO2qS7ge
         gEBjbQ7KexsO55KjaEIp3YBDlSblfxmtK86pEeq54azBlO1qpw3n/zSo5oJc/KbofADb
         qVgBG9Y5JaTFBrdmv6EsHW+Aak+4fdQzVGeBg3fqa7mOQ1ksPTpdHVQaSRcgDTF9blES
         9q3bBXvSxRGWcxG70XVpbBTAoI6ZufylRyUm3DQWNsZ86Z9N/cjMPa4UPI1Ipbg7NgHe
         n7cg==
X-Gm-Message-State: AOAM533+W8t1Z+0PfjFk5KM2xoOi+Q3XXbYLZ7J9aasdLlYW5BnZujnH
        7aWHmtDQTmQfCDgI0jtM0cuTn/Es+Js=
X-Google-Smtp-Source: ABdhPJz9pQxA+6MgeeCits/WIx8UvPVVZPkWFwZbGypuJpHKYQ1+72G2PnQWRBIvNLCNL9l0aVdaFw==
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id c17-20020a170902d49100b00142892d0a89mr54305625plg.20.1638924892114;
        Tue, 07 Dec 2021 16:54:52 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:51 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ PATCH 0/5] Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:41 -0800
Message-Id: <20211208005446.196637-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This series of patch replaces the standard random number generation
function, rand() to the l_getrandom() from the ELL, which is based on
getrandom() system call.

The Coverity scan reported (CWE-676):
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break.

This patches replaces the rand() to l_getrandom() from ELL. It is based
on the getrandom() syscall, which provides more secure random number
than the standard rand().

Tedd Ho-Jeong An (5):
  emulator: Replace random number generation function
  peripheral: Replace random number generation function
  tools/btgatt-server: Replace random number generation function
  plugins: Replace random number generation function
  profiles/health: Replace random number generation function

 Makefile.plugins      |  2 ++
 Makefile.tools        | 10 ++++++----
 emulator/le.c         |  4 ++--
 emulator/phy.c        |  6 ++++--
 peripheral/main.c     |  8 +++-----
 plugins/autopair.c    |  3 ++-
 profiles/health/hdp.c |  8 ++++----
 tools/btgatt-server.c |  3 ++-
 8 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.25.1

