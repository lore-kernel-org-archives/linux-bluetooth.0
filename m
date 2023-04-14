Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1432FC77B6F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 10:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjDNK4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNK4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 06:56:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43DF2719
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 03:56:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e9so12744554qvv.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681469800; x=1684061800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vEvkNwUQG75k6EKAHhpLjZf63LvWJQx5Ylezz12GIpU=;
        b=WqFPGiFGECP7jcORvcfR1j5aZ3F7mTyxvZMXtKtqdW2DfD07G9v3E1/nvJuqZZ3VDH
         Y+GE7PAtLuPPbAIhnfWnFCGbayvfRxz2UTcOFbxolN2hLBf1oqcdPK0X4i/iiDCWpPEY
         fym/EZI9vlUliDmxhms9lIQHpZvd/BJChSTlwqnLadrts4yNpVwHWnMtJxuIl/YH4y/9
         gcg/n6bntM4Ai9qS8m6BEmQBi0bk1/fA5jRHskYjuHF07Pb54tKc1/dEbI0F1sw8mLV/
         N0KR1T+rk3ThMO9RT9H1dD7USapLg1wkAjf5MEkDznOszKcue5tvSU4YqFF1ND8GvTcz
         nyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469800; x=1684061800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEvkNwUQG75k6EKAHhpLjZf63LvWJQx5Ylezz12GIpU=;
        b=MG+wkK30gjO0gZ2d+SJDvWOwIghdUs1m9sb3UiYNrS9DFUButMvMFtZLoQlV//X6c7
         djaH2t8luzR9oXzWS7iI1TOjgZPpgS1KXQtdE7QtrG6dKknWsmgcVe1bpPn60t4q+oXX
         CBrphEIxPb/XmP/FkYIhPGlK/quaTLqWLw7cPCQNBzFUhlcAn2qpvy0YZsNkL9NGbHdH
         7uIGUknam92du25ICIFtk7dtDiRJgUfNKzTW4vz54ODpCUrOJGwsG1V/XDdH7may9gmx
         X82187nou2TQBd5UBGsgZiDyLYVzUv0FfI/2xOlWT2XQ+6WRXAG9JuySvpnHxCT5uH4j
         YsgQ==
X-Gm-Message-State: AAQBX9dSdTMtyjArUiQp39YuM0cRLZ5s7KyaX8bW+sdFemz3o3wUMYGE
        Z/vB5x2StCXwUi9MPw7stUXq2WEp/08=
X-Google-Smtp-Source: AKy350YkXU4Svtpr9xlUi0O0yU6MIKCgLkiBSndH6e8q2QsLebWMZ12oYbNv1z7Ji6L5LB+VmMUFrg==
X-Received: by 2002:a05:6214:5091:b0:5e0:5ea6:69cc with SMTP id kk17-20020a056214509100b005e05ea669ccmr3033602qvb.0.1681469799765;
        Fri, 14 Apr 2023 03:56:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.102.34])
        by smtp.gmail.com with ESMTPSA id f3-20020a05621400c300b005dd8b9345d3sm1037179qvs.107.2023.04.14.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:56:39 -0700 (PDT)
Message-ID: <64393167.050a0220.70b8a.52af@mx.google.com>
Date:   Fri, 14 Apr 2023 03:56:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6849660207206784390=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v4] Bluetooth: btrtl: Firmware format v2 support
In-Reply-To: <20230414103125.33496-1-max.chou@realtek.com>
References: <20230414103125.33496-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6849660207206784390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739797

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.62 seconds
CheckAllWarning               PASS      34.50 seconds
CheckSparse                   PASS      38.96 seconds
CheckSmatch                   PASS      109.68 seconds
BuildKernel32                 PASS      30.46 seconds
TestRunnerSetup               PASS      436.83 seconds
TestRunner_l2cap-tester       PASS      16.52 seconds
TestRunner_iso-tester         PASS      16.53 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      110.22 seconds
TestRunner_rfcomm-tester      PASS      8.42 seconds
TestRunner_sco-tester         PASS      7.79 seconds
TestRunner_ioctl-tester       PASS      9.12 seconds
TestRunner_mesh-tester        PASS      6.69 seconds
TestRunner_smp-tester         PASS      7.71 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      29.00 seconds



---
Regards,
Linux Bluetooth


--===============6849660207206784390==--
