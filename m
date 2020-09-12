Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6984C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937C021D40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9b9GbDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgILGvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgILGv0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:51:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8BBC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q10so6373507qvs.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=W0otCJb0t2exDZa01G6rEt6eaiFdxQucf1NvvEpIOI8=;
        b=O9b9GbDHEF1+xpCqb9iWvbaaLMQLrMtAcl38JqT9OHj4evlbCVZTo2+I9NTag9eFwr
         EM+FhoKKe0FPJu5rPdFxPuE2HafN8sEWHeNED9mH2mTHCsDhdt8Q7SaLdRaxFQF0AKUs
         CWIKDNVFRjztfWbNoH9okvQf5Y6HewZZ0vn59Z4RL9vitum6uSxEHvdUerBf8cmRiVs4
         kafo01kQYGBRX7G45aKfz73UFF+UspidGi30f/h3wD7kXYsTnuY3NcukAtVNazrTSBCW
         mkori1MIYjzE0izkD758mebymITi5ohKjasoNZBmAvIqahcDCY4pWoOeCSln7IRCigiU
         v98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=W0otCJb0t2exDZa01G6rEt6eaiFdxQucf1NvvEpIOI8=;
        b=EcKtu9tPGC0DM3COg/oSZ5OOh0m8SghiDFplYU7XYeepmbCzbVquvaWky4Lax6/fiD
         hEN3+KPfArLqqyQ/+zrxnmLITM+lOuzw65/pRU7X74D3xzpf8fJjZ5ZLLCzAKuoZUPJD
         69YH41YZCw2qkciAzYMdcCXJotO87w/4fZ8HYXakJzyinSiyG/bBhmz4LMLcukwdl7N4
         yHkB/r8v5aQ6SejX/9FrSO4idJ9PeO8g7H5q+EkJ4Kr16Mq7TVWnbuX3FVP0aJBHn14r
         4XL0m4L9JIRGAQ8RgugTz0UD4GWXp+4dQCnreqDqOppQi6xT5j0h1bt9FVzt0H+lI3Pf
         O8Rg==
X-Gm-Message-State: AOAM531KMOcOGYjMADagSGBxCrnn3x5Vli3lDjmJmmbxsbQTVWWjDhed
        n8+Meo2bXVZkkxjiN0CRd20yGrdsSqIYlQ==
X-Google-Smtp-Source: ABdhPJyA/54hdT1Q81HZ2cRvVceHyoaGIO4Y7UCb8ruDWGs0bTZZ3LrCHC5NQQrE/W4fuXMTuMWhCw==
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr5296017qvm.14.1599893484257;
        Fri, 11 Sep 2020 23:51:24 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.17.224])
        by smtp.gmail.com with ESMTPSA id r34sm6310970qtr.18.2020.09.11.23.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 23:51:23 -0700 (PDT)
Message-ID: <5f5c6feb.1c69fb81.ac4d3.0c03@mx.google.com>
Date:   Fri, 11 Sep 2020 23:51:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6419365277445898984=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ,04/17] client: Add SPDX License Identifer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200912062357.23926-5-tedd.an@linux.intel.com>
References: <20200912062357.23926-5-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6419365277445898984==
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
WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'client/advertising.h', please use '/*' instead
#38: FILE: client/advertising.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#38: FILE: client/advertising.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'client/agent.h', please use '/*' instead
#56: FILE: client/agent.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#56: FILE: client/agent.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'client/display.h', please use '/*' instead
#74: FILE: client/display.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#74: FILE: client/display.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'client/gatt.h', please use '/*' instead
#92: FILE: client/gatt.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#92: FILE: client/gatt.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

- total: 0 errors, 8 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============6419365277445898984==--
