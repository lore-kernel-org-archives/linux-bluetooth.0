Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6696CD98F3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 06:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJKGCA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343606AbjJKGB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 02:01:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFD8E
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 23:01:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a5a746e355so16487639f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697004117; x=1697608917; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qkQfFxRfuHnEMVR1A+wbDEzFopZ5Ofccak6TVNlVzD4=;
        b=OQtgDDWEdY0YuS4NLu4Ny45WwZWRkF3eKca7EAXVcUNf6+hOjfzI4aUbr2lAF/QYCY
         F0BeyJzsrrXIQKk+ftwVJ23gysQmhsOsaUGDG8k4H1io3qmO1pBZidXHPGBRWSETVfmo
         rG5vTuDS8H4ZJd2K6Ln5unJevRcev8u4dU+gf9UF4c4ia73HV1ahFyLFdT4eLE6s0f6S
         gC8uLR0t/WqzUXDQdmhFNq1/y1flMGytG+HYZQmRPxs/l5D4CtOYPuH3vhj6/bPMgBjK
         7TqNW7ssrz97Fq5UWh5F8HnPnThCsntXaVCerC7RaVFlnVCqz+W89uTuM0u/0ZYw4hM5
         Z2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004117; x=1697608917;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkQfFxRfuHnEMVR1A+wbDEzFopZ5Ofccak6TVNlVzD4=;
        b=fqbIKOMjF/A6WWB2sNfoAJKZPie82a7WDKknjV2c/bj/RBASI5bhgWh1CYsPfsU/lQ
         V3km9R7EKfgEEGxOT1TixpL3HiGmrN6me5cOXSmMviH57RMZxiXfGjMuILFocPxgJe2r
         XQ/Y5Vgzu/RbSfkR4FroVXnIqRu+/nt9fnMQuiKpnUncywN4wn2+bOWyX0YcLGT1/fiw
         6jUQbL6QKL4E3VfZA3pQbvyjn/mSpbpqQPFb30gV2eMatythk+Anl8EYEhxWkY8riARK
         wnrVmupCOaefwUW5qrUb/1mBQyVdhanPG9xUf4/P07ONVI8+Goci/s/nW+H+e2KEjSdr
         jUHg==
X-Gm-Message-State: AOJu0Ywt3uEYzHNtKhi96i91gTP1tPIUslm1LETVND305ahAx3jvuNnm
        IXvX0EeC7Zh3gin8fGzSoDQnPr/gy/c=
X-Google-Smtp-Source: AGHT+IEovQSb/34grIlT5DhufBGd0RkBg8fCalrfehF62euKQTsKa3ej6GQMgQYEN8xdB05Nm6e+ZQ==
X-Received: by 2002:a5e:cb4c:0:b0:79f:b4f1:186a with SMTP id h12-20020a5ecb4c000000b0079fb4f1186amr15028268iok.1.1697004117627;
        Tue, 10 Oct 2023 23:01:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.66.34])
        by smtp.gmail.com with ESMTPSA id c23-20020a6bfd17000000b0079fdeed3ab6sm3400962ioi.40.2023.10.10.23.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:01:57 -0700 (PDT)
Message-ID: <65263a55.6b0a0220.ec807.48a4@mx.google.com>
Date:   Tue, 10 Oct 2023 23:01:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5260396786223571724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@126.com
Subject: RE: Bluetooth: btusb: Add date->evt_skb is NULL check
In-Reply-To: <20231011051447.92581-1-wangyouwan@126.com>
References: <20231011051447.92581-1-wangyouwan@126.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5260396786223571724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792044

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      35.48 seconds
CheckAllWarning               PASS      38.26 seconds
CheckSparse                   PASS      44.26 seconds
CheckSmatch                   PASS      117.11 seconds
BuildKernel32                 PASS      34.25 seconds
TestRunnerSetup               PASS      525.24 seconds
TestRunner_l2cap-tester       PASS      31.43 seconds
TestRunner_iso-tester         PASS      55.62 seconds
TestRunner_bnep-tester        PASS      10.71 seconds
TestRunner_mgmt-tester        PASS      223.06 seconds
TestRunner_rfcomm-tester      PASS      16.46 seconds
TestRunner_sco-tester         PASS      19.86 seconds
TestRunner_ioctl-tester       PASS      18.50 seconds
TestRunner_mesh-tester        PASS      15.09 seconds
TestRunner_smp-tester         PASS      15.11 seconds
TestRunner_userchan-tester    PASS      11.38 seconds
IncrementalBuild              PASS      32.91 seconds



---
Regards,
Linux Bluetooth


--===============5260396786223571724==--
