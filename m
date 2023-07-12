Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5EDEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 14:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjGLOda (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGLOd3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 10:33:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F62127
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 07:33:28 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-783544a1c90so331280539f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689172408; x=1691764408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jtOrOC160fxJCasbx6rKikpCiBhuTU3ILbmH8p/FMmc=;
        b=XamEgsl09WCbLGWqmy00KxaqkrVF6GWww5HijS3jAH1dogZTKz6U/iRvqP1hL5f/7z
         bmgdmEkJobcQM6U/0ouzxm8PF1W2xjil6/dSWFAZ82H4inHZ3gH75x6V/khVZ8ywshD+
         MTHgT1y7ZZ3JakS42hT4YtwvtDe8EtBNlXoavExLlp9kVmDxgeDFycbXLRUFQE/d9mRe
         apFZbFhW2kFhTDgAdkJHQY93fO6o7U71d0EydPvxmnQrsrhhXVYYwD6TMzoGbxtBg/lE
         /sErXpyD4xQm5toCd6M68WO3zuoogdYYtIZ5nbptqRZl0J8Bz3mvdG1M0w/ZHocYVEdN
         ghPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172408; x=1691764408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtOrOC160fxJCasbx6rKikpCiBhuTU3ILbmH8p/FMmc=;
        b=MsmohFe9uaE6Jk36afCfBGRD3xFYj9x/d8WjRgxm+/XVzk6Q1IzkwV0qrLw46Wfvn5
         LNdfEPl0PUCo/NB5M61V3SU2Xqaxh+3IOPOn4Ka8Qt0gSBQF8jdYjyHGovGa2E6R8Yrd
         OVxfYDwn5qHujU4d7opzHfDx+U7VmgUQmuf+jyLrGwg9bYu9kKlZ+Vi8EUpYzNBBnjQJ
         7PZIp7QtnebqbxUYIqD+bUQN6ZF6Wb4+BQTA+kSpyUE0qri/eaJuJ27Ltz80b4oAmqcE
         EN/S8G43uq5pqeffmUL4fq52vZ+uURCVXxQNzfjG/AFNsU8tVNLSpOWlqFGIvca6PKMu
         fGEQ==
X-Gm-Message-State: ABy/qLagMok/KdIkOlwRxmVoGS+tu2L/KeJAAkHzuxBLsdB2sVsqkIqB
        YWfwO9NLjfzNnlPuQmZvRvFRPypt7as=
X-Google-Smtp-Source: APBJJlFugz9mdIWQkhytTOB8tZQJidkzTflzP1mjs5H4xKUElq+xTdU7Iz23TarbUuW6zrpZGkDUlg==
X-Received: by 2002:a6b:e205:0:b0:786:ff72:8da8 with SMTP id z5-20020a6be205000000b00786ff728da8mr10076842ioc.17.1689172407950;
        Wed, 12 Jul 2023 07:33:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.5.18])
        by smtp.gmail.com with ESMTPSA id b9-20020a056602218900b007835686237asm1366146iob.27.2023.07.12.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:33:27 -0700 (PDT)
Message-ID: <64aeb9b7.050a0220.1ede1.1f7d@mx.google.com>
Date:   Wed, 12 Jul 2023 07:33:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7076232876498221488=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230712122135.7734-2-claudia.rosu@nxp.com>
References: <20230712122135.7734-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7076232876498221488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764846

---Test result---

Test Summary:
CheckPatch                    PASS      3.77 seconds
GitLint                       PASS      1.88 seconds
BuildEll                      PASS      28.22 seconds
BluezMake                     PASS      902.70 seconds
MakeCheck                     PASS      12.66 seconds
MakeDistcheck                 PASS      159.29 seconds
CheckValgrind                 PASS      261.24 seconds
CheckSmatch                   PASS      347.83 seconds
bluezmakeextell               PASS      106.08 seconds
IncrementalBuild              PASS      4450.59 seconds
ScanBuild                     PASS      1077.94 seconds



---
Regards,
Linux Bluetooth


--===============7076232876498221488==--
