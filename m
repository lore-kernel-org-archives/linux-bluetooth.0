Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8040BC49EA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 04:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C98561C2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 04:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhF1EFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhF1EFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 00:05:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5490C061766
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 21:02:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y29so24615631qky.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 21:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JRD2UMa8feOMRx3hhzF2mlskp3Kik/kxZufkZpqt2vc=;
        b=NNfnjKaJcTlNQahIjnNEq6e1WGk+1LYA34NYOjt7cFxTASF+f5qZVMLbbmb+5HkSz/
         M3k1MeQb06KQSTfBaHQiCvgg8+4Olk3B84afSYYnScUmyxI22MTm/eaaOemwlGOpBSiQ
         CL8CtkF3L1eW+eOmNFPmLUAMj5M4J+61WIlSd9MpMV51nY/+tHEtVnBrIVcLMgVcuD4O
         L3rV/HvMbM+AnRy3wADP7TGt625S9kG9NC8A3u6E1iPirc5GuHaRds139GDXLE6GyEVw
         gJVjzyBAKl6Lel5NSSeDHPRYypUJ+RiaxG41zs7q5xWwfnLQr4gtqQfFhRZL+6FUP/zH
         N45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JRD2UMa8feOMRx3hhzF2mlskp3Kik/kxZufkZpqt2vc=;
        b=ChIJO3NMJzfxJEiig6Gt7R3uaEzucJvV1BnXCZRx+dDVmew2xnIy46gS/qcRtR1ky1
         wYATTASe4b7hb4v8SEzL1ok/HF8AmdLZKbpAjO1azx2utLrHU0+xNskC43jBXntJv4nY
         IQPIkkF9NlycZWqUKB7j5LQScjk4ALRCyLTbf0M1cpPbDoYEzK3cvBwyWBoxKyp4pdzN
         V1YDyevh4nlOjAX6PfRT4J6BiHCW8eXYhC7qIZRLNfozhhQXUE54uksDu2aJ1CDrre/s
         Qj+cT5wjuceNGWJRS1EmNrTqHsYaIS8g3l21aoOpHJjiW16EMGW73l9Dqbqhu8boPxJI
         ja5w==
X-Gm-Message-State: AOAM532DJ/IYP7Xik9r1affMFEXqhRH5iLfKqCc38e+FEkbs9b+MH8yy
        1xOofQ7dZ5fwsRb1FjWaQBQQiitrubI=
X-Google-Smtp-Source: ABdhPJyVyv1r7ve/4DO+cQb3D7mLdwCk7hZSAL2dtdNxrFMkMzsn6MxWPyuFx70HoIyHxOL4pcgkpg==
X-Received: by 2002:a37:c40c:: with SMTP id d12mr17918825qki.392.1624852920601;
        Sun, 27 Jun 2021 21:02:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.224.243])
        by smtp.gmail.com with ESMTPSA id p64sm3422534qka.114.2021.06.27.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:02:00 -0700 (PDT)
Message-ID: <60d949b8.1c69fb81.7de68.0d09@mx.google.com>
Date:   Sun, 27 Jun 2021 21:02:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8264779283083004144=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2] src/adv_monitor: Remove checking in device lost timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210628113535.Bluez.v2.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
References: <20210628113535.Bluez.v2.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8264779283083004144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=507773

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      47.87 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      204.47 seconds
Make Check                    PASS      9.06 seconds
Make Distcheck                PASS      241.25 seconds
Build w/ext ELL - Configure   PASS      8.28 seconds
Build w/ext ELL - Make        PASS      192.03 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8264779283083004144==--
