Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF578C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Feb 2022 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiBMWAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Feb 2022 17:00:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiBMWAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Feb 2022 17:00:22 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7375419C
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Feb 2022 14:00:15 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id s1so13992590qtw.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Feb 2022 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=c5hok+X2JTDQwSIZ7hfHuQk8fu6H+wuaL1/+wQcaIMo=;
        b=pmdOb9xVGHtHQRahRzh5qJ0YiCJKas3MdyL9TEZj3qMkY0sH2V7u87iI3u81HUQA32
         0RPwPxJ06NPlZf8crfGwZgOPriWVmkwD4d99E+69EiFhnipHOJqYzwfp611C2e+SiiTO
         DrobAlAm21wQGTHXQNCECvWkU2KKj/lN1jHkRHqwZtRaSEw2eRZRHLlFcPEpxwCP+A4T
         bbXb9waYiaDuCeEH2DQ1FdY1lyjHu8Nr/iab24e3InlKXyJTDOnw35LSrroWOIjOnous
         58neTicsnvhjl8OaLzkcYgW2RnI+7uQt8Xyr02DUNPl8TKdRLkjywFlDI6V6nAwUQf7e
         /obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=c5hok+X2JTDQwSIZ7hfHuQk8fu6H+wuaL1/+wQcaIMo=;
        b=MYvvkCe6XK31nCE5t9Q4dt/OFreOgz3qFFNCVfKnIcEwHCvoM2aAPGeM2CK5EaLCNK
         sry3qIYZpbDsoMeTHpXyOEITKw/PjfLcJ/PzIsk3pQyeqvylci2eJ9jLkCOSuYGYAI1n
         PebbGDrKQ4cLFRKUPzUxyRowOGRbgMFvqNIfO1GJwUYi5qfNZB1ZAL96rbueyXoAZ7oR
         XxKdhxQ0PIQqrtydIvBpZCaSjPYZ9bWeUMi1UhSoGPwjge5xHtbJYwDbfxpo/eIqluL6
         eiMPspI9ctndwsJtOJKsklJ135x9OzIEBBW47x8s9na6gDTSD4F+1U8aXmidnhbE3tH9
         UfSg==
X-Gm-Message-State: AOAM53287yCQ+rNDJyRf/RKASDjo/REPhkKlh6Zrtkb6VLOOFYMT1yC/
        RJdtCwzEU1zcDfl74aW3p04geGAYW5Q+Bw==
X-Google-Smtp-Source: ABdhPJwc7CVDMT/Ge4ZPObl92MYq8+d3T4r0+TcppuTMZlezuUvEvYaHHmefxp+UElWL6irHyMwXqA==
X-Received: by 2002:a05:622a:112:: with SMTP id u18mr7818034qtw.480.1644789614851;
        Sun, 13 Feb 2022 14:00:14 -0800 (PST)
Received: from [172.17.0.2] ([20.119.216.162])
        by smtp.gmail.com with ESMTPSA id bp33sm14751090qkb.19.2022.02.13.14.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 14:00:14 -0800 (PST)
Message-ID: <62097f6e.1c69fb81.60807.ed83@mx.google.com>
Date:   Sun, 13 Feb 2022 14:00:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7041928058250571577=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: 6lowpan: No need to clear memory twice
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <2f67f1c5ed7de38b78a296c798f3d4afe9e3bd63.1644787831.git.christophe.jaillet@wanadoo.fr>
References: <2f67f1c5ed7de38b78a296c798f3d4afe9e3bd63.1644787831.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7041928058250571577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613897

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      34.58 seconds
BuildKernel32                 PASS      30.57 seconds
Incremental Build with patchesPASS      41.25 seconds
TestRunner: Setup             PASS      541.75 seconds
TestRunner: l2cap-tester      PASS      15.24 seconds
TestRunner: bnep-tester       PASS      7.02 seconds
TestRunner: mgmt-tester       PASS      115.93 seconds
TestRunner: rfcomm-tester     PASS      8.80 seconds
TestRunner: sco-tester        PASS      8.81 seconds
TestRunner: smp-tester        PASS      8.72 seconds
TestRunner: userchan-tester   PASS      7.27 seconds



---
Regards,
Linux Bluetooth


--===============7041928058250571577==--
