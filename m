Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E48C49EAB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 03:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883F461984
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 03:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhF1DIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhF1DIr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jun 2021 23:08:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47840C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 20:06:21 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g19so8582215qvx.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jun 2021 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hQUa/fWDQDNiLkzSqSWYWO3WB0UlC6dv03rn4HIXJxs=;
        b=Wzz5yGID+NvEjPe4oMEfdhG/bXNKVq+N1Ektb5f5qSFFqzyoKrOcXWNRmno27YiIHS
         ca+ZlK8t5uvS3qHuD7pQ0ne7F01XkMzfAMvynQPuncd5/g61K8rHTIgysu0mzmAuP/2I
         lGXeAGCCEkNzwB4CU9XwpKLMaASzRvXRiP9nhQgc6brQ5w7PKkMKcANRO/feOv7Pnivo
         eYk3NEhfUmcJ0NfSkhf0UU+rwyYTRcg3ebhex2OScZeHRKBGy+MfqA0+l35UgM9AF5d7
         uui72AaLBHzXm8yoUAGXtjlVnLTivqznChrhNr8jhlMgkjihHIIB+0mFpt1fqhdj5BzY
         /6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hQUa/fWDQDNiLkzSqSWYWO3WB0UlC6dv03rn4HIXJxs=;
        b=FikyqQ0WAsvrjWBUFdIsidN0jjNFUtAnTnEnFldf9VGMpa/B/sdyINjZFakuVTmXco
         pSkqsBMeCdzUIHqIqNjN96J8lCvHS01WKPydljoOBfUx8b5yqHnqdCNkpq+DgkWrHLOt
         LQspcbxNo1kTKs8XBww4AZ2byWhY0DNr3/d6DawahdSYU958eQdvmplPlbVqJZtnE2Hg
         ehgv7WF+HDrZvrnHR9Zf84OedIxhkZ+5FVzlH55SOwmAQqdLE3wnp0wD9CRrAaicsZWF
         TH8cb7ytoNpcYEzDkuR1o1dCqlWLPkcRX+/lWeBMpaxBOqbXXwtvve0J2YdRMB7BU2Kz
         3dNw==
X-Gm-Message-State: AOAM532JvfffxHFP5GSQtkdQRyBUiyOKOwGO/5v4S5JmUhr5iXgvyqxg
        pm+6iMd8w0aVS0XH5iDmeIA8MY4b7aY=
X-Google-Smtp-Source: ABdhPJzCq+E9+y1hdOCaxc4MkdWwpeD4FlZCJHfBiynPFrxwE7Gy5eZuJm4NgKLEc6XRUSAwjd2zeg==
X-Received: by 2002:a0c:d7c4:: with SMTP id g4mr22989583qvj.23.1624849580267;
        Sun, 27 Jun 2021 20:06:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.202.232])
        by smtp.gmail.com with ESMTPSA id u66sm2873957qkc.89.2021.06.27.20.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 20:06:19 -0700 (PDT)
Message-ID: <60d93cab.1c69fb81.7a523.e680@mx.google.com>
Date:   Sun, 27 Jun 2021 20:06:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8714702314424791434=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] src/adv_monitor: Remove checking in device lost timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210628103655.Bluez.v1.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
References: <20210628103655.Bluez.v1.1.I5dc587c2fe4bf2e49927513cd711d353510c12fc@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8714702314424791434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=507761

---Test result---

Test Summary:
CheckPatch                    FAIL      0.34 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.61 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      203.50 seconds
Make Check                    PASS      9.79 seconds
Make Distcheck                PASS      242.81 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        PASS      191.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
src/adv_monitor: Remove checking in device lost timeout
WARNING:TYPO_SPELLING: 'recevied' may be misspelled - perhaps 'received'?
#20: 
or remove the timer whenever an advertisement is recevied.
                                                 ^^^^^^^^

- total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] src/adv_monitor: Remove checking in device lost timeout" has style problems, please review.

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


--===============8714702314424791434==--
