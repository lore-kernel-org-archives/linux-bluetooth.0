Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE3AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 05:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0773364F70
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 05:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBFE76 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 23:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBFE7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 23:59:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC9C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Feb 2021 20:58:40 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so6656637qte.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Feb 2021 20:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wwl215Jw7j5ld0IO6Z9sUHI29eyftidLeJP9KK8mSSk=;
        b=EyNZ4HRkd1h4aMBuV6MgTWj3IOxcmJlOZA0VrtVcjhD0OLatD5pC3ZYE7/r4I17ixa
         I4ah9z7KA18a6Le9RIGXygfZ7Ty5LwFPOrDZ1sZTxaI4ba5uSP8KEnK+Df1elioupaqX
         f79AzL6PmgKtC4XLE+A7imGpHL+lyHbOhq1k0aNE5OxH8Iqfo8CjixftC3uEalz59yru
         qT7N7vZR7B+3Yx6G0n/Ph8wfOSqqJNDWir26S9f6yWvAU869pu3zsnjSXh+NaKARIIq6
         dAr223V1piM4DuKvGrh8NIzaC1ynchvRCPiHdMKzgJXnvbK1kxIg5GyidlZgfO+4yYXs
         B4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wwl215Jw7j5ld0IO6Z9sUHI29eyftidLeJP9KK8mSSk=;
        b=Ln4EqhsuL6sBwP9Mdk7RkXxEQ2jQKCKKLb0v8474ne+lBmHoN6cKDdHT5TugMqtvYx
         PEW13rRCriY3sZvV4GFWLpOgjalWQXfCzyP8p/V0W7hXcDcR/lMmaljksysBKOmNcyHw
         glSCkW/kKQlDOJAXsrEzXRJDbPpd6y2L02EWJtKKfxwy2fBCo03KlQQc5YY0eTmYnBU1
         Y65mJSs9idzUGjyKp1ASzPGknuZgzGlmo8AFWtdQDN4UomYsJQJk3XThFN5LuFU7wtnw
         NMmBinaxXQoV816jp5Tp5Z/d057mBGuu0WqAnGSrKWqxIzApFEB25rJ4YDPCTYBYt8R0
         LVIQ==
X-Gm-Message-State: AOAM532r9YooRvUROi7qBKczjVB+KGcpqHC4jy8w44j0zLDK3Jb4FAgj
        Fsnh8ccRyn6zDKJ89ZBFZIbH5d04iYmeqA==
X-Google-Smtp-Source: ABdhPJzp0YwyQSuINpXgaNEFP3xr4Kv+R8lMlwSZOhmTAYypneUyLX/VrT1JVlbLzRfuspYfEvHrJQ==
X-Received: by 2002:ac8:3a65:: with SMTP id w92mr7455336qte.267.1612587519300;
        Fri, 05 Feb 2021 20:58:39 -0800 (PST)
Received: from [172.17.0.2] ([104.46.195.126])
        by smtp.gmail.com with ESMTPSA id v19sm11543837qkj.48.2021.02.05.20.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 20:58:38 -0800 (PST)
Message-ID: <601e21fe.1c69fb81.2de1e.1841@mx.google.com>
Date:   Fri, 05 Feb 2021 20:58:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8751267821651649437=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Framework for non-interactive mesh test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210206044340.396467-2-inga.stotland@intel.com>
References: <20210206044340.396467-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8751267821651649437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=429183

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
shared/tester: Create ell-based version of tester code
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#168: FILE: src/shared/tester-ell.c:120:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#173: FILE: src/shared/tester-ell.c:125:
+} __attribute__((packed));

- total: 0 errors, 2 warnings, 913 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/tester: Create ell-based version of tester code" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

mesh: Add unit test IO
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#665: FILE: mesh/mesh-io-unit.h:1:
+/*

- total: 0 errors, 1 warnings, 677 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mesh: Add unit test IO" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8751267821651649437==--
