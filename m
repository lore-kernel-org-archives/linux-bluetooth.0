Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A11C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAZQzi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAZQzh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 11:55:37 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F47A86;
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so1065059otp.1;
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKnZbnx9fdPjMf6YVn66fFrnk+ilXjlXGrdoyOZ5ghI=;
        b=Y8Bsq+EGpG/MvrR+QboXH30/8y4bsVpbd2RAI+9/5qDEwCNppPB16JhEUehG3Ffg64
         UaToPMvVmGoMo7s7BrpQt/dKylYjIAUePmbGG37EoxygcXnKCx+dl9tnAkIDTTTiG77N
         xLLLMe1GwONS48xCSfAVC+BqTw+k8xIQOX4v9MRJGz4VYkWxwLrJFX0N7HlahbYtseVe
         zoJDSQoXFTdMuFGumFsgFNQDH/IGIogW5rlCrKQTgw7o4avG4+rlV5KOGODuzrhgBgPM
         eqlTPUfZFEUyoA3LB7F3GOBgCVaCj/Y3z/le3kmfI9fAjDjHi2+NvfkkTCWUlxS9Rr6F
         bHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKnZbnx9fdPjMf6YVn66fFrnk+ilXjlXGrdoyOZ5ghI=;
        b=sczb0bDuJKvCDffbtL6JA/2VSVFbZv6mgpjguesy9W3ISuIGAoFFCOTxHxjuyrzPSH
         bOuv2tGtybWizwsOT+ZQDN0T1fdFwJ2z9dFgp9Gj762rug7XND3zCeUNNeQFPEfa97kU
         P1aR9HzdpVmSSU7bJCIptJf0l4OJzfz0EGLRHjolhXnMnf388UP25idYWi3y3lmxGTcT
         +VvjOKWit9oRVe1TCtYUo279fYGXclhlQ95mzdT0MJYEUMGNo3WGO/Lgu2eV4ENTqm78
         pb0WtcGomPmkhWOcm9G3R/YWURJucRfTEzNME1qKWrMyLy+xIUfnlSOkE/RIzaq0WkV0
         LJsA==
X-Gm-Message-State: AO0yUKXD38jSPXwbgOa+3X6tOqrmlwvapBjNupGcm32z510gxVpLB03m
        iwWjqvwd82RhqP6JmSbl+AgGFtXFVpU=
X-Google-Smtp-Source: AK7set8JTcIdnd8h7LzZeQjS68jtmvisOZWL7bZBznNOxZN4rJu2/MxbXIc+5sfFOZqW42FxAbH7Ew==
X-Received: by 2002:a05:6830:6583:b0:686:e39b:787e with SMTP id cn3-20020a056830658300b00686e39b787emr1626427otb.28.1674752135096;
        Thu, 26 Jan 2023 08:55:35 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id r10-20020a056830120a00b0066eab2ec808sm694798otp.1.2023.01.26.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:55:34 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devicetree@vger.kernel.org, alistair@alistair23.me,
        anarsoul@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH RFC 0/2] Bluetooth: Add support for RTL8821CS
Date:   Thu, 26 Jan 2023 10:55:27 -0600
Message-Id: <20230126165529.1452252-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

This patch series is to add support for the RTL8821CS Bluetooth
controller found on the RTL8821CS WiFi/Bluetooth combo chip.

This has been tested with firmware version 0xaa9a4e68. I am submitting
as an RFC to hopefully get guidance from Realtek on submission of this
firmware (or a later version) to the linux-firmware repository.

Chris Morgan (2):
  dt-bindings: net: realtek-bluetooth: Add RTL8821CS
  Bluetooth: hci_h5: btrtl: Add support for RTL8821CS

 .../devicetree/bindings/net/realtek-bluetooth.yaml        | 1 +
 drivers/bluetooth/btrtl.c                                 | 8 ++++++++
 drivers/bluetooth/hci_h5.c                                | 2 ++
 3 files changed, 11 insertions(+)

-- 
2.34.1

