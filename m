Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B09DC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 08:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCIIje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 03:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCIIjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 03:39:07 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A337B76
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 00:37:52 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id nv15so939518qvb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 00:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678351072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SycIun7ZBcaoqXlMwKSzqRw7gXSwayGu4xgNkz5dVDE=;
        b=hzIQVsDJQPFlrijxlMmLPMcDm9BEb5WKOpRi9MqSlJXRvesCuHWs96m2R6oryTOdNd
         +5bNrmim5t3AX+ruKX8rPiqTwzdC1dfSm2/thqb+tk9MTdezF+5QZMAer/gQISXWuFeu
         feHMFcGoWmyullBsDeLzXbWbWLuh9Zu79W+Sk0U1ZPl4SUVsR/KGKDmDUOj0vKZK3MRN
         dgTihlJTs6lcvp7l72D+LUbjHxX4RA59mSXc/SBBtxLkokXCJwtaPFYNAlFFf6lc5gPO
         L5jLiy8TL4uxUfTEsVDQzXvFppPDUxL7mmhSo1hyKBc8usxkW+OgI0K6hdHyc3i+cCkw
         guCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SycIun7ZBcaoqXlMwKSzqRw7gXSwayGu4xgNkz5dVDE=;
        b=iMzwoEqAo7kETyNYMS/BC7fI1nlr+CWnFH8JJf/R43QVWgbYM0Ah58/wBfK1OCC5UT
         JSs5Z78zrGcKZQRsGpryMD8dVYpgW1QR8oOpiRwMd0fMLAGF7Z9euCGG0G7GCYLdrngT
         zsea9RqJ7qvJndp2AV18fhtOW33kNpekn9VUvX37E95kE26Ecg1T89KtLwoFm7fXtVkb
         jgC9epwoFmkgMfqWpI5N2W48nXyGFlpX0t/p3/FALqx5ENgyHXPKUKlI2dsw+1SOcd1V
         V5W8CPQbpZK9I9f0+mc9yab0i8g2OP3cYOWy3fpSOuIhmIG41TC+HrAPb4PJ75vNIBKH
         7QEQ==
X-Gm-Message-State: AO0yUKV5UB++0jz7lpmsg5kXeMImxBhMQWOdXnqBdf4RT7bQEGDOka00
        3NbsK4j1y82zKne5TcRrY2DujtmWak4=
X-Google-Smtp-Source: AK7set/1BFRMMM2Ia975u520zXHpixLbVmYcOc8iXOemX/v9YJMeuY1IS4oYLIBnErIjIC4htc8vpg==
X-Received: by 2002:a05:6214:1cc8:b0:56e:b427:819b with SMTP id g8-20020a0562141cc800b0056eb427819bmr269298qvd.16.1678351071991;
        Thu, 09 Mar 2023 00:37:51 -0800 (PST)
Received: from [172.17.0.2] ([172.177.120.48])
        by smtp.gmail.com with ESMTPSA id g66-20020a37b645000000b00743049c2b15sm12951596qkf.66.2023.03.09.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:37:51 -0800 (PST)
Message-ID: <64099adf.370a0220.f9f4f.9063@mx.google.com>
Date:   Thu, 09 Mar 2023 00:37:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6812493348472812283=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zyytlz.wz@163.com
Subject: RE: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
In-Reply-To: <20230309080739.3714610-1-zyytlz.wz@163.com>
References: <20230309080739.3714610-1-zyytlz.wz@163.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6812493348472812283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728147

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.17 seconds
CheckAllWarning               PASS      36.88 seconds
CheckSparse                   PASS      41.27 seconds
CheckSmatch                   PASS      111.11 seconds
BuildKernel32                 PASS      31.87 seconds
TestRunnerSetup               PASS      454.01 seconds
TestRunner_l2cap-tester       PASS      16.98 seconds
TestRunner_iso-tester         PASS      18.11 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        PASS      114.07 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         PASS      8.58 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        PASS      7.37 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PASS      29.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"


---
Regards,
Linux Bluetooth


--===============6812493348472812283==--
