Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52714C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C46109D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhHYRRI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbhHYRRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 13:17:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114CC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 10:16:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g11so48014qtk.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jlEzQiH7/4eyM6TEeWHESnQYJrnZZ9XQKn40rivjlSw=;
        b=ZZxKthW9KjpyCUm9EeJ+uQ2XqitBVgL1CvlMgLml5ZqHM10ZvXLm9d3x3sFJFfvq/C
         L4GznFfpnC6YLC0eYXdModeQA5GUbAvuJ+sxtALdfUfmnKSgWSz9bzEyi396R8ARHIvk
         oLhs9jQV5c36pcu4WZ9DazivEUJaxXZ1tYADXB+kDeEdHAWjc/bREOozdxEsgcJ5QR93
         ytbcAJUd2GlqypPVr034eGof78IgzA58zCn3U89yrX9zeSACyXwXTnPmdi/5Pq6r8pWx
         iNxjPcaNN5ShUdSrqulKPiAyETKnxFc5gxekKQNd2bh5UAnlOipJi0WcjBpNFwyEg4Zz
         zfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jlEzQiH7/4eyM6TEeWHESnQYJrnZZ9XQKn40rivjlSw=;
        b=BFf9T4+pM3r2xeUPECHQApYzV+foxVdHSHxfoY7RxGpQVq3jAMk4h7PtusJHPkxlv8
         9oS8/nxjFTdjSFJSZWLrRDt9iVLWRP+yVxHnpeSZzZGbSLSsdd+S4ppmMtxYM297gew0
         4tv22pI2+oY1BLzBWqFzw/OLhSpqI/Qi6W47d22lFaEW4t8xnT0h87yRkzJDTVRkobPu
         IBDtaIB8y/dfOMTkQ4V3cui7eZp5peIrOuvgqQ7023FzG22z56bMwxFC/Z4JjahZHfcC
         4iwpWfzAO59e+sQW82hvh+mOWuOncj++QAkAS5bz7NffvBRLc6cluTXvh7Yv/5Jx7/BO
         FgTg==
X-Gm-Message-State: AOAM533dR00VbetZ6cyeZEpz/wrm9i+xXsCmYNVt3wHL1aOYpqxOfE4A
        aIHtUvJpPV2ejIMqJjLYehlIrKqyY/axvg==
X-Google-Smtp-Source: ABdhPJwdinzqLKreFlK4WPw88PNY5w8oFMDGfks4nS8OGQ/j+E2aSaOO0VOXyswUG1NsIpyGhUmwDA==
X-Received: by 2002:ac8:46cd:: with SMTP id h13mr39939771qto.369.1629911780236;
        Wed, 25 Aug 2021 10:16:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.11.81])
        by smtp.gmail.com with ESMTPSA id d7sm200755qth.70.2021.08.25.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 10:16:19 -0700 (PDT)
Message-ID: <61267ae3.1c69fb81.12d8d.1c1d@mx.google.com>
Date:   Wed, 25 Aug 2021 10:16:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4754008936390328246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: device: fix advertising data UUIDs ignored when Cache = yes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210825165125.2675544-2-david@lechnology.com>
References: <20210825165125.2675544-2-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4754008936390328246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537283

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      40.13 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  PASS      174.78 seconds
Make Check                    PASS      8.99 seconds
Make Distcheck                PASS      206.59 seconds
Build w/ext ELL - Configure   PASS      7.11 seconds
Build w/ext ELL - Make        PASS      166.73 seconds

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


--===============4754008936390328246==--
