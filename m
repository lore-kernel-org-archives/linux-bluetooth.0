Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB57BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD20960295
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 14:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbhICOeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhICOeS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 10:34:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5473DC061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 07:33:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w78so5953826qkb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+0VJLUeRL0/FD3GOW3WU5XZKTqgE1eRXP5N9E1JZBIY=;
        b=kLH5cHfIMrhxrPc8rEPb6d7qA7gRCHQVZvoexG9EM5E7nu3Ycsx69rXr+HEwMBPuXb
         Incxdib+r0Jj7zOwwfNcGWkcZqojhISN5BfPtd2zCZ5QfWglfsuC5wNxJs62jUq395Yx
         UZYcPkyuw8YQNDyni0mdX/dQOPgvj+0nP1Cg2TjWogQtQ73oM0nSy522jXrPoheXBS8n
         BxbW30O0IgcGWqWolT+YW+inU6mfETDFignbl87VuJOp5ITR8V1JfdJSZ43+mkyojHzr
         5hO8+t6ZqpTZw9jefb0JBHeqwPXsxGeMXpF+WF8Gpn4hw+vh8Jx8bz84l3OqKEXhMHHx
         88Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+0VJLUeRL0/FD3GOW3WU5XZKTqgE1eRXP5N9E1JZBIY=;
        b=LIAZTMRF1sveerGnvPxSuCralVl0T4+oQk4yivwD+M+Xk+c5pF10UZjTO5iGfTBHGx
         AoFJOsZGHj95qtt2yHhAvupRAaQupmwA4+K4a9SKmOiAkhe2lO41ozcNU3Cao3dK+t2G
         X8/13Ywe/Thr4x5BVhRL2UI3SAsFl611ufURFb753CCLfg76AixQqPortBukaqcWK28x
         b9SHdwztrBvnYC+QYo3mpO3fnNiFtyQHmxn4toBjaRM8IEEUQ0sTa/XLx83ioehAjKRC
         eF13jzlBEGTOXqOIcWBFVIh71FTXtLULGGN3dLgGaQCSOzjLs9OL5JUpkt1vYkjls86i
         Oypw==
X-Gm-Message-State: AOAM533gSsiaPkKMdw3RSd1x7Ynu6sbKJ5pwKGStDp3FFudhV4i9K98e
        iOTfuLf7kSNW1ckNVdiowANZfLvK//QSUg==
X-Google-Smtp-Source: ABdhPJzzX56T+jhe7/A3b/ONlN++orMP+XZeDg0Ji5NTLZQ4UhlCP0eB9G/4jbPsVL/71Naw5llz+Q==
X-Received: by 2002:a05:620a:2408:: with SMTP id d8mr3604576qkn.148.1630679597258;
        Fri, 03 Sep 2021 07:33:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.14.156])
        by smtp.gmail.com with ESMTPSA id c23sm3797080qkk.50.2021.09.03.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:33:16 -0700 (PDT)
Message-ID: <6132322c.1c69fb81.451d0.b741@mx.google.com>
Date:   Fri, 03 Sep 2021 07:33:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5856723213431456484=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [Bluez] shared/shell: don't allow completion fallback
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210903140118.3469656-1-alainm@chromium.org>
References: <20210903140118.3469656-1-alainm@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5856723213431456484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=541783

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      40.85 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.13 seconds
Build - Make                  PASS      177.53 seconds
Make Check                    PASS      8.82 seconds
Make Distcheck                PASS      211.31 seconds
Build w/ext ELL - Configure   PASS      7.27 seconds
Build w/ext ELL - Make        PASS      169.16 seconds

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


--===============5856723213431456484==--
