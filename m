Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA60C54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 08:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjAZIkO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 03:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjAZIjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 03:39:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0581706
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 00:39:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d3so1239669plr.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 00:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTvwwK8/hvkhHsj3BJHA6lNH6ZvCTinC9U5FBoemrU8=;
        b=PRUZ7+Mk5CWMl4cofxb59nl3/Pc6bIKdoTLhGm4JFll3xJZau7QZ6n+RcpCBVZhOMR
         Vylg7V6Ay1rU8Ng+X9bApOURE4vYsHEH508yj4aY//DbvEL/YiQlSK3j7J8tYIOntb3G
         4AvH4Rh0gRfq0JNTHkbgHQSTi9Y1UheI063kF0VorPfRXood4ofq9eaca5jafgst0r5O
         GRsIUwyxliXfeOtcNJDt6SLtEGaJUW1y0+MsHXxHt3P3zNO03fwnwDYY/e4gotudPaGi
         kKZBTQcav59Ctjcs26kQ44o9sQWDI5WLCuh9BXg9jjUCXVJM/4Om2CZCYb0NfqlPsOUb
         S7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTvwwK8/hvkhHsj3BJHA6lNH6ZvCTinC9U5FBoemrU8=;
        b=oRrxtqrUWt4enRX+dsO48Jn4Zzb69cV6z7c0Kglx938J5TU/+nDubrROdMlB4HP7+s
         H3bVY4sTnTi2Aax59trvxTnANRB6xg/rSk8ZKhX61ELMOxWxS8WTd7hAjmHpqZUNTkwm
         1KH6IUzIlFY33fDExd5z+Xx7h1Vq1nyytDY4HxrBAQosgCa2KUyeNz57SxgD+RmZZwtW
         z9nKDOo0kestM6fmHc7zPIjuPgFAv7hpeo0UJNEYlhlaslRc244g+Ilw9dUjQx3Xkxkx
         yBg1ns6JddXDWTJRsNlHgdkbRiPsB6AAGrhEgPU3u+xcq1vEWJ/UANUeZxoSuIe8tfSy
         1egA==
X-Gm-Message-State: AO0yUKXcH+Qazpw6QwkdQecXaLoqoO6ZorPXVvzuzAg8kHyicSNXyLwv
        OYxC/7FOhz+yKgy9Lqzo+zKeC0Web/Y=
X-Google-Smtp-Source: AK7set9BdxxKhS4m+0JuCky9Gs12U5s69QQYn2mtnStA+0uxaKDDsk0I8MZ9BYAnjDfI0fOy2vAVqQ==
X-Received: by 2002:a17:902:e293:b0:196:39b2:4ada with SMTP id o19-20020a170902e29300b0019639b24adamr2158133plc.35.1674722384734;
        Thu, 26 Jan 2023 00:39:44 -0800 (PST)
Received: from [172.17.0.2] ([13.88.61.176])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001925016e34bsm597510plg.79.2023.01.26.00.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:39:44 -0800 (PST)
Message-ID: <63d23c50.170a0220.124e7.0ce5@mx.google.com>
Date:   Thu, 26 Jan 2023 00:39:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3851083104937542809=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, francesco@dolcini.it
Subject: RE: Bluetooth: hci_mrvl: Add serdev support for 88W8997
In-Reply-To: <20230126074356.431306-2-francesco@dolcini.it>
References: <20230126074356.431306-2-francesco@dolcini.it>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3851083104937542809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715765

---Test result---

Test Summary:
CheckPatch                    PASS      3.26 seconds
GitLint                       PASS      1.22 seconds
SubjectPrefix                 FAIL      0.69 seconds
BuildKernel                   PASS      37.71 seconds
CheckAllWarning               PASS      42.06 seconds
CheckSparse                   WARNING   46.99 seconds
CheckSmatch                   PASS      124.80 seconds
BuildKernel32                 PASS      37.73 seconds
TestRunnerSetup               PASS      524.78 seconds
TestRunner_l2cap-tester       PASS      19.56 seconds
TestRunner_iso-tester         PASS      21.01 seconds
TestRunner_bnep-tester        PASS      6.98 seconds
TestRunner_mgmt-tester        PASS      128.06 seconds
TestRunner_rfcomm-tester      PASS      10.71 seconds
TestRunner_sco-tester         PASS      9.93 seconds
TestRunner_ioctl-tester       PASS      11.95 seconds
TestRunner_mesh-tester        PASS      8.75 seconds
TestRunner_smp-tester         PASS      9.70 seconds
TestRunner_userchan-tester    PASS      7.45 seconds
IncrementalBuild              PASS      54.93 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:170:23: warning: restricted __le16 degrades to integerdrivers/bluetooth/hci_mrvl.c:203:23: warning: restricted __le16 degrades to integer


---
Regards,
Linux Bluetooth


--===============3851083104937542809==--
