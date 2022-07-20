Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D0C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 12:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiGTMCt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiGTMCs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 08:02:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFAB6B743
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 05:02:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w7so2312903plp.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U7MR7ftLSlDA9QakmRQfEDQ4twvLgc8Uuu/iYvq/gKE=;
        b=OWEEdFzIz0b/7agESLz4ajuZrLiG5LWmFKcEJH3rqUb9kR9jP/6R4hEtu/nvZOyYpQ
         6mlwGed1/F+0/Y7UYV7H1Jup9ooHvUcgAR4vFHXKUSVDbpH54qQZbl3inpMYlj9vJRdz
         Pfh1glGj+ETUv8R8kat7LBF86YTgIf7MdgLW769oe0yMiVFJ6cpvJ6F+xDYWby6i5NjC
         HohqksheWpSKlF3eNWhJH+iCK78/3KoZT4qS+vkuoak16hSsL/n+6vhXhs1g7LsBlEkt
         W5qjSzRiOw+Lr5Frhups/9IYYDKeShGVlnsXInXKxnRjgVjpTivPolilcH/NAqX7A/E3
         OMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U7MR7ftLSlDA9QakmRQfEDQ4twvLgc8Uuu/iYvq/gKE=;
        b=stJEdv++2OpDQ8RH2kEt9N+s1ylWJWdpiV4Bb0l7wSBhsBN9ZJsuQieBlpZKOu/w3f
         hIfSQwKt1N24Ii0zU7+4cf895FLg2qjOXHL3AQsaSL0ZcTvTW0I6prL/fgPAgQycohX9
         e1hLZQkn2WGVrFtQZoiQCGYWJje4R29cPeQCoVhA0pQF/TxicJDvD7sLVhAJTH3VQPYh
         fsyKITVGaZMA0XEM+57BWekqXTwvs1bk8kJEAsI9T+UkD/OVczRs5nqESVQjJ4XtT/AV
         aQF6LeZGh89fr93vtuiP+bXQcjfYP5gbyQghAfsM1FVtOOx1x+FuXqw4ksp96Usf77Q1
         OGUQ==
X-Gm-Message-State: AJIora8RDSoQ2iGB4YxOnpYbIGVUqYd4Ve+qukxpMY9xUyWDz+b6CVae
        IGKVoVxytTVNYWeQHHC4EUDHmN/gnWQ=
X-Google-Smtp-Source: AGRyM1uDemRN3fYoilZSPihkAxD4gXDGq5cKQ/4oSu2RuSOm0IeFEFDgXW1wJo2h8j3Y1n+ONsaN9w==
X-Received: by 2002:a17:902:f681:b0:16c:1fcd:eff7 with SMTP id l1-20020a170902f68100b0016c1fcdeff7mr38130999plg.86.1658318566261;
        Wed, 20 Jul 2022 05:02:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.247.143])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b0015ee985999dsm13843827plh.97.2022.07.20.05.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:02:45 -0700 (PDT)
Message-ID: <62d7eee5.1c69fb81.98fe7.4b47@mx.google.com>
Date:   Wed, 20 Jul 2022 05:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0367760083996236932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
Subject: RE: Bluetooth: clean up error pointer checking
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <YtflxRosxskh2CoH@kili>
References: <YtflxRosxskh2CoH@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0367760083996236932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661424

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      45.84 seconds
BuildKernel32                 PASS      40.97 seconds
Incremental Build with patchesPASS      69.34 seconds
TestRunner: Setup             PASS      676.66 seconds
TestRunner: l2cap-tester      PASS      19.85 seconds
TestRunner: bnep-tester       PASS      7.13 seconds
TestRunner: mgmt-tester       PASS      118.69 seconds
TestRunner: rfcomm-tester     PASS      11.35 seconds
TestRunner: sco-tester        PASS      11.69 seconds
TestRunner: smp-tester        PASS      11.14 seconds
TestRunner: userchan-tester   PASS      7.73 seconds



---
Regards,
Linux Bluetooth


--===============0367760083996236932==--
