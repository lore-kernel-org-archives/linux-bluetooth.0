Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30683C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJFQWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFQWL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 12:22:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CAEB0B3F
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 09:22:10 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1326637be6eso2719657fac.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Oct 2022 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwquJrFmP8v69zmi0EOTqyoG/84qtHa+65O7hUgzNA8=;
        b=SZCliZDnnsIW6rRCmbIpLk5qBrwl5x6tfXPZ+s7ntVXJbP1/W2u6HqLZ391cmwPvhh
         qiQvSBI+sYrJIM+KU588LYwurVpMClfgVUusqhdKaZubo6ory4K0Zm61hxwtzRaHwM7B
         gPr6ZIKmvL45+MzgMoZyampR1929O6VS5jAu/+w/5Y+WSIOvENnSP/yqSQ2jy3nBS9Tc
         OUSse1WlrH5b8LnlWZu7XDk5WjAGvzuCtnohV9f9o+/H66skmMqGvx286UMxN/OvXAS8
         aMMmr8GA9lWc2wDWtfxXWK8NloHi9/oIBHfQ60WkV10h9hpFqBo0cHR2ktovWkgANU8A
         +nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwquJrFmP8v69zmi0EOTqyoG/84qtHa+65O7hUgzNA8=;
        b=m5kcPL3JCnaP+UQNUBMfG1PlGWJhbOiDJsBSuRV2cVZu2tNSe3tVU1VSShBb4rM4qL
         KkjCa/g80qopHlwxa5h1XSIY6h1GGIfLrVik4+o3RxaUqfjNK6gw3dRGQ+Egof5CIs6t
         iCT+K6ul1MrBqfd2rHbF5w2G/yUgZswTZPU+WkDueCTokO1WQ+VmczsNarJ6v7+P9Gpz
         CHXMEkeoqHRegUg7Ajo6eMVS0q4pEXwgOLwkqZ6mzSQ1q03eJlldYfwW/zOIaX65d+VT
         1Ly3sWjJFUBWwjqx7hbBOj/a9XKdhYK+hy/kOkgB3vkIizmoszIZdO9hNAsxX1D72NNm
         hD5A==
X-Gm-Message-State: ACrzQf0BW/PiQxeYbQZ9GYdSx60s/tePRZYzZ1qs0OHL7cb08Hm1kVBZ
        nICVh1bF3dKifrbDu6jAOQEcji0edZ8=
X-Google-Smtp-Source: AMsMyM7SL2wqG5tEETAL4GRNiphGkHhs4e1KtunV3DjR0IxkMYMwtsJT5TaYnSKkRszpAUwu1hT6Ig==
X-Received: by 2002:a05:6870:e248:b0:12d:27b0:db9e with SMTP id d8-20020a056870e24800b0012d27b0db9emr280529oac.28.1665073329483;
        Thu, 06 Oct 2022 09:22:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.5.129])
        by smtp.gmail.com with ESMTPSA id m18-20020a056870889200b0012d939eb0bfsm6742921oam.34.2022.10.06.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:22:09 -0700 (PDT)
Message-ID: <633f00b1.050a0220.96b53.62bc@mx.google.com>
Date:   Thu, 06 Oct 2022 09:22:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1248933080820003736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: Mesh: Fixes for PTS issues
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221006145927.32731-2-isak.westin@loytec.com>
References: <20221006145927.32731-2-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1248933080820003736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683513

---Test result---

Test Summary:
CheckPatch                    PASS      6.47 seconds
GitLint                       PASS      4.32 seconds
Prep - Setup ELL              PASS      27.73 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.76 seconds
Build - Make                  PASS      867.47 seconds
Make Check                    PASS      11.56 seconds
Make Check w/Valgrind         PASS      295.55 seconds
Make Distcheck                PASS      242.61 seconds
Build w/ext ELL - Configure   PASS      8.79 seconds
Build w/ext ELL - Make        PASS      85.61 seconds
Incremental Build w/ patches  PASS      602.70 seconds
Scan Build                    PASS      518.24 seconds



---
Regards,
Linux Bluetooth


--===============1248933080820003736==--
