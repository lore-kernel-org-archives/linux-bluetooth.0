Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7855FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 01:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F85D64E04
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 01:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhA3BYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 20:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhA3BWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 20:22:40 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B226C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 17:21:39 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t63so10681805qkc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 17:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BQExmW8eUyhM7cXz1UVIJfjaCeP5VIY+bFet0UrrVqA=;
        b=ClFgVl/lIlxQ7pAf0n3Y4SvmQ77r8IWJeMmaIFAdydwyePIqJa0vo6YnMXnVf0+ljA
         NM5Db3+DWzSJPjA5Og8sdx4Dn4OO1IGXUIMC+Rq/v81j3uHw5meHqOIN/YScmtA5jhRl
         VQMN88VgsOAhywdsT6mQi4GUUtrOzmiAeKGqdTo5b9TiC7jXvUrdYvXTm/XD0HF52DNH
         zWtb3deqPhei8sorCEwoARnrffoTpJdLdUkV2PD18kfu2NPll3MmN0l9wjzxOBKTCLqo
         rTHCWYKy1wqzbvGx0NoZmQrQm6BtRFtz1WaRc1E8d+o2F7ZhWQ4/WSTHzAAuBnI8BRHb
         hpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BQExmW8eUyhM7cXz1UVIJfjaCeP5VIY+bFet0UrrVqA=;
        b=ZtVNvW0rfgBfC08OVGsQ+s1U/UkvzxJaiJ+ob+gD01qYDpp1xjC8a2LAIBPAlXt2Df
         c/MnMK37ikZ3Cq99auq0DVJ0evq4hoft/HxECmBnnXDxct1QCWuywMZ7CKFyJgfB0AH3
         3OAqj+LD5rPBtG8lBSwaxWFKiLnrsJhfshL35W4jh4Y8IktC2dtLRs15sdnawHxO2wRL
         0KePWnygGqcXqZcN9GA5iNjJpNT8D4O+OPFzeEFaVcc+QxozrZdZnQTJYWKO2eVavTY3
         /KUOMEGPg71mGyJf3vBIHkRqRFG5+RDeAPJX246f4KRRX0MSabYpzazjP9GsJ0AP7we0
         fRow==
X-Gm-Message-State: AOAM5333dtonRnuAu5Yoy936X2Gp7CaT7uchL6id0vwW1XQtsGvWBV4V
        r2XDQ8nMXzgiP5hwkMp8zX8oTZd8IX/F/A==
X-Google-Smtp-Source: ABdhPJzlPLnBUJAgex5vF2oBkQOqaxzciPa4lmTYRxmbXrMuX/J4l5SvSYJZaN4k4aBNCMwnr8ku/w==
X-Received: by 2002:a05:620a:145a:: with SMTP id i26mr6654398qkl.346.1611969698186;
        Fri, 29 Jan 2021 17:21:38 -0800 (PST)
Received: from [172.17.0.2] ([40.70.188.140])
        by smtp.gmail.com with ESMTPSA id i17sm7919657qtg.77.2021.01.29.17.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 17:21:37 -0800 (PST)
Message-ID: <6014b4a1.1c69fb81.cbb0a.e885@mx.google.com>
Date:   Fri, 29 Jan 2021 17:21:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8366720096188844225=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3,1/2] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210130001519.91190-1-hj.tedd.an@gmail.com>
References: <20210130001519.91190-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8366720096188844225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=424647

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools/bluemoon: Add support for checking other firmware file types
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#59: FILE: tools/bluemoon.c:757:
+} __attribute__ ((packed));

- total: 0 errors, 1 warnings, 168 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/bluemoon: Add support for checking other firmware file" has style problems, please review.

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


--===============8366720096188844225==--
