Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D607FC19F20
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEBW6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEBW6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 18:58:16 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD733589
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 15:57:45 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-32c83c66b1cso35405455ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683068217; x=1685660217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NkOCkM4QfdvL1aqFpHzcgcKsi2Sh2T4skl+W9h++o2o=;
        b=rU81dYGIo0xx3w//WNePIyriGeDOi/HSu9IjfXPp5VzmIFrXE5GX3iG5L5PeClU2La
         HKEZic/Q7twldOx+xEt2yenOnhQHCFwiszUYRdYUnigAw/UyXY7d3MJZamNIEtw2Z3iI
         PbbpEPB+5k5rVJXh0UqoKiUyuRz/0M4Ho/5GCZUNFNAtnopuA5tx9eQg44lpRKi+aXGE
         2EgXIIaOSefdghHwbH4cfAxwUrbdQYaXma1nsK2jZVcFt8TB/20n9fG6I3GOXK170bgc
         HX4X/Aj5uYghkIUXW7FyBWesr9WYRMAIVbqaTRyQy7d3H25/tQdzTyVwJtKDqRWJ9bOW
         cKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068217; x=1685660217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkOCkM4QfdvL1aqFpHzcgcKsi2Sh2T4skl+W9h++o2o=;
        b=PZzLpoLMgxF+Wm1NAxDti33XrAQM1PB+RQkUqhNn3+wuC+QiH6Ia7dCoBdCvWK3jnc
         T9Miih0g/tJx/ceNATtbguvemS6GPwzQDaUOseZyrUbGXUY80xuRttwT/TvCJVMXsLBc
         IODZSdfLI+JeMTrXRsDCNDB3HBt7zZWLYDbSt3IED1wa285DyENSl4PzZmuZl92tEfiz
         waM8nhUW5CyxCcKn65Q3HXL8jwfQB4X9WqRvJELzlnKMSex4Wnt9bsItA9JZThlTOJVy
         XwQ6ZkemLiJEWW5NaurrXF3U0cunipmZKWXrXwuBqra+hVDnWJyL+rcXwgSq7Am7lZQ7
         +0qg==
X-Gm-Message-State: AC+VfDzo928R9rmLINATdbBRy1iwQ+MclnpmZR7LHl1CYrTuHAomvzRD
        D3Zg6y5c9XIFx5Y8fM4nCrSkATiPxss=
X-Google-Smtp-Source: ACHHUZ7V+54RIx1rtgn8Bl5uFdIUPsP/kdmndZ2jAUwCipdhDLwChRak041lDvVA87le65js4UR2oA==
X-Received: by 2002:a92:c68f:0:b0:326:2b56:3cf5 with SMTP id o15-20020a92c68f000000b003262b563cf5mr13509070ilg.22.1683068217160;
        Tue, 02 May 2023 15:56:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.28.135])
        by smtp.gmail.com with ESMTPSA id 3-20020a056e020ca300b003261422fdbcsm8439796ilg.80.2023.05.02.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:56:56 -0700 (PDT)
Message-ID: <64519538.050a0220.eeccd.aa15@mx.google.com>
Date:   Tue, 02 May 2023 15:56:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4141031182457227613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: btusb: Don't suspend when there are connections
In-Reply-To: <20230502221159.1674607-1-luiz.dentz@gmail.com>
References: <20230502221159.1674607-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4141031182457227613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744511

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.02 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      40.95 seconds
CheckSmatch                   PASS      110.81 seconds
BuildKernel32                 PASS      31.59 seconds
TestRunnerSetup               PASS      449.98 seconds
TestRunner_l2cap-tester       PASS      17.48 seconds
TestRunner_iso-tester         PASS      21.46 seconds
TestRunner_bnep-tester        PASS      5.73 seconds
TestRunner_mgmt-tester        PASS      116.60 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      8.39 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        PASS      7.29 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      5.98 seconds
IncrementalBuild              PASS      29.95 seconds



---
Regards,
Linux Bluetooth


--===============4141031182457227613==--
