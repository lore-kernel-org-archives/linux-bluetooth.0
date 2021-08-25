Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D8C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A046023E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHYR6d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHYR6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 13:58:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABEC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 10:57:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e3so155339qth.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aVr7aeSAYBbXeldLmyGNFMeMurxtieAW4XjzD8Lz8Jg=;
        b=Rn0utoRgJ2pQkiwdQgZ3MWqncCOXy+/IWuTS5dpHFttcqdgg/2DkPWYAEmMxNViBlb
         9nOj5y0BuymSwnWituDkI6F7RlSxxxJl6FSgBXx7zJs3l7JR9XYIcx4sscgaWLI1TtMf
         fgMJ3afyU8xW9CJ/XmvTkaEHn65GR9UaIiByW3m7zCH//wK/n237XzIMo9ixge64vNNh
         7g91iAWIiIIVzsg8MTnwxQxxi0A7AHCO5J8DUVsrhORsfiQbPtCFB/dmHNN8c8arGVCb
         r+LwVIxL6vXvspqsAsX9T0BM4/uWi0ZR4Gck4Y8kYaPE1rfR41IuI27aIM3dY13GLJGj
         FDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aVr7aeSAYBbXeldLmyGNFMeMurxtieAW4XjzD8Lz8Jg=;
        b=d3aw1PxSF3hMj1RsbHP8Uuf5V7zRN126PX33z/iMbYW0Cvd+Ge9cUvb22pY5Q/WWAQ
         tc5UMn8zhDEmZFtHAH3x+aqQfXAv87wJhypW14w4zl5JDoaKLq1gG3aJBnaI/KirQFKe
         9EHgBBgmUVcW/IVKGO9iti6bqKjCVboehILzjFSIEHyec0ipLKw88HwV9qr04Z6TRwH/
         JjQcd7LJilEaSk3EKMyPzeSxiCTQFnSp/SvFPyNvtzTNiTDRVmhrUtJmFDnzdkcycN+n
         q1KI/3iL9UJZ66vBahlXwOuDAHdB6RtamvdxAjeByNXpvMKM6YA2xHHWU6MV5Zw9TUAD
         6Rsw==
X-Gm-Message-State: AOAM530Z6cn2RDvCXv0Pp37jQZqncUiZvLx+Sth8IRfkYkIWHxjFd+iP
        XIDCmDxZn8AG8woqwSrV5iwB+jf82yVXVg==
X-Google-Smtp-Source: ABdhPJwNG+DAEKee13xKh2uPLo1lPZ+eoyWN7vILtr8G8P4Jyu1lvCQbd72/Ku++7KrFh7NxXBGT4Q==
X-Received: by 2002:a05:622a:199d:: with SMTP id u29mr12636149qtc.357.1629914264595;
        Wed, 25 Aug 2021 10:57:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.80.204])
        by smtp.gmail.com with ESMTPSA id q10sm498988qke.108.2021.08.25.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 10:57:44 -0700 (PDT)
Message-ID: <61268498.1c69fb81.278b9.4716@mx.google.com>
Date:   Wed, 25 Aug 2021 10:57:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6977814599810716762=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [BlueZ] device: delete cache file when device is removed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210825172936.2691027-1-david@lechnology.com>
References: <20210825172936.2691027-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6977814599810716762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537293

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.03 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.02 seconds
Build - Make                  PASS      175.01 seconds
Make Check                    PASS      8.81 seconds
Make Distcheck                PASS      206.38 seconds
Build w/ext ELL - Configure   PASS      7.04 seconds
Build w/ext ELL - Make        PASS      164.16 seconds

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


--===============6977814599810716762==--
