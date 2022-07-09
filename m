Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4994EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 19:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGITXX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGITXW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 15:23:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE71580A
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 12:23:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i21so1171235qtw.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DcgUCn9Ywit0aAF2rzURmXhjDwDOILjrvQLQXn6Yk0=;
        b=hTqR4ktv/hE3TPlkyd0dLLNLXfc1mmoJipEt29rcVRxWtH4m04cdoBZ9i/cRJQxxr7
         4LG6YA82wwIiC6qfyvYBLLK2KqJMAwfqRgHFgOBaCGTAWLk1hGBmYGTTMJU6bRqevga9
         L1wjAWM4U1sBdTNY7sRmtRTgQn3hY0aMeG1keOXOCVNE/72ZZX1TW/hKrDM5hRdeJkBc
         hFKp1mXMtdT1jMSD2bpz3OzEKEqsMkZj0KXNfdNLrxvBWMigSn2LV4BZtP48BaYmZHpS
         ah4KckYXNRWNyprux926fTEafwVwW134UrAj2fxtBTS8S/9+1XiM6h2DMgP5mrujw45+
         1iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DcgUCn9Ywit0aAF2rzURmXhjDwDOILjrvQLQXn6Yk0=;
        b=GbeHkABjmvnqtqnu9vqc1BphA0Fp2DaAoep2TxNbIHI/u1gtyMH9nxM+JArg60CzRn
         EaP2yCk/0l4GdhuUqy8/RtvEnFpVtAfg46SN/iB5hVUoSPd0e+3GIfLghqvrcnSkWuOA
         4MgmTyR16pSoSwLg36zsKlNES3fdqXeG3WjxKR/8SjtD9F4prKgZaq+O42sVH5H2VSWQ
         SW0q5SWRm6C1R3MKa08R0QFPWoBK7hWj1Y/EIELXEnXr6NFTAkQVWLfdBo1zKu4ULXkB
         NxuyzJhBXRzsszb+Qh1fds/iAf1GhYmDFL9r1iqunI7zRZ5zHI1UabF5RjcmOSxuSYfW
         JFKw==
X-Gm-Message-State: AJIora8qzITfU/lcvtgg1hgeMjpDKDNFd06NLfOSJ/4ylJVdPBYkuhqT
        QuqRmIukaxK7uvGmoV5m2wsZSfJ56ITY7Kn7
X-Google-Smtp-Source: AGRyM1uXOC4wUd+4j4VMf0jwDgO5N3ozuB4gNZeCxYtDLDLSFWQPjtK983N02bHnhtAapJy/BK5ZNw==
X-Received: by 2002:a05:622a:1802:b0:31e:af62:5701 with SMTP id t2-20020a05622a180200b0031eaf625701mr2105918qtc.327.1657394600791;
        Sat, 09 Jul 2022 12:23:20 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id w3-20020ac857c3000000b00317c519be8bsm1933554qta.66.2022.07.09.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 12:23:20 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 0/1] [v3] ExcludeAdapter configuration setting for input plugin
Date:   Sat,  9 Jul 2022 15:23:16 -0400
Message-Id: <20220709192317.1704-1-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As a bluez user I have run into cases where the input plugin can be problematic because it binds both HID PSMs on all bluetooth adapters. Simply disabling the plugin is not an ideal solution if you want to, for example, run an application that binds PSMs 17 and 19 on adapterA while using a bluetooth input device on adapterB. This proposed feature would allow users to determine which of their adapters can be engaged by the input plugin. Using the ExcludeAdapters key in input.conf a comma separated list of bdaddrs can be specified that the input plugin will not start a server on.

shwoseph (1):
  ExcludeAdapter configuration setting for input profile

 profiles/input/device.c   | 22 ++++++++++++++++++++++
 profiles/input/device.h   |  4 ++++
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.32.0

