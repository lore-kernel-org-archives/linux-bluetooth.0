Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70CC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB466613CA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEUGvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 02:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhEUGv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 02:51:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:50:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ez19so9915201qvb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Iof2D8Q/X8WDqPBMVCydYyDuo75s/Y/DiqHyVi7eTeE=;
        b=WXpdMuIwyR1aYGcdrrDIcR8KGtTAwz7+/WQur79fJ19yok0/c2Yt2mcEmPGXnNQmJN
         2ngUponoYsepRLMeZtahxBZ3alE898z/9D1aHimWDtfZjZGddV5ez+frmDTu2V5gJtDu
         2R4wzCvMROvivpfPxocBBAzP5uLkXX3AA0Bcgi02hdhPcR81dAFAxQUbX2fZjL75vhTV
         Xvj5GR61D5ddR77uSyE1yePGI23wKtmdN961GVlN5MUUME10wJm2+r/t4T66EvdCrgRt
         UKlCPXHwJDbNuXG1ASTeuOD2Hft1vaGG8k+X1cNBfvo/gTQIXKitaXylUPzD1fHACBKk
         +bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Iof2D8Q/X8WDqPBMVCydYyDuo75s/Y/DiqHyVi7eTeE=;
        b=s/pbN08oGxOwmPDChA1JwiV7W2n3BuFQiX/EX8bzPocire7Sw2p3x1bvRhIYGRedss
         5cQC5FG0sHWYMkE3x7NNG5PKqRc/OFxiGWgkKmV6KSG9bTg+sFRXCw5RkAwtt85h6G2U
         M5Zy/T+vfNGPg4vB7qXQmf6bimx/UUhpb2afJc1MzpPAADgZyWUtJ8P04kEQB6NEe8GW
         OuQ8AiYkqyzjxxS+S5haElEqB8V+xTGMUlKXFMIQSY9EfoGxw9qASvFAFEO7+ZscWvrF
         zwy7kVJQ2v1lmYYe9IYB41Jtq4/21WrcxF8lzDXlQrqYwELIB+xx8PvAN11hVkJefFCd
         LUIw==
X-Gm-Message-State: AOAM530TlsUlxzOE6e2GYn9auMAZgiMHMDo43jKEpOskz0mCStS3ZKZZ
        fEVriMjYE+3GYlxr5QU1fy2xgyvuAKk=
X-Google-Smtp-Source: ABdhPJwVzzysvZgtBGAd1ionFKNPrzyidiyireMJG/KvgBAjkfXdG53wRl9bKYci2Erc7jwxDnYxow==
X-Received: by 2002:a0c:d80a:: with SMTP id h10mr10998186qvj.25.1621579805296;
        Thu, 20 May 2021 23:50:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.192.81])
        by smtp.gmail.com with ESMTPSA id r62sm4254459qkc.128.2021.05.20.23.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:50:04 -0700 (PDT)
Message-ID: <60a7581c.1c69fb81.b194f.b789@mx.google.com>
Date:   Thu, 20 May 2021 23:50:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2053177601905678215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/2] tools/mgmt-tester: Add test cases for set device id command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210521062441.155117-1-hj.tedd.an@gmail.com>
References: <20210521062441.155117-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2053177601905678215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=486249

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      40.17 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.08 seconds
Build - Make                  PASS      172.77 seconds
Make Check                    PASS      9.30 seconds
Make Distcheck                PASS      203.34 seconds
Build w/ext ELL - Configure   PASS      7.13 seconds
Build w/ext ELL - Make        PASS      162.09 seconds

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


--===============2053177601905678215==--
