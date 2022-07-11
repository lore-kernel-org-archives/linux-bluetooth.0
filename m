Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD247C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiGKX7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKX7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 19:59:17 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504B6147
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:59:13 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o133so8596178oig.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UjCFOwf0jWHe/GM/COFL2k5eoeDCrZ/VMVxX8o6Vq30=;
        b=OeT1pIqW4IHISb16rIFrHVw7dd1vi+UywY/Wxrtpd1qwSu9Y+KM6lNuIhAZN+w14dc
         6k1Dl/ZkpqaVbZnz6xQGSn4tQnyKsNtTVuoSD/H6Fl4zDTFqeWU514LslqieGcVrQjRN
         cP7fznxldvruy9YDIh0+t3fJyoXqQzcOpzFGFXyzYgCrd6OaUuCGpIRMeM0e2jbWaYvt
         URIuT8vKqj5TyaG3tGuHN41KFpPy0sxsALMsJVavYFhp4E+63ZsfrB81bJqpXk5dud6f
         wGXS8ZTPN531RahZLDpewMO7kZF8XU7ECryhAtw+kyd/squU6znOvoX5/2Vdln8UHXPh
         nsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UjCFOwf0jWHe/GM/COFL2k5eoeDCrZ/VMVxX8o6Vq30=;
        b=GsbTPZXXe6jstFgIJJGTFnOY3GNKd29dVKT72CuStezb2HM5CLLni7gnUbpyz9ZfPf
         ufDBgbPnNzJDL526u+uCZ3YmC7UgtO9AaHfjT0zOEjyzLFStW+yUzm27jcxBAQKWVYcP
         VyfHYGSctAgncizSiG8eahOlhsQefeh3OlMaJpdxLlvbmKGDaK47EIT+S0PGCNDYFkeT
         pErUwUQIqtKsVEt5SpTDBdVjcAlrRAIM3QPXGoAJdXA9yZQTdTg6kk2yyc9nrR8CwiwJ
         lw4b1Y8yyRe5vNBfFwOrHHClqZ1OWagHT7XLzsc87n5xoSf6MckyMCLQ24hFEzySJHq3
         NYTQ==
X-Gm-Message-State: AJIora/IU5VI+vFO/rPQ2En/bUnIZhvY3kDF1AmBzl6lYfX7xJDHxd+2
        YEGzvhCLTIBFVswjsxLJIvVfXJnMA8Y=
X-Google-Smtp-Source: AGRyM1u8ZAE5OpxAUv4qghzlu1qq+dP9yYASz3UWSl2T31VkJjBg814IbQ75ePuDmAKSS0s0aUkIlg==
X-Received: by 2002:a05:6808:158e:b0:33a:4e2:3ae5 with SMTP id t14-20020a056808158e00b0033a04e23ae5mr591213oiw.236.1657583952970;
        Mon, 11 Jul 2022 16:59:12 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.90.230])
        by smtp.gmail.com with ESMTPSA id eh40-20020a056870f5a800b000f342d078fasm3938940oab.52.2022.07.11.16.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:59:12 -0700 (PDT)
Message-ID: <62ccb950.1c69fb81.1d2c1.c258@mx.google.com>
Date:   Mon, 11 Jul 2022 16:59:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8984191173231710860=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: This patch fixes a previous patch which did not remove setting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220711155349.kernel.v1.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
References: <20220711155349.kernel.v1.1.Ia489394ab4176efa5a39ce8d08bb4c4b7bee23b9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8984191173231710860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=658707

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       FAIL      0.91 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      33.12 seconds
BuildKernel32                 PASS      28.93 seconds
Incremental Build with patchesPASS      39.50 seconds
TestRunner: Setup             PASS      487.99 seconds
TestRunner: l2cap-tester      PASS      16.99 seconds
TestRunner: bnep-tester       PASS      5.85 seconds
TestRunner: mgmt-tester       PASS      99.27 seconds
TestRunner: rfcomm-tester     PASS      9.02 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: smp-tester        PASS      9.19 seconds
TestRunner: userchan-tester   PASS      6.15 seconds

Details
##############################
Test: GitLint - FAIL - 0.91 seconds
Run gitlint with rule in .gitlint
[kernel,v1,1/1] Bluetooth: hci_sync: Fix resuming passive scan after suspend resume
1: T1 Title exceeds max length (83>80): "[kernel,v1,1/1] Bluetooth: hci_sync: Fix resuming passive scan after suspend resume"




---
Regards,
Linux Bluetooth


--===============8984191173231710860==--
