Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CAEE57EB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjIHKiS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjIHKiR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:38:17 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8FF1BCD
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:38:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79545e141c7so48477439f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Sep 2023 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694169493; x=1694774293; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3cKILj6NAJTHfRyVhgE3CUxJq0SZofrKcHWGBc99oRg=;
        b=HaXN8sQrwoXGIQW7oqqXbvKsX3ZwhggQRxlZK+Ez0LzShwOhTDvQlrMv8CCRmUjkjK
         SHjr4RRWw8IT84i6OqkE9wkEErn50JMQMU6XUrh/tYs3qKOLAKEFGoMVhO7TP2X9NfRU
         g5QIVQD254r4fkfGjXc4TBKAtPMtZ9mX3pulaWnigSyLycj8yKYfJaS/upZRm9RVV2d+
         l5djBfgee76ruYZWfoWV2IjCQjWnSFYrYRO4t9SBEOkPDbWL3M+oBxvpu92a6ujFLfyH
         P31zPEGT/YvkvtI2NREtfgKeZ86gaz13sIG3jH6h5QLHRqW3BOCcqG7B96Quj4I8F2gs
         nI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169493; x=1694774293;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cKILj6NAJTHfRyVhgE3CUxJq0SZofrKcHWGBc99oRg=;
        b=VEoKc7NiB7Hbweh2c/gbW0g7Ua14YqjlJjy9n5zhYcPEjQNuSg94BDLq52pd5OYSD1
         2TtkHrSDkA8lVLgVURnk4aS1EHa8AYjF5kSrcHdul+a/mKDx8yuw8gTparbzDwlOnWIx
         zTcMkks+xxpg+HubnWaLsLj1A8kwpVOb3xQzVrrffGYIG2LVF5UglGTz5yYTPM1fsSov
         3h+94u5yHK0PMk3Qm9R1CBQYd+8ZXr/kviQf8KUinGg/ppqPnr4lVsM/tTzXk6CgafUz
         S0KZvCiWvWL/kNbrRJorxvLGWv5uJ4ok8QQNuBxVR1+vk8+EopjkGE/qaRrcnKrHuAUC
         0YVg==
X-Gm-Message-State: AOJu0YzVwTBVOX2Y24LALNpxqdEbZWRa35Ym8IpahV0KwmPlfogep9b1
        nRG794CyUyJ8soBcq/dtBGoOXAHHmGE=
X-Google-Smtp-Source: AGHT+IE7urWqR6foXo5jDqnmUdP7HKVijxmnM/casLnVd3Dvrf1dA5X5uVEVj6tI+0gkY2EbNJz1Qw==
X-Received: by 2002:a05:6602:8de:b0:792:7ee9:af39 with SMTP id h30-20020a05660208de00b007927ee9af39mr4985952ioz.9.1694169492680;
        Fri, 08 Sep 2023 03:38:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.13.181])
        by smtp.gmail.com with ESMTPSA id z7-20020a5e8607000000b00790a8cc4fb6sm402602ioj.10.2023.09.08.03.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:38:12 -0700 (PDT)
Message-ID: <64faf994.5e0a0220.f82dc.07a8@mx.google.com>
Date:   Fri, 08 Sep 2023 03:38:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0974962863037835796=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230908100618.63986-2-vlad.pruteanu@nxp.com>
References: <20230908100618.63986-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0974962863037835796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782474

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.16 seconds
CheckAllWarning               PASS      38.32 seconds
CheckSparse                   PASS      42.85 seconds
CheckSmatch                   PASS      115.77 seconds
BuildKernel32                 PASS      33.23 seconds
TestRunnerSetup               PASS      506.87 seconds
TestRunner_l2cap-tester       PASS      29.39 seconds
TestRunner_iso-tester         PASS      56.22 seconds
TestRunner_bnep-tester        PASS      11.61 seconds
TestRunner_mgmt-tester        PASS      228.81 seconds
TestRunner_rfcomm-tester      PASS      16.97 seconds
TestRunner_sco-tester         PASS      20.26 seconds
TestRunner_ioctl-tester       PASS      19.18 seconds
TestRunner_mesh-tester        PASS      14.31 seconds
TestRunner_smp-tester         PASS      15.21 seconds
TestRunner_userchan-tester    PASS      11.92 seconds
IncrementalBuild              PASS      31.64 seconds



---
Regards,
Linux Bluetooth


--===============0974962863037835796==--
