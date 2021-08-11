Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD2CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AB060EBD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhHKHgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhHKHgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 03:36:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB74C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:35:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so8275237pjr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EyScIBLb1f5iH8LxwPl0JKRHO4pzv4UBYRPzpvqesiA=;
        b=usKK+8BFbUOhfTDXyyj8esSvmp6jJt8U+NZX2bykYzZEwBIT88SFi+JXa92Cz/fRhq
         2K08jeSAGGBMsc1VmWaZAk7ayu9AlR3jaPXifHSjJenECY5zTKdyT4BFgsQR6cqvk5CA
         VqkmQuRd3cD4pOAZ/wRJPmFGa2yOJAM3djDu8czeXvQeRJ+gl4Sfr3+3/iGOQWgQITm2
         t71kgKPwGWp37+EPP1i9GTsrvSxejZ5jkO6oyZzE2TDLSxpjczSxtsaPDtKqil6izZMC
         9+Ap6B3IR59y/L+szzSq0LnZamzL3hzySH1s/AR/ZBdsCO4GtLCPU2xPiRwPFLI5vKAx
         nf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EyScIBLb1f5iH8LxwPl0JKRHO4pzv4UBYRPzpvqesiA=;
        b=lk+yCnA7KpCJSovROFMB1s/OPN9fqq9cJL7NwYRwHNbZBP4hUTQGGEC/WbFau/1BHp
         PNr/RELJrEwNJKl3Xf2GO9BzG0O7miIIX4xX1TNI53KtlLh2FH3hc+jvOQEUY2KMF2Gq
         IIUqtb85Z/L0TzB4UuL279nX06Ga4W1aUANGYgDLHwY8rcgIvXprTU+R1pGM1mgfXyfk
         daCAwcQeDZgvaLvZ3/8RRs79eBLpw9eXG/otch+P0K/zxmE6kpFmYcuIxNorZP5HybPG
         0Kv0b2tX85Bey5Pd3j5xg4tgoWpq9oqpWHR/3JrVrWmdZf5wajHVbloq2S+Gr0SaFzJs
         AOOA==
X-Gm-Message-State: AOAM532W7fArYwXKl+ds7+zjchOOA+0H0j+GlHVdsnmWy9mP2xaTtyon
        SCS6kIU+VrYDPTR7mLcFroQmw8rugFM=
X-Google-Smtp-Source: ABdhPJxgGBlBhAGKiA5JJXqO/+xpeZl2OrpZoOqJfOFy8+OkFDT/Uh9b8uk6rvQvcbMJT4zzLocSIw==
X-Received: by 2002:a17:902:7294:b029:12d:f2:e8d5 with SMTP id d20-20020a1709027294b029012d00f2e8d5mr701816pll.5.1628667353205;
        Wed, 11 Aug 2021 00:35:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.222.203])
        by smtp.gmail.com with ESMTPSA id h16sm25946484pfn.215.2021.08.11.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:35:52 -0700 (PDT)
Message-ID: <61137dd8.1c69fb81.530f8.c7bc@mx.google.com>
Date:   Wed, 11 Aug 2021 00:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0181118328273124133=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] plugins/admin: add uuid duplicate check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210811151742.Bluez.v1.1.I3c1703ddae63da383b15e001bc965dadb4bd00b8@changeid>
References: <20210811151742.Bluez.v1.1.I3c1703ddae63da383b15e001bc965dadb4bd00b8@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0181118328273124133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=529641

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      47.72 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      212.01 seconds
Make Check                    PASS      9.57 seconds
Make Distcheck                PASS      249.30 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      199.45 seconds

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


--===============0181118328273124133==--
