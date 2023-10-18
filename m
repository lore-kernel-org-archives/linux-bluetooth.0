Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764BCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 12:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjJRMqW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMqV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 08:46:21 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DA98
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 05:46:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d0169cf43so43554196d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633178; x=1698237978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qywHkSxN4C6KIirMZLgDyt9xsiReAsB3D/TVbjGel1E=;
        b=VC1OeoUPT/62YDHgmbNGixbvj16aawIMBsLeyuvOYzND2nltPTofZfv8tb7HIG50im
         m93/0vZimEyy1ya+CF64rhXN01Z8TOTdvwSCLpiruSzu+14gTeR9IofaAzm/5hhRac+v
         nThztowVmffV0deORtZZDCAG9455a+VsVE9Cxrf63Y42eEGqVLPCRmuWasvqX/nQLTlh
         RN2CF+rZrYbarC7nlS7X4RJDPLNy8lSEwLlFry+Bw5M0fVC7hNR2n20c7tZjFIfcv06Y
         6ck0mH7d2/Z+tIaILEDEA2RLeDHuJqM/weWUVpxoqlV1k+bxENJLp35STIs3uKT+sJS8
         ISUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633178; x=1698237978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qywHkSxN4C6KIirMZLgDyt9xsiReAsB3D/TVbjGel1E=;
        b=hVhqfKhydIIlnD3TXxTADbvL6F1+HTf+HUeRFU+z06AR3ASYiirzF562x/ByEjegKs
         D71m4aAFAuiwYu5xAs7D1DBcK7vWIZUT+NtE2VO2uNXL6WSzYd0tTWC/4iRUewU9Jc5W
         /a8sabCBstJ5+JuQPsxruTZHNht9psecW5/wcuNlHD6lYUbyIx+5K1jSj1J0453U8mdj
         BTGVA9X2ZkuOiWvtcpsquy2/hDCK7G9UUjv+Z4zH3SYZmTqqd7kN4qOIHcVk2saJ98xe
         +QWcGjsgym112tKtM/m9JkQYnCDd2VfKMIT8umtLFKWE/j43j9A8WSp1Oox3deAy2jr5
         AJtw==
X-Gm-Message-State: AOJu0Yy4uV5WFog3nfR1BRbLQnkX27Nw/dclgSs/SimgTgxGLQ+76K2V
        74lwaRxSh5TN8pFkztZz8gl7GwHYyDw=
X-Google-Smtp-Source: AGHT+IHLBruVkAihe7CFaXr21wrUpiTCxHPL0i9YIN5LgMFfzMyCxfsZpeVIde9pqTa93u4Qrq3erA==
X-Received: by 2002:a05:6214:d0b:b0:66d:20f5:23cb with SMTP id 11-20020a0562140d0b00b0066d20f523cbmr6158911qvh.5.1697633178649;
        Wed, 18 Oct 2023 05:46:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.246.192])
        by smtp.gmail.com with ESMTPSA id mh3-20020a056214564300b0065862497fd2sm1310544qvb.22.2023.10.18.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:46:18 -0700 (PDT)
Message-ID: <652fd39a.050a0220.a0041.649e@mx.google.com>
Date:   Wed, 18 Oct 2023 05:46:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7314824340308111617=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: Bluetooth: btusb: Add return error code
In-Reply-To: <20231018115557.200757-1-youwan@nfschina.com>
References: <20231018115557.200757-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7314824340308111617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794307

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.48 seconds
CheckAllWarning               PASS      36.46 seconds
CheckSparse                   PASS      42.13 seconds
CheckSmatch                   PASS      116.35 seconds
BuildKernel32                 PASS      32.36 seconds
TestRunnerSetup               PASS      508.66 seconds
TestRunner_l2cap-tester       PASS      29.94 seconds
TestRunner_iso-tester         PASS      61.07 seconds
TestRunner_bnep-tester        PASS      9.88 seconds
TestRunner_mgmt-tester        PASS      209.56 seconds
TestRunner_rfcomm-tester      PASS      15.19 seconds
TestRunner_sco-tester         PASS      18.56 seconds
TestRunner_ioctl-tester       PASS      17.14 seconds
TestRunner_mesh-tester        PASS      12.44 seconds
TestRunner_smp-tester         PASS      13.64 seconds
TestRunner_userchan-tester    PASS      11.88 seconds
IncrementalBuild              PASS      30.88 seconds



---
Regards,
Linux Bluetooth


--===============7314824340308111617==--
