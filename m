Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F505C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjG1GTJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjG1GTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 02:19:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFD2D51
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:18:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403a85eb723so12012101cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690525102; x=1691129902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/yLuPU4LE+LGP7wv78jd0yvyQP/JMRQiKNmk3AfDabg=;
        b=TyvbaLC+t1IXttBN2yVwgczT/R1q33m4kkyAbTbcNI4hUKQte2RuceWzmeDZOOmL3C
         VYaPa87qBvhWwqdtuatpRWyIowC9dsasTKGSVhbpUtVbEjasvRToyUol+FfiMmLDfi0a
         uzbzJB8cKQE9L5gPDP3MmuUe0mJxTk5szNM2e8bockuMPDDoWyxtF6GkuZJpEWqi7LT0
         2D2k/sxZPlJDmx+cHGngoO8U5cGsn5c7rozU5oWJo/QtZs+4bs/TPWA4rp46TCiEk2SB
         uA7PsLsdz/AJVtxH411L/tvA3eyMQwz7Zlrue2eqaWQcNBcEpAF/zS8Ru0kTEkS1ZRKG
         lRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690525102; x=1691129902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yLuPU4LE+LGP7wv78jd0yvyQP/JMRQiKNmk3AfDabg=;
        b=W2ou7u1d0C6OqZ9tGDu/81RPmLd6Zwm8GiBFru6SAH/VUpQjIXMUCOm91N+Jy0Y727
         S+Mb5V2HHhlg6l2x/rZx5oZ0Cb8ZEoEaVbfUmOxiJk3MHaEvq8rfNMmNTLzkn7i1sdaA
         JfTzBeYF576hlM2TQ5qHLbNe4pfcnWtNlzGDX7iWzax7oDn6s3JTFnWztsLBnpwx6j4r
         A+rQveBXZPjVEZ5lVwXSneM8/Y/Fy+xXBJdenPW8SS21nMODnHolakwZb9aIZncu/oJ0
         5iujkpSHypxc4PFdOEnBm5VhAzhJAOj0XrSUFJE+kBy7GfYFGfW53FrZTbSxmPrBHO5q
         OsiA==
X-Gm-Message-State: ABy/qLYwlmRJpwkbVh7KPOsZ58knWIzIAd/J3SPKwPYY3Xm4RVuLG9IC
        Zl61duUWCyRDaaBxBqLdVtRw6zwHDjrXRA==
X-Google-Smtp-Source: APBJJlHc5ehxxiCR+AUY7J8gFn90NoetEeaXkgWy1/XHhpcDmeHdrmlvWCTMemMp5IaGtHZKtO75FQ==
X-Received: by 2002:ac8:5a44:0:b0:405:4eec:6356 with SMTP id o4-20020ac85a44000000b004054eec6356mr2402660qta.13.1690525102360;
        Thu, 27 Jul 2023 23:18:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.41.209])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85485000000b004055d45e420sm943573qtq.56.2023.07.27.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:18:22 -0700 (PDT)
Message-ID: <64c35dae.c80a0220.b312e.419d@mx.google.com>
Date:   Thu, 27 Jul 2023 23:18:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2723870740587424998=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] gatt-client: Add read-only handles to dbus
In-Reply-To: <20230728044944.576220-1-simon.mikuda@streamunlimited.com>
References: <20230728044944.576220-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2723870740587424998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770395

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.78 seconds
BluezMake                     PASS      1023.54 seconds
MakeCheck                     PASS      12.48 seconds
MakeDistcheck                 PASS      160.47 seconds
CheckValgrind                 PASS      262.36 seconds
CheckSmatch                   PASS      348.72 seconds
bluezmakeextell               PASS      106.00 seconds
IncrementalBuild              PASS      889.17 seconds
ScanBuild                     PASS      1096.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] gatt-client: Add read-only handles to dbus
WARNING:TYPO_SPELLING: 'usefull' may be misspelled - perhaps 'useful'?
#76: 
This can be usefull when mapping names for services and characteristics
            ^^^^^^^

/github/workspace/src/src/13331197.patch total: 0 errors, 1 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13331197.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2723870740587424998==--
