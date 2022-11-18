Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8F3C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiKRIe4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKRIel (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:34:41 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0318EB4B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:33:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id x13so2919954qvn.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tlo0Ps2XD2N337w6+IoBYjQ+OqbZjHWDSPMSfcJ2+A=;
        b=Sz9Suvi+wRfsmNMIJpPvnyw9IXrMagohEWHFBMQr5LwMzLElnen/SBPu12qonvYcot
         lx2HOaTaM7ChH0S4m5tf4GBMEPFkwdms+pOCNd/vS15puxLqm9xwcLRMpBBaAY5BBhOQ
         0fiw8wIyYZiAB5ZRvdz+E1VKkZAYMDefnKlNvgshMzN0NU0OYzCx+z+sZOTfJg5fmOC8
         WTet4SR/FAYBs3MP6lILRg/t6XAJk5ghd9aHgngsQCgdziJjypaBjQKc74+BCXP7TSKo
         R/l4LDihtheSSqOqq6ZynS0wotHMVZ8GUUSodOW0A3WDl/gSCbKslWjZhrqDUcWG3h8j
         Ihnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Tlo0Ps2XD2N337w6+IoBYjQ+OqbZjHWDSPMSfcJ2+A=;
        b=Lyx4gAZOlyR4KMxXp2sZeeC8j6aYu3ZhcdK0QRmiPbDS20vcXN/+TnnB0sCb++aHsB
         sqjivpcO3dGsVEkVwKn1uZHEe3dAtCI3EMztrw9IhII1iqmwJFxlM9sPeIg/qAmHiBLO
         J4sNQyzC5UKuStaKJX28lRm0cmm2riM1CXqDA88lO+s2gTdnrHu4VVeN4Nmqgn8krMWG
         mKuUaGjrVsuAfcAz3HeMiXUkewlDkGRoBVVyAvTH11xsbZoE1UeXy/siVbT5BkQu8ICY
         9oTFSB33/IYZdnhIhpfH8j83kE8r0MnaBhITm/tjmHwqw8LFzK62sA4qnsprWAFgXwd4
         d32w==
X-Gm-Message-State: ANoB5pmT020x6UcfgT3u4q0OsxiS84Fy07cEi5sJpQsEGmG0lmQ1tt9u
        jVAgtOe3iqHIFwmd2lA49ACb4EuLW7gleQ==
X-Google-Smtp-Source: AA0mqf65vmydD1xAA9wRTFlE6pkCrfenZRql3TAHJ/8rVg2556FV7CORadrH4UwEn7pBWieGMadjgg==
X-Received: by 2002:ad4:5445:0:b0:4c6:62af:5e14 with SMTP id h5-20020ad45445000000b004c662af5e14mr5888022qvt.95.1668760423464;
        Fri, 18 Nov 2022 00:33:43 -0800 (PST)
Received: from [172.17.0.2] ([20.96.124.190])
        by smtp.gmail.com with ESMTPSA id dm50-20020a05620a1d7200b006fb7f94a65bsm2073773qkb.44.2022.11.18.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:33:43 -0800 (PST)
Message-ID: <63774367.050a0220.3ef9a.9b4a@mx.google.com>
Date:   Fri, 18 Nov 2022 00:33:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0805058445826653439=="
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

--===============0805058445826653439==
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
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.73 seconds
BuildKernel32                 PASS      29.94 seconds
TestRunnerSetup               PASS      418.97 seconds
TestRunner_l2cap-tester       PASS      16.05 seconds
TestRunner_iso-tester         PASS      15.06 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      104.08 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      8.57 seconds
TestRunner_ioctl-tester       PASS      9.68 seconds
TestRunner_mesh-tester        PASS      6.72 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.54 seconds
IncrementalBuild              PASS      30.81 seconds



---
Regards,
Linux Bluetooth


--===============0805058445826653439==--
