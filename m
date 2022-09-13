Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788FFC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiIMLLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiIMLLO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 07:11:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BE4F1B6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 04:11:13 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y15so6025972ilq.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=AtL4nH42b1YDkXam35FwAVT8wGD9yLpZUCvbIDRzBOA=;
        b=EJeCOgwGK8KsJY6u3JD7unQpLsvkIfV7amvOsJM4kaCwYBN/FAj3UeISUmRQur7X8J
         lwnN4RMisj18qRvuCP073mi9gAewdCdg4FfQPh0nPXJFhhZbVfbVBxvZdvpiECMGU3mn
         2ZlmR39kU5NNr2scl83HX5RAQ5WIAXnAh0UTd9Vmh1GsDtB+VP592E3gcHbndnZBgRGE
         8bLBa/rAdWaATE6t5wMrlZaWFjL02gjVuwHFKSy53n7yGE7WAXkl7DsZcMvWhzP42yib
         VSq3lj7xtyIWYJH96EBLgxdIdSXdk48HVt1dhJYBbSinrTs/0rNb9C0BulZKuieMWqLT
         XWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=AtL4nH42b1YDkXam35FwAVT8wGD9yLpZUCvbIDRzBOA=;
        b=u/qcS7kXIgOTOUaGtfna2l8QcKLhUkIF5lWukkL5d9rKQFqX7BUUOW91wVGDuRgyda
         AvQ7AcjZXTYef4DuB9UD9Pygmq1ldDdG2dtQrsuKvA5YC/ERyQGUIykTqzAn7Cl6gSAw
         cRho32tU3/npcDw0BnFDQCM0mrF1H8SN5dgvYVTp2/fkUI529+ssj1w9d+YghZUbr7GU
         D+eVNkEQg2nNg44ny6WJkA5XOifhShwKR7eLlPnSE5eC+RYTZmRIR4px9bnDxwHEHkVP
         /ifjtDEYpJM7evnkjZVcU10WPMrIIpPNhZ5RJnx7bxkETH/KMS4rWzBAALiXuV2SXVHw
         HHrA==
X-Gm-Message-State: ACgBeo2SCvm/i3KHWwPizvcodt0rW7N0K6gW67bUfJuQSVMvnpzJqMFW
        NohxqiyQ39Un2h69RaaBdZkBSl0hWZc=
X-Google-Smtp-Source: AA6agR7GZzZl3iQz20nntRlox0LMpvbI1eUSKybraJcTis6FNhSZS5ZgwYBVO81Ij4ofIvQdKXsN2Q==
X-Received: by 2002:a05:6e02:dc3:b0:2ea:d7a4:a5f with SMTP id l3-20020a056e020dc300b002ead7a40a5fmr12044672ilj.308.1663067472035;
        Tue, 13 Sep 2022 04:11:12 -0700 (PDT)
Received: from [172.17.0.2] ([168.61.147.86])
        by smtp.gmail.com with ESMTPSA id v16-20020a92cd50000000b002e900a19516sm4934569ilq.38.2022.09.13.04.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:11:11 -0700 (PDT)
Message-ID: <6320654f.920a0220.76fde.42f0@mx.google.com>
Date:   Tue, 13 Sep 2022 04:11:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4839441262261072539=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: Add btrealtek data struct and improve SCO sound quality of RTK chips
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220913100244.23660-2-hildawu@realtek.com>
References: <20220913100244.23660-2-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4839441262261072539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676514

---Test result---

Test Summary:
CheckPatch                    PASS      5.12 seconds
GitLint                       FAIL      2.46 seconds
SubjectPrefix                 PASS      1.94 seconds
BuildKernel                   PASS      34.34 seconds
BuildKernel32                 PASS      30.14 seconds
Incremental Build with patchesPASS      56.77 seconds
TestRunner: Setup             PASS      501.76 seconds
TestRunner: l2cap-tester      PASS      16.63 seconds
TestRunner: iso-tester        PASS      15.66 seconds
TestRunner: bnep-tester       PASS      6.21 seconds
TestRunner: mgmt-tester       PASS      100.91 seconds
TestRunner: rfcomm-tester     PASS      9.78 seconds
TestRunner: sco-tester        PASS      9.30 seconds
TestRunner: smp-tester        PASS      9.38 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: GitLint - FAIL - 2.46 seconds
Run gitlint with rule in .gitlint
[v2,3/3] Bluetooth: btsub: Ignore zero length of USB packets on ALT 6 for the specific chip model of Realtek devices
1: T1 Title exceeds max length (116>80): "[v2,3/3] Bluetooth: btsub: Ignore zero length of USB packets on ALT 6 for the specific chip model of Realtek devices"




---
Regards,
Linux Bluetooth


--===============4839441262261072539==--
