Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 09:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCFJgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCFJgB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 04:36:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27218233ED
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 01:35:48 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c3so9790922qtc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 01:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678095347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVpqh/Acx+iZGUKBTpLjCzL2Uz3jjtgTP6VHMRFYONQ=;
        b=Pt+mPF1fqXylTYMjLXlV+uAAhieKLBErlfmlikn6Z3M+aOJ9O/WWdTwxWcN6cEelJY
         YbcB9qIyRrLXVPtk/AP7PDxQ9DZCrlqlDLpwn/JJCZM4cqUR3RKogyea1nt8SP8sVX6E
         MkttKCQa++z9Cag0DTCPD+IRs3vHQbZVntnkGQJ6lIwdu6BD+nRIqHQNlq68d5iCUltv
         CEtGLu9xRwCYCQ5sP9EEUIn5zGLl5nE3txgtBOGLigZv4131FdirOJUBz+ttSkXXbkDc
         lT4yBiAFMDCgJpYCWfyDHhlTPu7DiycASfIQyhdrqA0nN189UMO32rv75F+SfqX0RzXC
         X4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVpqh/Acx+iZGUKBTpLjCzL2Uz3jjtgTP6VHMRFYONQ=;
        b=jTE55HAXf8JDuM8AEwVE95GPyV/A7Ee0KEsr3sWbsMlWBti+KSOpTJA5k8PW7/mKdG
         Q2KlGg1n61+8vAeHfMmp1GnF0ANcyxkcJKVOXhM3i18DYTTl3cdVzZXvfu/CAk4PY3e4
         ofW7q6wSORuZWtTOGr8yJez+hXjzy1hJzDoLRq+jOXVPL3b0jXLJSHNkdMeL+1GovNC6
         EqxFWQ1baUEAMoE3VSw+Br8/lMZUviVkkE+VvnY+ak1AsxdO4lEOB9Jo7Ng6aepnbrfa
         1xy/N+i1gth+MXuarP3kN/S8vv1M1n2GTqeZynkiMy8fNYSkiaSJQO5rixsjKN7C1Rfl
         QCsA==
X-Gm-Message-State: AO0yUKUofIHSxuRwUBLbGrAAWfQ8G6orDUEeqGYYPhI4Q/r6Jr5co+6d
        IQKZLaJk/2/MmGgYHAqi8ix1AngVzVg=
X-Google-Smtp-Source: AK7set8gc3NTCTR3iISmznQa4KGJ1GElvff/tKi8FyoPjzctw/MsTUlJi8vx36yx/y+9wC4RHYRgqA==
X-Received: by 2002:ac8:7d13:0:b0:3bf:dd45:ed68 with SMTP id g19-20020ac87d13000000b003bfdd45ed68mr16920628qtb.47.1678095347082;
        Mon, 06 Mar 2023 01:35:47 -0800 (PST)
Received: from [172.17.0.2] ([172.176.229.23])
        by smtp.gmail.com with ESMTPSA id l11-20020a37f90b000000b0071ddbe8fe23sm7065289qkj.24.2023.03.06.01.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:35:46 -0800 (PST)
Message-ID: <6405b3f2.370a0220.cb3ba.4861@mx.google.com>
Date:   Mon, 06 Mar 2023 01:35:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0066982757305344303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: hci_sync: Don't wait peer's reply when powering off
In-Reply-To: <20230306170628.1.I8d0612b2968dd4740a4ceaf42f329fb59d5b9324@changeid>
References: <20230306170628.1.I8d0612b2968dd4740a4ceaf42f329fb59d5b9324@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0066982757305344303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726802

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.50 seconds
CheckAllWarning               PASS      37.61 seconds
CheckSparse                   PASS      43.06 seconds
CheckSmatch                   PASS      113.89 seconds
BuildKernel32                 PASS      33.61 seconds
TestRunnerSetup               PASS      479.47 seconds
TestRunner_l2cap-tester       PASS      17.60 seconds
TestRunner_iso-tester         PASS      19.19 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        PASS      117.87 seconds
TestRunner_rfcomm-tester      PASS      9.63 seconds
TestRunner_sco-tester         PASS      8.56 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PASS      30.68 seconds



---
Regards,
Linux Bluetooth


--===============0066982757305344303==--
