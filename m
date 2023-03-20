Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3753CC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 07:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTHB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCTHB4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 03:01:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DB1B328
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 00:01:54 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x8so7065952qvr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679295713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dcrcefB/TcyCxc4GksfkQ6WwHLBrnddwKboUZzTX3ls=;
        b=CPc7y+Bn6UCavopF4NX61agkCJSRNfJQMiRe+fd4o7xMCyGBkomVfzzEq4HFrkHXKy
         W6fHG5lZTp8AFxMlls+gfxWz0U0C6SX67NwQIUNCuMX/VlqV/RU6eVVsUuS13LRaqsEM
         sCtbCBXQPATi87a1Sn7atsqS5A4NwBfSyUcKw6QliD0WLJXL7WautV/+516Dv1zBCvCf
         Swa8pTCpjjk1Ha0KQUMnOd5OrgUUMt3/lQSKMBrOSGgpNYKyRvyiPfN2kWYEi+7eHGAP
         wIS87pXGtHoABdxGbv/y0nE4idNcM893SmuiRZ1WP7U9VGaEgcBgtIoJ1K0e8teQyt3I
         5f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679295713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcrcefB/TcyCxc4GksfkQ6WwHLBrnddwKboUZzTX3ls=;
        b=VAuls7Yu/xV9rDlHNst7jsoGB+U1oTxMI+/ztlflJB7vvvajLNmzCOd5It731Mdrrv
         fG47yWsyMViGKG+/cgSlznGX3Yav11H1zlh3OZCBh+Ob3v8Uv8QrTr6e6ZGA/TSE3J6Z
         odVbulbONhDEPvfztExh3tQ5OUBQFaxM8YjktxszyOo/SNZG422WmDZnJISDGNIADKZE
         GvxDia4zAlntYiamXB/TrLGbNKsJRfsIjnslpqV/rYjOyIOQsOpRBCYHslyQK5MnB7uT
         a/GEPRKVHNm5zYhsK4NBSesUSzHlwTjrTgK3KdBckCdIzzu+HGWAPxMhjl5EgvuqwSNd
         OGzg==
X-Gm-Message-State: AO0yUKUrqb699IE7+kEBk6QPUxW+qJ2E7lfCJpC5yjf3XCvjljN38VWo
        nFjgQxBTWiWVKXoC/77i12x/rwo8zS0=
X-Google-Smtp-Source: AK7set8qdwTUp3/HLUJKIsVo2GZso44kaXJIKkHZai3JXa0W/CgMrv9tFsjdhklIwAndCl/gyLR9KA==
X-Received: by 2002:a05:6214:19e9:b0:5be:cb17:90ab with SMTP id q9-20020a05621419e900b005becb1790abmr17364181qvc.40.1679295712918;
        Mon, 20 Mar 2023 00:01:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.104])
        by smtp.gmail.com with ESMTPSA id 14-20020a05620a048e00b0074636e35405sm6776400qkr.65.2023.03.20.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:01:52 -0700 (PDT)
Message-ID: <641804e0.050a0220.f67ad.3262@mx.google.com>
Date:   Mon, 20 Mar 2023 00:01:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3458789212105275537=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com
Subject: RE: Bluetooth: btintel: Fix: Add LE States quirk form Solar onwards
In-Reply-To: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
References: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3458789212105275537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731691

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.69 seconds
CheckAllWarning               PASS      34.44 seconds
CheckSparse                   PASS      39.17 seconds
CheckSmatch                   PASS      107.40 seconds
BuildKernel32                 PASS      30.98 seconds
TestRunnerSetup               PASS      426.98 seconds
TestRunner_l2cap-tester       PASS      17.22 seconds
TestRunner_iso-tester         PASS      17.53 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      113.56 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.44 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        PASS      7.23 seconds
TestRunner_smp-tester         PASS      8.25 seconds
TestRunner_userchan-tester    PASS      6.07 seconds
IncrementalBuild              PASS      28.88 seconds



---
Regards,
Linux Bluetooth


--===============3458789212105275537==--
