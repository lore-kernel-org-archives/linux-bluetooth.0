Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACBC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 00:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiI1AOa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 20:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI1AO3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 20:14:29 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AFAE7222
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 17:14:28 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so7290597oto.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 17:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=dqkng8C1EzOil1E9BfbyalZ7zOJjeQoA5Ogqa87llIY=;
        b=Z+HErfgnuQW3e4k5FuWNOFcPP7PWJAdushvXzPAsfEfrWo5O3aa0uTZO0SCBSeIqtX
         /7nochsx/KFSAgJjGsQAoW0nsqSxgS4wXlUoRmA6piEzoGWT+C+eAjzdSxhpCaXKYRBT
         oCPV/4IC2AEpFzL/xws6pCC3QQWJy5LGsjyX04PwjG2gqz7AaZcxQoJKSRQOrCi0QgAC
         LFHfXG0dg9BO1A6CojgIy2/FNZ4rxl4QVSN/Ocjle0E5NZJGJNyFvd9UCZndrdouWPnU
         O71sjVTKV0mrFKurOpVI92BmbKdL+JECjPXXqMkpfMscpVlFfTRX+2IjmASq1vTgOePy
         2R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dqkng8C1EzOil1E9BfbyalZ7zOJjeQoA5Ogqa87llIY=;
        b=a+Dh+UzsHAURTOreqwOOdxsJE3DFTj3F4bssATvL2K/w8e9+VDcjTrJZ+gf0MkSHIA
         yP9xUDHanKGFxEv2P5UahGkssagMQfhe+/ypc1psFq+oHSv1AqRaG9YC5tNJgHrHOn/F
         p4gfG44KuOZBTUQVd5Z4cI0Igb58/uAhK8bBTLAXPgP0XyE7Q0ZtxZdcsQRPVHPYr0zQ
         yolxkxre0is601+Ew/CNMr6xntsQxLUxmVNQS6mcd6t+wB9ESK52Uy2Rgnr7YKmQQEBk
         uG1QfVdhud/0GM88my1dLsYuUHJ50gg/E5XrURZwzmikARi0UPh6wFiLxU7KJDGG8tI3
         7FgA==
X-Gm-Message-State: ACrzQf2bOz744lSSQAp5KmRYdi8p655ePWoSR5G+jJyB2dwF3alL52oN
        kA+1ACRrHhz/hpKNP13sr+hLiZkHP7I=
X-Google-Smtp-Source: AMsMyM6FMHoj6a9+L6+UnLR/m7TP8u7e7HIgrNeJ82TA99A6I2NURvFK4Iqd72h98etcDTCGeIzNxw==
X-Received: by 2002:a05:6830:31bb:b0:654:d29:32d5 with SMTP id q27-20020a05683031bb00b006540d2932d5mr13433994ots.130.1664324067748;
        Tue, 27 Sep 2022 17:14:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.70.195])
        by smtp.gmail.com with ESMTPSA id l9-20020a056871068900b0013191b00f72sm1242503oao.17.2022.09.27.17.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:14:27 -0700 (PDT)
Message-ID: <633391e3.050a0220.db980.5ded@mx.google.com>
Date:   Tue, 27 Sep 2022 17:14:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2881990754829530441=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] tools: Fix mesh-tester to expect end of ADV
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220927225514.278400-1-brian.gix@intel.com>
References: <20220927225514.278400-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2881990754829530441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681242

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.75 seconds
Prep - Setup ELL              PASS      27.19 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.47 seconds
Build - Make                  PASS      951.52 seconds
Make Check                    PASS      12.09 seconds
Make Check w/Valgrind         PASS      292.27 seconds
Make Distcheck                PASS      239.91 seconds
Build w/ext ELL - Configure   PASS      8.58 seconds
Build w/ext ELL - Make        PASS      84.60 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      503.88 seconds



---
Regards,
Linux Bluetooth


--===============2881990754829530441==--
