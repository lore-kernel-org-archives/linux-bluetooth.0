Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiKRJbE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiKRJbB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:31:01 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46998C49D
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:30:58 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s4so2770199qtx.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LvZjF8eLy6qWU5IZHq0PNElE9eZJ0GL9YfLBS+KO32A=;
        b=GCo75WEGE0wZfaRT/XLe07AoKSqRBZ867x1abJSdSss/p2NtFXV/zywxUShlhu5r19
         wev2XHzYmuvNVyVUkpS6uEeWRo5rTc79zcKKnNmU3qbJ3+3slpY8VtRHMUi65++16AV5
         5FdVJ2XbiorX1dchkdBbT0k6HEW2JnsZILrY3oCBl1w48Sv1xZCuVbALQKySuWCJdPtS
         t6CP1JnyqWgZ2nIdF8LtwnboPKWxqhHPh8L8ZjOXbnqqsxHyXaEUQw7pbP9VjQeGRbUz
         BZhmiTZWIvTRpSB1RX9nLvEQzusl5+aBuNVuGc7bmkvduDkD8oSA9cxUUM/PoyD3yx0Y
         tVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvZjF8eLy6qWU5IZHq0PNElE9eZJ0GL9YfLBS+KO32A=;
        b=W6L1KlyKmFHKFYWmG8dclvJAGPpW4Tf0vN231UFk8mszFCz46QW/DXmCXvqWyQbZMj
         mmRvZm5pFWnVfhKN3pBxUsCDmp3TR92LFReln1rWDSXTEJv/GrKILtChlBJMPpKNJMiv
         0nCU52IMHt6G8mRq4RSJiTOq4dsTVJF6DZ5XxykRaCihJ746DrmHteQ41fsOUHmOT8Q4
         nBIDEze8aV7RKtmXJpRabx5LvI4JHpQe0xNizjzn60XdASHFfvIWohRMMnjy+MuiXigD
         cV0+8Do5jRu8DNjek7ljTenEPtoUQ0qEqDwDKKO9gsp4rGvpJFgpPepzh6vKoIJnQFzP
         SF/Q==
X-Gm-Message-State: ANoB5plYS1LNA3G4Yt3mytNOW3V1qamFuD4DI2l/N/OOb0FJJjsAszSl
        CR1dVLP2neV1kG3tNh4MxLiZj0Q8BPrG0w==
X-Google-Smtp-Source: AA0mqf7Dmc5mijXE0TyFNuDAT7DpoMNfJOADuRax6F77kPZPEFacmLzbBpTIS9nqQmaotZENkRo+vQ==
X-Received: by 2002:ac8:6792:0:b0:3a5:1c8b:8890 with SMTP id b18-20020ac86792000000b003a51c8b8890mr5990280qtp.63.1668763857493;
        Fri, 18 Nov 2022 01:30:57 -0800 (PST)
Received: from [172.17.0.2] ([20.22.184.227])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006fbb833fef8sm2083871qkg.28.2022.11.18.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:30:57 -0800 (PST)
Message-ID: <637750d1.050a0220.260f3.9a1f@mx.google.com>
Date:   Fri, 18 Nov 2022 01:30:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7768061432373301413=="
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

--===============7768061432373301413==
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
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.82 seconds
BuildKernel32                 PASS      30.51 seconds
TestRunnerSetup               PASS      425.75 seconds
TestRunner_l2cap-tester       PASS      16.35 seconds
TestRunner_iso-tester         PASS      15.92 seconds
TestRunner_bnep-tester        PASS      5.60 seconds
TestRunner_mgmt-tester        PASS      105.95 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         PASS      8.96 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        PASS      6.99 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      5.89 seconds
IncrementalBuild              PASS      31.59 seconds



---
Regards,
Linux Bluetooth


--===============7768061432373301413==--
