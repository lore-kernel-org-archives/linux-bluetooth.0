Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E9C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 01:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCBF610F7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 01:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhEGBbm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 May 2021 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEGBbm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 May 2021 21:31:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C45C061761
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 May 2021 18:30:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id n22so5567995qtk.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 May 2021 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=m/ynwBsOjNhNeecWqKJ+rHlfryMIlRAVBKL2dOLJL1Y=;
        b=tOF0qPrqJCFenQ8iH697fHgleah+vKHFpBY81enLU/4PreD1PeMdzdhsgyilhAuHTP
         OqjUFoaWCXFfCZO42GScWT8JsWbg5usIfm2lDu2MZfARaHdWe5+YqCeIpOamrJNL6JK4
         DZ7ZfIPyKP0P2bwqM+MgF+6pl8sNp9MuqGYT7VXpoq0zdzxYQtcVAtewWshwTdfaHtLq
         Z6VJ8UKj8ADj+ElGYNv6pKxGr8q+NIujxtMbcmjqGyZ3whurakdqIrnKvKAbR4pBLliP
         6GDSsMg4ldwpuEIU4hkTst0y2KtWbQINEFFcnzO2GfPxN3DUD7wnfnjIY4X7ewIFFOQ2
         xN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=m/ynwBsOjNhNeecWqKJ+rHlfryMIlRAVBKL2dOLJL1Y=;
        b=L5mYdpiREqnDP9J5K54KenPI1hEHdZ9PaeIWjEd9tQqCOM8SWO1PMPbufDy57JZl5p
         Us1LnJ++kMetQrDAdbMrtrevFq/7u6eu864Iq7NB9aC5s1Nd2vX9pXRxcF8YzvFLfvxQ
         3/ZqU/+iWxSdQ7uId5KbAQP01AjQa6x/qjNEYeLvzgy/AwjvfDNoVoh23cyYHrpiN9H6
         UN1WaDSQs0OuMX/qsmgs8QBm5riKy7YGiK5bxZDmKOxyIccC/SVky6l1Yz1sA7GYV5Ly
         hMLahclAYV+q858ISFR7mfIg59O1rHy5WuQMRDjIklvraG5jR18r5ZxZOwSngaCphbnZ
         NzGw==
X-Gm-Message-State: AOAM533V7ge07gdF49xB/hF1CB4600k/ULUVUYEATdXUD8n5/bNXz9n9
        rDc+I6Xdldbk7lV1AMKgAy60VNrwdl7GHw==
X-Google-Smtp-Source: ABdhPJw4EcwYerlPeiOugqB1h8nNC/LDLU3h2baH3Zar05B4OFMraFkjiBrgfto4BrGm6X9Dd2imgw==
X-Received: by 2002:ac8:5649:: with SMTP id 9mr7224523qtt.148.1620351040130;
        Thu, 06 May 2021 18:30:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.229.105])
        by smtp.gmail.com with ESMTPSA id r186sm3623405qke.97.2021.05.06.18.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:30:39 -0700 (PDT)
Message-ID: <6094983f.1c69fb81.c435d.7385@mx.google.com>
Date:   Thu, 06 May 2021 18:30:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8985385030710743259=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Remove Pygments dependency from manpage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210507005630.1231205-1-hj.tedd.an@gmail.com>
References: <20210507005630.1231205-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8985385030710743259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=478179

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      47.68 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.37 seconds
Build - Make                  PASS      203.26 seconds
Make Check                    PASS      9.58 seconds
Make Dist                     PASS      12.87 seconds
Make Dist - Configure         PASS      5.15 seconds
Make Dist - Make              PASS      81.78 seconds
Build w/ext ELL - Configure   PASS      8.41 seconds
Build w/ext ELL - Make        PASS      190.81 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============8985385030710743259==--
