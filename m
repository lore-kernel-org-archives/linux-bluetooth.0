Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875BC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiHASMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHASMo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 14:12:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284EE15FF1
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 11:12:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c185so8995699iof.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=poxYjFq1FWIil4mSs62y6fmVOp/jyChqb4MrwOSRsd0=;
        b=SmleJrnIMPjrOpAfpQNT2Ox6keVVl5mizMGG+fZbHlSCtv1Gr335udRiasch80wjlY
         d8qffFK15oFJkN2NB//ugKl+nh6vJUXS4fX2PCCJ9mbtECNUfWVc+rlWLeTvTw+4EsC5
         ADkrO4843mj3xDWJ6SNjWT1c3VfFaD8sa17nGNlwe/130+caoMiJB124yQx7RSe0IlmR
         b4wKwbxHgGK9NkZAlcEjR/0lQam345DBjMtO0Ie26WGFO3hbjvTjyRj1DhFe7s8HyVjd
         N4PvecBaoEWZH2ley6Fxp6qGDkjdxBOxcn5ogCHv+GT593yDUOe5cFEiYX3QKdr+3Ao0
         SHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=poxYjFq1FWIil4mSs62y6fmVOp/jyChqb4MrwOSRsd0=;
        b=GcaLXh485pHX7O05fxPp48aVs48dDoCo5rfZAERDoJFP0RlVOIK9g1c9q+0uFYR0eE
         gnZehYeqQOHRn0VSmDWYODwGeq1rPwvwBOY5EPyEEdE8n1Nd5eZWQqKNOgxjFD+fi7ow
         jr2qtfAcRTEDhQvq12eL3FyXvrLbkYb80f8qZDDNdwxLcVSYrz7gdflJ1u8rWWiPnMbt
         pWmiXxmtZ+ZpoDrnMzpzg+M7MRmU7P/h6jGy+hNzv4dxte7h32AIPFvm8IkPa5ERrWbd
         SbS0NYFBjFEpR+TzgyHgBBYeaUX7nxvE0OvqYfuLSm89hrgXnAL7aGYF1xo729h/T38F
         8RYw==
X-Gm-Message-State: AJIora/9o7t4Pe29rV8bRocQFKG/zqGoI1iNjM80RbtPpa29AKGVUXM3
        UlOJasNgCaGKH1RrzpGCWUJF35VqEUM=
X-Google-Smtp-Source: AGRyM1sPGKJu2KDQHEdS7stNNL/J8Em75Lf2IUcDyAWeG3zK6AWBz8CsuFPdgMJ9fuanuU5JjAFI7w==
X-Received: by 2002:a05:6638:4115:b0:33f:8715:cb15 with SMTP id ay21-20020a056638411500b0033f8715cb15mr6982392jab.189.1659377562144;
        Mon, 01 Aug 2022 11:12:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.145.228])
        by smtp.gmail.com with ESMTPSA id z12-20020a056638214c00b003427f78c30fsm206058jaj.8.2022.08.01.11.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:12:41 -0700 (PDT)
Message-ID: <62e81799.050a0220.2e22c.0808@mx.google.com>
Date:   Mon, 01 Aug 2022 11:12:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4692793719549820468=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220801171505.1271059-2-brian.gix@intel.com>
References: <20220801171505.1271059-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4692793719549820468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664552

---Test result---

Test Summary:
CheckPatch                    PASS      17.22 seconds
GitLint                       PASS      7.55 seconds
SubjectPrefix                 PASS      6.28 seconds
BuildKernel                   PASS      32.10 seconds
BuildKernel32                 PASS      29.15 seconds
Incremental Build with patchesPASS      201.28 seconds
TestRunner: Setup             PASS      480.60 seconds
TestRunner: l2cap-tester      PASS      16.65 seconds
TestRunner: bnep-tester       PASS      6.20 seconds
TestRunner: mgmt-tester       PASS      98.89 seconds
TestRunner: rfcomm-tester     PASS      9.45 seconds
TestRunner: sco-tester        PASS      9.14 seconds
TestRunner: smp-tester        PASS      9.19 seconds
TestRunner: userchan-tester   PASS      6.43 seconds



---
Regards,
Linux Bluetooth


--===============4692793719549820468==--
