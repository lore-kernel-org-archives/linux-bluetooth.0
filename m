Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C51C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B8761183
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEDKE5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhEDKEz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 06:04:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03051C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 03:03:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h11so6972115pfn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jH9iioBC3fM7bpb/oSMNnUShSE48d4nQAvrEVMT7LoA=;
        b=pJFrQVKWgrk0e30FLruCiMoz057JHJSHlrb2nFFzFPutomoR/4zTvdT2cLT5/xt/qc
         8QZNuW8fgrgcw9tyjf0UZ8tFclUIrIE3OT5YaYYxRyeVd9FZWn44aVykXjN/2cN0DChr
         m2rTm4emIfhu5VOI/4AnqffZQetLQAIWHHwvee9eAp/iiZ9Baxrszr9L6Ej6/q9DB6P2
         S2YgoDlD+DgRo67RXoy9xJcARF9np48IEqrSb6iqFyY85+OXdrD1syIk8JOFlsKgRkDH
         H7yG9bXvjdc/ccav/jS7uTDprml3N+1io/GyOYwK27fb/rPSqQSUj5KAdgGmVZ3N3yby
         s3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jH9iioBC3fM7bpb/oSMNnUShSE48d4nQAvrEVMT7LoA=;
        b=M2fUhSy7jvTid6jGu4oiAW/sjnqLx2kAllFkv4Kt772Oj5Z6RYpGJVvJhieuBhgrNx
         tS0g4MdbPdq2LRJmngKYoRD3sV22kHB2m6H++CARlZoEGnB+KDFTDS9SWbKwrG5/rZON
         Jh6HpsW7lHcCeQGsdAHCIw0lKBgYFQlK77J6GK7437J7qnzt6Q3vrgtJySmqFe0ClRwS
         dbZXoYWgwS4kBMZSj0Dlz6qOvANPFBzhwVe2Iz+L4vKFAkOev5rEHu5+f6a6aPZvEThQ
         EF06LkhsqAZjNj/k81it1jiPrwkoAHmFYC/LgfJSxYgE1bB/BnHZrIMv4yP5dGGM0JKb
         KFOg==
X-Gm-Message-State: AOAM530le4YZcfzKf4DaRmYX5I2QhCWc2HFVwVJtJtYq6p26OfzVBhyk
        7kmbkzCyrtMm1+2mJzfsjASW943uVH8=
X-Google-Smtp-Source: ABdhPJxmC0stN5Vt9lqldbAXYnaeqjoix8kAhLfEKrYMC7oBh4yY/9gVThqSlHZGtHgM0yr6bBQktQ==
X-Received: by 2002:aa7:8503:0:b029:27d:497f:1da6 with SMTP id v3-20020aa785030000b029027d497f1da6mr23566905pfn.28.1620122639197;
        Tue, 04 May 2021 03:03:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.242.136])
        by smtp.gmail.com with ESMTPSA id k12sm8400510pfc.218.2021.05.04.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 03:03:58 -0700 (PDT)
Message-ID: <60911c0e.1c69fb81.51ff5.68d3@mx.google.com>
Date:   Tue, 04 May 2021 03:03:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6586064662282062303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: btmgmt: Fix enable adding irk when turining privacy on.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210504095927.29393-1-sathish.narasimman@intel.com>
References: <20210504095927.29393-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6586064662282062303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476771

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       FAIL      0.16 seconds
Prep - Setup ELL              PASS      47.44 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.93 seconds
Build - Make                  PASS      207.56 seconds
Make Check                    PASS      8.65 seconds
Make Dist                     PASS      11.54 seconds
Make Dist - Configure         PASS      4.93 seconds
Make Dist - Make              PASS      83.59 seconds
Build w/ext ELL - Configure   PASS      8.49 seconds
Build w/ext ELL - Make        PASS      195.27 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
btmgmt: Fix enable adding irk when turining privacy on.
1: T3 Title has trailing punctuation (.): "btmgmt: Fix enable adding irk when turining privacy on."


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


--===============6586064662282062303==--
