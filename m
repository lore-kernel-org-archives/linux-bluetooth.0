Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3DD613C7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbhDMSwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhDMSwH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 14:52:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E77C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:51:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n38so12044490pfv.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Apr 2021 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i8ueMeYMJzxWZ/GNQbMCBB6BnEbNzo5RwHo+zNp9plM=;
        b=JQaVuqIpBiWdWHsNEGdRYCVH0Zq7J297E/skSArs4MIpIlYbfLoHqUXOnUAjJ0hdND
         rfmABc6viqpIKjdQSlWvjm0MZg34XBrCJyXqzIqx6fdEURXgKd8qBEGX4hXeZ+rTgDs6
         EFbeh1W8hjMvrObg6HPkBC5xnODrOJ2YOlpTFsSUiplPOs7z4/hQrJcnzRVODTYcOPon
         60N0CX715As7ojYA6Azk1T/4tvjA6TcO069rk8XoVcn+KkWFirFosBtOtXHZJfYe7AIh
         jDjtS/03USN53i0FDqX1DDsUUMZS5516BjH+pkGA34SCZs+nhtR9Nr5SOXGYE8CG6K5D
         nykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i8ueMeYMJzxWZ/GNQbMCBB6BnEbNzo5RwHo+zNp9plM=;
        b=ilUQSIVOUdF6lIPJnpYAnSRgM6ypyXpwFfyTz6IymFWz4FWTGMTK4ovs2ueOe9ehKR
         P8v/Bj37bRSmQWU0dRMdL0oAiVx5u9R0cxIeH2CwGMTmJxgawh12QRT7qiyLZNI6zH3K
         ZyrrRCOOO2/zan0LuJmNxSG3hTMduZvmKhBpYXyc9qgVST1fBtB5A2JUbJVqGTve4omS
         DpKA9SIjc1nhGrtIJgV9kWnZ0dnEjEPbt+xxx+Gj2QpXDhCAlAkQ6XYsH/sjEzQOTTIJ
         AzQEaS9CznPtHOakVgAyUXwXc2o4vHa+gChwM7fNPXY+Bd1KUoCBzgvCSjirOBfKXCOf
         JtUA==
X-Gm-Message-State: AOAM532SkELbzK5toEnncd5OAgqTlvokUEm+p6HrlhbA8FHJeBXF28Um
        3Gt/9ErBnMkusC7iD9MVZcHDf7o+syY=
X-Google-Smtp-Source: ABdhPJyImsm9XfDWvOfKKXdGJGHcMGNqXmTtoq1gZKSIan/qtqS32T4OlHctA3m49NE+2XscD4ceJg==
X-Received: by 2002:a05:6a00:1743:b029:215:225d:9e78 with SMTP id j3-20020a056a001743b0290215225d9e78mr30367437pfc.18.1618339907293;
        Tue, 13 Apr 2021 11:51:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.74.85])
        by smtp.gmail.com with ESMTPSA id a185sm4789769pfd.70.2021.04.13.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:51:47 -0700 (PDT)
Message-ID: <6075e843.1c69fb81.a9224.c20f@mx.google.com>
Date:   Tue, 13 Apr 2021 11:51:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8467205223942493666=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [1/2] monitor: Add control packet count to analyze command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210413180430.356676-1-hj.tedd.an@gmail.com>
References: <20210413180430.356676-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8467205223942493666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=466569

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.23 seconds
Prep - Setup ELL              PASS      46.93 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.36 seconds
Build - Make                  PASS      195.90 seconds
Make Check                    PASS      9.40 seconds
Make Dist                     PASS      12.67 seconds
Make Dist - Configure         PASS      5.45 seconds
Make Dist - Make              PASS      80.33 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      186.31 seconds

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


--===============8467205223942493666==--
