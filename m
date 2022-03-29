Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 07:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiC2HGo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiC2HGn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 03:06:43 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6CADE915
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 00:05:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id gi14so13767992qvb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 00:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DX0z3hbdd4gJDgNEnYglfEokD8GYtrLWQSZAWc5qL90=;
        b=fMe/hFQl4JX89gf8sA/fUofsXxhzIMhza4G13ocZf9z5iSyibKCTvMBe3Mu2+u2Mod
         BnYyJ8WioIBq3QvQLOzxo/vp3/cLpP0qZnkdZPeJFS7h1Kjuavnp32OdE7LfuGRjqi05
         amGyxEMvkVUzUfSJb1BSRe8M9x37DgfFPaKe5830Fi/D6alZPl3FGptpEk+eRDhDv4bs
         x2EzzJfl7ApzgeZIi6TkvfOts6LIlt9IP88YWHi+JVyyyHpwLGfAFji512TLVUmwLH0I
         WmFcX//8iLC+yLYY4CkTBMwJvLpuYF4MlZaFIpr6NyH7WDQJb7Du7spPOg8AS+nK6l6/
         K3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DX0z3hbdd4gJDgNEnYglfEokD8GYtrLWQSZAWc5qL90=;
        b=Smiml5pTfRISyfF2QnX7vw8HwrMKJTnhYrawq3XCbuTinYmhT3Fcs0uxRs3i3814PY
         RMN8XCRjeMZTZvaoatWtoHhKTBZc8YUgn6G/apqxvn+AVk186pcCtnafDjptoynB2dk8
         F7V5rEz3ji9kCxKQNuhc0raZrjGzTEMmsbEBtgrwpDJY3h4JwOzeJwhT3b+mUcTJuPcj
         8OptPhdh+kMYbDQN6E8dFsoIrTmxyqXmyycK5eDJ9U9s4RuDHeg69OW7Pk/s7qTXawyv
         1KAifk3fBtULEe3H0uknAQdkXNHtFYK6/OeDIScsqDEe9C5Vlgic7HKIjEFP3UXNKoka
         CDuQ==
X-Gm-Message-State: AOAM532tqDEsYWXLyUHxir441nT8Jzct/CYymonPvTV9lHcNhZkpi/UO
        3CeFYmdTjEww0FF/2XlHKBicy1Ffz/4=
X-Google-Smtp-Source: ABdhPJzsY1EbegVy7c/ZhieP52yqx73fzgRtd8tb5oIkhYnZi953HIMpKDVBcpIZgVOtR3w1iT66AQ==
X-Received: by 2002:a05:6214:1742:b0:440:e595:e467 with SMTP id dc2-20020a056214174200b00440e595e467mr24492002qvb.120.1648537499861;
        Tue, 29 Mar 2022 00:04:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.54.249])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002e1d5505fb6sm15245013qtp.63.2022.03.29.00.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:04:59 -0700 (PDT)
Message-ID: <6242af9b.1c69fb81.f148c.cbda@mx.google.com>
Date:   Tue, 29 Mar 2022 00:04:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1290479513344092603=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: [v4] obexd: Fix can't receive small files sent by windows
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220329052801.28748-1-wangxinpeng@uniontech.com>
References: <20220329052801.28748-1-wangxinpeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1290479513344092603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627081

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      55.08 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      11.05 seconds
Build - Make                  PASS      1990.73 seconds
Make Check                    PASS      13.51 seconds
Make Check w/Valgrind         PASS      575.57 seconds
Make Distcheck                PASS      309.50 seconds
Build w/ext ELL - Configure   PASS      11.60 seconds
Build w/ext ELL - Make        PASS      1949.50 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1290479513344092603==--
