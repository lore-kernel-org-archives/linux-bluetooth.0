Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D49C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07406613BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbhGOKn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jul 2021 06:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbhGOKn5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jul 2021 06:43:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF4C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 03:41:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so3831619pju.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ggke8uTYAX9w1k4fraDwg3l/BhnI+eZKS0bKRSJZILk=;
        b=Wp25N6sITpgLEgp/QpMHMmgjO8xbHxi2hgu0RkXJ59mo9Q5XwTF6DOC3kb1VN9RH8r
         rhdm1fsLDOeZ3s2FzjZ+qBjnPDgmdAXOwaEat85ewApr4SGfrDr+6RfQ2qqLBb6vWNgE
         ES2zH1hWWFVCF0Qtrx9Onr5UnEcS6LYB/KoZFVu1tlmrMxUwdlUXieY1FJaVfusTagBU
         SeJfm7kOUZ0FM6yY2xgZwDHocgU0C/n+KEIY/w7MMLqI1ki6MH+l9JP8s5fs5iVE4uVH
         teuWBqsKsyCOWwKrwTT+knBH+Ss8XsyBpN5A1oJ6e1GFFo5chB6E1iCixnXHsobS0rc8
         pjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ggke8uTYAX9w1k4fraDwg3l/BhnI+eZKS0bKRSJZILk=;
        b=POn+pwDSI+py9agey9cGZmQoiusu9bucBJxNbjIUq8H4/yq7ocjquYLtFUAYA0Htuj
         ufSVO42C8nsJ3xKzFY/XlCCq9PcgWwe8i1jE1abv+CrXnllN6I2sJSglCan20DwMprrW
         d9PbfLECg/8O8ctC5dpfmtcWFkAnClV/tcd/91xYdKVnrvKTi9X1D8E7ZuuB+6o5AnVp
         oWwyYLv7UQLMSgGxP3Gb6NG+Is8kcdZCdirmhpq59dzSfxD0HMexOkZ83gs/Fmid0Wdf
         4Egl+s2r/it/IDXp6HQJiW+bLze+acInnYBes/ZwkNlo0zSmT1zX0BddA63w32Uuhgi9
         s56w==
X-Gm-Message-State: AOAM533/zrb9xo98c759xxHeMzh7fz1dY+ipPCRSxrJZw/NzAWQJYeBp
        18zilPITfY2I6nIneeJPGOkNkdrE4gw=
X-Google-Smtp-Source: ABdhPJz6QBnpdHV8FAqn6UdmxsEmW1iNINyBgjcWJi20Ntcl2YVEuKujg3RLUlhATI8mH7u8QlMAcA==
X-Received: by 2002:a17:90b:3b4c:: with SMTP id ot12mr3748719pjb.218.1626345663643;
        Thu, 15 Jul 2021 03:41:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.250.180])
        by smtp.gmail.com with ESMTPSA id k8sm6712266pgr.91.2021.07.15.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 03:41:03 -0700 (PDT)
Message-ID: <60f010bf.1c69fb81.6775f.4720@mx.google.com>
Date:   Thu, 15 Jul 2021 03:41:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2358319315232691060=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v6,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2358319315232691060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=516039

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.37 seconds
Prep - Setup ELL              PASS      47.86 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      211.38 seconds
Make Check                    PASS      9.48 seconds
Make Distcheck                PASS      249.82 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      206.23 seconds

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


--===============2358319315232691060==--
