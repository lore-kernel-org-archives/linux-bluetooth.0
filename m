Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 23:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392404AbiDUXE1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392393AbiDUXEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 19:04:21 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163F48304
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 16:01:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x24so4375586qtq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 16:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=eAwMk3fNH6AJoTfiVHr0rAmnzztYyedNUm4JQhK4A6s=;
        b=EElpaNEZy2M8S6+AKyaNRoCAnK56q02Fexn0QUEneexc81T0Isyov2m3njjlQnb6jo
         u4s9iNi/i0gv64gFgrN/acN/dclcU5Ya+t94TVARud+HCXrdrbd4ExDdko/mF7u7wr8r
         Fy10xrbEQxiVLVhW66hfYOwXJtKbwtgYl0/6VHIl06NwORs0tj5p1KFz4vA1zk+saCAM
         tcNtW/o8BKTJX9w/CG6ZeRek6uVn3NvoHLJ6uJKUJoe0TELLwZjZeC1zGqFNwbRO5iap
         ttl9Asr5GROmDR9H+DYnu81yZnLBDCyyYlxwQ0G4FQAOgJoO64JYmj1bm//88BdjTMvc
         nnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=eAwMk3fNH6AJoTfiVHr0rAmnzztYyedNUm4JQhK4A6s=;
        b=gw+/amM+oSCU87GbrYOH+VXmZYHYOvGIyv9l40hOu/h0dPktmUdbkQ9OCyv5pQb8OB
         No90v07/9Md+78loQcVjF2TAdZHnnlfQkxwpR4XlP3BBHI/uPSyXSEUrIoWtwu54Sali
         dV3CYKURhqzxfVWYLBcd5iYhd5wHpUogZoVhC9aNBpbsheCnDKfo1wpXtUM2xsM4FxZq
         hS5yMmHD6LYPhJ/1yP6dom59END8qThUJv67SM4WydU/K26gkQyL+kNYOZsGcGSig2RU
         gbW5pvXCH1IqDqM6Vqzz+YZ4TRCwCWcKRQv769EGIsNXPtA4nWqVVFY9xo7PUSiLgjGA
         E6yg==
X-Gm-Message-State: AOAM530FENUorPZ2feGPLva2EsC5H9IA9Hclfz+iRU0E1crEGaLOjtxx
        WZxbkz9k3xM+RtBuqKvkeHwMP753u9A=
X-Google-Smtp-Source: ABdhPJxdOYPVQvzw4AqPHy6mE538R0LVX8nAFsRGKgUadC0b7Y06fAi/4WUZ1kY5yIsTQqodWSPbMw==
X-Received: by 2002:a05:622a:446:b0:2e1:b95e:3b48 with SMTP id o6-20020a05622a044600b002e1b95e3b48mr1296944qtx.310.1650582089730;
        Thu, 21 Apr 2022 16:01:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.77.206])
        by smtp.gmail.com with ESMTPSA id q17-20020a05622a031100b002f1d478c218sm303205qtw.62.2022.04.21.16.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:01:29 -0700 (PDT)
Message-ID: <6261e249.1c69fb81.661cd.1e60@mx.google.com>
Date:   Thu, 21 Apr 2022 16:01:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1945223072382211363=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220421214607.3326277-1-luiz.dentz@gmail.com>
References: <20220421214607.3326277-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1945223072382211363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634391

---Test result---

Test Summary:
CheckPatch                    PASS      5.65 seconds
GitLint                       FAIL      0.99 seconds
SubjectPrefix                 PASS      2.65 seconds
BuildKernel                   PASS      31.29 seconds
BuildKernel32                 PASS      28.64 seconds
Incremental Build with patchesPASS      72.57 seconds
TestRunner: Setup             PASS      476.19 seconds
TestRunner: l2cap-tester      PASS      17.44 seconds
TestRunner: bnep-tester       PASS      6.36 seconds
TestRunner: mgmt-tester       PASS      104.48 seconds
TestRunner: rfcomm-tester     PASS      9.90 seconds
TestRunner: sco-tester        PASS      9.69 seconds
TestRunner: smp-tester        PASS      9.82 seconds
TestRunner: userchan-tester   PASS      6.58 seconds

Details
##############################
Test: GitLint - FAIL - 0.99 seconds
Run gitlint with rule in .gitlint
[v2,1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
13: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
25: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
27: B3 Line contains hard tab characters (\t): "	gateway SDP record: Connection timed out"
32: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
35: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"




---
Regards,
Linux Bluetooth


--===============1945223072382211363==--
