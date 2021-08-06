Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBB8611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 09:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbhHFJ6p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhHFJ6o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 05:58:44 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7BFC061798
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 02:58:28 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 3so4569121qvd.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jtHDdd+NsBMfvt5HBw3bPAka0BWHafQxBNRVlPPmYZE=;
        b=EQwsahoazSheL6zcbFnV5zyRXC5I2RYtHhxggOeROu91R7W35Ti7MJU4HtcwoQeH0C
         YuUPLxIFlDZt7kDy5I1aRJNA2L/jpxBp6tT6z54CS5TYUg5TIOQucGYBVqDpufg1TLSj
         bdAHAa8xe1gCWrAVZGTfaVuAvS2+NMftzGG0lSrdUX0oCatIRPiEpLwilqV4eLcd/Onx
         ajmYexztJYdgOgj3QfU/fBjc+3vS0uAoOuTls51WDzjoIh1AvgjrwFQ07HtmLjkSXReN
         vmcjsUxgtFiwuRj+V7Mh0jX90SWJCuaQeV9ClgmWiuoMcKa22qdvVZf1TUZsDvrY4VNU
         KYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jtHDdd+NsBMfvt5HBw3bPAka0BWHafQxBNRVlPPmYZE=;
        b=sGtq+fs0Nm/nvSBcvnaQltC8tdXa6sBEnZmt3eX8RvR2ew9IQdfnHdNGLZxcefk+15
         eMyxBC0lcTLLZr8cn2UUED7vmu0BiXHvNoJWyjUlb/pb/juO+rLzfDOzs6CDYRdO3YbU
         zpFk9qpzb2izWHzTq7/8Euyhstzxl0Q94BCoN1SrMSQbU3oSwFyS50KilJPmr2ElGCbu
         OEd2jWZB3MDAM8BOPouqTif7a004Ph7iyTx/gSN4L7AckFYuDqM9hf/5Bq1jDS97NGVR
         zBhhdIdoAbpLMVAsNZac7VXbBPC9z/V3XBu/rkT/2amJMKV318+76vvmQtErWriVWjff
         LwHA==
X-Gm-Message-State: AOAM532cf9pc6N8aBu15oHuVAESMxl4PRDmff8BGZjyhtVSMmh27RwU2
        fOUttfjvLkbELK/kU0Tf8gHCLVScFuLcyQ==
X-Google-Smtp-Source: ABdhPJxf+NgaYzsyQ9kEQJ65ze7RUKeCd0nVAVLNMssBDKOdg7fMtXSOJAzkvvXsri586nCtRdI5Ig==
X-Received: by 2002:ad4:5c4a:: with SMTP id a10mr9955914qva.59.1628243907342;
        Fri, 06 Aug 2021 02:58:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.72.114.166])
        by smtp.gmail.com with ESMTPSA id n190sm2233634qke.134.2021.08.06.02.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:58:27 -0700 (PDT)
Message-ID: <610d07c3.1c69fb81.1acd0.f4e3@mx.google.com>
Date:   Fri, 06 Aug 2021 02:58:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8896097633631934174=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v1,1/3] shared/shell: fix missing stdbool in shell.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
References: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8896097633631934174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=527443

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.35 seconds
Prep - Setup ELL              PASS      44.67 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      7.81 seconds
Build - Make                  PASS      195.12 seconds
Make Check                    PASS      9.19 seconds
Make Distcheck                PASS      229.33 seconds
Build w/ext ELL - Configure   PASS      7.78 seconds
Build w/ext ELL - Make        PASS      176.58 seconds

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


--===============8896097633631934174==--
