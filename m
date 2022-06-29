Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D39C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 06:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiF2Gg1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiF2Gg0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 02:36:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F48D2C656
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 23:36:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u124so11282344qkb.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rpeuAMUidyBUO/TxhVRBTadcdEH55S/v/56RywkSBbQ=;
        b=hb7X8BuQ40U9B5W1JzAkjsh9M4GiyMc1cfCbYHZJTHHXSEt6LpO0liyl8dQUevUjuN
         KytX2lo/7VatUWNaiCSwNO4yXoC3R0YM7w/jLvfkfp4kQWE8H4xG+0NEOiYuZmSB10or
         miQTCgt227YKqsh5e5D0n6ouqKfb7g4QskrmW6w4BG2zoyTDJA5GIK9ta9FgKDoLj/3X
         honAxA6jCetU85ci+5C7OSBTnTl0AGoJibueECZhWnk9g8NhGTdquOjNQ81/aKY9iPBH
         vpBv7yR3H7rK8CJEoqEerqfDbiWOUrWNTllxId3t86ehTer3bZcBaAnPoZi2tOSO4MKg
         crTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rpeuAMUidyBUO/TxhVRBTadcdEH55S/v/56RywkSBbQ=;
        b=i1juQRvRymZVjQbM4QXUJ9v5TJ5ctLvrqCnOLIwfEEidqVM+JfXbjlkaJfP7rCyWyK
         FpKFP901rX2k9wnBP9UMXFCh7wT126vwnP+9EGoTb+6LeqChASkaYVAOqr5sevZV2pAk
         tiwNirlm6/56Kz+uIAFgvOqRiwB0IAq+aJ9Oj7iICBV2ZZMRlp+XYJMh2J0kTA1ZAK0e
         eV1P+H5oCzoTQ7SYuPyapZMIvougXxMzmcqrcopp1R4o6i/mCGU0/UdTih4CyGMbDQph
         yetB0yUwT+cPcYpdE4m6+NA9Ijt4gNzti0rJyex0zwtcl3KP3NpL6KjpWwPtJuZfnO4K
         a19g==
X-Gm-Message-State: AJIora821U1gUbeCwz6cYVESnLRCAXPRgSxo/nkTePX+FjJ8h6cyJsSA
        PY5fGChTOvYG5wYciHz3mCey3RePB+A=
X-Google-Smtp-Source: AGRyM1tz91sQxQB0NauFU7QJAOUT0/pkkXtJLKcGSZSJxPtegm9b1J3ik1BKQn9Nvufh173FXypLJw==
X-Received: by 2002:a05:620a:d86:b0:6a7:92ff:cfbc with SMTP id q6-20020a05620a0d8600b006a792ffcfbcmr958245qkl.176.1656484584461;
        Tue, 28 Jun 2022 23:36:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.246.112])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a408b00b006a74458410csm7384949qko.123.2022.06.28.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 23:36:23 -0700 (PDT)
Message-ID: <62bbf2e7.1c69fb81.e8839.0bb1@mx.google.com>
Date:   Tue, 28 Jun 2022 23:36:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8304154333166632648=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629051902.23452-1-wangyouwan@uniontech.com>
References: <20220629051902.23452-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8304154333166632648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=654862

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      44.29 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      1455.08 seconds
Make Check                    PASS      12.42 seconds
Make Check w/Valgrind         PASS      448.35 seconds
Make Distcheck                PASS      243.59 seconds
Build w/ext ELL - Configure   PASS      8.71 seconds
Build w/ext ELL - Make        PASS      1467.38 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8304154333166632648==--
