Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A8CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B1861352
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhDLUsb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbhDLUsb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 16:48:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16133C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 13:48:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s5so6995348qkj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7SqjG7tkiRre8/MCaDGmdjwgbESEDolYvrA/HUsaP5w=;
        b=TUUPi0WiblLzyHOMP9vEMhgfrhQBmciC2PlZGHcHSjGAJLgHFlPMRXPJ1POsIVHhQP
         ftJHUHn/dyQ/4dW2ZIMYoU0LZUB0oPkPhFqcU+3NlQYR1yrjBjy6WS5wSl5yT0FS6y17
         L+z6QmbF3VF22L1u6xTlPhWI0Zc35sXA3zgGvrVX9ZjBKOl5t0+3kr3KKr7cpYuLsQtT
         gA49eI/k4LB7+82zZmLeFgHxL6UX7IkZEbgla7/LIAFnRwyqJUuXz++DzJHwZU5lw2ID
         CwWOtvEFZt7zA8W/K/Tys4OcbBO4Oa1U8oxtBdrbpTB+7u3OyQbYK7WZbgCEeO9lbeNc
         pfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7SqjG7tkiRre8/MCaDGmdjwgbESEDolYvrA/HUsaP5w=;
        b=rcRCtAUcGQdWtNseuMdJGW0fsaReI9nEP4bDI1zPtldYeM3NzFY4nZbvQ5mDI2nLXY
         qF2s4JkBiqfepAS2D5fSZxpbOzXJTpl18HrhJV+IDt2ZZdDghbFauFElmEx/a5E+tVmR
         IOqf7LCqbwkUOGl6zrZ+MoUTJYFbQF0doaoeDLsbhutfCWVT+es4zcb4DHxD707S28Xg
         C7hAgJzu5hdAcBdb0qdhyRlIlHae1QIvJtlc+oXprvI9yECMaO4Y6fxYkO4JbWkjzn7C
         2Uhr366g9Co0peVPryOWrQRAQcu1j3TZpJaJLHW8t4Re/xbqFk5FNcjeSW3KPtNd3zT5
         AEBA==
X-Gm-Message-State: AOAM5323Ul/WqfnABilpjfKG6BbrUzBGD+Yr6IBv5PNcnIWDJojuNoFV
        eCC/ePZgoSVcemC4cm2cI/JRii6cpArFCg==
X-Google-Smtp-Source: ABdhPJw3K5QLu0d3Jpcvl19Atl+IwhKEXbzn6MGs25+p/nXEoT7EpDgm9+SBOo09Ll6zlHyLt46KTg==
X-Received: by 2002:a37:acd:: with SMTP id 196mr30214250qkk.219.1618260479979;
        Mon, 12 Apr 2021 13:47:59 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.6.113])
        by smtp.gmail.com with ESMTPSA id 71sm3357899qkm.40.2021.04.12.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 13:47:59 -0700 (PDT)
Message-ID: <6074b1ff.1c69fb81.287ef.5b83@mx.google.com>
Date:   Mon, 12 Apr 2021 13:47:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0096509952925809482=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, curtis@maves.io
Subject: RE: [Bluez,v2] gatt: Either notify or indicate, do not do both
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210412203426.213872-1-curtis@maves.io>
References: <20210412203426.213872-1-curtis@maves.io>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0096509952925809482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=465885

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.34 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.08 seconds
Build - Make                  PASS      168.14 seconds
Make Check                    PASS      8.33 seconds
Make Dist                     PASS      11.23 seconds
Make Dist - Configure         PASS      4.40 seconds
Make Dist - Make              PASS      68.95 seconds
Build w/ext ELL - Configure   PASS      7.14 seconds
Build w/ext ELL - Make        PASS      161.10 seconds

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============0096509952925809482==--
