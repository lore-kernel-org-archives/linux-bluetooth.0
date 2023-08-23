Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D056EE4993
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbjHWQOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbjHWQOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 12:14:41 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF33E78
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 09:14:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64bd231c95cso32349336d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807277; x=1693412077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cVNjDB8QVmRQg29B/S9YmEE5ebA0PrL2Np3sasYzi0A=;
        b=Oq2bPVAAlMLC8XufUpGqaqnpssykeEnZ2hsVYlOMc0lwD+b1whCdruOtBWank7VRWQ
         8x49wHOCglgAFtr8hzsI1JSYwRqNOoHiF5hbSXgnIBdb1jdRWRDQSc9GH3wwjxWC0d5Y
         cagVdJ8B1XKV5aaq+8VmV22ISNaZ78ghwc55+p1LTlZj1B2dHw5EpUEZs1tL+j9JnaO5
         6OKZgLgucTXQQVlpAdr+XHZdW4fDiWlDMwCJa29wwvgjsoxIp+IMVKSQk4IQmL81rVpk
         tpN8AEt8ig4eLwJmzIbnVY7Ai8V9SUAGznUGnYNESyUA2MmeD4QXDrqmfzEoqXq0Tf65
         sKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807277; x=1693412077;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVNjDB8QVmRQg29B/S9YmEE5ebA0PrL2Np3sasYzi0A=;
        b=dRbNRZVwhQJEMCooMThZus/pnC6/Br06zmae3mlaIpBPFhvHdp1GdpdpwtbOfuSMC6
         kbFVBtCJs4e5jkh/Cfyg4LZftRlm9EyjqBvnhQzdnLUtaAb0f+hYI4BM6GCEg577+qZv
         l8hqrBdWCDRT6rJ3SLg9sU6IBAp3uc/943o7zdeAsns4uQWE/VG25fzmMoULaqbWN/Wx
         EvSFHWox/At/XIymt5KPaCZZwWExzNuDAKi2ETKKmOUO1wB57+bk0kXR4mwJGvhf2DZH
         /35vJmPkqVbSoCHGhhQMC480qJ12Ma44fVcxtn9JzruS+vfumY6dYaE/h3ix0d4Uy/AI
         XjXA==
X-Gm-Message-State: AOJu0YxNEV6IwMXUf1p1sYAZL2geICtofDX233BwNJvjP8d8te2EZnp8
        vyqsXLaUuyHtcnpmUMJMijKKfRTC/BA=
X-Google-Smtp-Source: AGHT+IFDU0yT2YFeZOnnd/Wyc/jFsR0tFGFeB+p5itfIAv4LVaxv5wl8bk1rvylOhinTsBCKkYzNxw==
X-Received: by 2002:a0c:abc3:0:b0:635:f899:660b with SMTP id k3-20020a0cabc3000000b00635f899660bmr11585094qvb.36.1692807277649;
        Wed, 23 Aug 2023 09:14:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.50])
        by smtp.gmail.com with ESMTPSA id z16-20020a0cf250000000b0062fffa42cc5sm494001qvl.79.2023.08.23.09.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:14:37 -0700 (PDT)
Message-ID: <64e6306d.0c0a0220.e850f.2485@mx.google.com>
Date:   Wed, 23 Aug 2023 09:14:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1290277953486354624=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: isotest: Add defer setup support for Broadcast Receiver
In-Reply-To: <20230823151125.16100-2-iulia.tanasescu@nxp.com>
References: <20230823151125.16100-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1290277953486354624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778644

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.68 seconds
BluezMake                     PASS      903.00 seconds
MakeCheck                     PASS      12.11 seconds
MakeDistcheck                 PASS      159.22 seconds
CheckValgrind                 PASS      261.53 seconds
CheckSmatch                   PASS      349.90 seconds
bluezmakeextell               PASS      104.95 seconds
IncrementalBuild              PASS      729.79 seconds
ScanBuild                     PASS      1090.00 seconds



---
Regards,
Linux Bluetooth


--===============1290277953486354624==--
