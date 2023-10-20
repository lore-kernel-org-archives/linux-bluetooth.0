Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6FC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 02:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbjJTCn5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 22:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346883AbjJTCn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 22:43:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64563130
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 19:43:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4197fa36b6aso2074931cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697769833; x=1698374633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFO/ynpqe8b7Hu+8S1EAVyaQtVO8XVsjJJQyJEC1v4=;
        b=MhBlgISaCMLSafpRcbZHrHCp0a039BxYrwg99OAjbFoqR/10jIOBot327XLTA4ENaw
         wptV8vRz2o2KJA0Rv41jOVbvJEOkFR/KWIx4XmO9O51o9n0a0Ac6UnBTmwpYmT6qomHN
         dTem6ywo6EQnRVrWQRkI9Rftzm9vVKipbOxYLHdJ8YVnFtOKC+9u7UxHjs1ExC5wK1sa
         35DFO4MPprau0vNhCKD2Pmghyk0Zh3eqNwU6UYkQWsHKQd0JXCyXpHVaKveaJIWKG8z5
         Ced5o8dJ7ivzhS+Gl5SEJaJhq7tgZb9W4HDE2dCNhuW7Vwmkhj2GD3kg0woqxgkHoKmc
         hYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697769833; x=1698374633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfFO/ynpqe8b7Hu+8S1EAVyaQtVO8XVsjJJQyJEC1v4=;
        b=P2kHHWhBWenhVBFT3ZFN+j0YmaE6GXhsaE2EMwVN2I/hnFwZCIOdX115gQYAPuimBe
         poHCURiPYMB6rGfAjkUlp841H8DQwHXxNEfJV0oJKfw8IgFFxQ+w/O0hLB1eyEop+qc8
         y5APOM/cNXiD2FLd5QnDUv05OeNfQZZSUV/Fzzhdqn4gNW42iX2B95zO5MLvpaNKr26e
         qXAeotgGFU4T8puxoYEuYPY2t0zKgF9YvfC8Kzk+PkbjvEYcf260VIGzUjFQqJXKiw1u
         wHOx4QNKkyvUfZ36rDC3mvdU15qCBI0EB+Y/4rs9rK8izcOkLm7cSPqNxft+8rYgE4eA
         xTyw==
X-Gm-Message-State: AOJu0YwtI0KfpJzqJkTEL1uKzIriTvcfvveVvRbYjhAcV7nS1ebrIwz8
        Vqej89ryYJbbmW8LkxbHUXJxC7UqMKY=
X-Google-Smtp-Source: AGHT+IFIts+g04//UKSrz83MP7DnoQF8K+xpQxxspRlwlUqwNnFC8NQqAY8bm+lPA9lRPR8o/7mP+Q==
X-Received: by 2002:ac8:4e86:0:b0:41c:cf9d:aa0 with SMTP id 6-20020ac84e86000000b0041ccf9d0aa0mr554125qtp.32.1697769833249;
        Thu, 19 Oct 2023 19:43:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.74.16])
        by smtp.gmail.com with ESMTPSA id e13-20020ac845cd000000b004196d75d79csm279134qto.46.2023.10.19.19.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 19:43:53 -0700 (PDT)
Message-ID: <6531e969.c80a0220.46eb4.1531@mx.google.com>
Date:   Thu, 19 Oct 2023 19:43:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3620925866097270515=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [v4] Bluetooth: btusb: Add return error code
In-Reply-To: <20231020021606.224872-1-youwan@nfschina.com>
References: <20231020021606.224872-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3620925866097270515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794918

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.83 seconds
CheckAllWarning               PASS      36.11 seconds
CheckSparse                   PASS      41.57 seconds
CheckSmatch                   PASS      116.80 seconds
BuildKernel32                 PASS      32.08 seconds
TestRunnerSetup               PASS      501.45 seconds
TestRunner_l2cap-tester       PASS      29.55 seconds
TestRunner_iso-tester         PASS      59.66 seconds
TestRunner_bnep-tester        PASS      9.77 seconds
TestRunner_mgmt-tester        PASS      208.71 seconds
TestRunner_rfcomm-tester      PASS      14.90 seconds
TestRunner_sco-tester         PASS      18.37 seconds
TestRunner_ioctl-tester       PASS      16.84 seconds
TestRunner_mesh-tester        PASS      12.43 seconds
TestRunner_smp-tester         PASS      13.29 seconds
TestRunner_userchan-tester    PASS      10.30 seconds
IncrementalBuild              PASS      30.49 seconds



---
Regards,
Linux Bluetooth


--===============3620925866097270515==--
