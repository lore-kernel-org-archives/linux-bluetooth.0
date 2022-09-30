Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 12:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiI3MGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiI3MGa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 08:06:30 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D4157FE9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 05:06:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j10so2495978qtv.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=BzCHffmD0555gwgRkUib6vy/FVV6CxKKixa7SxBqGWg=;
        b=dPR4TIaH91RkJK+31RW24LLRLbuC6ywf+Tu7ebdD4QYYw2k3JKLo1d6mNPGrLuCyRS
         OBy7pgnbcoeX1X3p7Q/uzxhroXEvdFIZ3J2jUARtKkoq3plijwpLH38qp3zyLAmi/zTi
         PMHfeLB3FalWUQV6xUOrOW6TFyYvdDx70ugCEb1lEmUKIuHwYw877KngKR3wX7aCAqJP
         yggXlmcVFTzzoFYXo+lrpdTHoMUkQFaABkvyCwMPnMpLjDyv9MtIKGMZtwRGJNFIoM7T
         UF+RcCcVfV633gjP4co6QmvUqLjOJ6Wdq3J0pSoZKG/8QbDDLpTv5eswHwHoad+uPa71
         4DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BzCHffmD0555gwgRkUib6vy/FVV6CxKKixa7SxBqGWg=;
        b=pnnyuOkoABiyodvSrmSs5sbmTVLqPAqZRSh6kES0DKpPz8G3vFAwfiLJ7WyX02cgvy
         i9RdGkMfcAa99Ypaqhz9RbiisKpGFUOflDRmN3WHxjoCmSkZ5bq8+BhTW3svuq6TnkSs
         YBXW0RWm5apj+SJWJlpZP0a7dmkXixWc9lQhXcORCEoCkMOFTSIP5Zuri2HztwU46nq4
         fQn907xJtLKhQ0NZ3fu3QX4F2vzdIfKZ5IyRJidv41R9Rf6wb4TwXJtCU+tW3k0IZZp6
         O0kn9tymhXSbstGIoOxRfPNHSC/DU+BnQVZktRKiDAzCzvxhOwEGsom6CmhaLT8bIpjP
         6tEA==
X-Gm-Message-State: ACrzQf15l1a11KHiNmKZl3R/XY6ITxeLjUczLYQX54Iq4rzxcCLoNCCp
        oChRHTb7ICmGrwEYGrT071WRyy88+RH1aw==
X-Google-Smtp-Source: AMsMyM7DwWJzRMb43jt2Sbb7bug32QgP76egi6kbChLl289uoomjwyDrnLwJavze0Ecx7/XOZFSUog==
X-Received: by 2002:ac8:7f4d:0:b0:35c:b953:185a with SMTP id g13-20020ac87f4d000000b0035cb953185amr6352992qtk.382.1664539587433;
        Fri, 30 Sep 2022 05:06:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.95.60])
        by smtp.gmail.com with ESMTPSA id w41-20020a05622a192900b0035d432f5ba3sm1625397qtc.17.2022.09.30.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 05:06:27 -0700 (PDT)
Message-ID: <6336dbc3.050a0220.41bf9.2d86@mx.google.com>
Date:   Fri, 30 Sep 2022 05:06:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5867121262661865910=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [1/3] audio/transport: seperate a2dp and bap transport to update volume
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220930104523.2572-1-sathish.narasimman@intel.com>
References: <20220930104523.2572-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5867121262661865910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682212

---Test result---

Test Summary:
CheckPatch                    FAIL      4.94 seconds
GitLint                       PASS      3.15 seconds
Prep - Setup ELL              PASS      26.45 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      8.56 seconds
Build - Make                  PASS      747.72 seconds
Make Check                    PASS      11.31 seconds
Make Check w/Valgrind         PASS      288.42 seconds
Make Distcheck                PASS      238.75 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        PASS      83.78 seconds
Incremental Build w/ patches  PASS      297.45 seconds
Scan Build                    PASS      523.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[1/3] audio/transport: seperate a2dp and bap transport to update volume
WARNING:TYPO_SPELLING: 'seperate' may be misspelled - perhaps 'separate'?
#55: 
Subject: [PATCH 1/3] audio/transport: seperate a2dp and bap transport to
                                      ^^^^^^^^

/github/workspace/src/12995246.patch total: 0 errors, 1 warnings, 230 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12995246.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5867121262661865910==--
