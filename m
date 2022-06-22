Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiFVXB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiFVXB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 19:01:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB064199E
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 16:01:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 128so10389580pfv.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2x8R++oL6OBl1eH680TgNtXmz9NbmiDcxjERpxJlG7s=;
        b=I2ZBu2goAQSsCbZKJN4IVRtskS9BTyspAEnqSlwxbS49SAHb5hT/YZu6cHMCzasgr6
         A7BLwxVEhhLBYA5Bh/QP1HufbqsZFYkdvjSumvzMvWzEaAgWdKLKVgsZTMsPEjuxMDyZ
         HxfT5+mu1RX56+lh9X3CqJ99emA6Dx0wPdjclGkTtZp0GIgHkqK88KTMH8kxhY1OA1FP
         mzyj6hZcdAe5NiwqvC9ggZpC1BXVOFoYfMjlDlFdiMR7k5JlYzgQC3YNZHiZFA1MGWbU
         v/M4oEi2DOife01iT4ikI7mIIkgwfHq8ilwdESo3xHYSFBYVSw4qJIGmxzIcNgGQqyJL
         3GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2x8R++oL6OBl1eH680TgNtXmz9NbmiDcxjERpxJlG7s=;
        b=NsHOFopRWujf5lgNXHBChrFHk8MY6D1EsB/tDDXjyIcxGdm3W016Na2xtLaFIBJHtd
         gXOiMtVF0eObLFHf0ySbDULmIGLOTNrK4DXYsLcr78+fV4Qa54nCI56epzJWs5rMhlh/
         VpbvdTJFoLUxJQb8XITcDU71sOenWv3vCjrmJYrg446qRF9jBe2vw7SjWMp8X2Y47azr
         npsfAQqzPyNOxSaVNcIwFb/NOSAmvj9/tdFp7lgKBUhjv4HgPcaLj1ukkSJysq+cOgED
         cx+xHyNIQOEJZMZU4cdl9kQLNM7iI+8aGFHNa5pPEzSsTVVjI4H5EzXiWnw686zfwgK9
         PM0A==
X-Gm-Message-State: AJIora90aObg1i7WqB9worId+YcX8kzI4U4Y6ekwIDc4roo3MahhjmDE
        Law/RTAXyLDDkxT6RtKUTSnJYWH4768=
X-Google-Smtp-Source: AGRyM1u4D2tmr9Q8q4sesbHT6dygdW3gqCGpP3HCXO5ocoLgMxSqhxy8/Cy2uKG53bU/3q9FNuBI8Q==
X-Received: by 2002:a05:6a00:2450:b0:4f7:bf07:c063 with SMTP id d16-20020a056a00245000b004f7bf07c063mr37717231pfj.51.1655938885761;
        Wed, 22 Jun 2022 16:01:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.161.255])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78119000000b0051b90ac6c15sm14016604pfi.125.2022.06.22.16.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:01:25 -0700 (PDT)
Message-ID: <62b39f45.1c69fb81.c25da.4376@mx.google.com>
Date:   Wed, 22 Jun 2022 16:01:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0943335318139733377=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v2] Bluetooth: btmtksdio: Add in-band wakeup support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <52b63a1be094a1ccbb20f2c89472580d95f0652a.1655934689.git.objelf@gmail.com>
References: <52b63a1be094a1ccbb20f2c89472580d95f0652a.1655934689.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0943335318139733377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652944

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      30.71 seconds
BuildKernel32                 PASS      27.17 seconds
Incremental Build with patchesPASS      37.53 seconds
TestRunner: Setup             PASS      464.66 seconds
TestRunner: l2cap-tester      PASS      16.55 seconds
TestRunner: bnep-tester       PASS      5.60 seconds
TestRunner: mgmt-tester       PASS      97.86 seconds
TestRunner: rfcomm-tester     PASS      8.98 seconds
TestRunner: sco-tester        PASS      8.81 seconds
TestRunner: smp-tester        PASS      8.87 seconds
TestRunner: userchan-tester   PASS      5.78 seconds



---
Regards,
Linux Bluetooth


--===============0943335318139733377==--
