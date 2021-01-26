Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5033D20663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 22:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhAZW6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbhAZUil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 15:38:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A472C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 12:37:57 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c1so13306571qtc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Jo25SqO162ljtYy3opNjUYw9l7UmnqtvfLvq7QJSmdQ=;
        b=M3hoPS6DGvlGKJfnT0RWSnXqbg/QxxgdBFXltdi2KVopCPyvyBjvjYVLCfp5y9Jgp3
         0vGZ1AUbSSzbMoN4/tSJM43e6LPZqx4fOnDeItp4HunosVNHZNwarRt4QzMtkGydekJg
         4gy2VXpBkft7zuiWPoFLau5/Orkpvu1UFi0xBsP5JZ1BJHiQteIH5iN/P6V3Nb+odq2C
         BndYNUs/xly27uTP80e/q9KTAQNoAQJVlPO43jDLgufE4C0h5XR0VxW/EROtKfybQBYg
         pCG3PiPW4r11gIl0gkdZD/VU3CqUB+karUwDGMHDCA39jf/Nzn3utKYYLmZcXEkIL54J
         TJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Jo25SqO162ljtYy3opNjUYw9l7UmnqtvfLvq7QJSmdQ=;
        b=ij8pfAiHMCP7aHaEonrldDtIHea/oTRzJMtTO5zYN7qpC4+5KdbRPf2DuyxQ4uwDKH
         XOqtn7V8/AVEruuZS97O8+Q1NSj1Jn9ee+yzb9E2ld8SyWgRd1dogFQyxKt98dGwKpBT
         YX5rQTIucgN6nPd/4eJZ0GkUup/PXdgdxv342tsRCCdvibvOBV6TAoOQxZw13J5jcJvc
         lf0zmpj5zMP2Lppo6fMCBh4jEYy613utZ3n/ABuQwQjhGRY0LtorrwSTvtM09+sgQkCG
         eKcX5Y+yc4xt2GBxFdmLhvQK2Nz5CU5xQdR0E2dLMxv5Jo3R8+ncbEct54GSBHDmkxMo
         Nuqg==
X-Gm-Message-State: AOAM531U9tzHIdPOYJ1Fdx4n69RGLcjU3HlxDoFcYASOoo/F+fREpnP5
        RPkHs7NibIsPQciHD7nuFIQbe0xkTl6LGg==
X-Google-Smtp-Source: ABdhPJxtizZp9fdcl0A1w3enMta8p9w2jPUZBX3c+An788kPfIspK6nMuz8Vso6AzXZsfnQNaiTnKg==
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr6906698qtb.98.1611693476730;
        Tue, 26 Jan 2021 12:37:56 -0800 (PST)
Received: from [172.17.0.2] ([40.70.43.81])
        by smtp.gmail.com with ESMTPSA id y66sm3568555qka.17.2021.01.26.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:37:56 -0800 (PST)
Message-ID: <60107da4.1c69fb81.69aa8.809c@mx.google.com>
Date:   Tue, 26 Jan 2021 12:37:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8624967815812112023=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] input/hog: Fix crashes of UAF of hog->attr
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210126011130.5233-1-sonnysasaka@chromium.org>
References: <20210126011130.5233-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8624967815812112023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422227

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
input/hog: Fix crashes of UAF of hog->attr
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#21: 
    frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325

- total: 0 errors, 1 warnings, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] input/hog: Fix crashes of UAF of hog->attr" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
input/hog: Fix crashes of UAF of hog->attr
18: B1 Line exceeds max length (81>80): "    frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325"
22: B1 Line exceeds max length (86>80): "    frame #11: 0x05ad5a64 bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - FAIL
Output:
./test-driver: line 107: 14777 Segmentation fault      (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9755: test-suite.log] Error 1
make[2]: *** [Makefile:9863: check-TESTS] Error 2
make[1]: *** [Makefile:10257: check-am] Error 2
make: *** [Makefile:10259: check] Error 2




---
Regards,
Linux Bluetooth


--===============8624967815812112023==--
