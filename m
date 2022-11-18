Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0BAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiKRHcr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiKRHcb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:32:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBB8CB9B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:31:52 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h10so2838737qvq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M5mHybbazzzBCKRD5FUMQ2kNgIYWgstp577Niy0lyXA=;
        b=gpn0gnkC/kve2GhfSlXx/U0MSM7U54QZWS3x9DokQpzsGct3yGFCEz8/ISUSrlxVEq
         Sw+qLjJm/tDj/3bcymUiPguX0FEgChdN1HEg+1In5A+II99fvzySFy/0gcIDeyXkJ2x8
         KLMnAj3O0WDXpDNoFoutrIzgn6mPyM2IGOSvan244cwqSo0hlo5rVPsUL/4hoYGSlxf0
         EVul+wzwhtRdgYdQC/aQWWgZ3lzNYnw6pQ4LTHAqi7U7E6vE8IGJFa01SmZyBLygj8vu
         kfOTj3e82xmLFR+sCCnazgSP59GXouUw+kek+INSCj57UK6pLNCHJIM6/nXct9sDwQQB
         72ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5mHybbazzzBCKRD5FUMQ2kNgIYWgstp577Niy0lyXA=;
        b=Ys/uPAM9YUTqMWuDaSmMd0lekR8x0VhbwpW6L7nwan5vE7iqzBRSGZfyfqg9KTtyyy
         /WMJa2PZMicINTuPwBKM+M57mQ+vZPGWEbzy0ZkbUrV2QKJdILfD7HgggKAhQL/DRPG1
         7nEBQFwzmr2cFpieHdBfFgFwfySCPvlzeUi76YzAtQJr9NKbNeARh68sdJJgfrNoONB7
         XsPfM+jP7c76EEihx6vU9ARdcDx3X+BK0X6/K+5t8+qKEV10j57j4xmomYKVMW5+5RUf
         RhZ/PpKkB/ifz9Atq3ueFvNBrhMPV8ir4o0XRKD/ANKsJGNh0VmQA8evyBD7gG2tfMMz
         4tOA==
X-Gm-Message-State: ANoB5pmkDIklf+9j9Niy/NYBbFJEDaPPz4+viKKMylX+JHAWeFysIRQw
        T2X6PCU4vzJgtXOtimeZZLMzXXfjxhdejA==
X-Google-Smtp-Source: AA0mqf7XdlFurdCZCzrkWPGxxpeXffBXibcaGYVAM+R+wSNHHmOHehQzYbkrfRpNDZ03zPCk++BMkQ==
X-Received: by 2002:a0c:fd65:0:b0:4bb:b0d5:2113 with SMTP id k5-20020a0cfd65000000b004bbb0d52113mr5670632qvs.87.1668756711188;
        Thu, 17 Nov 2022 23:31:51 -0800 (PST)
Received: from [172.17.0.2] ([20.163.246.23])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006cebda00630sm1950800qkk.60.2022.11.17.23.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:31:50 -0800 (PST)
Message-ID: <637734e6.e90a0220.92b90.95a2@mx.google.com>
Date:   Thu, 17 Nov 2022 23:31:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7489951505244500742=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7489951505244500742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      38.69 seconds
BuildKernel32                 PASS      34.79 seconds
TestRunnerSetup               PASS      489.22 seconds
TestRunner_l2cap-tester       PASS      17.50 seconds
TestRunner_iso-tester         PASS      17.58 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        PASS      118.97 seconds
TestRunner_rfcomm-tester      PASS      10.72 seconds
TestRunner_sco-tester         PASS      10.03 seconds
TestRunner_ioctl-tester       PASS      11.72 seconds
TestRunner_mesh-tester        PASS      8.04 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PASS      37.34 seconds



---
Regards,
Linux Bluetooth


--===============7489951505244500742==--
