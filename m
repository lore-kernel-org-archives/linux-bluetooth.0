Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDBC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiHEVGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbiHEVGp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 17:06:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD511DA4E
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 14:06:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a2so2775770qkk.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=iG2WdFT6YcXfj3SASKrF7N4A9J4gA/hcmTx1buk7TdY=;
        b=MyMtAX3INJJcyVNQ9f4jyZralq/dF/2DyPrweXZL0wRKHZalag9RGivpqIZ0V7v3Qs
         Dh+foP/nUGbRWJizUA5y3CCg/yISti27XX8+zxDHrF1PPJJRkA6uZQeZCDgLaMM6suQx
         J78OEwezjciGECf/PeCaa4YTOpNUZGr00wNkSnPQdIhPQTp4cyL4Ui0+SxAm+e74VVYI
         oqSxkTmYpHW3lPZGz3AcUAreFc5PJlXEpkHsT2flkCSBaIWM5UcMDAWZG24X1f7wxarW
         R3hQ1Ip044Ib8vCT5e+F0a+PWmj4CFJ2fJ/nh/6aaDFKwhBt5dt8yBi1t6k0v7fgCojp
         JkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=iG2WdFT6YcXfj3SASKrF7N4A9J4gA/hcmTx1buk7TdY=;
        b=B+E8bL/a8Pnp6jBnnYIZs/BJNu7MQptagrVgmU0pZkR7V+QZDnE/5yx6KCkJLHi5o+
         zI279sHzNieDUiHW/o84PNUSUrhCXenJiY3ko8Asoders4KCS5XDt/XXLhx8iFGTpKSd
         klSnhLLDN3BKYyCLoPpHxGHqd+4LvNeeiiZEzJnJt2yYrxXL9Boy8kGSDYQA/RgMdwoR
         gXjZkPXQIbrc/gRJBrUj/ky0K8Th+cwb7wmevkfz1ryB9o8rg06RVj/qcUVFwy625+V+
         f/TnndFyuheW28ShACqATFdnpPTv0XHk98sgUaczrGtt09nbug7FTpr9tZGho5xaff0l
         vq5w==
X-Gm-Message-State: ACgBeo2kp9xLg2wF5Jc5SQoAMz6ZrVPmQZcamxm2FGGmQNBCkfpM1XNe
        ysoztekRvO3fy62UvXN1x1Eaf4UyRyg=
X-Google-Smtp-Source: AA6agR5l8OmQhL1c29oDf6Jpffn++VoTQqf1yQ+fcRjGmr7nKr4iYNaQFFFjpl5yJX06osrk/pTXxA==
X-Received: by 2002:a05:620a:48a:b0:6b9:1b5a:24f2 with SMTP id 10-20020a05620a048a00b006b91b5a24f2mr3056541qkr.659.1659733603887;
        Fri, 05 Aug 2022 14:06:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.23.234])
        by smtp.gmail.com with ESMTPSA id x206-20020a3763d7000000b006b5c87e9eb1sm3360688qkb.102.2022.08.05.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:06:43 -0700 (PDT)
Message-ID: <62ed8663.370a0220.f1e10.b8b0@mx.google.com>
Date:   Fri, 05 Aug 2022 14:06:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6082484175010483036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/tester: Add tester_setup_io
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220805201034.3838529-1-luiz.dentz@gmail.com>
References: <20220805201034.3838529-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6082484175010483036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665746

---Test result---

Test Summary:
CheckPatch                    PASS      3.05 seconds
GitLint                       PASS      2.09 seconds
Prep - Setup ELL              PASS      26.88 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      8.52 seconds
Build - Make                  PASS      828.07 seconds
Make Check                    PASS      11.48 seconds
Make Check w/Valgrind         PASS      284.37 seconds
Make Distcheck                PASS      233.57 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      81.50 seconds
Incremental Build w/ patches  PASS      194.17 seconds
Scan Build                    PASS      581.41 seconds



---
Regards,
Linux Bluetooth


--===============6082484175010483036==--
