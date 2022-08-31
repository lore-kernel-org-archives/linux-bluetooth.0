Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F97ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiHaXCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHaXCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:02:16 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8027DB7CC
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:02:15 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e195so7265573iof.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Y02qLveqK7jK7rAFnM3BtpUSNP/llb7xJuNhVvUmCeA=;
        b=Cvj94qnpD/3nNYnCyJ6DYySvKY3j3Dk9NvoBiIK6iPOZjy2jVueJN6W17iqUnsw2/h
         t8b4nW7zrU6B2IM6pcvzxP30zEbbreYe54PhQnV3Iz66vfQZNdW/H5uXHbYUb63ZDAiJ
         NunqGDkoIFvtllvRVZIvzepU6dTMQDbVsmlaAqIpXA4BkU7bwOQpHbCpE8oYupx/meWZ
         /AXehM0OM6ts6gUfg/KoR1sskFh2ZwbVNmer0ZVI4a0Z01mSBC2l9mfao5DgY7CR9q7y
         8TMLYTK5Zb1LuvBERpz3Yeiq/bWf0u5u9k+mxPF48suAMVGnjnMSQ+rT4rfzCekmvGiT
         BGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Y02qLveqK7jK7rAFnM3BtpUSNP/llb7xJuNhVvUmCeA=;
        b=TGJHz/ON0GUHj63FfiyXrUXeoXMmNx597BlzqnJK/fGxOi2S0Nc+uAq8IX8+Dj5Wi+
         i6uYlJGQW5ommVU+fO0EwNrNoEOEMHGsrIB8fFXuuUqeMosMVOz+MVPDfHufzYjoNLdA
         f4t1vvfk0jf6WHWXx+5rNNzslSmyBc2O5Zsof6DOl3Z3ovXOK4ujqzEac2hHE7VEeOsM
         xkvE1liUjTU02Xk6rd3nx4MP2ZQQJf3WV0jh38akXzZKN5Dk/gS1CeCkGVtd8h4Mbq6h
         lCkKh81/9emxnOEpWNswZr0DfSDqOAmYvkgfzT3jJM/PB+43m6rQHsVYa3rRJ4mhYXwz
         GD/A==
X-Gm-Message-State: ACgBeo1k7bG9JLli7HbCDFt7WkesljyFgUe+MWfBAR5mICHEfZ9KBScw
        8PrFZbMKrbM+nw2gG159FZo9id1+Cwo=
X-Google-Smtp-Source: AA6agR42MKRtEldhJRWo9NEvawUK7qWbN/yKjg2SOe3lc6KvABoUEQw/QgvdEzliXn5RNZjHPBwbWA==
X-Received: by 2002:a6b:3f88:0:b0:689:c144:328a with SMTP id m130-20020a6b3f88000000b00689c144328amr13526708ioa.63.1661986935118;
        Wed, 31 Aug 2022 16:02:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.15.91])
        by smtp.gmail.com with ESMTPSA id q2-20020a056e02106200b002eaddcf4c75sm5084845ilj.47.2022.08.31.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:02:14 -0700 (PDT)
Message-ID: <630fe876.050a0220.2bc9a.5920@mx.google.com>
Date:   Wed, 31 Aug 2022 16:02:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6424664747178011981=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,V3] media: Fix scan-build warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831222453.1369940-1-luiz.dentz@gmail.com>
References: <20220831222453.1369940-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6424664747178011981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672985

---Test result---

Test Summary:
CheckPatch                    FAIL      1.14 seconds
GitLint                       PASS      0.81 seconds
Prep - Setup ELL              PASS      26.34 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.23 seconds
Build - Make                  PASS      741.51 seconds
Make Check                    PASS      11.09 seconds
Make Check w/Valgrind         PASS      287.49 seconds
Make Distcheck                PASS      237.69 seconds
Build w/ext ELL - Configure   PASS      8.25 seconds
Build w/ext ELL - Make        PASS      82.43 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      488.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,V3] media: Fix scan-build warnings
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85: 
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,

/github/workspace/src/12961483.patch total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12961483.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6424664747178011981==--
