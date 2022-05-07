Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387121AbiEGUUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 16:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiEGUUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 16:20:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AE1EC70
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 13:16:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id kk28so7807218qvb.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 May 2022 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=je1H1q257IFevwsX8vx31ojtGApWyvR+JhEq8Ja9V8g=;
        b=WqZcAKFvwZO89LZdSOeW+cjk0K4dLXoK6LFJnDNpzt/BUT59LjvWsNqgoFf4nD/qm4
         Y3NnuXYEXbqe7rdijd0frQBeoe9GuRppgKYNVDSe4fWG1SxLhVCvcNG+q6NamPuKojFp
         MvQPKcq1Oa0SatjJoKUCkT+5iajE9xcb5mBByOtwTrEh88fg+9Y5jwN0jjOm8pat8y6z
         6fU5ZXvYo2gO5OY1bjrg1TLeGlRW0x/uGjRnB8MlSdMYNXmjAzwikyvEDdDsyLKXwevd
         G8sakJ8XWTH1B86hANf+uZKxUXRyp4K5TWK5ovOC29ZFraqB9jHI6lmsqK4hwLxXgkmf
         J6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=je1H1q257IFevwsX8vx31ojtGApWyvR+JhEq8Ja9V8g=;
        b=6nI7WsmjWKZrKJEvogRfL/Pow4RKGA+WP/RauFv9q+Mxb7cjfXIGBzTp5iR1Lhpv9Q
         fRjSNyRaNYA4RzMfCXzYfVRaDE1wvuyqEIg0fmIoLOLfjuInvBzB4Wlz62XdzcOxp+fK
         nLOdBOPUUtVgRtz5ca4XHBe8rGcvoupq7q+FOamjhCWldS2Oe6k7A6zSzyhNVCZJg3M7
         AWqC1iDASTtLhL41dZ21i7zvVuOlaBCHHT0k3A2gGOWlvUizoXcQpX0q5y2/Ty8G/lAE
         biN+DMFoJ2b3KwJe21uABbDRYvdEqrow+LRcjR5vfmgxZVEUYpmqL369mh2ba7CB9g7F
         2Y8A==
X-Gm-Message-State: AOAM530KRq+EjN4RlgirlD/wOvZtLW3ZEcAr21itAYaeaSUVatk2YbHQ
        g5RiVQ9wblQUKAhw+x/UUo1NPVpUb6vPwA==
X-Google-Smtp-Source: ABdhPJwsHxApxUyW6ujGatJsPqLgy5Iw0P/MkjWr73NR9elZlyoIzh9qsF/autAm3UWSzjMqmlV8YA==
X-Received: by 2002:a05:6214:2349:b0:444:2a7b:cd5c with SMTP id hu9-20020a056214234900b004442a7bcd5cmr7984108qvb.77.1651954602873;
        Sat, 07 May 2022 13:16:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.46.184])
        by smtp.gmail.com with ESMTPSA id z188-20020a3765c5000000b0069fc13ce1fesm4522131qkb.47.2022.05.07.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:16:42 -0700 (PDT)
Message-ID: <6276d3aa.1c69fb81.34ab.7f1b@mx.google.com>
Date:   Sat, 07 May 2022 13:16:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8938204150643337259=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: Fix few more bugs found by SVACE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220507173505.31249-2-i.kamaletdinov@omp.ru>
References: <20220507173505.31249-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8938204150643337259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639429

---Test result---

Test Summary:
CheckPatch                    PASS      5.75 seconds
GitLint                       PASS      4.05 seconds
Prep - Setup ELL              PASS      45.04 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.92 seconds
Build - Make                  PASS      1359.48 seconds
Make Check                    PASS      11.38 seconds
Make Check w/Valgrind         PASS      460.06 seconds
Make Distcheck                PASS      246.02 seconds
Build w/ext ELL - Configure   PASS      8.85 seconds
Build w/ext ELL - Make        PASS      1354.51 seconds
Incremental Build with patchesPASS      5536.54 seconds



---
Regards,
Linux Bluetooth


--===============8938204150643337259==--
