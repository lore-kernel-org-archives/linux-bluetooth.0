Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 18:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJGSWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJGSWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 14:22:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C00CC823
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 11:22:27 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id z18so3584408qvn.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WKg8kUu8JohHZhhng965BezTk4FHw4vmT0pTenT9QOc=;
        b=Ac27sErSaXibWBXbw0nHXFPC/NkeS9m/G9zv7ENDnb9rzcp4KzxYln/Hu3uNhIvxFn
         mbTFkLc2s5hjW3/IoBYzo1QFwcGYY7XR8ofAPjeQp7GObQ1x9sXVkwetFttd4utdJg+Z
         P+GG7ZAowfd0zp8+RpeJ/xRaQjBqfXHHMMvGO3Ar5LSlzWuLhmVfA4KVFiGi0KFrLR4K
         1La3Gfa7Z18/CKZvyQRaRp/wCl5e/BigqCCMoDhvFtpSM76gT7OqZ9eWY+02r5t5aSwF
         RC7lBqPDEpR6QdYXPF6u7cH/LsY2pKv1+kk7PmN3EsUvboiQa28tDwEkVzyE/7f/iGRs
         0jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKg8kUu8JohHZhhng965BezTk4FHw4vmT0pTenT9QOc=;
        b=nmqGkUKcy5ZjnaGZtkiYCOYKVcP57nEHEvpuJ/KDJhayqz8mctzCOrIxQMaWJxpRnM
         oYwE+oAgvhdrkRCUPlgg/84M/viZ9hhb3hvJC9J3XmvJhL7dUof/ENVyXYJE53ml70Wg
         RWS3tskOPWGtvVG3kPGfaWuoereEVOjb1XBcRINeuGog1gRuzzb4TFTDzfXFZhZuASS9
         9RFPnJOgMzZ5kdOFxCytdQccdGO9y8u5LDm0p0zC3erimrObDqRRCu8MlQ+t2rMMk5ia
         zQ68MvBCtgQQXTtgzLZX0ksfg0v/ezkvTmQ8SwQFYxB1HoXoKzYoEtIo5mTzVvZhKh9r
         W+Sg==
X-Gm-Message-State: ACrzQf2y5BenhJUjXMZiEK3skURhwlEjFfb09gGOMw85lImhzXMwAZO9
        y9PkdCbtEF94806X2vE//+X9PNCdPxA=
X-Google-Smtp-Source: AMsMyM6S/GVb8XkxTOVy0+LmtWvdkkW7zKrhmPHcwuwBZQ0aXC9h5Cc5csh8gAFXxn5Js2+Kp59aPQ==
X-Received: by 2002:ad4:5bc5:0:b0:4af:b21d:2ad7 with SMTP id t5-20020ad45bc5000000b004afb21d2ad7mr5214066qvt.112.1665166945955;
        Fri, 07 Oct 2022 11:22:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.14.128.76])
        by smtp.gmail.com with ESMTPSA id bs38-20020a05620a472600b006b615cd8c13sm2650750qkb.106.2022.10.07.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 11:22:25 -0700 (PDT)
Message-ID: <63406e61.050a0220.316d7.5e10@mx.google.com>
Date:   Fri, 07 Oct 2022 11:22:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2191053889535834479=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: [BlueZ,v2,1/1] shared/bap: Fixing memory overwrite during ASE Enable Operation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
References: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2191053889535834479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683769

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              FAIL      22.29 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      8.60 seconds
Build - Make                  PASS      829.16 seconds
Make Check                    PASS      11.32 seconds
Make Check w/Valgrind         PASS      290.40 seconds
Make Distcheck                PASS      235.65 seconds
Build w/ext ELL - Configure   FAIL      5.82 seconds
Build w/ext ELL - Make        SKIPPED   0.38 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      534.74 seconds

Details
##############################
Test: Prep - Setup ELL - FAIL
Desc: Clone, build, and install ELL
Output:
writing RSA key
writing RSA key
writing RSA key
writing RSA key
writing RSA key
make[1]: *** [Makefile:3276: unit/cert-intca.pem] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1264: all] Error 2


##############################
Test: Build w/ext ELL - Configure - FAIL
Desc: Configure BlueZ source with '--enable-external-ell' configuration
Output:
configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
configure: error: Embedded Linux library >= 0.39 is required


##############################
Test: Build w/ext ELL - Make - SKIPPED
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
build_extell test did not pass



---
Regards,
Linux Bluetooth


--===============2191053889535834479==--
