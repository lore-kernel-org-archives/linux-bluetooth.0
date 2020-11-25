Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A501C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE320857
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvZUzIvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKYIdA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKYIdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 03:33:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E280C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 00:33:00 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id v3so1367487ilo.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 00:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=T8ZKx5CKvGYj4tArkGZ4CUydWUM92bE8AjTAKR15UCU=;
        b=uvZUzIvCAp//Ipjae8P+aFZZRXM84vWxGuRC9YQQXM7c+ZOc3EgCSvkhZeXBeBmK5Y
         fLnTsBF6UwsLdjM9sXxRDOsoIKZfCdpk3oZU5nIvE3xceCaUh9M23NqR3ho5cbVLZ2hi
         edvQz2YWrsdYpIqe8SGV4daLbVwSY+WLXuq5mclWHCokn//dPrSym4j7D0YjCs03lBJq
         BnWiJqChNeGEn23a+4nmrYiiPAJOV8r0TKZoSiVC3dcahoq0eI0YWYb4EeviGYgtI7my
         mFmdWxgfcSjGMiQo84twNCUmZdEWtWJRTOPJ4GYgQ8ckt1rGXL2SGXg94mx4DSBIpp1S
         +/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=T8ZKx5CKvGYj4tArkGZ4CUydWUM92bE8AjTAKR15UCU=;
        b=qNjDm91QwiUIdLYdezT7IENr0vM8NjsNXTgio0Mnbn164SOBUQe2zewrJ3ViR3qkVI
         IXwXt+58Rxfh4ct/hVK+xMyp3uKSSdUh8Gv6yTipee5K3n9VVdnx9cs4yt9NzcjYK61P
         cIDdPp8UVGXga6leuVWOdWAuNMlfXZpc99uS+O97Icd+MmMF8wGI3wkFwwFRj/OLzfr2
         vO6oN8h5Sd/l8zkN5y+B7JU6V97GJP/Y/ObjCn8xgvIURm2DPqvapHOT6CWFmPG9M6QZ
         kGRV42BTFJUXbfUwogNldbf2KkrskfDEdxLG6FzappBHEFfgdJHGXz/WUjF0Uv2lxC4v
         wW0w==
X-Gm-Message-State: AOAM533SAMDYozzRBcHW+MrR/g6+pituBOzZMYxNtUYksfVcfV70a6pL
        +6Qs+QOw8au5PfZ+ofBEhtHopaKv/aA=
X-Google-Smtp-Source: ABdhPJxuePP5dUDXvvEe0TLrs3JSs0isr3haZy45xjeRvwWfqGtDxS4ZotzLmgd/A7ULEVnOUrFcbw==
X-Received: by 2002:a92:ba14:: with SMTP id o20mr2099175ili.268.1606293179184;
        Wed, 25 Nov 2020 00:32:59 -0800 (PST)
Received: from [172.17.0.2] ([20.36.200.16])
        by smtp.gmail.com with ESMTPSA id b15sm945804ilg.83.2020.11.25.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 00:32:58 -0800 (PST)
Message-ID: <5fbe16ba.1c69fb81.6e3a4.361c@mx.google.com>
Date:   Wed, 25 Nov 2020 00:32:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4841168810073341729=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: doc: Fix qemu unable to mount root fs for test-runner
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201125075707.492685-1-tedd.an@intel.com>
References: <20201125075707.492685-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4841168810073341729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390729

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
doc: Fix qemu unable to mount root fs for test-runner
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9: 
 Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

- total: 0 errors, 1 warnings, 4 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] doc: Fix qemu unable to mount root fs for test-runner" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
doc: Fix qemu unable to mount root fs for test-runner
8: B1 Line exceeds max length (84>80): " Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014"
17: B1 Line exceeds max length (102>80): " Kernel Offset: 0x2a200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbf)"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============4841168810073341729==--
