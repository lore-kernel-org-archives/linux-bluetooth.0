Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84163C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA7610A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 22:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhIVWhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhIVWhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 18:37:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF54C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 15:35:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 138so15034435qko.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QzJDN4hvwg9H4KyG7nyyS8CQ6gK5uU+WvxWUyvyu9Kc=;
        b=N3cRK3uCqgMIhKByxNJMSYvnCEWH7Orn1mWrJMXB2702Izvz9XulR1ZETezqjI0Neg
         HtBCk6Ofw5EYDjfmJ7LQ3vyAQJ/tMFUX0RJijAB2jA/rJ9tcHEaeWqvKQIIP4PqDkgEn
         Jmd3ncTsmQAd4hwp8F6P7mRNH4FqLWNBzUcieRJhtMagC24BnamqtAVZU6OqtApH8gpp
         DH2T64G+JZuIeEwZS4EBYA9r5fscx5Iu9Ix6pNpnp70wxfGpn+vfGMof4i070OnGt8Qn
         0wTxvxurFpc5haFqrwih6YNPIRls3eXDQ0jOs3g6DPVHc2WmMtJMzjJfXcjveBehepxc
         qtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QzJDN4hvwg9H4KyG7nyyS8CQ6gK5uU+WvxWUyvyu9Kc=;
        b=WPYPSbJoFBVWvJ9iPZo3SBTVulAtf77QLh+V4DAO7Xd46f2Bsx8NHIF14AxhUWYL13
         YVNyKjmV0Ff+x3y7rmvmprCFYbY0noZ189RJ6h798Z3b7Vq+XJDueKOXoq/+uTPlPPE3
         5qbPjZ/4S5WmtwujqEqQu7cE63ssDUOXZyg89BUptFaLA6IrOaBvyb9QqvV13x3Xme/k
         o9Yt3YEhc1GbJf44KjwlkwZeHGwAiDqyKvo1qYsfPp3W+yqwPoO5NMurU375BOH6ZHcp
         bIIC9bFLJELBom1wnGBRHjKLdtRh8tlR4a8V7ixQPbMD1lHwhKvoG/fbEezkIkNOhWJI
         QDOg==
X-Gm-Message-State: AOAM533bYOMKrvBlYI/E1siDNSfaJ+pieJOd9Q2z7oYZsXXDxf5Qj9V6
        Run9DIyjDGSrX9x4W1P6XAO+IbjfJaP1lg==
X-Google-Smtp-Source: ABdhPJw11JnstP6ur6/3ge32lAJ9nC0ZenZ788a/Cg+icRMUcP46oPPu2CZuLog9ZiYl1a5r7t3EbA==
X-Received: by 2002:a37:8287:: with SMTP id e129mr1794254qkd.415.1632350141818;
        Wed, 22 Sep 2021 15:35:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.35.13])
        by smtp.gmail.com with ESMTPSA id l1sm2349816qti.94.2021.09.22.15.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:35:41 -0700 (PDT)
Message-ID: <614bafbd.1c69fb81.c4aa.37ba@mx.google.com>
Date:   Wed, 22 Sep 2021 15:35:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5818766418056963531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/mgmt: Set MTU to UINT16_MAX
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210922213402.1978215-1-luiz.dentz@gmail.com>
References: <20210922213402.1978215-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5818766418056963531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551265

---Test result---

Test Summary:
CheckPatch                    FAIL      5.36 seconds
GitLint                       PASS      3.57 seconds
Prep - Setup ELL              PASS      40.85 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      7.30 seconds
Build - Make                  PASS      173.82 seconds
Make Check                    PASS      8.95 seconds
Make Distcheck                PASS      204.82 seconds
Build w/ext ELL - Configure   PASS      7.29 seconds
Build w/ext ELL - Make        PASS      163.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,4/4] adapter: Truncate number of LTKs loaded if over MGMT MTU
WARNING:TYPO_SPELLING: 'accomodate' may be misspelled - perhaps 'accommodate'?
#91: 
If MGMT MTU cannot accomodate all the existing LTKs only send the ones
                   ^^^^^^^^^^

/github/workspace/src/12511495.patch total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12511495.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5818766418056963531==--
