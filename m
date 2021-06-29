Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35F8C11F66
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9C861DE0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 08:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhF2Imf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhF2Imf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 04:42:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F47C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 01:40:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso1091736pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0ZJyGgQmz1DHZtaFBNCd/rwaRl+lxfjqE6jaZ98TJao=;
        b=em3QS1VAp0vSu1IvSMU5oSMk7wagKVQsNTzaEAflUhLcuu8Kv0onnI1AvDlyJl05x2
         HmodkKPTWZ3o4bCoiOhh1eOzz2xVlTjc40Suxgxouicmj6FJvhPszC63lGJzwV3iPkIE
         W+F0ov5B+ik4ZRwiMhMDXeEOWYI+E2NWwFd0jeHE5IAczfakkIggXKikFC7et4BHTTJj
         af1IT9Wdll5rkLoUK30fsIwkRQV2kLSAmTZLb8H3hbprPNfIa/nL8OHwvDniEryTFSGw
         KM/2jxB4b7pgLMi/BiYpF1EJWIM5e5A3bvTF2LCEgBhy5wjD5EFwMb4w361zlcroEtvF
         qLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0ZJyGgQmz1DHZtaFBNCd/rwaRl+lxfjqE6jaZ98TJao=;
        b=Kd7MkOBBzA738z4FjGGQlpnN2ie1I05rlR1XWRA/f1OxF5z/kjotqnJxeewNdTDeek
         jizPSDJaGVee5vo5A93szVBDtvd9sDG69t2e6Gvo27ZsWdFt+4FfQxm9Kd9SeGFcfhed
         w66wMVW/sRv62bulaM3wF/oCVU/4YS3QIvEG2A8v6fXeoCfaXimF4rE4Buc98WAx3G9z
         ybbRBQ1W/NW/FVhVBhIZb3mklN8+DliSnbOldlU9lNED5ZMscLj5yrpij4htytTXbehC
         5D9/OTWOtXLButrgfkIMbDDY1gAwZ4AEZ4wSi4TfoHH+UdhPN1grgeAzdkQYPqXJ2XgN
         Dltg==
X-Gm-Message-State: AOAM5304Q8T10PiBSyTv/8KUO3Edsd6UWBizMXYyD7MUIeu201VxPyHx
        HOsTz1Km4qmr4369Op+SVZuUpB+3GFI=
X-Google-Smtp-Source: ABdhPJydSn67dpDnjWrMyWppbK95fsjUtlwdIxGRcKf/TDEDrmukvTlcCDt1rPyoEYu79Nez9/AncQ==
X-Received: by 2002:a17:902:7d8c:b029:105:2b81:3915 with SMTP id a12-20020a1709027d8cb02901052b813915mr27048302plm.71.1624956006950;
        Tue, 29 Jun 2021 01:40:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.195.153])
        by smtp.gmail.com with ESMTPSA id 81sm18052125pgg.85.2021.06.29.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:40:06 -0700 (PDT)
Message-ID: <60dadc66.1c69fb81.4f567.3fe9@mx.google.com>
Date:   Tue, 29 Jun 2021 01:40:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2294208330233726877=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v5,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2294208330233726877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=508413

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      0.41 seconds
Prep - Setup ELL              PASS      48.73 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.66 seconds
Build - Make                  PASS      209.56 seconds
Make Check                    PASS      8.98 seconds
Make Distcheck                PASS      245.71 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      191.35 seconds

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


--===============2294208330233726877==--
