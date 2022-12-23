Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330DCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 01:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLWBYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLWBYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 20:24:35 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147E767A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 17:24:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h26so2775700qtu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZzucPpLmX/XLjkbUSfz9V5ZEPNUJS50GCCiI0bWSY=;
        b=kyQKvlC3r1cOxx6o/QYX+mkSSRFZ5BHZ6r4k+SkyuiRG7PfU+5ddDVlbjVfexNL1ac
         RPcGHR5Aev7ImPlKD1NTsEEJHTz9a7ZgH4Mavg4rriTj7WLaaPs7FH+cH2Eet+fcFg4F
         mmpmB77A+LsryKM0xyvLJu7OcTOu5/L9kLOXgkdzlO94RlIgud/iEUsKUfah9ehLsVDx
         /lzXy9ONBd+WTLjLTAj3Xo902BxQKnESJ/jQQZAff+XfIUQjJePQiibI+ljHnvrEdpEC
         t1kggoSBDKxy34iOESAOwG4q8B07Cwg8tzbeG1yIvBvfp0yCNAmEHWf/ZKK0kwDPtGSI
         o0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrZzucPpLmX/XLjkbUSfz9V5ZEPNUJS50GCCiI0bWSY=;
        b=4GlZBmWIKw+d3rNjTsznZK9YzBfOLLKhnwvNvgExS/5k/hwh0C1DkC2HP3w5KlyxPK
         BJYhZnrrhxlAn428GRFVl8T3cY3D+s04MQcTmXQu4618Nz4fCLIIa+aHg4c/9gkhNTXU
         Eks4G6V9qjQdIdhORgVa4UT/CL/pLxOxuUAL+yt9Q6wOqnKaxa3ef9twIrLHrh2+bE5d
         iFoe0+NFB1gFf0ja07AufM1PlZcPo/cEW4qOfzmkA2LIo+4USgJ7+KOA43jkNNSYviFw
         1BPRSWzEYErgKndbZ7Jnj7V+cphYHh1iRQwxSqCIfgj12zsq5T93utbDPpOZM4FQhHfJ
         c8RA==
X-Gm-Message-State: AFqh2kplmQqgsxXK3w0ZECwKsGTFm5WqVia/sa6qZvbJvQHPIO12Sxda
        5uF//9zdxZZ+yerKB7rngZoVPMWLb2v/oA==
X-Google-Smtp-Source: AMrXdXtlrHyDJRd638yl4oflNuDxZ//hw2pHCUVCCRbUA/oPIgdB6CqS29SVO9Ke8zSAqWi38bnBHg==
X-Received: by 2002:ac8:1249:0:b0:3a6:7558:e0af with SMTP id g9-20020ac81249000000b003a67558e0afmr10633319qtj.28.1671758672846;
        Thu, 22 Dec 2022 17:24:32 -0800 (PST)
Received: from [172.17.0.2] ([172.177.213.80])
        by smtp.gmail.com with ESMTPSA id j18-20020ac86652000000b003a50248b89esm1196620qtp.26.2022.12.22.17.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 17:24:32 -0800 (PST)
Message-ID: <63a50350.c80a0220.e18f0.673c@mx.google.com>
Date:   Thu, 22 Dec 2022 17:24:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5936871393637459962=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/crypto: Adds bt_crypto_sih
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5936871393637459962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706598

---Test result---

Test Summary:
CheckPatch                    FAIL      3.15 seconds
GitLint                       PASS      1.72 seconds
BuildEll                      PASS      32.60 seconds
BluezMake                     PASS      1106.86 seconds
MakeCheck                     PASS      12.66 seconds
MakeDistcheck                 PASS      179.90 seconds
CheckValgrind                 PASS      297.90 seconds
bluezmakeextell               PASS      118.23 seconds
IncrementalBuild              PASS      4631.99 seconds
ScanBuild                     PASS      1278.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/5] shared/crypto: Adds bt_crypto_sih
WARNING:REPEATED_WORD: Possible repeated word: 'is'
#80: 
This adds bt_crypto_sih is is used to create a hash as stated on

/github/workspace/src/src/13080417.patch total: 0 errors, 1 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13080417.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/5] shared/crypto: Adds bt_crypto_sef
WARNING:REPEATED_WORD: Possible repeated word: 'is'
#84: 
This adds bt_crypto_sef is is used to create a hash as stated on CSIS

/github/workspace/src/src/13080419.patch total: 0 errors, 1 warnings, 213 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13080419.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5936871393637459962==--
