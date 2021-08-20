Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EC860F4A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhHTFgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhHTFgs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 01:36:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B403C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:36:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u15so5294094plg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XkN1ypgWAuzbmmlBxIXlHeqqpIbwY08qzBg5zs/naLo=;
        b=igzNU+oBL92UL0YXQXgzcEjfdsBB47YJfaSTXuhXNpb2CEwuThw9GT+qyr4fZRnYq0
         r4lNmDt3pQCfZvmP6xNl4xumQ/qEhS6M03g7Vld0gvzJ68uEHoBmSZac7jSAJNoJ6MJM
         F0wmSh43db+x2vFNudZNYTlyb8+CDElZUJSrFAtXDoEOTN5JP1QJ+XRMQIp9ChlsbuBq
         ItpH7RYnooNVkhRNgYX3SKXTr0l8XeKGeBAUJ3iqL7noSIJ2q6QT09DUU5braL2UBjd0
         FjQfVWhet1jhag8IpGJS7PzDazmgkWm+RKQP/AjuP911oY1EVymjby093O9tXEkMD2Ng
         a1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XkN1ypgWAuzbmmlBxIXlHeqqpIbwY08qzBg5zs/naLo=;
        b=mmRGD39say19fFkcowl0WCSa1Gv+UtwgqVT3j1QtsScCxPLlffV1qL8pHPZyX2r1hx
         rhwAHkoyyiMOixfFkTnQjovkO4XRb9Dr8v2pb54PCFXYGw3huMnw6i7ogf6cez3M7UyJ
         jkFQonLx820X2nKTRL33vhUI/IFzw7HJyM5lDdSOHL6b7rofemziErAfykwI6Jyy/WxL
         W6ea9/QrguIyokePw4RY9tvSWJUBlnQNbIA3L0ekjX6y7fhUSItUKAXNI8OSnehUS4Id
         L/gq0LbhTOeUcMWXK+qzTrUOiyNcsHk2BLjCip41hGoL3Mbsqu2WiJaaT1ltuZi655kd
         nSSQ==
X-Gm-Message-State: AOAM5306d7Tke1rrErBCN+VpWSgdX3EzqYLk7DnczozSi+vPcvg0Q60N
        DfAKxWPWB4Eb7ZLaiyLUfov+qV+yTW0=
X-Google-Smtp-Source: ABdhPJyCGh+kLIY+7O/hrv24+UX7l1O7/UWz4YNkp/dUh4P+NfcN0cFF1FCl5itNite2Oew6egISFA==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr2833155pjb.218.1629437770408;
        Thu, 19 Aug 2021 22:36:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.10.166])
        by smtp.gmail.com with ESMTPSA id u24sm5827947pfm.81.2021.08.19.22.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:36:10 -0700 (PDT)
Message-ID: <611f3f4a.1c69fb81.5e87b.392f@mx.google.com>
Date:   Thu, 19 Aug 2021 22:36:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3043788472588274830=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v1] tools/mgmt-tester: add a exp feature to Read Exp Feature - Success
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210820131751.BlueZ.v1.1.I165b6fc2b20d80c8d18946434005f0269d92f489@changeid>
References: <20210820131751.BlueZ.v1.1.I165b6fc2b20d80c8d18946434005f0269d92f489@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3043788472588274830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=534647

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      49.11 seconds
Build - Prep                  PASS      0.16 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      216.81 seconds
Make Check                    PASS      9.11 seconds
Make Distcheck                PASS      251.16 seconds
Build w/ext ELL - Configure   PASS      8.44 seconds
Build w/ext ELL - Make        PASS      201.38 seconds

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


--===============3043788472588274830==--
