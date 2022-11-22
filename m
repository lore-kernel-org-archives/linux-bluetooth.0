Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E93C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 12:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKVMjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiKVMis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 07:38:48 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE61F61C
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 04:38:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w4so9174654qts.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7J36dJHcV3GMiHzwEQ2uHdj4lQVOd14sHgkM//TcrPA=;
        b=GTzsYXKmMcUJNmYABH9UtzO7/7tubelUvHlDN+LfMq8tmf/BarOoeLoasnhZO8FYW1
         eUM/qbxTpfXPFUnelb1Yqf4Ss1gspSbEAIjH3lVHgzAsuSw6Ft0H03+yd4b60UoSABnU
         Sb2qaEQtWJ1AzQ0pS63G8mufHbmFAF0HSIdnTMqF8/GDiPzoZJ1+qpzqiE8p7jdtx4CL
         i1mhyJSsaZTLV4MNpZ8XrB1spnwMevZhmnF0HyTv5CKmyQmqy0UtAdIqa+BJGVxmJNuS
         DQUEjjpeqec7qUelP1rIHjKj1aOcMSU5gcIOTEKpoqkkLUgeLa9krpsKIzwMSKKDr47K
         lTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J36dJHcV3GMiHzwEQ2uHdj4lQVOd14sHgkM//TcrPA=;
        b=YLmroW8uLyuLF5HYuA97JDxC5Zd/D+saRGOIbbNxvmKcLp94DI1V+gUCbEf6zsc/VL
         TSljPBdCrDsqsck94XnbM05O7/7cFc3ESpMjXqlqFV5h0vuZE80vqYaFPPykXCpMHdml
         PM4j2BCSQ/FQ1Ik8ImoWF0wrrhhPUkj792o6xOLUfnfgDzreBjaN6QL54gRoh/dHhmWY
         MSkFwKEB8kMR2QhpftM0T22H5V31N9Ce6+WlecZ6XoRNv5w2/yuwvvRJxxFtl9fpUNAm
         HadI1Av3SQuHmSSdG70e4oOH60A9LrGbpxQHCNmDAMVZ4c0T+zArWda749txz9cvnP5r
         AXQg==
X-Gm-Message-State: ANoB5pnr7ZHmlNvU+kesQCPa0R/qlc+pnZgCvohyAQOQ7SnWBzKM33ye
        0D3cieOl4D0IFqQ7kQYXgHj+/B1DS2dD2Q==
X-Google-Smtp-Source: AA0mqf7ibYin4a+S5ofwu9ru05fPbPCNMp227baMb/eo6PhRNwhdc4osQnNk3+DdymK/iFsvfxzysQ==
X-Received: by 2002:ac8:53da:0:b0:3a5:c1e:d8b with SMTP id c26-20020ac853da000000b003a50c1e0d8bmr21077101qtq.537.1669120725989;
        Tue, 22 Nov 2022 04:38:45 -0800 (PST)
Received: from [172.17.0.2] ([4.246.211.90])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a410b00b006bba46e5eeasm10221076qko.37.2022.11.22.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:38:45 -0800 (PST)
Message-ID: <637cc2d5.050a0220.73ca7.2ec4@mx.google.com>
Date:   Tue, 22 Nov 2022 04:38:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2093944013392759411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: Csip - Client role
In-Reply-To: <20221122101232.45320-2-sathish.narasimman@intel.com>
References: <20221122101232.45320-2-sathish.narasimman@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2093944013392759411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=698015

---Test result---

Test Summary:
CheckPatch                    FAIL      5.01 seconds
GitLint                       PASS      2.58 seconds
BuildEll                      PASS      32.32 seconds
BluezMake                     PASS      986.05 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      174.43 seconds
CheckValgrind                 PASS      290.29 seconds
bluezmakeextell               PASS      114.13 seconds
IncrementalBuild              PASS      5622.11 seconds
ScanBuild                     PASS      1194.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,3/7] main.conf: Add CSIP profile configurable options
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#119: FILE: src/main.c:152:
+static const char *csip_options[] = {

/github/workspace/src/src/13052136.patch total: 0 errors, 1 warnings, 199 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13052136.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/7] shared/csip: Add initial code for handling CSIP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#668: FILE: src/shared/csip.h:16:
+#define __packed __attribute__((packed))

/github/workspace/src/src/13052137.patch total: 0 errors, 1 warnings, 605 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13052137.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2093944013392759411==--
