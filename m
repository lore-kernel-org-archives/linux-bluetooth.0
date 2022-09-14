Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C385C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 18:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiINS5s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiINS5q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 14:57:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79314D809
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 11:57:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f14so25715290lfg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gPfbkeIYaVopJrRsNVDJhc0yLj8eY4j3MAgfbBt+sxE=;
        b=OPLlLZS7KRNbONLlitB5/O7utZowHBbpt5AZ/lAR+kM/ZWUnKNSFQPtQb7pDsq8bIM
         Ji7QnYghtoeb+7B7PGhLfo1llBDas8Xw+wlikbxvSl2TYAGLh9xb0Ry/ZRaD1D3TaNMf
         6KVzJAp6OhLVhR8bnfKLCVPja+vsGgOQ+d4aazFl17+zqR2AZ1dRU9ci3Sllylg8zhf7
         12LW9d/YmBPsX7AizdMr0MrDdv26iTzKwpR4Np8ntJGgnW0WuTNzlwiyqiR7aAk4ATGg
         kdpV1JMd7mRB9RctNDy885oM1xZVq8zVBuq2+14bgaDAxUULu+NX/TaMZDIfaSLmoPmF
         edJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gPfbkeIYaVopJrRsNVDJhc0yLj8eY4j3MAgfbBt+sxE=;
        b=DUQ0PE4jHv+iNhdNJaX7y+qWoFMWTC/UtNpc9pIElc6PKa5TxZS8h3ZXI8uttcUfGd
         /fHcd0wtgXADHde3Pe8Ia4QihuaFtX4rUMNyS5+HyMs85DZoWpeRR18Fg3GegHiyt3fv
         LO2YJLlfbri5uyh7hFOmpHwc1G/Ch6NQOBwyz9L5tVqBQOkcITAeNErTZyrb1uKvsODX
         tTqssuFzyiUBmDgBN91SmPsv0IR5NR4vKKK3W60gX8gBl07wd/YA8CPKIl6eAfch7jvJ
         /9K255ilaYVrm34jb9HkHlIBGsOF/Hr85RNK8vldNijszvYXkF5qgPDH7lIm8EL4gF90
         rFoA==
X-Gm-Message-State: ACrzQf1R5pfUnNsE9eix5pxDEgahZcAjorMfJzc7UvqYDB0r8X/IJGpV
        FJPlCJyOlnAGLDqqUk5iu4r7zAjCATscFHnYiAraGn4HsdHsSg==
X-Google-Smtp-Source: AMsMyM7gjnU3PEOBc+LUo3qrlwLaOUqq3ehximM6YPm9NVHMn5Bg6LSyBnm7eZFDw7BgQJjgOnQFtRzE4PhsgW24RYA=
X-Received: by 2002:a19:6555:0:b0:49e:7d52:a4ca with SMTP id
 c21-20020a196555000000b0049e7d52a4camr377014lfj.198.1663181863391; Wed, 14
 Sep 2022 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220913233157.526041-1-luiz.dentz@gmail.com> <63211c98.a70a0220.fc7d7.e5ba@mx.google.com>
In-Reply-To: <63211c98.a70a0220.fc7d7.e5ba@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Sep 2022 11:57:31 -0700
Message-ID: <CABBYNZ+d3QuemepkKGL8yS4TRyzXh8EcH=K4LkTkKLkfWfR51A@mail.gmail.com>
Subject: Re: Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
To:     linux-bluetooth@vger.kernel.org
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Peter Sutton <peter@foxdogstudios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Sep 13, 2022 at 5:13 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676714
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.92 seconds
> GitLint                       FAIL      0.47 seconds
> SubjectPrefix                 PASS      0.31 seconds
> BuildKernel                   PASS      45.45 seconds
> BuildKernel32                 PASS      40.12 seconds
> Incremental Build with patchesPASS      59.47 seconds
> TestRunner: Setup             PASS      667.48 seconds
> TestRunner: l2cap-tester      PASS      20.48 seconds
> TestRunner: iso-tester        PASS      20.45 seconds
> TestRunner: bnep-tester       PASS      7.74 seconds
> TestRunner: mgmt-tester       PASS      127.19 seconds
> TestRunner: rfcomm-tester     PASS      12.53 seconds
> TestRunner: sco-tester        PASS      11.90 seconds
> TestRunner: smp-tester        PASS      11.79 seconds
> TestRunner: userchan-tester   PASS      8.35 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL - 0.47 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
> 21: B1 Line exceeds max length (101>80): "Link: https://lore.kernel.org/all/CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com/"

Let me know if this fixes the problems you are are having, note that I
did add a test for rfcomm-tester to verify the deadlock is fixed:

https://patchwork.kernel.org/project/bluetooth/patch/20220913233349.526675-1-luiz.dentz@gmail.com/

-- 
Luiz Augusto von Dentz
