Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 00:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiDGAhm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 20:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiDGAhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 20:37:33 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDFB60CF1
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 17:35:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c4so6996816qtx.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TbZRvjy9CFqAGP1/lvkp4QGk7PKyLeRUjBVZS3UgHJs=;
        b=eoEeume5uwJ2FTSfDi9fd3mofEiD1YjXw20szs46GbYhRYRAJAXekrwFWypfBocSOx
         Xo/ZNWSxZd6Qf4VYYRH9Llr3+6o+J0jm7/WHRSHtjOfXLp1VNZHa9e5txFn4xcptk2t3
         mhrww+i/thvmY6OmLX5lz/JcVguGd6ggsBoAcwZHsmLNFTeNYgNBY62SVpOLKE5mXmy6
         OLGxigt28nTwVEeQq9vLBsKWmfX0cZ/gdmOHPu0VFprJTtCJ7QMNw8TKPDCyVem4ey/w
         7x9WefPwfCesPE9ARVZ3EENZzWWTNUp5przBQ1ObI46iYCh2YhcINglg2hfA6aTW75hk
         yd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TbZRvjy9CFqAGP1/lvkp4QGk7PKyLeRUjBVZS3UgHJs=;
        b=UC92HIRBiEGgH0ofk1u31MR4Mc4fhpX3pnOHruii3xAQa03eBTkKDKj/20VUpvUXOf
         FsCfEtxkIzIm+GX1ssrNlCO3qtmBWVxN72r17/QZI37mX3Ypl8qmDyYd6XJhFloSoqRa
         HUMd8QQRP+5gxN66Hw8mTdbnFR4xH9J+Nv6UXtQjZw1X4l+PGxlIq13Q+TcxlNgqkhCU
         Xj1RWdikUKmbqwJJr89WhbeqH9CkqJjAnPSVheempUHbPHYToXEKsE8IDwLjpekzFaow
         JEWsJ69hUw66sBd86EUrXX1BMyqSDAoFgM/BXwnEEL9rcJNyoq4nwssPGYLWOZ8S3Ye1
         kr4g==
X-Gm-Message-State: AOAM530G7zgZDO213/nGeOF7VVJWxlm40V+y8EmKAGfjAoPFbYMgWnn4
        XrCedxn+VDKw/igjgh35SpiJdGKona8j6w==
X-Google-Smtp-Source: ABdhPJwGsREtZJMoA3jHI51R6DhDmbAq8F/YhIJq80DL1FiYM1LJQvExjHpdpX6yUZ51qgC177QaYw==
X-Received: by 2002:ac8:4d96:0:b0:2eb:d035:7f00 with SMTP id a22-20020ac84d96000000b002ebd0357f00mr332860qtw.597.1649291734155;
        Wed, 06 Apr 2022 17:35:34 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.228.53])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a180700b002e0ccf0aa49sm15060093qtc.62.2022.04.06.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 17:35:13 -0700 (PDT)
Message-ID: <624e31c1.1c69fb81.cbd7f.c832@mx.google.com>
Date:   Wed, 06 Apr 2022 17:35:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4001751413933387052=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] monitor: Add support for LE BIG Info Adverting Report
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220406213355.1918220-1-luiz.dentz@gmail.com>
References: <20220406213355.1918220-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4001751413933387052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629731

---Test result---

Test Summary:
CheckPatch                    FAIL      4.33 seconds
GitLint                       PASS      2.89 seconds
Prep - Setup ELL              PASS      42.45 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.47 seconds
Build - Make                  PASS      1384.46 seconds
Make Check                    PASS      11.53 seconds
Make Check w/Valgrind         PASS      440.77 seconds
Make Distcheck                PASS      228.57 seconds
Build w/ext ELL - Configure   PASS      8.77 seconds
Build w/ext ELL - Make        PASS      1367.66 seconds
Incremental Build with patchesPASS      4171.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/3] monitor: Add support for LE BIG Info Adverting Report
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#110: FILE: monitor/bt.h:3671:
+} __attribute__ ((packed));

/github/workspace/src/12804115.patch total: 0 errors, 1 warnings, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12804115.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4001751413933387052==--
