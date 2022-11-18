Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiKRFiL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiKRFiK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:38:10 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCEB7AF52
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:38:10 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u7so2693559qvn.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sxu34FnkndWQZM6lLhaDgP3E1bRBwmlaSSVuyC5CRTQ=;
        b=CjCqgFTdHv7PiooXh5C0yC00mdxEbmIWN2E7KDTdfTENnQwcDuNNCXzffbAVQw14kh
         LJyi2xoce6v4Uc7K9lPksXmRDAIA+LcPHcQlR30fIxptbpOlYf2b+SObePPLmqh+VmpE
         cKkcK9rdXAfVa9duzM3N00cRGecB3jBc8c1km1L1zthWAT5zuxaDV/OnuFiMJWcVr6gf
         LDB+YE7cHaqUKKaoXsPfZFbmX+Yq5q2jBWrbH74epTJwvtuiVZn+w7OoRMmKzXCHtAGj
         0IO3ummk8WdjkSp1vBF3EY1kOzYcoaGHBJ64HduOlNJzI25kth7mbRGY7P8guffgCrIW
         YAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxu34FnkndWQZM6lLhaDgP3E1bRBwmlaSSVuyC5CRTQ=;
        b=RCKnmemi9+zcfacIzNEWuHmelEp4+ZSOAnbwXPXgB9AIHnNGFBPowG1R+OGsEXKVSS
         Aiy6dMuNZCVnmJ7dWh9S7LS0iZCKmn2+DrnevUjpJ0K2r6G302ItJ37sXGBi9KaIUj58
         BXKKVjOjTfFJtC0OUPdMvcIoLFY3G4qIgffYEo0f/6sd/fHK+pmiA/4uXKoXhiV1umJa
         yUjyXqPsbHoMt5j5O5iV0o/RLH5Ee6KIsdOoa+rVjbSwr+MyhD2LYl8VolODnm4FfMT5
         dRcu7au39rMtoXqh7f2eygMsztytRVPW+2QdDvA/OPPBQbE8rhTR8YmB02oaW51yzIf2
         DjhA==
X-Gm-Message-State: ANoB5plErXgv3VGFP+5IVwgq9bJAeV8roeUaj4EXWi/Oiplozkm9bM4V
        MSeClUIBAzA1QiAlxZP/7KidFDbeKFUUJA==
X-Google-Smtp-Source: AA0mqf75gaaSj0wHwSf/EkZBRqzM9z2IGaeh2Yssr2YeWYZIqAE12Qca6scqlZnmGnXhPuHW/1OjkA==
X-Received: by 2002:a0c:fe44:0:b0:4bb:6bc6:4276 with SMTP id u4-20020a0cfe44000000b004bb6bc64276mr5452485qvs.122.1668749889226;
        Thu, 17 Nov 2022 21:38:09 -0800 (PST)
Received: from [172.17.0.2] ([20.1.157.252])
        by smtp.gmail.com with ESMTPSA id bs10-20020ac86f0a000000b003992448029esm1509771qtb.19.2022.11.17.21.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:38:08 -0800 (PST)
Message-ID: <63771a40.c80a0220.4de17.7301@mx.google.com>
Date:   Thu, 17 Nov 2022 21:38:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3045599154915446154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3045599154915446154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696161

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      26.95 seconds
BluezMake                     PASS      833.68 seconds
MakeCheck                     PASS      11.72 seconds
MakeDistcheck                 PASS      145.90 seconds
CheckValgrind                 PASS      240.80 seconds
bluezmakeextell               PASS      94.19 seconds
IncrementalBuild              PASS      693.39 seconds
ScanBuild                     PASS      986.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/bt.h:1794:
+} __attribute__ ((packed));

/github/workspace/src/src/13045866.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13045866.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3045599154915446154==--
