Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0ADC48BE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4661351
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhFQABN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFQABM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 20:01:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC44C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:59:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g12so3370919qtb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HYtpoJ0HRR4hNriLGt1aqktErW6JjZ4M2C3nHHIOU58=;
        b=WbowMULPLoj5iX4s1EQlOIfeLP0/KCO72rwodqQMJSPZT9OzP2yeybn4wPoIWaF/94
         1Mbw0w2IMN1/TX/vPu6XZnHxEMqaYNgPxCLJRR+90UEUZA7clEbBumstaprvGu6QEouV
         zxI4m5DtJqd72d2u4e0NzQSmWfKMfV3YbauXX3RkpmguWDvwfdeLaHjO7+G3KD9sYiKi
         /k6UEStwpy6gzwB3LhFGFg/pYOhpOgLsEVggFGH1v+e0Bgt5oi+LxshLV2vopYhU15D9
         UPMHXRLxYfKwp+1P4qSL0uYqBtlQpmE2vfbBQgHdukbqDGEHW75o0SHzzVUVH5Nm9ZNi
         POJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HYtpoJ0HRR4hNriLGt1aqktErW6JjZ4M2C3nHHIOU58=;
        b=uSFboImh6Yqoz4nF5R36Y7tgZN8U69N5xym9lGkI2d8QT/NuAOIIJ15kVZ/M0W0WfU
         A8kUNWuBigIyx/m0smqd6uOwmpmBELgpUtOuNL1N9VZhK9oHFfNu3Dmm3LsQFzRNYe3z
         VIoQTAx0uIe4jN3Pu+q/0/86jDKGOW8T7TGS+K5FtnRaraRaSwPi+eRwnGfjYm4yoGhk
         0I/Q04IAtcZnQlXo8EWFy+lDX6V0uEvMwoN4mBc3TlFYmw/tpYgA2xXEG4Oa8e5ISp0b
         Mc8SXf86eKeDHjsROLpJ/zNSV/oJOXBmXkHGrvVVrgQBQoUGBuPs3FaWC/jGEAZDBUqq
         ZC4A==
X-Gm-Message-State: AOAM532hO31e0ubQm/NDKJAb6TS1YmWVk5XOtAgVzDUzxjO5a/SPsvMg
        VMw56OXXXjnJV6WCw8BwtBXIDCz45R8IUA==
X-Google-Smtp-Source: ABdhPJwPGGKABYtE25gGw77c3nvDTp7ODkXaGhygrfbDlgL5L8mROp+gedPW+cx0Vd2kzU4f2wT/PQ==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr2335164qtr.309.1623887944776;
        Wed, 16 Jun 2021 16:59:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.227.186])
        by smtp.gmail.com with ESMTPSA id q12sm2339299qtl.13.2021.06.16.16.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:59:04 -0700 (PDT)
Message-ID: <60ca9048.1c69fb81.858bf.14b3@mx.google.com>
Date:   Wed, 16 Jun 2021 16:59:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2845756996519320411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v2,1/2] emulator/btdev: Update the white list and resolving list size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210616233716.1920026-1-hj.tedd.an@gmail.com>
References: <20210616233716.1920026-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2845756996519320411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=501957

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      40.50 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.09 seconds
Build - Make                  PASS      176.76 seconds
Make Check                    PASS      8.85 seconds
Make Distcheck                PASS      209.42 seconds
Build w/ext ELL - Configure   PASS      7.10 seconds
Build w/ext ELL - Make        PASS      166.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mgmt-tester: Add LL Privacy test cases
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#322: FILE: tools/mgmt-tester.c:9315:
+ static const uint8_t le_add_to_white_list_param[] = {$

- total: 0 errors, 1 warnings, 1162 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mgmt-tester: Add LL Privacy test cases" has style problems, please review.

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


--===============2845756996519320411==--
