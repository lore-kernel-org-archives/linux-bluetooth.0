Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4931C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D44C60F58
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbhHEB0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbhHEB0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5CC061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 18:26:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l19so5741736pjz.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=R17E5D305O7QgYpjR6W62lEN77hzjcW+hMOuQg8QJUw=;
        b=rBuXyuqr4YL8SRTnF/X2JJff72VzEG++1GYCHCmYYsoSlY1tiyWHfQOOz7/hOob1kt
         wBMe736vw+FoSmZwXE+vaXXIVtpe+0c7mVkTP3I2TJg/M+kAa6QQ9l7N8bL6eRTTgl+n
         2N2ZUgsYZ4Mo5QEePb+dcvo7yW3zFCW9nVs3fC0bRyE4FXS/xcRtYYJZZ/OecDIlkNUa
         v2r/KvKWW6/4CjCrOMIIL/C+MK9gk9T/uZmak99QgmFI+CYJ+jdRCLoCBuPZK8wqZ8hh
         Kp6zJBuWW78tcQ54tjuByeHi4Z1QSLkVgcP3qZ4TPXZuj0iwwCNqThL5I1K1GZ+1HUAS
         Bprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=R17E5D305O7QgYpjR6W62lEN77hzjcW+hMOuQg8QJUw=;
        b=pBjpH75eKMx/WINPd+DoBZX9nuzq6NcGXH4y4OfznD+iL23hyXmEYB7dQDUY+K5x4Z
         df76msp0AMYk+eeRvyWZIYPKlNdY8b/Lxsd1yyeTbvrEWhizG9V4O0gr73+u2YglXSCi
         0tOH37qVu+1GGkGUeCYNabeoY4OwgGUZ59ZJw3OKiewzVrMNovSp+RedNwn5O+WXLndG
         b03Bw/mTWFoh2GNKV4Vb+qd+NH9aQW5wx1YCbeP38ZcfGgi8dTt2WMKMDqmiV7IOPJy2
         Uh7XL39jZRHGiAnUIgJO0Lcig1ApN0/xXYcrl1CHvGB439uztYc9FQSpa+2z4EpQF5/t
         j3vg==
X-Gm-Message-State: AOAM532VVzNuy2Z1/7IkE9InBVcVraiYlIgzSVWmvOD/hzhHXzJa9iHx
        0dVWJ3b0+rHJ5m6vcm1jvms2qPo6KEA=
X-Google-Smtp-Source: ABdhPJyGOqYd/dyLOQyc/+yYyeBtOYsMtR+0Nv2yiJKso4v4TA5HvnkHo5OyU9eqcSL7et1THDaysw==
X-Received: by 2002:a17:90b:ec5:: with SMTP id gz5mr1903782pjb.77.1628126785646;
        Wed, 04 Aug 2021 18:26:25 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.88.198])
        by smtp.gmail.com with ESMTPSA id v31sm4678462pgl.49.2021.08.04.18.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:26:25 -0700 (PDT)
Message-ID: <610b3e41.1c69fb81.9fb5f.ee0b@mx.google.com>
Date:   Wed, 04 Aug 2021 18:26:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4310985092097953771=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Add proper handling for own_address_type 0x03
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210804234858.345329-1-luiz.dentz@gmail.com>
References: <20210804234858.345329-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4310985092097953771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=526609

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      45.58 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      7.95 seconds
Build - Make                  PASS      202.00 seconds
Make Check                    PASS      9.33 seconds
Make Distcheck                PASS      240.65 seconds
Build w/ext ELL - Configure   PASS      8.38 seconds
Build w/ext ELL - Make        PASS      193.00 seconds

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


--===============4310985092097953771==--
