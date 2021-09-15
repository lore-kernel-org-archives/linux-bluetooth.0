Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B1AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8B060FA0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhIOTDo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOTDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 15:03:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A5C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 12:02:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so3640701pgl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bqdcR8SURQltPLaKZTxXHBQbsxl1Stuu8RRKmsetEGk=;
        b=ko/Ro51wSHll7AQPiuOCnBvtym/57CCQWFQfD8fHEErty/E5S8PhzkaA3PThN2V2UA
         /HkX2ASVpeDHfiuJK3gHdRmAvFeBDSdYXEyYLlYI7HV1ewxYUTgW/fL2mhtbTk+yqO3t
         GQMSisRXDbKX4wixPBKtzVN1RE3WGolGkJLbsc7PeFi7jqRwWe8I70E5dhWJnbieGlgu
         q0pX9UMvJq4Zq0y/h/warwto5nqbusSFSChMzY7M8KsUWDHeq7UfZxAN56KZEcOeOqOe
         f4ID9kBh45RL3v7rE1kZaFSP2FO3Xro7rlTJEm4zrz2ngAmzpdTfzrQGTWHQ3Y4mLuAu
         F6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bqdcR8SURQltPLaKZTxXHBQbsxl1Stuu8RRKmsetEGk=;
        b=4J06Z9z4B94mWNIlblo4TC7NVJ3iNUlsTs0Ql3LH6/VdYAjfAixqzIgqFIU3Kc9CcW
         A+gnlo3vPWb8CuoBCIFTT8KeP8mnWJtuIZmKoC9NWjID407tbdtOldRhITr/MSwfr+Fb
         xR245wk3wOHooOzN7m8UrCDaVuGrwIOo1xoWGYtzp/bK8hysNFKGqhmmYTGdugSjVXPr
         sv1QKdKAdSrbvuSNaqXbqLNCbjmFoLGGUgayf8Bn2Ly1YuYjDwUTVZeJOgjguv9ykLne
         2HsruH5oct8ni0BeQDt79+Mxu4SQAxKvrod60OT0m3Xr8gA4A5GrVZHNgKHEDVT/0ZLk
         tIXQ==
X-Gm-Message-State: AOAM532WRqOTSxPWTp6t8tRjuoBeC8ATmCVSsGqcH1YjCn2WajgzwZ99
        XcYmvIb3C0lbqG1Y/DYTGU5vWPfLIHY=
X-Google-Smtp-Source: ABdhPJzY7/QUAKBTwP4e6N5bx1kBWw1I9wjOdVhgw0eppbHIGgTCPhIAuoyOqTdFfHinHk0+qElAWA==
X-Received: by 2002:aa7:8481:0:b0:43e:c776:e20b with SMTP id u1-20020aa78481000000b0043ec776e20bmr1142664pfn.45.1631732543690;
        Wed, 15 Sep 2021 12:02:23 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.187.227])
        by smtp.gmail.com with ESMTPSA id o16sm697809pgv.29.2021.09.15.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 12:02:23 -0700 (PDT)
Message-ID: <6142433f.1c69fb81.5dfd5.3017@mx.google.com>
Date:   Wed, 15 Sep 2021 12:02:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6415379551291245376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v2] Build: Test patch - Do Not Merge
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210915183136.384103-1-hj.tedd.an@gmail.com>
References: <20210915183136.384103-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6415379551291245376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=547527

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.30 seconds
Prep - Setup ELL              PASS      44.72 seconds
Build - Prep                  PASS      0.21 seconds
Build - Configure             PASS      7.93 seconds
Build - Make                  PASS      199.54 seconds
Make Check                    PASS      9.12 seconds
Make Distcheck                PASS      234.00 seconds
Build w/ext ELL - Configure   PASS      7.88 seconds
Build w/ext ELL - Make        PASS      197.77 seconds

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


--===============6415379551291245376==--
