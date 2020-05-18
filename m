Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA85C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726BA20674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWlARjNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgERWGg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWGf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:06:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B77C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:06:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z1so5599629pfn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nzitGWDCR4w4t/OxwAxx2mxNEe1skKC9SmnArXNK45w=;
        b=FWlARjNhkJrqWcu65tnV7PubBsJ8BDbosdzKxgoX2uPT2HCEFShVqu7PsS7z4daPW5
         dZfeH+PhZZXfq9qs8mCwCuGRSr7zI8x4PJmpLsiecGyyyaAbQHeYxfv/DS23E2kJDLad
         Hjv9l5JNFFvfKxbVGTX0dnRrOD0O/bUa9VjQxB2cQjN8Bdq28AqemP2LvSLMuv5NT29T
         qedX9TcMFt0CkZ/ukZIIz5DvJiO9sVaqiIBiVrXeVmCyDeQ6IZVsc6JYFLkkrguVZzDf
         ynHaZLMXqrhd/8ShBB8P9mPHcGPmrM/Ol12v7fvAE6UiKPsb5vRfmPFbpwb5K16IFUg6
         PiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nzitGWDCR4w4t/OxwAxx2mxNEe1skKC9SmnArXNK45w=;
        b=r1YX3ITjYxZrP8JIwQL4BH0ZxgT6pDXMbj7ieqPjpfdzl09VPa6ojjJ37/T6h0ZWPM
         zHeqW1LR6K1Tsoh0vfZlc7V4USzM3mizf78TPAvKUD2vICEf/0aceLZ58U5OaAF10tUe
         7sKXW+upCAs2+vHpT0tZqYapWRN/kpHKZPUN2FGlj2zWaIEXNSot0vECQymE1wePYV9x
         FjjOZqEaX6mqufeRAJnEkPbf/FAjrI943GKCoRwQse7ncIShOtsC5U6X1ZXTNT5j3zUO
         gTrmowD2u5xUfhqslNjkgFhHz3ef75mqnFdU9GhPwKungHFPijuqT7qC1KHOiuknCFEz
         +DXA==
X-Gm-Message-State: AOAM531FLrTPmf6giNqZ1PBBrqJgM08dnNbz14s8EVsL3fHU8QPACiqb
        1LW/IyMTCgH3ZcxW5IrOkd8o5utl
X-Google-Smtp-Source: ABdhPJxOrZ6n/Zc9P1lhJZ2LcSZcyZ4CZfJLz+Is06dIZ40xICPIHfvxx3fKQXk6VY/+7pabBJHBHg==
X-Received: by 2002:a62:3343:: with SMTP id z64mr18446498pfz.55.1589839595023;
        Mon, 18 May 2020 15:06:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.175.228.195])
        by smtp.gmail.com with ESMTPSA id b74sm8408129pga.31.2020.05.18.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:06:34 -0700 (PDT)
Message-ID: <5ec306ea.1c69fb81.28e7f.65b1@mx.google.com>
Date:   Mon, 18 May 2020 15:06:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3251183851954376195=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] a2dp: Fix caching endpoints for unkown version
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200518205636.139184-1-luiz.dentz@gmail.com>
References: <20200518205636.139184-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3251183851954376195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:TYPO_SPELLING: 'unkown' may be misspelled - perhaps 'unknown'?
#4: 
Subject: [PATCH] a2dp: Fix caching endpoints for unkown version

WARNING:TYPO_SPELLING: 'unkown' may be misspelled - perhaps 'unknown'?
#6: 
Don't cache the capabilities of endpoints which the version is unkown

- total: 0 errors, 2 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3251183851954376195==--
