Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC49C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7101964F70
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBFGhk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 01:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFGhj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 01:37:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092BC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Feb 2021 22:36:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d85so9296231qkg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Feb 2021 22:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pkoCam5OTeDaijW/MNCAdIK3e0HPNL6FDgSX7wq+bgE=;
        b=f5SNTfX30hJDPpaoxEN6aaTh35zz0ITmXMxEZ7cEJ8c1RssFoCJyvJcLhLpZdY2kcS
         klF+PH+9pq+LTIE/ZiON1g/Yap3+j8snoTssDyXMkpY7osVu5gPJ9Fxbp3y2NxUaYTDP
         aByzXgh/UpcTIl5ILCrqaB+NofbsgiGq+aMnE8Hv8vB7xz0rmZgsUmucP2xUMwW5PuUe
         oP1bkZt7kuIV1VFC3QZYWcoL/VMPuNKUVDaYQRUDNH+nXvIaxCxweKz6i5ruSUQGiDOV
         MbwFpBct2oVv7PRxlDhCMV7gkecNSS6zbuQzH6Na4kzTYJtqArkqTlHwa2GGkwl5mzL5
         4v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pkoCam5OTeDaijW/MNCAdIK3e0HPNL6FDgSX7wq+bgE=;
        b=AWFvtHJI+aKkni0QTpuR52yQ7xkmYOkT77xf+9gU3nYdi+7Fdu/d+2wTWxN+rTxV3u
         WVwtm9xMMl5tvml9SEB4rVwKuhMD82RGbLVHnFkxX+8etzBF2DJOUk90SWBn0L5Igsdi
         SJbL3X58BAYqypJnPPUDggFl7ZKKuzPu0fU17TFINL5IrbroFwpIyGzFlLsJuRc9DPUo
         BhU8jEXywG7n7fC/3lPJK/pNsEeKWDoYWdKDfornZF8qa2hlLH/6bfKW91k7TKfu+ngk
         lXxrFMDi7ramFjaYOtOCjJHjjEoyn9egrzOpZeDQL8xA7MxLLZ/xxQRVMlAy/IJslLlX
         omNQ==
X-Gm-Message-State: AOAM531mDEM4XVqaOuRquDHJNqRY4zBGQy2mY1wt0k2xC5jdiXWIOMLj
        qtMljOnT4+gF9XcEpqZxQKLrn8UyKgeOKQ==
X-Google-Smtp-Source: ABdhPJy4AKsB8F0ByfKbWHJ1KRJ98i/HSbtIhvfaULTYUdW+hDg4GVA9aS2/bNSJMx+sOcigh3Fzzw==
X-Received: by 2002:ae9:ed82:: with SMTP id c124mr7670234qkg.399.1612593418587;
        Fri, 05 Feb 2021 22:36:58 -0800 (PST)
Received: from [172.17.0.2] ([40.70.45.125])
        by smtp.gmail.com with ESMTPSA id z187sm12258978qkb.52.2021.02.05.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 22:36:58 -0800 (PST)
Message-ID: <601e390a.1c69fb81.12cbb.3559@mx.google.com>
Date:   Fri, 05 Feb 2021 22:36:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0235350681536866538=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Framework for non-interactive mesh test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210206055023.401381-2-inga.stotland@intel.com>
References: <20210206055023.401381-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0235350681536866538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=429191

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
WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'mesh/mesh-io-unit.h', please use '/*' instead
#665: FILE: mesh/mesh-io-unit.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#665: FILE: mesh/mesh-io-unit.h:1:
+// SPDX-License-Identifier: LGPL-2.1-or-later

- total: 0 errors, 2 warnings, 668 lines checked

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


--===============0235350681536866538==--
