Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7AEC05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Feb 2023 04:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBJEf4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Feb 2023 23:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJEfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Feb 2023 23:35:55 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DB1F49A
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Feb 2023 20:35:54 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 5so4608677qtp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Feb 2023 20:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aDAytIKlHT0BWS9arczVcdvxOAP3M8R92JXHC8MWW9k=;
        b=Ht66p92/lvvH98lVRRIa73uGULZr+XBvibJ6kTgQ2vy0Ri+YZQ2JDV35CYjcA8LPxK
         +T4cVFmYN4FWm6sRGE9efMYYuUx4KLQZDHpnHvMwwEm3dccZ0oDGIL+8sBzI/SlUU3jL
         bDLQFiyMt2t/tRVub7mpcbualzCpwaIg9LcFLEh8L5TdgnnenbodmGercOqNf0RR9wI/
         9lYYw5AmFNH0ZLqXMw+1JrP8y2ObWo7nMY8exI4eAYhYi/JdzNWfFFJwE+kgSSxMDDrI
         +6yWVGQ6QVgHxN00quPEuzS9BXBq88+q+SEwBLrVfgHn/78A1+Z3bEfVvzTOTgIsV3sn
         9SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDAytIKlHT0BWS9arczVcdvxOAP3M8R92JXHC8MWW9k=;
        b=DJqZNbkEL4SQsJp5dbvCNZyDDvf0DPsoyqyGPRt3Ym4zjF+fHFg0ytRyKhNoC6Frr9
         xL8x28bV74qgeqWZoPJBFkX0j9TqzoWUQ/bypDcsGKewCCIEsgvm+FGBd6RJEhboeNLt
         si3gKqdNxYN8+54Z64HprxUI1w1y0wXikCpyLOIoBfxxKtrVafDvkmrImo19eX/Ug9HA
         IjWc7cm/1Ye+6d/LAbfgwp4hPrfWQwnAwjz3ehTrf5H+VoDF4oZg3mPkDVgQmN06NGOg
         4sWI9yYXCKfhWUpV+HpmxUdzSNYCO+YQTfk9+uhbn29vR8Q2ToFcwzRhJAheu75mJ1q7
         f8Ng==
X-Gm-Message-State: AO0yUKUD4NhQWG7e6/F7/aFEuL+gv7oc6wH5SlYLkTSrH9uUveaaGtEJ
        3hN7UzWCLQVWRFHuvolGDcFW8HPIyrI=
X-Google-Smtp-Source: AK7set+4TJdx7rfKgVny4stIe7ql152NaOzBER6SO30K38zEozs2KPSTajtV2Kpi9VcttNzMw40APA==
X-Received: by 2002:a05:622a:118b:b0:3b8:6bef:61de with SMTP id m11-20020a05622a118b00b003b86bef61demr23445840qtk.34.1676003753725;
        Thu, 09 Feb 2023 20:35:53 -0800 (PST)
Received: from [172.17.0.2] ([172.177.98.52])
        by smtp.gmail.com with ESMTPSA id t73-20020a37464c000000b007186c9e167esm2736512qka.52.2023.02.09.20.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:35:53 -0800 (PST)
Message-ID: <63e5c9a9.370a0220.f8061.8e7b@mx.google.com>
Date:   Thu, 09 Feb 2023 20:35:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3497460262301193013=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zyytlz.wz@163.com
Subject: RE: Bluetooth: hci_core: Fix poential Use-after-Free bug in hci_remove_adv_monitor
In-Reply-To: <20230210041030.865478-1-zyytlz.wz@163.com>
References: <20230210041030.865478-1-zyytlz.wz@163.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3497460262301193013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=720534

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.39 seconds
CheckAllWarning               PASS      34.34 seconds
CheckSparse                   PASS      39.17 seconds
CheckSmatch                   PASS      106.54 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      435.55 seconds
TestRunner_l2cap-tester       PASS      16.51 seconds
TestRunner_iso-tester         PASS      17.04 seconds
TestRunner_bnep-tester        PASS      5.70 seconds
TestRunner_mgmt-tester        PASS      111.82 seconds
TestRunner_rfcomm-tester      PASS      9.06 seconds
TestRunner_sco-tester         PASS      8.34 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.32 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.02 seconds
IncrementalBuild              PASS      28.96 seconds



---
Regards,
Linux Bluetooth


--===============3497460262301193013==--
