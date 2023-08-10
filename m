Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D283BC001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 10:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjHJKgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjHJKgv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 06:36:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E310DA
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 03:36:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7910b9bb891so22643939f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691663810; x=1692268610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xpOk5YKRpHRWE74Prh201GYxSKUgGCj9domHIC//sK4=;
        b=bQIO3cTlzehAn02mqM0t1MZ/0J6r5rBWJkRsXFZfj/aLRfRIUAEdfqfdvMlVjaaHhg
         g1YgEge/exiwMoftYJTiYzseZhIRYJTicgLRSHjOUpZi6gGlnBc0y0wpJ8D/G+1qER/a
         BnWFf9mVPfOfTifBV0jxlGrzB5KGC+NFE9diGa49FfFHr+weru/e8ii7n1KZUltn7Bo/
         +81evuOAVnc2lfe6UXgoz9gplp0oluOPq65SUnR9LuiHHrwQsrUFdj6jIVyU+xLobCT6
         xslxlDG0nUdBWNiWuYeeRx/iEiKXXSSDeadFjw4ZBQtHUBsylRHB+/0/McaWKxLPLhsj
         cuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663810; x=1692268610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpOk5YKRpHRWE74Prh201GYxSKUgGCj9domHIC//sK4=;
        b=kkP6bzoKzryeansYR9xdS8Bya24RGDEkZuh731L6NUulWaqSD7sRJdJlx9vUJ4pAct
         ZQLpsa8kpXffo7fpqnKevypRIuO1ezgnJZYLMecak5FWXRrqZ0vmFHbk7jtIbcEReCHe
         O8B3oIx9Kjd+FnhyZ2p28K4J7m3ZvR0TJboqjJbL8JnnigzBfiBfn/t3BpIatwnw4X+7
         +qvo8O/FnRKVvruveXWrYYkEgsyNAjn2Ss7PhkonQ7mgJGr780rvUeY2BjpPUTgmDSSX
         hZCMcYVyUcdvmqCyQoiFFNpIU+EuKddk+GANvv0m5RrYfssFKGGQr2bfTXmVPcS4dkv1
         TLNg==
X-Gm-Message-State: AOJu0Yye9YkcU+rLv2l7SCe4FF1K+fvmG5Y3MELSDQHyPbvbe/htxTAP
        eaUe6ol+TRq5/5Y24J4ISHqX67xi28Q=
X-Google-Smtp-Source: AGHT+IFHAoAoNYz4bf7CzicTrDg1Nt0bZ5L0O1oIo7y69KqZMSDzrO/cMdRYfQ6atUnPEBblS14usA==
X-Received: by 2002:a05:6e02:1caa:b0:348:ce4f:c842 with SMTP id x10-20020a056e021caa00b00348ce4fc842mr2755479ill.23.1691663810207;
        Thu, 10 Aug 2023 03:36:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.137.37])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02054e00b003421231fb8csm361358ils.74.2023.08.10.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:36:49 -0700 (PDT)
Message-ID: <64d4bdc1.050a0220.ff178.069a@mx.google.com>
Date:   Thu, 10 Aug 2023 03:36:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7042974467037572218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Add support for IW624 chipset
In-Reply-To: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
References: <20230810094802.832652-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7042974467037572218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774873

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      32.96 seconds
CheckAllWarning               PASS      36.07 seconds
CheckSparse                   PASS      41.09 seconds
CheckSmatch                   PASS      111.35 seconds
BuildKernel32                 PASS      32.05 seconds
TestRunnerSetup               PASS      481.20 seconds
TestRunner_l2cap-tester       PASS      23.22 seconds
TestRunner_iso-tester         PASS      46.83 seconds
TestRunner_bnep-tester        PASS      10.68 seconds
TestRunner_mgmt-tester        PASS      217.68 seconds
TestRunner_rfcomm-tester      PASS      16.00 seconds
TestRunner_sco-tester         PASS      19.12 seconds
TestRunner_ioctl-tester       PASS      18.01 seconds
TestRunner_mesh-tester        PASS      13.45 seconds
TestRunner_smp-tester         PASS      14.26 seconds
TestRunner_userchan-tester    PASS      11.18 seconds
IncrementalBuild              PASS      30.09 seconds



---
Regards,
Linux Bluetooth


--===============7042974467037572218==--
