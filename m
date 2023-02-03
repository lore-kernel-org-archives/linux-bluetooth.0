Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3ABC636CC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Feb 2023 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBCJ5i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCJ5f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Feb 2023 04:57:35 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E024712C4
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Feb 2023 01:57:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so4829494qto.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Feb 2023 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7IMjzUclK/eYv3EXLko9LyhABIub74O5QhEJA4mxseQ=;
        b=KxLB/tjVyzLOXHX44CcRO6H2oX02hMj29CDXPXFfjERXvL47VU1H8jPp/bQMp1Y+LZ
         FlwTrv/o6tGUoQdTUIoLDr7JfCD9g25LjoJPzov4oWaWGBBiyWsRGwkckHY79TSwcL73
         wY2z3+diRYEaYXLcWIuwJT6DuhYHgc7UwAXt4Vv7/7OQr6VMEww9uEaz9OW3dagAT2Uu
         B8leaCgs6vz7catnEIO5LeO+w9NZpFr3hNgYjVw/ZVWzq2zxrTJyvUY3HhU4d9ClZjSY
         8o3cEhX2GmqwulCayiH+rZsQE+kXtQRD0Pe2+1U+sLkb3OKe92/O87UkV3i5PB3Tz4xu
         QQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IMjzUclK/eYv3EXLko9LyhABIub74O5QhEJA4mxseQ=;
        b=5U7s8capRY0YdxZxnoNfsD1OnqSoNfEk4RN/I6RnSiHV6jDpA46LiOtEJvoMB3T6rh
         pnuV+xV5sqPhQ/ojsp1ChTf8AwLBeFXyJfxdihb5gbYn0r3vr5judEPEtIdviYdUPiI5
         6bCfcROjuM0b9sRq+y6bGlfWT/edB9RN3wM2/jzyVt8Z7AmMqGnL7LG3z67ECiQQW6kv
         Zjvl7SIKbQiPZBaPh8Ggo56mZ1wXrf4JqBkb2dZN0T1b3z8eYuOF2cRwLjKzf4e1RqFO
         GN7j9n6J3MUijrTJuOq+gvOjakTeenpXt4GORsp3otOKSbvgIApYk8MHMgn2zzZGUfMg
         m3Hw==
X-Gm-Message-State: AO0yUKWI4s7+AT6YxuX/Lk4lmGsdydIXllX5FEHnDYUghWyLVEOT2EPW
        44lR9XLUyG5QKkNaFLNkYEN1U5Qs1V+1BQ==
X-Google-Smtp-Source: AK7set+mjnWJVchzmhBi9D97+8NKNXGweAuf9iEU3Re9AU5BWY7T50N9RtrpYi8XtGPKbZbUwnzdjg==
X-Received: by 2002:a05:622a:1790:b0:3b9:f459:b096 with SMTP id s16-20020a05622a179000b003b9f459b096mr4376842qtk.13.1675418254067;
        Fri, 03 Feb 2023 01:57:34 -0800 (PST)
Received: from [172.17.0.2] ([172.177.114.130])
        by smtp.gmail.com with ESMTPSA id bk19-20020a05620a1a1300b006f9f3c0c63csm1540690qkb.32.2023.02.03.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:57:33 -0800 (PST)
Message-ID: <63dcda8d.050a0220.60350.4c25@mx.google.com>
Date:   Fri, 03 Feb 2023 01:57:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5011471546833941528=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: Free potentially unfreed SCO connection
In-Reply-To: <20230203173024.1.Ieb6662276f3bd3d79e9134ab04523d584c300c45@changeid>
References: <20230203173024.1.Ieb6662276f3bd3d79e9134ab04523d584c300c45@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5011471546833941528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718492

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.67 seconds
CheckAllWarning               PASS      35.09 seconds
CheckSparse                   PASS      40.33 seconds
CheckSmatch                   PASS      108.31 seconds
BuildKernel32                 PASS      31.15 seconds
TestRunnerSetup               PASS      446.14 seconds
TestRunner_l2cap-tester       PASS      16.98 seconds
TestRunner_iso-tester         PASS      17.80 seconds
TestRunner_bnep-tester        PASS      5.76 seconds
TestRunner_mgmt-tester        PASS      114.33 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.51 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.42 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.05 seconds
IncrementalBuild              PASS      28.98 seconds



---
Regards,
Linux Bluetooth


--===============5011471546833941528==--
