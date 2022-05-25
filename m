Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C56C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 11:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiEYLJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiEYLJZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 07:09:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961853721
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 04:09:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e189so24618942oia.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=M++1S9Pwj/dq1bqlV+AgQtZTABv6W6zvE3VQALsjPbQ=;
        b=VQGTbmpFe+CG/JReXoYZ3JN8f6Y/WeWvEQVW/HxDtf44nAKW833y3u8Y0zNB8NzA00
         GsjQ0Q22dtpJeqHx9otV1mKqunNS2+nr1teXGKDl/JkP4/zLHPAH0GcnNlpGqisi0PAk
         +kWgF5zF8mWPwBFZsr+muC0QW5UDB3LZZKKPs/ykpiWzIJofdQgH/Ta6vPuPYiKLtA5J
         BkstqmqDYgwovjMLaeczkE6QjP+tOF36mDtKfFjoxjH4hAhRZi0KF7RgNj5nc2ns4g0R
         F/6geHNup3beDPaJLNgjwtuKG8Fb9mNauqhP84qQRpNmnDaUATWZxJViGOhXayluxDin
         Q3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=M++1S9Pwj/dq1bqlV+AgQtZTABv6W6zvE3VQALsjPbQ=;
        b=GlvcaAJX4G5ZQuC2gKpcMcwGFqS9BiV/FUHFQXyqWR55lleaLqp/9dlR6TNCJ1uxwz
         RzkMfVyu6ixN4uNWhpnsjOZ3k9Jx3DlpSm/GZ2am/63kCKaNxiFNSAM/eMpS/VgR2d3o
         qALbru7IodJh1fxdo9FYLPnA9xI9G/qLFoIWWosUGQFQzVRCN4Fmz2gQ+oB8x0eDkrNO
         C3tRvpCLSdYXGZXE8HIhGIOEkAvzp6wZ/Wg6DMnlBjI7EpEXaDb2lV1CPX7oY0an4kiw
         46UPoyfvH6jkPfMHYG1UFcaiILnsy5zNFOpU+17ZVYkBFPGD1AQ1D55kYZ2LobUbnu1+
         vruQ==
X-Gm-Message-State: AOAM530xNVFZPlSRdP9zjmxXVbSfLJaxEmthKqltU+JCRAJztbc3ki1P
        SnVh9E1hFWETpLG1ufKl/GHVClNkYJTZzw==
X-Google-Smtp-Source: ABdhPJwEFZRaMra7AFYgineR1wCEylWG2UUV1hvvI4TXbUuY6krxIVHYN5nHiqDrclcsjZ16zCHXlQ==
X-Received: by 2002:aca:f306:0:b0:32b:4753:db60 with SMTP id r6-20020acaf306000000b0032b4753db60mr4775269oih.157.1653476963024;
        Wed, 25 May 2022 04:09:23 -0700 (PDT)
Received: from [172.17.0.2] ([104.214.112.195])
        by smtp.gmail.com with ESMTPSA id n24-20020a4ae758000000b0035eb4e5a6b1sm6475016oov.7.2022.05.25.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:09:22 -0700 (PDT)
Message-ID: <628e0e62.1c69fb81.c5f0.d2fa@mx.google.com>
Date:   Wed, 25 May 2022 04:09:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5160353566567595830=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [v5,1/5] Bluetooth: mgmt: add MGMT_OP_SET_QUALITY_REPORT for quality report
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220525104545.2314653-1-josephsih@chromium.org>
References: <20220525104545.2314653-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5160353566567595830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644906

---Test result---

Test Summary:
CheckPatch                    PASS      8.20 seconds
GitLint                       PASS      3.56 seconds
SubjectPrefix                 PASS      2.96 seconds
BuildKernel                   PASS      32.06 seconds
BuildKernel32                 PASS      28.56 seconds
Incremental Build with patchesPASS      124.19 seconds
TestRunner: Setup             PASS      463.22 seconds
TestRunner: l2cap-tester      PASS      16.78 seconds
TestRunner: bnep-tester       PASS      5.96 seconds
TestRunner: mgmt-tester       PASS      100.82 seconds
TestRunner: rfcomm-tester     PASS      9.25 seconds
TestRunner: sco-tester        PASS      9.31 seconds
TestRunner: smp-tester        PASS      9.33 seconds
TestRunner: userchan-tester   PASS      6.21 seconds



---
Regards,
Linux Bluetooth


--===============5160353566567595830==--
