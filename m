Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CEC47095
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 04:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EF961178
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 04:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFIEIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:08:40 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:41504 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFIEIe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 00:08:34 -0400
Received: by mail-qt1-f174.google.com with SMTP id o20so1629076qtr.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 21:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8ta2qBey43qymkEZk4++K7I0MNCdl5cmmUUr8C7httM=;
        b=ghA/bit33tzxG9PIR6M/tQggzWP70YpJqNsJ0zG3V/C8UGQWzrgtfAbpdmYGuWVnCy
         4d+uRVR21dTKAWCFnNDHbb9BqXNJEeaKs+w707GyT+4Vw/awVTS1JOfLRCNNm1Ql18Im
         UxteJWRpintLqYHHza3H1hBzh6l7lf4t5YwEPWX+OOIm+NSZTe4BCYT0zzb7nlsMPJzX
         grTBkh8PbjsyLGijdyglbNW7RQqvY7GjxYRjrwdgZN9B59xVCyjJCxDb3MMJxfftJ0ZO
         ztKQKEvOcpMtVNfmZ4H/nahBCM9Ssgh+IQQLgj0YRmhRSqMBKWWtlU2x/RYwnMVBpJiF
         z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8ta2qBey43qymkEZk4++K7I0MNCdl5cmmUUr8C7httM=;
        b=d9aOOepV6Mx+xklki04dBibih1YE1W+uwZiP4k7dJ7P3q3tvJ/PkPxCOIu5xyfp883
         haLROZSWP1sb+GKzCQHDJhwMAP26I6I26f/0/aHHDizZgn2SXW/HBL1E0tKf5wfGIdIU
         Ko7rDHNx36NEWt+1OMvqnq3X+MKbbZvNvb/ARjKfuGg9A4M5v77MIZ6jUDP07A4jsbB8
         NHMZ/2URebGYJivTYgCOsR75H1Co0YQfyzdT31WHTrE81ND2DICuHfeugZBNvNzeny3i
         yrJbZEigOPlZeq0R9izmvMshJky3e0iFw30S6NwE6cJxOx1Fgj8s3eLEySRGVTrA6x5o
         bgvA==
X-Gm-Message-State: AOAM531vZB+KdVZ+gEjJjMnlSxJ/D8bBPS5IUHdfENVGe8DCg6BlLi43
        zG88SDmH4myiQBGdUOyFHolrmk6AmaUppQ==
X-Google-Smtp-Source: ABdhPJzWrDhkyIv1YD9mnvZWzCje9lDyWn8GDpQpFEGSfK5GckDm+Pw6ji7P7cxlIwoFXrHfW5vO7g==
X-Received: by 2002:a05:622a:15c9:: with SMTP id d9mr24357854qty.103.1623211524471;
        Tue, 08 Jun 2021 21:05:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.234.170])
        by smtp.gmail.com with ESMTPSA id h6sm3215985qta.65.2021.06.08.21.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:05:24 -0700 (PDT)
Message-ID: <60c03e04.1c69fb81.d6c5d.766d@mx.google.com>
Date:   Tue, 08 Jun 2021 21:05:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0110546453714479736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Check advertising/scanning states when changing White List
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210607184134.2664349-1-luiz.dentz@gmail.com>
References: <20210607184134.2664349-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0110546453714479736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=495601

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      40.30 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.00 seconds
Build - Make                  PASS      173.43 seconds
Make Check                    PASS      8.70 seconds
Make Distcheck                PASS      204.32 seconds
Build w/ext ELL - Configure   PASS      7.18 seconds
Build w/ext ELL - Make        PASS      163.31 seconds

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


--===============0110546453714479736==--
