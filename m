Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7DC00528
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHCTGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjHCTFu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 15:05:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E949EF
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 12:05:25 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a74d759be4so974818b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691089522; x=1691694322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuVsEFHd3nkW5ardGh8CRPAcciiLw3ewr0WaUIjZEkE=;
        b=ffKePd36ghYksVoxIqgGgq0zrY72VolQTUoMyFiUu2vrELA4yL7Sc2wMx8Rcf7KMuL
         yiSwIN2kqqOEkAxn4NaDvNLy7dBV66pWTTxtmAFUnZdz4HY63bt5KKfoo+tQN6qVJCem
         /dsGmIbjl9adaCqhNOMfDyxWcIybmrCHy7AlouIhOHk40ueExSSEtJRprmy0B6p3IQ1D
         AluPWf49KaRJkNm1ImrrsGwnd0e22g4I9jdSh1iqhu4Cb7W2XySXtu2U5PQxSTh5E0NH
         tutWRZq7z9wNC43mWg0dPD9cXK5AAPXvNc/nxI1kKdsgpRrqyMMpS6vxlpPe8rFiYCnZ
         37vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089522; x=1691694322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuVsEFHd3nkW5ardGh8CRPAcciiLw3ewr0WaUIjZEkE=;
        b=VxIXTvz2D9MsCIveWQFSQTiCss+jX7cZlxySkA2g2QN3C6QJ+nJ9PEt9cGhadJjRcb
         vox4tIy9HYjLUPZcbRCFyboAiSFeC8ZX8gBSeORB4Ja45lc9PCA5ASR2j16Tjp3+ie23
         3kDVEljYx+AQwXgFAv3rjc+A69zONeFi18+XskIUir7450GFPQZWxfuMfXN6WmYc4AQe
         vPn41VaJtFvcx+ows/CjgPDnRrnGnmi5EB/z5kKrvxVfe4SNMgzlxDGJBGQ3NW9TcK/l
         nb1/30fcXuPBlnzUUgcInoFBBcAbxqPamvmuDRMyzQKozW8nZ+1Z9KGH488iPEV0HzTW
         zlCw==
X-Gm-Message-State: ABy/qLaGlcZyvhhU5SbZ0+z8gb7X3UizkvtH2BROlEW+xUPEuNp7ShDG
        ox4y1es8V1vvhLioz8nTvMgqurpyHYY=
X-Google-Smtp-Source: APBJJlFht14bjZcaZC6RGJF3KI2yVOZrMUo2zJdpvQ2tKzXnhd1speaGupTzb//67lkSqXdkrkFjQw==
X-Received: by 2002:aca:241a:0:b0:3a7:55b3:85d8 with SMTP id n26-20020aca241a000000b003a755b385d8mr7669507oic.0.1691089522432;
        Thu, 03 Aug 2023 12:05:22 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.138.115])
        by smtp.gmail.com with ESMTPSA id bh36-20020a056808182400b003a368f3e0a6sm192742oib.3.2023.08.03.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:05:22 -0700 (PDT)
Message-ID: <64cbfa72.050a0220.36d11.1cf7@mx.google.com>
Date:   Thu, 03 Aug 2023 12:05:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6501289804542317094=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
In-Reply-To: <20230803181624.746299-1-luiz.dentz@gmail.com>
References: <20230803181624.746299-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6501289804542317094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772760

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      43.63 seconds
CheckAllWarning               PASS      47.75 seconds
CheckSparse                   PASS      51.86 seconds
CheckSmatch                   PASS      137.76 seconds
BuildKernel32                 PASS      40.27 seconds
TestRunnerSetup               PASS      596.74 seconds
TestRunner_l2cap-tester       PASS      29.42 seconds
TestRunner_iso-tester         PASS      64.93 seconds
TestRunner_bnep-tester        PASS      13.43 seconds
TestRunner_mgmt-tester        PASS      244.77 seconds
TestRunner_rfcomm-tester      PASS      20.17 seconds
TestRunner_sco-tester         PASS      20.63 seconds
TestRunner_ioctl-tester       PASS      23.07 seconds
TestRunner_mesh-tester        PASS      17.45 seconds
TestRunner_smp-tester         PASS      17.98 seconds
TestRunner_userchan-tester    PASS      13.89 seconds
IncrementalBuild              PASS      45.98 seconds



---
Regards,
Linux Bluetooth


--===============6501289804542317094==--
