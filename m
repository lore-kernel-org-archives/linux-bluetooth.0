Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B961C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F4760FD9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhHZQxX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbhHZQxW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 12:53:22 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FEC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:52:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so2998891qtx.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GX7/b5wJzrVTiq+z/8tKpnDSZ01ATqYYp+hMtun09Qo=;
        b=HHtKBSTWP4vQPX6PkRe5adqjyt0qXWWD8KB80ddVUgU0n1VMSrVD6MJ+FPz5fUWv4S
         eNp9P3y8u9TUTfcT7VrWp/tLmkvnGn382IRQur2CsY8cG9XWd5FVTApj8yxdZ63vF4QJ
         E3/GxRASmlP3HCP2LjopCTgW52S9DGKTABhmeThVlVtjJKwBlZJIkO1LvOImCube0Hli
         oShqwqpITy8qIysrjlxjJAs6x5xWw1YNLvAvUCqA0OlYvR4GhN5YzpJH1EQIhZEizOTg
         uPPPD58QqdnBjYavUTb65xjVrj2eeixi/fJQG6hj0/rqLOQOk2h9nOamuiLQv6mF0vKW
         vaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GX7/b5wJzrVTiq+z/8tKpnDSZ01ATqYYp+hMtun09Qo=;
        b=DuS3w8gtOk6jDBwz0QLbpxT6u7cMR4xywyLUR4znY7wYklNf1y+9mAeVeHHPYgrOFC
         rSwUkNJmDdUubffK8urIrw5GKPX6pknzEnYWRrIPlfA3q9cekF0OsQ/muwodlHtH3tdU
         BgoHljvcz97cldnjYla8tJ1vB7036u0IqQ3/0+ixSHi4pWFI3CT3Mc+ZwH5YCLSQbDhF
         OUI0qIotWVWX3iftCw+NwygGNQiWxWt1lbfpS/I4/xYGJigCju6JUx0y9UfxnOeK7mkO
         mnxGethGUIbQZnySBJvbL8m3Lal4XggfRJ9FVZ3mect5iwboSSpTRj1w9W5ru2jc1Mni
         h7jA==
X-Gm-Message-State: AOAM5315GOGf8he0r/KGuf+tDuLlbJsIevnZ5SjSmhBpNRrP2iOI+/b6
        KZ/NAytkhbZRlE9O05BKn3FiPkB4hAw=
X-Google-Smtp-Source: ABdhPJwLLDidfqvkyOrdSQ6oXNv/mGWnmzN5uIFufwDGoE1uJYmW9Yjv8btJKf1lbnWK6pcH/yD+eA==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr4273870qto.143.1629996754396;
        Thu, 26 Aug 2021 09:52:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.208.107])
        by smtp.gmail.com with ESMTPSA id o23sm2119890qtq.7.2021.08.26.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:52:34 -0700 (PDT)
Message-ID: <6127c6d2.1c69fb81.a5bda.fc77@mx.google.com>
Date:   Thu, 26 Aug 2021 09:52:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0181659638810107696=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v1] adv_monitor: Change sampling period to uint16_t
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210826090050.BlueZ.v1.1.Ib85d2d946d853ea8c879dc922ad8e47587d3c603@changeid>
References: <20210826090050.BlueZ.v1.1.Ib85d2d946d853ea8c879dc922ad8e47587d3c603@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0181659638810107696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537877

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.77 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.33 seconds
Build - Make                  PASS      207.00 seconds
Make Check                    PASS      9.46 seconds
Make Distcheck                PASS      243.74 seconds
Build w/ext ELL - Configure   PASS      8.33 seconds
Build w/ext ELL - Make        PASS      192.99 seconds

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


--===============0181659638810107696==--
