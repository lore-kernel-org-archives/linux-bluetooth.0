Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794BC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043EA61285
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFKCpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhFKCpV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 22:45:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D144C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:43:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y11so1262132pgp.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8cyC0vWOpceUJbmwh6lBsemSqJiYB1naFKT9mYuOnqY=;
        b=sHwkqstCnT9IiDCqBTxivL6gHGVSpNHIyjWHEzMAEPkTggbxH+iHOBlTqZsdCsyZIG
         X3oBfMvqQdZLSvAAMoxrkwBiMZBeAKXEONT8p+H+OQud1ISb4eZJc1vlfDkHmyoVGcLa
         ZW9EYnGkicJR7146nau38NcU7xUOVZ+Efw5x6IOtPvm+8+k1JNNYmBJLZSjjERFhmDdb
         wBjGrZNJW5TxRZkxAYgX3o2CA4Pzu35cbfMarAgoNOVlecvJH6wGfxAWENjGzmA5bWxy
         Ppj6f4YWmtvikGY7unbSrF/LdIo0aQ7kUdiYv3t4uUkq/yTbP8womQzT1vJrStkIUtz/
         n8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8cyC0vWOpceUJbmwh6lBsemSqJiYB1naFKT9mYuOnqY=;
        b=X7r3EVME4rT6kC5xAlT3o969iagCG2E+MzfGAqfBfiK0YlbnAPX4I/USClljT/ChSn
         +dCP70ZtrvuOSmFGOTBU1OKbVavDVMKgqszkDmda6CFYX9TAzU8AodSTJfFXuzLqn65X
         1gBwF4931YAIAB0HOzMNXHdhJ8vBb+7nYRmtKXLuqXMcilVtb5onG8fLmuuK+y7WoqJe
         K3T5ydBIJw7Ds0JoSvDYPSZHkv9ehYPBoFIhZJVdj+gcoxMC6tG9JK0DUUog1cYkRYPA
         9+jRH0V/TX6XV/P24TicpF4XKcWPTrA/pNY0Mq5hnk69W3Qx5H+iUORva6EB0kr3k5V3
         DMRg==
X-Gm-Message-State: AOAM533KUUDdK4jiXqm2lvDAVLdV9BcjZI2F23hVBeeKbQ8zcSs+V7oZ
        PjPi0vYGJUXAafTj/+HlGQs1VOMUb+w=
X-Google-Smtp-Source: ABdhPJznqBtq+k9ajW0Ax4kuUJsrgI3OKk4+id3KqGjq3YhiHfurbKZ6DoUXNzYg8+FEM8jJTrsb1w==
X-Received: by 2002:a63:1f1a:: with SMTP id f26mr1332856pgf.432.1623379402256;
        Thu, 10 Jun 2021 19:43:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.61.230])
        by smtp.gmail.com with ESMTPSA id j24sm3391149pfe.58.2021.06.10.19.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:43:21 -0700 (PDT)
Message-ID: <60c2cdc9.1c69fb81.1ca06.c30c@mx.google.com>
Date:   Thu, 10 Jun 2021 19:43:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8848412824889677094=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jprvita@gmail.com
Subject: RE: [BlueZ] profile: Fail RegisterProfile if UUID already exists
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210611020728.15233-1-jprvita@endlessos.org>
References: <20210611020728.15233-1-jprvita@endlessos.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8848412824889677094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498503

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.43 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      204.57 seconds
Make Check                    PASS      9.18 seconds
Make Distcheck                PASS      233.55 seconds
Build w/ext ELL - Configure   PASS      8.01 seconds
Build w/ext ELL - Make        PASS      186.29 seconds

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


--===============8848412824889677094==--
