Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA1EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 23:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF0XiH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0XiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 19:38:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D71BE8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:38:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38c35975545so4621369b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687909084; x=1690501084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TrK/5VbfKW/DR24er1zBWsF2CZOJp0ndWerctM1Qob8=;
        b=HQ8B6ewtSzCTCQn5oyBH5j0JFgfhA5DzO2A7Nvkjw7qCidk/xTSEQAUGNT8wEsvRk3
         GDXE4lL46gBUHea74MAEuxLtcCkCF3zxPlX3zdCyo75SReYS0CE/Y/afNpCy8rNmEUwN
         R/r6OM5g9SkUA1cRz3RbVqqFRMik8he4hlKjPc/3D8hZ8oC+BHyjPKRnLHpdwOStPfMX
         X/gLR24HrBK5EnRo/FOecfHx1lYbLntOIVFlIKBlJXLL4/cJDrE572TGyG+QYUN9ETmO
         s/Yd4xBCSVdETlYOV5j5P9Ijz41cERvfoj/in0tf5LFnbNHxbLihDGLJ7L/xSjuiTbMJ
         j9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687909084; x=1690501084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrK/5VbfKW/DR24er1zBWsF2CZOJp0ndWerctM1Qob8=;
        b=SzXD5Yn7gWxZa/l34HuGFrymrLPljoAveNxJWFvD6IC91WHYzeLwa1Q5feEOL2XDgg
         Jb/W3BDZZX/ci2mjmtqiAC1dAhBdoFpMXjYjk+hXVqKERyposc6xY7cMEp8xoj+SjhRy
         0qHt0JJRPNk5/iAgMxH6CNfdMU1kOYwFibXAqBe+U3v2wxCkubMPpnRCP38oWUhmxps3
         aiu8UiYsiqTByHnPqykZEl2o7YGwj4ebXn12ouBcM2n2xPSH+wRCaP/dvQwe6MRyptoZ
         THg1P0t/cN0U1eHmoAMkiBb+va6mbEAJD9pgSmv+LCR63W6p9ko3vzNxx3u79YZEF9vC
         DfSw==
X-Gm-Message-State: AC+VfDwd9a+KODFZXBKoTJS8/heilMt3FDt67QNgo7mvELtXrOZucM7n
        YmGOX8/z8vAQRMhh77MP4KFaPW6ejPw=
X-Google-Smtp-Source: ACHHUZ7ZZ66vQpuFA8CiqOpuzy9vEUhq4X8fZwwdvajMRQYO11DrwzHZ3QAZshU17lodm7TShKezvQ==
X-Received: by 2002:a05:6808:1210:b0:3a0:5cd6:8773 with SMTP id a16-20020a056808121000b003a05cd68773mr22176510oil.54.1687909084135;
        Tue, 27 Jun 2023 16:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.79])
        by smtp.gmail.com with ESMTPSA id o18-20020a544792000000b003a05afbcbf0sm4179885oic.22.2023.06.27.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:38:03 -0700 (PDT)
Message-ID: <649b72db.540a0220.6db32.3854@mx.google.com>
Date:   Tue, 27 Jun 2023 16:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0644464187777403464=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_conn: Consolidate code for aborting connections
In-Reply-To: <20230627225915.2674812-1-luiz.dentz@gmail.com>
References: <20230627225915.2674812-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0644464187777403464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760761

---Test result---

Test Summary:
CheckPatch                    PASS      2.31 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      41.59 seconds
CheckAllWarning               PASS      45.27 seconds
CheckSparse                   PASS      51.43 seconds
CheckSmatch                   PASS      137.24 seconds
BuildKernel32                 PASS      40.21 seconds
TestRunnerSetup               PASS      567.22 seconds
TestRunner_l2cap-tester       PASS      20.55 seconds
TestRunner_iso-tester         PASS      28.88 seconds
TestRunner_bnep-tester        PASS      6.63 seconds
TestRunner_mgmt-tester        PASS      153.95 seconds
TestRunner_rfcomm-tester      PASS      11.36 seconds
TestRunner_sco-tester         PASS      12.37 seconds
TestRunner_ioctl-tester       PASS      12.72 seconds
TestRunner_mesh-tester        PASS      9.11 seconds
TestRunner_smp-tester         PASS      9.90 seconds
TestRunner_userchan-tester    PASS      7.43 seconds
IncrementalBuild              PASS      45.57 seconds



---
Regards,
Linux Bluetooth


--===============0644464187777403464==--
