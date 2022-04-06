Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiDFJbx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582682AbiDFJWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 05:22:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D322C1D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 19:54:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id o15so2321320qtv.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d0F0q0VxA4CuqxxoDRxv00y/WTDUFtz6OJ2J1cqjYSs=;
        b=o+j4tK5K2Vx93Y+ntUUA0+34nIdZzTZ/epmwQ7oqnKNYayqRUlH/QRZoSD7qeJ5f/4
         IHCi1X7nEYfsEES443SfR+hrBsUYA0ue3mEQdIGFQm1VoOzaMgL/HLOgAwJbbTZ0QX2h
         AC/Obf5yEEj7nkLAQnb9jlQMyvo9/PRrpcuvtbiXR6nvJ8I15baY6W/0FQv8jPTF3ZEy
         Jo9NXfSj20TFWxK4rOmZJbRyumlLwn23IBSn7kuSCNq4/D/WWDoklLQEra3BL7t9vQF0
         PQJg0hIUCOjOdHSl62VLanWUpKqh/cN/Flx75XlxHOJi9GIBf6uCjNeHdnudeozVNFzs
         ZIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d0F0q0VxA4CuqxxoDRxv00y/WTDUFtz6OJ2J1cqjYSs=;
        b=Ukt1iK41+f4D74B9fja29WX41m0QLoPoB7slVPs/eRUw+Xtt3M3ZGxAk4XzSDjRSBL
         +VB9D9OmMUniGoyRAGi/SVHOrMHTIISJPv9N0d/Fd27CINlpFNg/9/GuvuMHYlozJ15J
         5HZsyXJwa91h+qH2w1K4jlhsbYdiPuu09Rrb5tX5pKywRSvd9tmy+sjf59Ce7gvErw4w
         bM8yTiGEoJKv/VURdUhxf/6fUvgHl9pRpQonfurMN5V1c+FuaTen1AqK0xqUd8xA08fN
         opzMvc8VYXgLwnuPNNpFYqOCo5Q4Ni+6Tn5ySIcP6GWVeR+Zbf/wUfDcz2ByN46+Bk/M
         QsQw==
X-Gm-Message-State: AOAM533r4Q4o63AdWlcfn4smDxU7EDQhYbpn/OqoBuO/dmEz3ITq+7+D
        Aq+YtMaRtf84mfuC9zN6CLjOd1juZo/Cyg==
X-Google-Smtp-Source: ABdhPJz8GtL/F1jQOFNLFgJs3PmSt+nLag/p/M6q7Ypvz262cpsh9kv50pXYU5e1p4wkJqHTAWZGcw==
X-Received: by 2002:a05:620a:414b:b0:67e:2b2c:324c with SMTP id k11-20020a05620a414b00b0067e2b2c324cmr4416707qko.205.1649213676101;
        Tue, 05 Apr 2022 19:54:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.63.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a05620a132a00b0067f926e36b2sm8813050qkj.91.2022.04.05.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 19:54:35 -0700 (PDT)
Message-ID: <624d00eb.1c69fb81.e0504.b7b2@mx.google.com>
Date:   Tue, 05 Apr 2022 19:54:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4090320862309617696=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pelzflorian@pelzflorian.de
Subject: RE: main: Remove unused main.conf option NameResolving
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220405154226.nejyr5twrhsqrzim@pelzflorian.localdomain>
References: <20220405154226.nejyr5twrhsqrzim@pelzflorian.localdomain>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4090320862309617696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629300

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      43.41 seconds
Build - Prep                  PASS      0.73 seconds
Build - Configure             PASS      8.74 seconds
Build - Make                  PASS      1421.17 seconds
Make Check                    PASS      11.57 seconds
Make Check w/Valgrind         PASS      449.08 seconds
Make Distcheck                PASS      235.85 seconds
Build w/ext ELL - Configure   PASS      8.83 seconds
Build w/ext ELL - Make        PASS      1419.89 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
main: Remove unused main.conf option NameResolving
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '826023de56896e83f35ae69a73d6a120a2f5b11e', maybe rebased or not pulled?
#51: 
Commit 826023de56896e83f35ae69a73d6a120a2f5b11e removed the last use

/github/workspace/src/12802245.patch total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12802245.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4090320862309617696==--
