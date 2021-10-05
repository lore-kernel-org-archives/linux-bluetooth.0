Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3732C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 01:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEC761406
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 01:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJEBU4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 21:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJEBUw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 21:20:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCDC061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 18:19:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1143067pji.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AakUyIouEa2A19NyFf2YgLxre/KvVpfpai7uIXPumLU=;
        b=OBCz9LlsPoW1UXurmbtyuRvzBau/Km/PvPZXWTWXyDmP7itc6nhhuOYwTUAPAmeB6F
         Ofb/+D3ePuumLuP1M2gLM7Ju4VrZXVEZHKh37+8Z5N/pd+RrMy6F0mLbaz1NYbrwvIz2
         KSSIEz6UelXfL6LsgKYsb/oR4szkYdTmU0/h/eziE5RfBksqwhnu9ou1XZybLk2oA8tv
         MozmEW6KHRzt+iGvIbZpZ+KJfqvTZbgBcK2yv674aS0UpEQb/NK0EgoVyh8IgTThzt9M
         5dxhkomZQsufV05G4olcPXhPzRkTrkV99eXCokqEShmZMKWj0OO98cJFA7+vZGMvKEx2
         j9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AakUyIouEa2A19NyFf2YgLxre/KvVpfpai7uIXPumLU=;
        b=pgsI+GFmjLZgmcdAtkRK36hM2q9eWeCDlTWwecvwnR73j4Wxw8fmmOvaxmguozkDib
         Goj7MNYFEUrr1DzbZ+GmwWB9T2ifw/rJmKqX8QE8yUU6VFevAhbxtLmNVwmzjuwg2e8E
         VyM3I0YHA2t7tAZHdjrXq4f1n3YX/LiWGOgT+kaoxJ/M3PPP4V9GmUN9hjWBJjHPib8f
         g+WRSIc5KWxT0Vr+svDAcuCgtUdimr+IiRWOIjScN3UeQnBp5uLkymmBFcke3Y7ujwsR
         Xr9dl33/qKk/biwQd3EGKRHfC6bhdGQJGJRcA07m15n8t+LqJw0zhHX74wdOhwJSxwWc
         DAWw==
X-Gm-Message-State: AOAM53072OtJAIWNYfIV0S5ikxPOY+FiTvES6UCc2EcjsxAsVnlLz18A
        5/oIe5IUIPxunQkBR04UYtrPcegOuR0=
X-Google-Smtp-Source: ABdhPJwMKkbbmzGtmF0pWSQYWIdniNVU085XiJjqHo8QL0ayHI67wM5v4sjXj516NODROmFJ6BuBcA==
X-Received: by 2002:a17:90b:4a45:: with SMTP id lb5mr391528pjb.94.1633396742584;
        Mon, 04 Oct 2021 18:19:02 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::d9e])
        by smtp.gmail.com with ESMTPSA id f20sm9402141pga.12.2021.10.04.18.19.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 18:19:02 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [DNM BlueZ PATCH v3] Build: Test patch - Do Not Merge
Date:   Mon,  4 Oct 2021 18:19:01 -0700
Message-Id: <20211005011901.402910-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Do Not Merge this path.
This is a test patch to trigger the CI test.
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 3dc226ff1..1d3eb20eb 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+
+
 BlueZ - Bluetooth protocol stack for Linux
 ******************************************
 
-- 
2.25.1

