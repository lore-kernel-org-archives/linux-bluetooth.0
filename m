Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5837C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C973B61026
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhIIXfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhIIXfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 19:35:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A5C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 16:34:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s32so3106987qtc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3GrvNqFWxefFb9aB39RF/SLKsd0KCOS/ehPA+r8/tcE=;
        b=Xzo+bqb8qL+uPAWX8DbB5CaLAPovYsDxaupwARAnb2PaMHXxK6kj0GCpB6Z2MclRqX
         7wTBZfqKuwnI22/wV7hTXt+fJB1I1+NDkCrpxSoHRWdYVVVRUdL0/Lh/uPuS27qRaobq
         3zxmFwOs/FE7gWTJYMV3FQSUUllSyiJo4AOo7FuDUyf19EkqMUvRHk20p7r44GWKchCQ
         nYrtAcyidaU98iWbOASAfEKW3F7AVrUXza0GnZRwZxfFby/ZZxMsK5rqyZlE+PN95dWz
         MrA9RAlgsyOqR5EzSRiSqmHmvDsy5i9IjBd4iCgvCYRRmIIcnM8+acEwgiOWVYzuPDJF
         ooXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3GrvNqFWxefFb9aB39RF/SLKsd0KCOS/ehPA+r8/tcE=;
        b=Zw+5nFIv+xinF3YyWgpdtQczJNVlTjgZ2nnnWcYfTdeKTRy9/mgqQTXy3ZcvSv1VBB
         BacYZTyqhn0wsFHoeBnvdTbIQlsHoopOB3Y2XMpY9U9UXe2PrZIy8/+pXCgje1BD8nI7
         1e3dEWDVSeuCmqPm231S6KoFWc24loZebbXwB0s0Vv1d58+FDBfj3BlyHjiyF3Qop7ON
         Sz3gojx9kbLCvj9fsS8HK7qXeHpU8Hjornuf+al/TYUgOQV48mgxJXUSeAviORyzeClE
         q/yB8gHpEwHdPixkZpBIKRcW1ASbdOYsyJhE96rvUgD4vmvsD0f3NV2MwUlCVLV0lphc
         YiiA==
X-Gm-Message-State: AOAM530L3L1Eulz42TOzNqLUchJbOHYaYaJ/rQiFjsBQP4U2k/i9MhuT
        GHCdjXiVP0V2QEs8vG4t9uvHzPBwQ+Stzw==
X-Google-Smtp-Source: ABdhPJyYZ1mNK6QYf/PO1yKMF23tFVjBxSutgsW6dnBKD3IcD+KlarW99/boyAbmUDHzIRnPTPQAPw==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr5563828qtu.178.1631230465435;
        Thu, 09 Sep 2021 16:34:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.6.225])
        by smtp.gmail.com with ESMTPSA id m187sm2401012qkd.131.2021.09.09.16.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:34:25 -0700 (PDT)
Message-ID: <613a9a01.1c69fb81.1298d.11ea@mx.google.com>
Date:   Thu, 09 Sep 2021 16:34:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7322016527044378743=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Add test cases for load_long_term_keys command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210909230906.165577-1-hj.tedd.an@gmail.com>
References: <20210909230906.165577-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7322016527044378743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544671

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.77 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.97 seconds
Build - Make                  PASS      172.58 seconds
Make Check                    PASS      9.04 seconds
Make Distcheck                PASS      202.74 seconds
Build w/ext ELL - Configure   PASS      7.01 seconds
Build w/ext ELL - Make        PASS      162.56 seconds

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


--===============7322016527044378743==--
