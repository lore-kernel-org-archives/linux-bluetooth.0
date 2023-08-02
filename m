Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2CEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 01:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHBBRn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 21:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHBBRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 21:17:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F10DA
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 18:17:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ca8921c6cso21278485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690939058; x=1691543858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VdPPkcvr6BfebgITdD1P5a33j2dCixwPFOTGlNZOOTo=;
        b=dL7bskCLrc/b+Z8m/bmvA5NEpkpPB4b3M+4ERFVQDVzF9vQSivbmSpN5M9p0LXuYaJ
         TQ2Uxj/RgWu6MfdJOBuRaM1H71Q/L6J+jf0KKUTy+m5zv0Uw2x49NS9ncm30CI1qiuCG
         RDBxcPfe+T3TVEIQha2cuYm9ZnqWfHWxytrGMC8ZySi7+gpeotHhlSROdmnccN6FnWTi
         EQDEmbfW61vXW+VhrCTKZd26RcwaG6ZVg/2O/T+ftzWgF7V2FgpwkLpbonV5j6stAwqe
         Yi+IYPw0yxtW2xwuvoHFsB7Felv7uyEIx+3M62V1nyseVTypF831UascArkTq+Gt/v7p
         ESYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939058; x=1691543858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdPPkcvr6BfebgITdD1P5a33j2dCixwPFOTGlNZOOTo=;
        b=UyQjBLo0Elm0Hr4jE8I7CnLETwC1sbswuoVliQ1htl4uGa46fT/UTlAwZPUoR1FWL3
         ORAflFXcP9Hlq7lU7TO7mOAiPCANRBDSmKLzKq8xn3Tdlyr8auM8kJuHh95FfNaNZKZT
         iObxUXKr2XOcsMx/6HLdD0Eapu2qRmZBVUZfDkZOKAWknwU/KaTrUncArACwVIexDPOw
         wmYjalEmLFraOf6HRt07Wk3vHaqBJMC9EcPK/YdiXE3GNuBm8uIL9P97q2kWrlD9Vtrt
         NPRg3xgRxaHuGW+ZaEUCvVEx5xLbGlRO3CCuAc6WQ9jEXZvda9AS6JPm/o2Ip4xiBrYB
         UfEw==
X-Gm-Message-State: ABy/qLattbyzjEP6FKH+p6vKA7wvNxxxJT4kllXZV5tc2SLkfRydbydq
        J5L4aQLsh7N1pUd1JTF7Qlsz2aF7AGs=
X-Google-Smtp-Source: APBJJlFqvZazrWjd8bFMnT3JOB9T32786bh1ao7oHg0Dfl4bRDFu5iUnuptbfhv8u+c4onxylziR4Q==
X-Received: by 2002:a05:620a:24d0:b0:765:a955:74a7 with SMTP id m16-20020a05620a24d000b00765a95574a7mr20023771qkn.24.1690939058596;
        Tue, 01 Aug 2023 18:17:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.120.49])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a135600b0076ca9f79e1fsm2500965qkl.46.2023.08.01.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:17:38 -0700 (PDT)
Message-ID: <64c9aeb2.050a0220.3b80d.9a19@mx.google.com>
Date:   Tue, 01 Aug 2023 18:17:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1946037687565449059=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] monitor: Add TX frame number and speed estimation
In-Reply-To: <20230801232135.535733-1-luiz.dentz@gmail.com>
References: <20230801232135.535733-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1946037687565449059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771865

---Test result---

Test Summary:
CheckPatch                    FAIL      2.92 seconds
GitLint                       PASS      1.69 seconds
BuildEll                      PASS      26.88 seconds
BluezMake                     PASS      793.19 seconds
MakeCheck                     PASS      11.78 seconds
MakeDistcheck                 PASS      156.15 seconds
CheckValgrind                 PASS      251.54 seconds
CheckSmatch                   WARNING   339.63 seconds
bluezmakeextell               PASS      102.48 seconds
IncrementalBuild              PASS      3298.44 seconds
ScanBuild                     PASS      1023.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,3/5] monitor: Print channel latency information with -a/--analyze
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
  10000 +-+----------------------------------------------------------------+

/github/workspace/src/src/13337349.patch total: 0 errors, 1 warnings, 255 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13337349.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1946037687565449059==--
