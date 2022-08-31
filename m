Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D9ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 03:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiHaDwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 23:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHaDwB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 23:52:01 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D59AFAF6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 20:51:58 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo19011633fac.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=TbKd6WR24nYD6HG5Nn0ofmUFgo57jM06dSgpaHZ2OWY=;
        b=MXwxFef6w0CWPI6tXYJzKqY3XrQzjC6XMVfTPZrIgMkXqZTEVoBAlJsutIxLwZtDEg
         7TF1yDiIemWi7Muh1uMhycU76A/X3drnyyMEnpjUiViwcwp6Wk9x2JYlN/QjNl0UUAx+
         KAXlO9D3Rxpfi6/3t5jH4lwVq1th5z8hwlWVol9daeRoap25BZTjNXfl/nt1IpQlMK4A
         k55HmFglW0RIX9TBwTssa510L/vqyXeIE84uVuV1+OFX7OIdzDdl0Tlr5zpbFdFqc7o8
         h/SpM+Wv2ST3+se2Pbly7LRoIMBd6PNgcPfk8NawVZJ5ewgFHXvCudF0SpE3VsEuL5CK
         CwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=TbKd6WR24nYD6HG5Nn0ofmUFgo57jM06dSgpaHZ2OWY=;
        b=ZroPYPe+p4HeXix6EHeLiSyJFQ0Q5xAmJi+a9W50s5oUV1g0lHrviscO7g2OzyBsaB
         ADoE2az51N87naT+v3qmLFsJaIRSSLOHMcreLT3LUleht/igIMUHFSUFYsH93pKjb5tW
         RNwGNvJmQpRhza0eU5reWofuUwxrcRJzPARllhAV4Py28v4Bmh9ClszI8QJ7xl7W6r86
         PF6QRb1x+6GnFltlr1Fq0fRTTgLNk8XEIZYNOBq9tjdAnJ7q8flXc+c+KzNlHjTCDSYx
         8P3wYIi9rQFcAhyl2JacdjltLm38x0B6ZmOjeg36tmMMf/QGwSuw+YpF8vkE8Q+WqVzB
         rE8A==
X-Gm-Message-State: ACgBeo0tkW7hnNKpsMzagmW1khEc+RqSs3e9IgzMg+5iJEWKNuPdFLlQ
        nWFTWBMLmsAXb9NJNiyulLTs7FEUNcQ=
X-Google-Smtp-Source: AA6agR5aIxN2tA1qrX7n44USdkHL1Xj6mmQs6xrWzKxwHrR2ZTogGovPPtIXjCHjxoNuWEvq9pa0OA==
X-Received: by 2002:a05:6870:a446:b0:11e:9189:b25d with SMTP id n6-20020a056870a44600b0011e9189b25dmr605818oal.206.1661917917048;
        Tue, 30 Aug 2022 20:51:57 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.131.111])
        by smtp.gmail.com with ESMTPSA id i30-20020a9d4a9e000000b00638ab4c953asm8285553otf.74.2022.08.30.20.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:51:56 -0700 (PDT)
Message-ID: <630edadc.9d0a0220.dca6d.68bc@mx.google.com>
Date:   Tue, 30 Aug 2022 20:51:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6393936541513590558=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,V2] media: Fix scan-build warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831000548.1222374-1-luiz.dentz@gmail.com>
References: <20220831000548.1222374-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6393936541513590558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672640

---Test result---

Test Summary:
CheckPatch                    FAIL      1.20 seconds
GitLint                       PASS      0.78 seconds
Prep - Setup ELL              PASS      34.95 seconds
Build - Prep                  PASS      0.99 seconds
Build - Configure             PASS      10.72 seconds
Build - Make                  PASS      1120.71 seconds
Make Check                    PASS      12.41 seconds
Make Check w/Valgrind         PASS      347.72 seconds
Make Distcheck                PASS      298.51 seconds
Build w/ext ELL - Configure   PASS      10.12 seconds
Build w/ext ELL - Make        PASS      102.54 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      655.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,V2] media: Fix scan-build warnings
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85: 
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,

/github/workspace/src/12960169.patch total: 0 errors, 1 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12960169.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6393936541513590558==--
