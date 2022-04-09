Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Apr 2022 10:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiDIKEk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Apr 2022 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiDIKEi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Apr 2022 06:04:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197D22C1C6
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 03:02:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g24so14279803lja.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Apr 2022 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hilmer-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2NI5s/Kez96wW+pQ6PCtyv/K39rhndqtpgMQoIhFWY=;
        b=iePKsxU+Q6sXSXveE08KYsh9iYtxVkwbjOIO2lwrOeFvCp68ER5IMDSUJt3eyneWC+
         RmVp2W7/XA+mjpM2tNH+CZ4sBphR6jTEJWdRe9UqnNljt+7YthSahJI84cHYqfnbNPbI
         2DvC9hpqiFJxXuCs+FnLDmpPyAZ1NP0g+ULB9xCWYG6ScPZjsx5eYwYYNt4UlW8am+m7
         mMCs2IhoU0Iirczx0YAPoe4eRahfKda5pBpHe04VGxlgLcZK/FrVBmePEn2CIpHf8zy7
         4FgtjEEFGuJNyRQep5ZGJa87LgbPyApxBMqUbCbVpS1r0Hul5n+GXYzNnPtUJp7Dngwm
         eqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2NI5s/Kez96wW+pQ6PCtyv/K39rhndqtpgMQoIhFWY=;
        b=C1c39htI+TsFvvv72m0AmgO2ie4/Qj3Uecf7mTYb/CsIKWn2P1XKqPmXr7YHLBP+uI
         T0g4/rqlhtZDGp0q7yV9EZk3xTb5e3VidbVRvHDSaphcnyVkL1dWNa10GDemKQuTLh5B
         JuuJ7vDNle7X22P2B5uYhlQdmpvBWtpbK4xaXGdmw2zDqk/FBw9hKvd14Lx2dw0IZn/g
         +vUIgVYRze9c8mXbgkPhHRA1/N5kutwt8xL7/4QmIMBUk9oYXnRjPn2i1A2UFrZ0g6q7
         +dwKPJa17noL4VI8gyq83spdjan3DMoJuzDtkpJsl7BKCbboqfnVXoASB1KRNTz0NnAF
         0/Og==
X-Gm-Message-State: AOAM532xemPC6K1TIeg6mKdqNej11mLsE8ZLynXhR0pGvIOpmrnwhYIT
        sY9hWWWosNTVUq1ByyqWCbOd+3uCpBq+1lsf
X-Google-Smtp-Source: ABdhPJzywx0gylDebZ4bgmxJ/nv8AbEE8UCBmLgRZ+or8CZ8D5mJ1SikKZB7sGf3SWXS8AR6p8B9nQ==
X-Received: by 2002:a05:651c:179c:b0:247:e1b4:92aa with SMTP id bn28-20020a05651c179c00b00247e1b492aamr14643792ljb.55.1649498531065;
        Sat, 09 Apr 2022 03:02:11 -0700 (PDT)
Received: from jakob-nuc.lan ([185.229.152.125])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512319000b0044ae52c6365sm2471759lfe.88.2022.04.09.03.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 03:02:10 -0700 (PDT)
From:   Jakob Hilmer <jakob@hilmer.dk>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakob Hilmer <jakob@hilmer.dk>
Subject: [PATCH BlueZ 0/1] adapter: Fix check of DISCOVERABLE setting
Date:   Sat,  9 Apr 2022 12:01:29 +0200
Message-Id: <20220409100130.9743-1-jakob@hilmer.dk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While debugging problems with BT discoverable with an older version
of BlueZ. I stumbled upon this error - Two places the flag of 
`current_settings` is checked against MGMT_OP_SET_DISCOVERABLE
instead of MGMT_SETTING_DISCOVERABLE.

Jakob hilmer (1):
  adapter: Fix check of DISCOVERABLE setting

 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

