Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B05C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 11:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiI3Lc5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiI3LcQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 07:32:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5625212
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 04:24:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c198so3970941pfc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=7Va8jCvoDficCnQRdPC3K8+s4+XcpHMiAY9eHzkkwwI=;
        b=lsqLxvGveY6sjP8fFgVikD3N0Sbz52jd322XjGi8/N11dyxQu6I+CTgJO2Ulo+JJyO
         3mreue6MP2X9h4xi3/I5LtJqGhY/R8VB4CzqhBuh44suvTE3nkZRSJ5kvx3S4ieM82oh
         LUxqcgeJdv2J69oAa5YMdAz+vNo/81bw4ZjdFjosKkPl4/YN5UDQPy2/OsG1WfqrcUAd
         dA7+mglnUt7B3OAoK+uK0ZHIhM6FSrnoZsFtcqrVZGdOz2qg5Pf6BlmEpJbb0l2KaquS
         qS6KKEORNkhoWV2Yj0mEHui9IY2mUWHgSOd5hjoP1PXYNxkrUxpHRSTXj2/ktxSUy3Zz
         ZerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7Va8jCvoDficCnQRdPC3K8+s4+XcpHMiAY9eHzkkwwI=;
        b=ACk595NPC3+aiH7kjVjDJ25NrDiewy3o/kSd7YmkTakrXUdEaox21obi0LbiAkMgcH
         Wiekhw1jZkChmwCUQ4zVrEFbgnAPvn6u02UqoyYZKDkURkcs7hjhZGE/cbKSPL4+lHK8
         j1YqjRSJ5kh2Q7TZw2pfFASr4qEothkMiJPy9C5ZEDV0OSh8tc9AqOD5CUO+p0bcPzD1
         MZcr34gHoF9zXX6I2Z5UGh77bAmLT4G2MYzOfAhk8HjCKSMOqxBEKQJ084SilwIbzHMv
         NsSSaji//yUNDCsdIoDe2TEVd/bli7oR59PY0m/XCX9aLodo93DTajltVKF3JkBSrcUm
         lGSQ==
X-Gm-Message-State: ACrzQf2R4QQgXFYaDcDR8ZAaTuSB5nBvvhXiKsh699+KBBgZYB1t018G
        Bq7JSCoix29d6jamt57Rt7dpABnAq+U=
X-Google-Smtp-Source: AMsMyM636+atG0pOsUhe3Ibbca5HGfleKFyApTEAEVRjhI2XwTz8rwbI/LHE9EanRaphheT/fbBXNw==
X-Received: by 2002:a05:6a00:b96:b0:55b:1054:865c with SMTP id g22-20020a056a000b9600b0055b1054865cmr5929963pfj.74.1664537046370;
        Fri, 30 Sep 2022 04:24:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.40.34])
        by smtp.gmail.com with ESMTPSA id v1-20020a626101000000b00543a098a6ffsm1485601pfb.212.2022.09.30.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:24:05 -0700 (PDT)
Message-ID: <6336d1d5.620a0220.8f30d.2aa8@mx.google.com>
Date:   Fri, 30 Sep 2022 04:24:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0765634973306130791=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [1/3] audio/transport: seprate a2dp and bap transport to update volume
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220930184954.108937-1-sathish.narasimman@intel.com>
References: <20220930184954.108937-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0765634973306130791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682195

---Test result---

Test Summary:
CheckPatch                    PASS      2.50 seconds
GitLint                       PASS      1.47 seconds
Prep - Setup ELL              PASS      32.20 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      10.32 seconds
Build - Make                  PASS      994.72 seconds
Make Check                    PASS      12.20 seconds
Make Check w/Valgrind         PASS      350.89 seconds
Make Distcheck                PASS      294.93 seconds
Build w/ext ELL - Configure   PASS      10.43 seconds
Build w/ext ELL - Make        PASS      102.87 seconds
Incremental Build w/ patches  PASS      364.73 seconds
Scan Build                    PASS      673.99 seconds



---
Regards,
Linux Bluetooth


--===============0765634973306130791==--
