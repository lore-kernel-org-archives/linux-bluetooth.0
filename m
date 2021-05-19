Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90350C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60854611AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhESVns (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhESVnq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 17:43:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E65C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 14:42:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 82so2894094qki.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n3neOzmOrN1ZULuHTQG7xJ1o7NPqUPTAitOyR9v7Krg=;
        b=qmNRJEnuP+eVP2lwF/jP34Y5zq/yfHGlPClLyxX+OONGqfJ8wla4raagXKuPAya4XR
         aOU02ZTRrELcZKx6Tmz8/izKhjtv/HReFwXtauK51Bp0ZiXJ92MOq6JDSpkXVpmLM302
         nUcYy1SSfH+8jVQ+Z+/6Xtca4sxyS4x+tt2kgXGrXPBfi66s4aQnBrsDtM+Aa2qUm56l
         OHQiX+tB92hOgiWDOmQogJCso8+Fw1MmFMdOYfBzzgid/bgFnGFDyxbZOXVgQOfVAJE1
         s/rF8TSQ1Ch4cQRN/l8U4CQI3qQtJdouSZ9pLsdrbYaY6+zIXQRI4eMo/zYOdubRVUQl
         1Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n3neOzmOrN1ZULuHTQG7xJ1o7NPqUPTAitOyR9v7Krg=;
        b=eHrih4tOd93L+JU8ESI7gOAij4ieEN5Z64+dbB/tO0nYAxX8DEo7AmWC65+l4zYoIH
         VHUxk4BLIUZe9BIeOlkglHswqiIoH8FcF3N5c8UEfEx1DoCevRyIjS2DAbCXmnGZRYBi
         S6qdAhhhv+YiKFGlm5GdyzBvN6SDIRD3g6InvxYWdBA0k0iSWHPT0mj2yPh/M+SPpG6k
         m1OOBWG+rLStXQaSmkhN86E2xuGcCdLDmGxLmL4Z5HXZFrpWTa2ieIrvI+dfpRfCbQ0z
         lwZfe3WG7qPoBwvEBCcGHpKiB3NfuM7QqEwrfMUwj5ik7LRfyHk0XhrKeixtWDNjbVeM
         VPBA==
X-Gm-Message-State: AOAM531spKsL3kDtKLV0eKZ/gCJDVwrAHhN0cMNezGaRFv/rqbhgLpGW
        DPKAoldv1iCEm2y9F6AJfYcn60d5ecnEyw==
X-Google-Smtp-Source: ABdhPJyUfHtGsnbyDadmD9pj8RzjTZIK7cpbOGegxayn3g+iIp8P/ktQ+p4yxkzFQrd9/i0eqG1zqw==
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr1710718qkl.208.1621460545430;
        Wed, 19 May 2021 14:42:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.9.43])
        by smtp.gmail.com with ESMTPSA id c14sm521170qtw.42.2021.05.19.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:42:25 -0700 (PDT)
Message-ID: <60a58641.1c69fb81.c548.4937@mx.google.com>
Date:   Wed, 19 May 2021 14:42:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0290257079159555521=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mgmt-tester: Fix "Remove Ext Advertising" case
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519211907.157397-1-inga.stotland@intel.com>
References: <20210519211907.157397-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0290257079159555521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485351

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      48.33 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      206.92 seconds
Make Check                    PASS      9.88 seconds
Make Distcheck                PASS      245.45 seconds
Build w/ext ELL - Configure   PASS      8.68 seconds
Build w/ext ELL - Make        PASS      194.87 seconds

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


--===============0290257079159555521==--
