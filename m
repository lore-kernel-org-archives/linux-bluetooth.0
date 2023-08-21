Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774ABEE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 19:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjHUTFl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHUTFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 15:05:40 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53226E56
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:05:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1cc61f514baso1110392fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692644719; x=1693249519;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sI+FNvIBcdXDlMVBtbKFzeMdbeQQ8BLrAJrLY59rYsY=;
        b=nj3IVcsbcM+AgrNscjxtgfN8EarAgw2WQK+/rq+Xw/biiTMWaMw+Q1z84UeXyv43HJ
         ifpv6yPpQ3Knrq7F/p8VQ+zBFzI96X9dm26MnHRQFGO1NpP7S2Yjq7RYDWajiNdKF5xZ
         TNiPraaaXrNZ8RalVmwADTCSsUzXC/oqQsbipTg/LvnlK7RC3VqO7fSas+Sa24TFWeEn
         SOwtshNepr9GWraDKTMqYfW8+DnwdMUElZeZVxCWNfJRy94nDOjvnVpncBmw63cgrxvd
         PFyqGWDd6IpqKPgwN6PzbG1UWYGNvKvgB8ETx4upRpXkn5WM8TgLVjX45t/vkWE5jA6M
         kwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644719; x=1693249519;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI+FNvIBcdXDlMVBtbKFzeMdbeQQ8BLrAJrLY59rYsY=;
        b=f0rnkvXJ4+f+a2ykJ6PSDI+JS/XsdhM7lHeJDzEbZJ/y+WNenJ57c8YqeymZG1ojki
         wGdIP+6oPH/W7Ot6bUbLZ0KnqKo+f17e7CS9FFf3nSJu01eKuRpc0LZkppLH3BeyWE0J
         zadXeQ+uwRVcsmMJMZMPIV0ZiuJT/X0kuzQtpAfmdTBSEntZDdSqwK0CkTc4rtX2YXxG
         isHjoAmkqDILnBM4WKLeRs3yqFixO6Ap1VyoMuhEWUPQTM4FXZQL2Gylr2sQTSd8woMC
         t6u8M2rR10aT3KChXj90Xvue2kphWbtOHH3VmgiR8S5CNMARBAQAhVYTLg54H+bC2W8b
         37Ew==
X-Gm-Message-State: AOJu0YyjPyO5y9Cfk/uHsTVheOeJlcaJakvfOLAIb0tAKSX3ZViu+9Bj
        BWW2aoCxoE7SqGaxjMTETmpk6TAaMUc=
X-Google-Smtp-Source: AGHT+IER8fPBM3D3R55W9h5w86QD2lKt5SdIXiVnFk7mi0UzPSeIdQXRPF0n6FVEAgF2qJODi6eznQ==
X-Received: by 2002:a05:6870:ac24:b0:1bf:cb11:c97e with SMTP id kw36-20020a056870ac2400b001bfcb11c97emr8348464oab.52.1692644719412;
        Mon, 21 Aug 2023 12:05:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.173.15])
        by smtp.gmail.com with ESMTPSA id e19-20020a056870239300b001bf3942ea12sm4570174oap.1.2023.08.21.12.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:05:19 -0700 (PDT)
Message-ID: <64e3b56f.050a0220.c20e5.81ca@mx.google.com>
Date:   Mon, 21 Aug 2023 12:05:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0937742584942423454=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
In-Reply-To: <20230821181848.3553863-1-luiz.dentz@gmail.com>
References: <20230821181848.3553863-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0937742584942423454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777973

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.54 seconds
BuildKernel                   PASS      38.96 seconds
CheckAllWarning               PASS      43.74 seconds
CheckSparse                   PASS      48.67 seconds
CheckSmatch                   PASS      132.32 seconds
BuildKernel32                 PASS      37.86 seconds
TestRunnerSetup               PASS      575.06 seconds
TestRunner_l2cap-tester       PASS      33.56 seconds
TestRunner_iso-tester         PASS      64.76 seconds
TestRunner_bnep-tester        PASS      13.54 seconds
TestRunner_mgmt-tester        PASS      254.21 seconds
TestRunner_rfcomm-tester      PASS      20.09 seconds
TestRunner_sco-tester         PASS      23.03 seconds
TestRunner_ioctl-tester       PASS      22.94 seconds
TestRunner_mesh-tester        PASS      17.20 seconds
TestRunner_smp-tester         PASS      18.46 seconds
TestRunner_userchan-tester    PASS      14.36 seconds
IncrementalBuild              PASS      36.01 seconds



---
Regards,
Linux Bluetooth


--===============0937742584942423454==--
