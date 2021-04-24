Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68138C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Apr 2021 01:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BCE60C40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Apr 2021 01:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhDXBdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDXBdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 21:33:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0FC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 18:33:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u11so20330954pjr.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ah5L09Q4gO1MG89th7cxRY2x0piaPlXiQDtc5df/+20=;
        b=kguaC2eQOkCea/jHePmf/Crn9h8Vx4i3vzYcnKBpKUdtkMrHnhwCSOKIsfoTItn0fb
         H6bjo8ScDHMsDKQm5twQ18z68cghHlBFZNqEDbR64+flKhi8eutRHvvDlKVNUB6Hjw8H
         aWpymObV72uF3zb7PxJVokaU5dVejWdRSkwUao242//JmpFnQp1QeZFNcj5DlHn20D24
         i85Q4/D2ZezZV5Q3isdU2BETJpvd3ZwlVuA+k+whkRu0Iw645d8YMCyClSMJ/ZX/rFrV
         YccAm5ek5mD+i2gAzniwqaTKoWprAYCMivQe2NKyl4gp/xXEjuwkinX7byg+FLHdC8O3
         n8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ah5L09Q4gO1MG89th7cxRY2x0piaPlXiQDtc5df/+20=;
        b=agx5dGrsiEMEUbcGe74XP3tvQMSP66Z+BYcf7bTJhmSLllkt09DvsnoBDoT32nfiy5
         FkCmEysSjisTIXF3x35jNkHbRDciXbNcxWfspktocxX0wwiTXtgkn0PJrbWmUESQ/3S1
         Y0Mx4Gr3Y+P/xsAE5mE6H9HfjE5u4ELRI6vkzPciMCm0vhlm8UVmrM3KkHE68RUkMVrD
         tDWL2Ix8YETq5HAIirfGl+WrfRQ7emrIPNL3U7xy78GRChRDe2aobHAutJzbKAp7a8H4
         upCmYKuc3ndoBfOVAncOco9EaiT0033KkV4jHwqTtlusk+EFVlvcwi6+C49v1h6htFkt
         hPeQ==
X-Gm-Message-State: AOAM530kubf8uT0EqwsilJfs2IPV3McFYeLH2rYYsAo8SWJIecRK6esi
        9kRLlEWl+RaomjyPLTJ7kjcVCVWSdsE=
X-Google-Smtp-Source: ABdhPJzlVZmJwI7ekveVaK0UyIS6vDTqUTDAEuP/qAVDdk7Z1jSJmOGMVSnuUUj1GXNbcYnlptqNJQ==
X-Received: by 2002:a17:902:ff09:b029:eb:3d5a:1332 with SMTP id f9-20020a170902ff09b02900eb3d5a1332mr6814177plj.24.1619227986051;
        Fri, 23 Apr 2021 18:33:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.51.113])
        by smtp.gmail.com with ESMTPSA id z1sm5838012pgz.94.2021.04.23.18.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 18:33:05 -0700 (PDT)
Message-ID: <60837551.1c69fb81.fa8bb.23d7@mx.google.com>
Date:   Fri, 23 Apr 2021 18:33:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5218753894364825439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] emulator/btdev: Add missing commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210423235352.33965-1-hj.tedd.an@gmail.com>
References: <20210423235352.33965-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5218753894364825439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=472555

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.34 seconds
Prep - Setup ELL              PASS      47.31 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.24 seconds
Build - Make                  PASS      201.85 seconds
Make Check                    PASS      8.79 seconds
Make Dist                     PASS      11.57 seconds
Make Dist - Configure         PASS      5.02 seconds
Make Dist - Make              PASS      82.43 seconds
Build w/ext ELL - Configure   PASS      8.09 seconds
Build w/ext ELL - Make        PASS      188.41 seconds

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


--===============5218753894364825439==--
