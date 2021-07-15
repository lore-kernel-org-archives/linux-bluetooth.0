Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3CC12002
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C10361358
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 01:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhGOB3E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGOB3E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 21:29:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BCC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:26:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 77so3614530qkk.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h2kJuEagRMLj3MqurPLoDzufRCHZUwi6DGNIoc6BEFk=;
        b=ub+N6Yjp5lBghrgomk12909MtYaUxmYFEjNqJ1R+dwbOdt98/1pyFz0LZtuNteEJfC
         wLW2wVUJ3RTvYCFuAEnKaNPE4qxIbB/aw827X7nyZBLWGkrrEOddpuR1SbNnPKXYgvzQ
         eri6GE8h9uyjcATYBUKADACACFGZsdWZb49p0FOMpuTsApWqvPXEKrxD9oPT8vADDxzS
         KFXjwakidSfNuAoudwhKTQ0O9HQ52vXOc0Rx1oaMdsnrTYd9xDtWKHuiAg9UpCjTmKZD
         BCQEU3rECJLlxdIkziUM82zra/hqEzpcvDH2XFHQ09qwvGhVW2bTFKxB1lniSetSCn/n
         Wd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h2kJuEagRMLj3MqurPLoDzufRCHZUwi6DGNIoc6BEFk=;
        b=PQvjTiJD/Pyz9C23LQgAcIKTo37Hz0r6aQz4DpWYHfTDKw60Ipe3Y3b01jzxccfExh
         u/mJxwE0dtwhTL0YzI6BuI68oOEMqBBaN4QX/LVEuJgDVCEWyMOSD2H0XxLWDQHncryt
         d4Bb82pL5JR/iV/W6uu5BVeAHL6c6F8VY9YYlYq//IF5iarRWFkgyJbU1x+sOyq/LhEC
         GuXnhH0ww2XPSOSNS5owLltP9IcHxwSA7ul5hag1rbHZlYRNJy9cvxeOQP46EMMoDp0z
         cJhSA1VkHgaHrY/gRwqO1fNwbytD0FFNbshSCugd3Mq+a++8R1qPmoSawGyxm3wiv3JU
         03dg==
X-Gm-Message-State: AOAM532zFUByiw6kK9fO+s5bcd0mT/l3QZn/Ty18QbYITC6Bii3d8KrC
        KulkXOEuFV54sunNEbRxF1fQf8aVWPrR+g==
X-Google-Smtp-Source: ABdhPJwFbdSnW4FPdj0rN1Fca8tyVlS+qouyK0Fi9oZrNRXvfhAmdkangJbMlRr+qdcN01631DvJ6w==
X-Received: by 2002:a37:e4f:: with SMTP id 76mr947649qko.44.1626312370286;
        Wed, 14 Jul 2021 18:26:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.111.65])
        by smtp.gmail.com with ESMTPSA id l9sm1442278qtk.51.2021.07.14.18.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 18:26:10 -0700 (PDT)
Message-ID: <60ef8eb2.1c69fb81.6fb78.9241@mx.google.com>
Date:   Wed, 14 Jul 2021 18:26:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1533979406608708764=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] monitor: Print EIR of Extended Advertisement Report
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210715003521.2222-1-sonnysasaka@chromium.org>
References: <20210715003521.2222-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1533979406608708764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515781

---Test result---

Test Summary:
CheckPatch                    FAIL      0.24 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      39.40 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  PASS      170.91 seconds
Make Check                    PASS      8.82 seconds
Make Distcheck                PASS      204.00 seconds
Build w/ext ELL - Configure   PASS      6.98 seconds
Build w/ext ELL - Make        PASS      161.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Print EIR of Extended Advertisement Report
ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
#9: 
Change-Id: I4805e589837733e7ecf9d33218e4135e8f822a7c

- total: 1 errors, 0 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Print EIR of Extended Advertisement Report" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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


--===============1533979406608708764==--
