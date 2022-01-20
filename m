Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 09:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiATJDS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 04:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiATJDR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 04:03:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCEBC06173F
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:03:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n16-20020a17090a091000b001b46196d572so5193400pjn.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 01:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TJfgftrKoDqoA2krUvFaNJvEdNxtW0ZkEV9y1xgo+bE=;
        b=H0lUllZgZqgLG5+LzXlKKPRCcXH3IJvXp9PNHX/kI80oGeUSA9IclIclCGxIEKoU6l
         qjCbWC5xevcm2tqXcdRa0bb27uJojb9Tq8ckj8q4T9weBOhdk6X+MKPu4YzPzUC4rq6F
         xJ5SRXetlwoYYzugIrxtHFsEpNgl9kZY14SZT51URVm+4YF99lX1QDZg5lmQdKkycuS7
         6mesJsrSPKqeMiN+3CgJ7npOzCApDPwjqiLNYW/7xzGhF9NIM13wHUGxNSwxBO+b2R4C
         +cdL7/TjHIISpm200bPcP0S2ehGg7ukZRnhjnWgK5NmEs++UWYl9K6EEQcVLUniKSzWm
         Eavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TJfgftrKoDqoA2krUvFaNJvEdNxtW0ZkEV9y1xgo+bE=;
        b=omOZYw07LO67MC9Q2nr884pVEqLRm5DknNrhFxReTLOuMGaX3W13Fd9jC73EF4mtGg
         xle5xgQwrzxwiLIDh3D+LZdgQ9xIqsgH9wEZSVF/0vYg2cUvLbP65y7d41sI8j7qpvmw
         LB0bMMV2Y0/cDs3/apxJ5KV3xVpJWsXeC1PMZ3brt+X0+RTYFPAEt5eynWQURrYSPz9i
         uJC7LNYbAjKJFO4zvfh7oZHd/4TylbvlKbhW5RZeMTkcUuiv3gJ+QlY5CTuXV5eBRx3y
         eCgcON1BwGAWVLYziALdx/j+qnqPsU1z5yP/X3bmsLtSpjwqvFyg8JIbVRSnGzuLGing
         ClMw==
X-Gm-Message-State: AOAM531DQx/2bcvSkgHyMHhGZonYC0VOTvaYO6aK0BE7Go8btJXP8tLF
        deHe4MR7yifCEOsiay6Z9HJUataY/7c=
X-Google-Smtp-Source: ABdhPJxSRhT8M3FpZf2Q9puwq4QhwJGT1ZFA35KQ8jnaINesg2i0LwuPmxiAS2Y9C5FZLT465rZzzA==
X-Received: by 2002:a17:902:7c0b:b0:149:711b:2588 with SMTP id x11-20020a1709027c0b00b00149711b2588mr36287958pll.65.1642669396707;
        Thu, 20 Jan 2022 01:03:16 -0800 (PST)
Received: from [172.17.0.2] ([51.141.173.24])
        by smtp.gmail.com with ESMTPSA id y8sm1812722pgs.31.2022.01.20.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:03:16 -0800 (PST)
Message-ID: <61e92554.1c69fb81.923d6.5905@mx.google.com>
Date:   Thu, 20 Jan 2022 01:03:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8329453789616111021=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220120075004.293700-1-hj.tedd.an@gmail.com>
References: <20220120075004.293700-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8329453789616111021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=606839

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      29.94 seconds
BuildKernel32                 PASS      26.51 seconds
Incremental Build with patchesPASS      36.37 seconds
TestRunner: Setup             PASS      478.30 seconds
TestRunner: l2cap-tester      PASS      13.18 seconds
TestRunner: bnep-tester       PASS      5.86 seconds
TestRunner: mgmt-tester       PASS      104.31 seconds
TestRunner: rfcomm-tester     PASS      7.16 seconds
TestRunner: sco-tester        PASS      7.43 seconds
TestRunner: smp-tester        PASS      7.27 seconds
TestRunner: userchan-tester   PASS      6.13 seconds



---
Regards,
Linux Bluetooth


--===============8329453789616111021==--
