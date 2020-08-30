Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94131C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1322071B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf1Dz954"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgH3HLf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgH3HL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 03:11:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07BC061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 00:11:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w5so2904373wrp.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ehZDFISSLHPOT/cvMww/3eQrFijdzTCQp0NJi7pzv0=;
        b=Zf1Dz954a6HkbYPcqQOnZ1aq8bpxtHGD2j1lYEKVMWd6G6YgQgtMD7scbqh49ewxIn
         ZFDN2wA2mqSNT51mAH2+3/j0K3LQFyF/LTJb/g99D3kwoYwobufVy+iUd9TlplIRlxal
         9HR6Lx0GOEgXtMN1Kg1eNvY4Yo6hPr/EcPio30lA+nDwPuWqdMaCW3LJRW+rjbIdEo5G
         IitdRYZfyBo/gR/EgzoLoH04dNIbYfwJZehVqoJ5pP2PPwODkAGylums33xRhz7tyijh
         92YRkWzpJUUW19f9aOX8ZtlaBlfWYODEkVNooD4NeduE4h9UzzkX1oOVFW+xfAYR4Es2
         +HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ehZDFISSLHPOT/cvMww/3eQrFijdzTCQp0NJi7pzv0=;
        b=H32KVgREna4JdTMNZue/tyZQ139e0Ajg5iRAUAoN87EQWYXUXm8F3jMMA9BPLXSPRU
         StWbyf0asfXL99/w3O8wrkZlg8ZPcF3ZpgRBTsVFFnKkLh++QSoBhrnyGrueYwtot4iV
         JELK7TMv7+q22P2IYOUBc++fryzYuVlArtrk9d4T8bqd48z1tFCaUD/STD+Qu/YyuMbO
         DAFXS0MXCZa7ZXdTSBtCX6+y9jZ+FD9wQhNZ1T0roINET/S3SKRMVLkDBMmcVjcpryqk
         kXRfTTjgBZGlNNH+GRD9iCcJSr0WWRo77VujzoInIgKP7OF5fWm3GVhJd1Snd4LUB3KE
         Z7kw==
X-Gm-Message-State: AOAM530rAQApK+W9nuKTw+xdfuKNEUQ9pLA4NgxHgegBXaMn9UlPb65E
        chXStp1yJpC88e0OXmt2lSR9868daEk=
X-Google-Smtp-Source: ABdhPJzUT+MKgSR9ysGC0LecFZo1aT7NXO+YZEcYZ20Ga0IRDpvG6eELIPkUehm0g3WTuigqgWvtAw==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr4270631wrm.210.1598771481256;
        Sun, 30 Aug 2020 00:11:21 -0700 (PDT)
Received: from thinkabit1.lan (21.81.7.51.dyn.plus.net. [51.7.81.21])
        by smtp.gmail.com with ESMTPSA id h185sm5197859wme.25.2020.08.30.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 00:11:20 -0700 (PDT)
From:   Barry Byford <31baz66@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Barry Byford <31baz66@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix small typo in bluetoothctl
Date:   Sun, 30 Aug 2020 08:11:07 +0100
Message-Id: <20200830071108.19777-1-31baz66@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changing apperance to be appearance

Barry Byford (1):
  Fix typo in bluetoothctl

 client/advertising.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

