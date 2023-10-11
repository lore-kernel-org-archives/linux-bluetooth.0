Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27BCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjJKWCE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJKWCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 18:02:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D69E
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:02:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-775810b032aso19933885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061721; x=1697666521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ftLBmH9HDSYHVBEvF4b38q+Wa2AsUCCuK/NUNESLFo=;
        b=X/z/KeNKctENmoJ2mS9CNPPkdnL9YnwbXesfpnpK2Qk0ydnOVFS7lKX+Z2xdgaFvej
         647WH2UkX2dY2knvu4Dx4KC9FuW37ERfiY56GE7uRL0L6sQ4w6cSwgedFjY8DfWAQoq6
         FhEKD7CAA5EuBetDakJD+kRwUtMP1DU8SdmwFWKLQ1BAFgZu5dfolp8n8In++gg6wUTy
         FJpdrNvjQel6orVjcVI/STl+T1+zpSzusWe88W3DWYDoNiswm7pfz1F74d/yOqsioD14
         tfkjscGieaFwL88YgcRp4yDx5xklZyLG1uIKlqpPQaTPJgDdQUqhtG3wxC0m/0Essk8Z
         J2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061721; x=1697666521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ftLBmH9HDSYHVBEvF4b38q+Wa2AsUCCuK/NUNESLFo=;
        b=qaCQGqDLslKZK115NcFmDIhLUwmOjC4Cyk2rrvw9fLdykorTYp5J1IjrMsXeJDnkgY
         znlxrpXmzwLNhnAXbuDihrPNRMm1AwMecPFaY7V7a1PpPYYi2eDBu9pUB7zr8lv29nj3
         rG20fc5J6tNKcjWtf0m95d72JtP6nD1sxvNfV9ZdYZidMD8d2P5CGakbpfIqr65fNA58
         RD8FjjicjLVW4tgCO9EVRDyoFR6ZMtUbCzF1u37B/G6Xbkp/kqK7IUp0p+a1EgdNy2PI
         uu4Dpwbo66E3SwVN9XXaPzat1ioToYQ6/4deEN6Lp1vNlbPnfwR0OrUTo+AafvNXI7pX
         RJjg==
X-Gm-Message-State: AOJu0YxqlwZfSZFcQphtXWBGEE7mjnV5iIEsCxOhFgB1bAljgH4RQUl6
        S0OfnaDs0doziDW5bl8iMFSpwyVjBi8=
X-Google-Smtp-Source: AGHT+IGBfkZEHxiouf0mnHykKE9n5s38d4rctUWxsANUsncqz75gWsOzfc/sfT7gs/JtR91b1wzr3g==
X-Received: by 2002:a05:620a:2945:b0:775:cf5f:8a57 with SMTP id n5-20020a05620a294500b00775cf5f8a57mr25568755qkp.7.1697061721540;
        Wed, 11 Oct 2023 15:02:01 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.160])
        by smtp.gmail.com with ESMTPSA id j30-20020a05620a001e00b00767d2870e39sm5544907qki.41.2023.10.11.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:02:01 -0700 (PDT)
Message-ID: <65271b59.050a0220.b25d5.a69b@mx.google.com>
Date:   Wed, 11 Oct 2023 15:02:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7860868421258741723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: Make handle of hci_conn be unique
In-Reply-To: <20231011212624.1206326-1-luiz.dentz@gmail.com>
References: <20231011212624.1206326-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7860868421258741723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792337

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      34.45 seconds
CheckAllWarning               PASS      37.71 seconds
CheckSparse                   WARNING   42.87 seconds
CheckSmatch                   WARNING   116.10 seconds
BuildKernel32                 PASS      32.85 seconds
TestRunnerSetup               PASS      514.90 seconds
TestRunner_l2cap-tester       PASS      31.00 seconds
TestRunner_iso-tester         PASS      60.61 seconds
TestRunner_bnep-tester        PASS      10.36 seconds
TestRunner_mgmt-tester        PASS      220.87 seconds
TestRunner_rfcomm-tester      PASS      16.09 seconds
TestRunner_sco-tester         PASS      20.00 seconds
TestRunner_ioctl-tester       PASS      18.24 seconds
TestRunner_mesh-tester        PASS      13.64 seconds
TestRunner_smp-tester         PASS      14.56 seconds
TestRunner_userchan-tester    PASS      11.14 seconds
IncrementalBuild              PASS      32.77 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7860868421258741723==--
