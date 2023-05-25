Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C850C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 01:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEYBSE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYBSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 21:18:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729FF5
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 18:18:02 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19eb96bffd4so827155fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684977481; x=1687569481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=htc51eH8vKbyAMC3rVBmB4y0mLw2pGdPsackfSOiBI0=;
        b=SGPBlHCCbqcOag/EbnaOEj4QHvqARimL/mZ/9OWJ7nhU99hr2rR/us2QpYBIboN53t
         405ePUjiSLHwMChvlIaDt3BIaD5eUFYN/Lo3BfYPp+N3kxeY0lMwKAna2tFXkOYvacTG
         TFCdYCshmeR69sxcXrhuSCb9X+iKJJ0pJpjU/WfXtGJX+epDN5vuTkXwF3fd7EQ1EscE
         JcD8xYt6/6jDPw3dwE6fSN80hRVFUdAtG312Yd8o5o1tD2c57yeJDIUMbjycE3BWDuBW
         NlsqNGsFF+/yFQyMSpV+A9gwZ9SKoxo3v7YohnJQgTb8VxT/3/cdbIGEiOZdc27ZOFBo
         OzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977481; x=1687569481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htc51eH8vKbyAMC3rVBmB4y0mLw2pGdPsackfSOiBI0=;
        b=f9sSKPv0DsyLv5C4BR9PpwHMfT3M8t1EW5xAthbckElrVvbd9pQtmbSCWueZgBkjVO
         zwQACfvlMsLGKmT7Ixxf/bj8a7QiCG0LuDJbJIn3onfiBz1M2lA8627J++7D4MyjyOX3
         4VkfLpSsrz75Bb9mXJFqCdMkLu87BcYuQOd1tcNjnuGR3fXaWJGD3OrX1YRCQ0Fzxwaj
         WnftJAODvnkTC9H0AcJ3op5YBcCI9RMKh9aYNIhc4M8dGHl2tt+f586SwStGhz+i4Kzw
         Nx4Cy/GwOW0MNqqdghvFgPbAjuqJPb84pCYlIHygm3LapWqn5mpZOnOBM0miQZTaVwS6
         TJ4w==
X-Gm-Message-State: AC+VfDwUgEigG84hd1NP4R555a4enGw637l/2I0Pz3CafARPFErJ1rih
        hUmWvojsf9KQweS07zLA8MHSydIYcr4=
X-Google-Smtp-Source: ACHHUZ5BY8/OcMOutgEpjbQqJSxY7fnF/3EFEgLY+HkW1DiKxHNvE5r/R6oKoD+okFTLOjkgNTnaSg==
X-Received: by 2002:aca:917:0:b0:398:5929:fac1 with SMTP id 23-20020aca0917000000b003985929fac1mr965853oij.28.1684977481362;
        Wed, 24 May 2023 18:18:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.233])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0b03000000b00396050dca14sm5460279oil.28.2023.05.24.18.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 18:18:01 -0700 (PDT)
Message-ID: <646eb749.ca0a0220.27822.acbc@mx.google.com>
Date:   Wed, 24 May 2023 18:18:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9100154288029256684=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] Bluetooth: L2CAP: Fix use-after-free
In-Reply-To: <20230524170415.kernel.v1.1.I575ec21daa35ebba038fe38e164df60b6121c633@changeid>
References: <20230524170415.kernel.v1.1.I575ec21daa35ebba038fe38e164df60b6121c633@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9100154288029256684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750826

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      44.88 seconds
CheckAllWarning               PASS      48.88 seconds
CheckSparse                   PASS      54.63 seconds
CheckSmatch                   PASS      148.09 seconds
BuildKernel32                 PASS      43.21 seconds
TestRunnerSetup               PASS      614.80 seconds
TestRunner_l2cap-tester       PASS      21.90 seconds
TestRunner_iso-tester         PASS      30.25 seconds
TestRunner_bnep-tester        PASS      7.58 seconds
TestRunner_mgmt-tester        PASS      147.77 seconds
TestRunner_rfcomm-tester      PASS      12.24 seconds
TestRunner_sco-tester         PASS      11.05 seconds
TestRunner_ioctl-tester       PASS      13.02 seconds
TestRunner_mesh-tester        PASS      9.59 seconds
TestRunner_smp-tester         PASS      10.95 seconds
TestRunner_userchan-tester    PASS      8.25 seconds
IncrementalBuild              PASS      41.64 seconds



---
Regards,
Linux Bluetooth


--===============9100154288029256684==--
