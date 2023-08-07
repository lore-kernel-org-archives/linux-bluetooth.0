Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF2CC001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHGXOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHGXOE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:14:04 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A071710
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:13:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40694b191cfso39800051cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691450022; x=1692054822;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YC3pKNAUkiZzq030DkjTPo7NEh0IR8JcZkmhc9EC4jI=;
        b=NwhFu6mPB4f8i35TiUumqwpvyhY2qLbeB0ADCyX2w6mu3WF8BIY74Q60EWG/rkjMxN
         FDkOxSbAz1+XVd90qg74i6Y705grDNR67EfS1C/IPKD44OWQSft2O3RGFQRER+Wqx1oe
         DHiLeG5Vncl0fDBJvpA+Kpelzbu04q7NoMroiV6/MuKJ1hk0EuUHL5JMoEj+Elkj2y4X
         DdlybnQTRVIoMRts5E4bMnenz7Pz4pxQDToRcJlgKUcyRCysRoBJenNBalJV923wnlzK
         BeoBtdwiQYu7+focdHWpR+7HkyiUGTHVilNrnooYsQ7wAiU6ehZDEbLPxAMiW1EYCMnS
         9eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450022; x=1692054822;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC3pKNAUkiZzq030DkjTPo7NEh0IR8JcZkmhc9EC4jI=;
        b=MCZMK+nQxXtPabgS0bRJPgaeKRVbqZxJAna1EsYHBVnrRc3wM+tdGXo+tSdOo6Ijpt
         3sLahcR8Q0QxAzCG61RPhKdR8J88tTRFCue4nuvSY00nxRq3L+faO1u8jPvDiE2HUU+f
         g+HD0ZOM0uIhT05g0wNeq3hyx7JIxb1KZthw8+zWPlYg1S6tPzBslhhXlOQi/vAAfsu6
         kmy6qNO46DBbv/QXNT2a1Ns1JFLtppxJoTo8KEEBWijIwVDOzoy4UOarkm4JPb5eMpBE
         s2WQYAU8yCdepPVENRfu3F6cpnKDmzfQ7VGra8+OhN6jf7aFeCWkZTFsihZwqe7kyB5o
         kqLQ==
X-Gm-Message-State: AOJu0YyIL4zrCXSoKWsaIAzv6n9Q6ckqQbu1MjxnkzUPwICdSFFfR0X4
        6m+xIH7Qi+Pu/OCWKNS6amx8SzcC7cM=
X-Google-Smtp-Source: AGHT+IGwbZ82hFzGyxGrucV6aVl2Mp2inpxTC/oCbpmreaU7GB4tXI450UkZQ87qc7KDRDdKnM8VBA==
X-Received: by 2002:ac8:5905:0:b0:403:b6ab:48d1 with SMTP id 5-20020ac85905000000b00403b6ab48d1mr15506756qty.11.1691450021677;
        Mon, 07 Aug 2023 16:13:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.102.33])
        by smtp.gmail.com with ESMTPSA id dq15-20020a05622a520f00b0040c72cae9f9sm2964837qtb.93.2023.08.07.16.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:13:41 -0700 (PDT)
Message-ID: <64d17aa5.050a0220.cbe75.bc0f@mx.google.com>
Date:   Mon, 07 Aug 2023 16:13:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0089861644198323908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Plot RX information with -a/--analyze
In-Reply-To: <20230807215825.1251961-1-luiz.dentz@gmail.com>
References: <20230807215825.1251961-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0089861644198323908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773861

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      27.95 seconds
BluezMake                     PASS      896.21 seconds
MakeCheck                     PASS      12.34 seconds
MakeDistcheck                 PASS      160.08 seconds
CheckValgrind                 PASS      261.80 seconds
CheckSmatch                   PASS      351.81 seconds
bluezmakeextell               PASS      106.39 seconds
IncrementalBuild              PASS      737.55 seconds
ScanBuild                     PASS      1098.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Plot RX information with -a/--analyze
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#90: 
  100 +-+------------------------------------------------------------------+

/github/workspace/src/src/13345069.patch total: 0 errors, 1 warnings, 305 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13345069.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0089861644198323908==--
